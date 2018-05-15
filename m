Date: Tue, 15 May 2018 09:37:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	alexander.duyck@gmail.com, tobin@apporbit.com
Subject: Re: [PATCH v4 1/1] drivers core: multi-threading device shutdown
Message-ID: <20180515073744.GA28338@kroah.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514194254.14748-2-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 03:42:54PM -0400, Pavel Tatashin wrote:
> When system is rebooted, halted or kexeced device_shutdown() is
> called.
> 
> This function shuts down every single device by calling either:
> 
> 	dev->bus->shutdown(dev)
> 	dev->driver->shutdown(dev)
> 
> Even on a machine with just a moderate amount of devices, device_shutdown()
> may take multiple seconds to complete. This is because many devices require
> a specific delays to perform this operation.
> 
> Here is a sample analysis of time it takes to call device_shutdown() on a
> two socket Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz machine.
> 
> device_shutdown		2.95s
> -----------------------------
>  mlx4_shutdown		1.14s
>  megasas_shutdown	0.24s
>  ixgbe_shutdown		0.37s x 4 (four ixgbe devices on this machine).
>  the rest		0.09s
> 
> In mlx4 we spent the most time, but that is because there is a 1 second
> sleep, which is defined by hardware specifications:
> mlx4_shutdown
>  mlx4_unload_one
>   mlx4_free_ownership
>    msleep(1000)
> 
> With megasas we spend a quarter of a second, but sometimes longer (up-to
> 0.5s) in this path:
> 
>     megasas_shutdown
>       megasas_flush_cache
>         megasas_issue_blocked_cmd
>           wait_event_timeout
> 
> Finally, with ixgbe_shutdown() it takes 0.37 for each device, but that time
> is spread all over the place, with bigger offenders:
> 
>     ixgbe_shutdown
>       __ixgbe_shutdown
>         ixgbe_close_suspend
>           ixgbe_down
>             ixgbe_init_hw_generic
>               ixgbe_reset_hw_X540
>                 msleep(100);                        0.104483472
>                 ixgbe_get_san_mac_addr_generic      0.048414851
>                 ixgbe_get_wwn_prefix_generic        0.048409893
>               ixgbe_start_hw_X540
>                 ixgbe_start_hw_generic
>                   ixgbe_clear_hw_cntrs_generic      0.048581502
>                   ixgbe_setup_fc_generic            0.024225800
> 
>     All the ixgbe_*generic functions end-up calling:
>     ixgbe_read_eerd_X540()
>       ixgbe_acquire_swfw_sync_X540
>         usleep_range(5000, 6000);
>       ixgbe_release_swfw_sync_X540
>         usleep_range(5000, 6000);
> 
> While these are short sleeps, they end-up calling them over 24 times!
> 24 * 0.0055s = 0.132s. Adding-up to 0.528s for four devices. Also we have
> four msleep(100). Totaling to:  0.928s
> 
> While we should keep optimizing the individual device drivers, in some
> cases this is simply a hardware property that forces a specific delay, and
> we must wait.
> 
> So, the solution for this problem is to shutdown devices in parallel.
> However, we must shutdown children before shutting down parents, so parent
> device must wait for its children to finish.
> 
> With this patch, on the same machine devices_shutdown() takes 1.142s, and
> without mlx4 one second delay only 0.38s
> 
> This feature can be optionally disabled via kernel parameter:
> device_shutdown_serial. When booted with this parameter, device_shutdown()
> will shutdown devices one by one.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/base/core.c | 292 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 242 insertions(+), 50 deletions(-)

Can you refactor this to be at least 2 patches?  One that moves code
around to comon functions to make the second patch, that adds the new
functionality, easier to review and understand?

And I echo the "don't use kerneldoc for static functions" review
comment, that's not needed at all.

thanks,

greg k-h
