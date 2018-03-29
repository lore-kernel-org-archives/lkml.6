Date: Thu, 29 Mar 2018 18:44:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel+linux-char@molgen.mpg.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: Reduce init time of `lp_init()` and `ppdev_init()`
Message-ID: <20180329164409.GA6268@kroah.com>
References: <447729e0-b026-80aa-bfb3-7d2781d32409@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <447729e0-b026-80aa-bfb3-7d2781d32409@molgen.mpg.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 05:57:20PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I am trying to reduce the start-up time of the Linux kernel on an old Lenovo
> X60. Looking through the time stamps of Linux 4.16-rc7+, the modules `lp`
> and `ppdev` both take more than ten milliseconds to initialize according to
> `initcall_debug`.
> 
> ```
> [    8.337692] calling  parport_default_proc_register+0x0/0x1000 [parport] @
> 245
> [    8.337735] initcall parport_default_proc_register+0x0/0x1000 [parport]
> returned 0 after 30 usecs
> [    8.359066] calling  lp_init_module+0x0/0x1000 [lp] @ 245
> [    8.381317] lp: driver loaded but no devices found
> [    8.385310] initcall lp_init_module+0x0/0x1000 [lp] returned 0 after
> 25613 usecs
> [    8.401727] calling  ppdev_init+0x0/0x1000 [ppdev] @ 245
> [    8.411427] ppdev: user-space parallel port driver
> [    8.415390] initcall ppdev_init+0x0/0x1000 [ppdev] returned 0 after 13329
> usecs
> [    8.434018] calling  parport_pc_init+0x0/0xeed [parport_pc] @ 245
> [    8.435657] initcall parport_pc_init+0x0/0xeed [parport_pc] returned 0
> after 1589 usecs
> [    9.343691] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro,discard
> [    9.742084] systemd-journald[271]: Received request to flush runtime
> journal from PID 1
> [   10.049050] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 297
> [   10.049668] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned
> 0 after 581 usecs
> ```
> 
> Furthermore, looking at the messages, it looks like it’s in the “hotpath”.
> If that is true, is there a way to load that in parallel of the other Linux
> kernel stuff?
> 
> Hints to get more insight are much appreciated.

Yes, either turn those into modules, which will get loaded later at boot
time, or turn on async probing for them and see if that works.

Or better yet, don't load them at all until after userspace fully starts
with an init script as part of an early bringup of cups.  Odds are you
don't need those modules at all to start the machine, right?

thanks,

greg k-h
