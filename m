Date: Fri, 23 Feb 2018 11:52:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Seunghun Han <kkamagui@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mce: fix kernel panic when check_interval is changed
Message-ID: <20180223105220.GA12058@kroah.com>
References: <20180223101350.8344-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223101350.8344-1-kkamagui@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:13:50PM +0900, Seunghun Han wrote:
> I am Seunghun Han and a senior security researcher at National Security
> Research Institute of South Korea.
> 
> I found a critical security issue which can make kernel panic in userspace.
> After analyzing the issue carefully, I found that MCE driver in the kernel
> has a problem which can be occurred in SMP environment.
> 
> The check_interval file in
> /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
> global timer value for MCE polling. If it is changed by one CPU, MCE driver
> in kernel calls mce_restart() function and broadcasts the event to other
> CPUs to delete and restart MCE polling timer.
> 
> The __mcheck_cpu_init_timer() function which is called by mce_restart()
> function initializes the mce_timer variable, and the "lock" in mce_timer is
> also reinitialized. If more than one CPU write a specific value to
> check_interval file concurrently, one can initialize the "lock" in mce_timer
> while the others are handling "lock" in mce_timer. This problem causes some
> synchronization errors such as kernel panic and kernel hang.
> 
> It is a critical security problem because the attacker can make kernel panic
> by writing a value to the check_interval file in userspace, and it can be
> used for Denial-of-Service (DoS) attack.

As only root can write to that file, it's not that critical of an issue,
but yes, this is a problem.  Nice find and fix.

> 
> To fix this problem, I changed the __mcheck_cpu_init_timer() function to
> reuse mce_timer instead of initializing it. The purpose of the function is
> to restart the timer and it can be archived by calling
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

Cc: stable <stable@vger.kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
