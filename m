Date: Tue, 6 Mar 2018 02:57:48 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Seunghun Han <kkamagui@gmail.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] x86: mce: fix kernel panic when check_interval is
 changed
Message-ID: <20180306105748.GA31087@kroah.com>
References: <20180302202706.9434-1-kkamagui@gmail.com>
 <20180306104320.GB11535@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306104320.GB11535@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 11:43:20AM +0100, Borislav Petkov wrote:
> On Sat, Mar 03, 2018 at 05:27:06AM +0900, Seunghun Han wrote:
> > I am Seunghun Han and a senior security researcher at National Security
> > Research Institute of South Korea.
> > 
> > I found a security issue which can make kernel panic in userspace. After
> > analyzing the issue carefully, I found that MCE driver in the kernel has a
> > problem which can be occurred in SMP environment.
> > 
> > The check_interval file in
> > /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
> > global timer value for MCE polling. If it is changed by one CPU, MCE driver
> > in kernel calls mce_restart() function in store_int_with_restart() function
> > and broadcasts the event to other CPUs to delete and restart MCE polling
> > timer.
> > 
> > The __mcheck_cpu_init_timer() function which is called by mce_restart()
> > function initializes the mce_timer variable, and the "lock" in mce_timer is
> > also reinitialized. If more than one CPU write a specific value to
> > check_interval file concurrently, one can initialize the "lock" in mce_timer
> > while the others are handling "lock" in mce_timer. This problem causes some
> > synchronization errors such as kernel panic and kernel hang. Other functions
> > such as set_ignore_ce(), set_cmci_disabled(), and mce_enable_ce() also
> > have synchronization problems.
> > 
> > It could be a security problem because the attacker could make kernel panic
> > by writing a value to the check_interval file in userspace, and it could be
> > used for Denial-of-Service (DoS) attack.
> > 
> > To fix this problem, I added a mce_sysfs_mutex to serialize requests for
> > timer and sysfs functions.
> > 
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> > ---
> > Changes since v2: add a mutex to sysfs functions according to review
> > result.
> > Changes since v1: add mce_sysfs_mutex according to review result.
> 
> Thanks, I've committed the patch below. Scream if there's still
> something not in order:

It would have been nice to add a cc:stable for this, but I'll try to
watch it and when it hits Linus's tree I'll queue it up there.

thanks,

greg k-h
