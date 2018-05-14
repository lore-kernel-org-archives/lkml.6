Date: Mon, 14 May 2018 16:17:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] uio: Prevent kernel oops on UIO device remove
 with open fds
Message-ID: <20180514141701.GA24912@kroah.com>
References: <20180514013223.4828-1-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514013223.4828-1-hamish.martin@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 01:32:21PM +1200, Hamish Martin wrote:
> If a UIO device is removed while a user space app has an open file 
> descriptor to that device's /dev/uio* file, a kernel oops can occur when
> the file descriptor is ultimately closed. The oops is triggered by
> dereferencing either the uio_listener struct's 'dev' pointer, or at the
> next level, when dereferencing a stale 'info' pointer on that dev.
> 
> To resolve this we now increment the reference count for the uio_device
> and prevent the destruction of the uio_device until all open file
> descriptors are closed.
> A further consequence of resolving the stale pointers to the uio_device
> is that it exposes an issue with the independent life cycles of the 
> uio_device and its related uio_info. The uio_info struct is allocated by
> the user of the uio subsystem and connected to a uio_device at 
> registration time (see __uio_register_device()). When the device
> corresponding to that uio_info is unregistered and the memory for the 
> uio_info is freed, the uio_device is left with a stale pointer which may
> still be used in the file system ops (uio_poll(), uio_read(), etc)
> To resolve this second issue, we now lock alteration or access of the
> 'info' member of the uio_device struct and alter the accessing code to 
> handle that pointer being null.
> 
> This patch series contains two patches. The first is a cosmetic change
> to the return paths from uio_write to facilitate easier review of the 
> second patch. The second patch contains the change to prevent destruction
> of the uio_device while file descriptors to it remain open and the
> additional locking to prevent the use of a stale 'info' pointer.
> 
> This patch series is heavily based on the work done by Brian Russell
> (formerly of Brocade) in May 2015. His last version of an attempt to fix
> this is seen here:
> https://patchwork.kernel.org/patch/6057431/
> My new addition is the locking around use of the info pointer. It is my
> proposed solution to Brian's last comment about what he had left
> unfinished: 
>     "It needs a bit more work. uio_info needs to live as long as the 
>      corresponding uio_device. Since they seem to always be 1:1, 
>      uio_info could embedded within uio_device (but then all the users
>      of uio need changed) or uio_info could be a refcounted object."
> 
> For further info here is an example of the kernel oops this patch series
> is trying to resolve. Output is from a 4.17.0-rc1 kernel with a test app
> opening a uio device and doing select with the fd, then removing the UIO
> device while the select is still happening:
> 
> Unable to handle kernel paging request for data at address 0x6b6b6b6b6b6b6d63
> Faulting instruction address: 0xc000000000605c98
> Oops: Kernel access of bad area, sig: 11 [#1]
> BE PREEMPT SMP NR_CPUS=8 CoreNet Generic
> Modules linked in:
> CPU: 6 PID: 282 Comm: uio_tester Not tainted 4.17.0-rc1-at1+ #8
> NIP:  c000000000605c98 LR: c000000000211d8c CTR: c000000000605c60
> REGS: c0000000f02f3480 TRAP: 0300   Not tainted  (4.17.0-rc1-at1+)
> MSR:  000000008202b000 <VEC,CE,EE,FP,ME>  CR: 24284448  XER: 20000000
> DEAR: 6b6b6b6b6b6b6d63 ESR: 0000000000000000 SOFTE: 0 
> GPR00: c000000000211d8c c0000000f02f3700 c000000000dc7d00 c0000000ef365bc0 
> GPR04: c0000000f02f3800 0000000000000000 c0000000ef4b9b58 0000000000000006 
> GPR08: c000000000605c60 6b6b6b6b6b6b6b6b 0000000000000000 0000000000000016 
> GPR12: 0000000042284448 c00000003fffd440 0000000000000004 0000000000000003 
> GPR16: 0000000000000008 0000000000000000 00000000ef365bc0 0000000000000000 
> GPR20: c0000000f02f3c00 0000000000000000 0000000000000000 c0000000ef365bc0 
> GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR28: c0000000f02f3800 c0000000ef365bc0 c0000000f02c2c68 c0000000efd01d20 
> NIP [c000000000605c98] .uio_poll+0x38/0xe0
> LR [c000000000211d8c] .do_select+0x39c/0x7a0
> Call Trace:
> [c0000000f02f3700] [c0000000f02f3790] 0xc0000000f02f3790 (unreliable)
> [c0000000f02f3790] [c000000000211d8c] .do_select+0x39c/0x7a0
> [c0000000f02f3b90] [c000000000212eac] .core_sys_select+0x22c/0x320
> [c0000000f02f3d70] [c000000000213098] .__se_sys_select+0xf8/0x170
> [c0000000f02f3e30] [c000000000000674] system_call+0x58/0x64
> Instruction dump:
> f8010010 fba1ffe8 fbc1fff0 fbe1fff8 f821ff71 7c7d1b78 7c9c2378 60000000 
> 60000000 ebdd00c0 ebfe0000 e93f0038 <e92901f8> 2fa90000 40de0030 3c60ffff 
> ---[ end trace 8badf75b83f45856 ]---


Very nice work, thanks for doing this.  I've now queued it up.

greg k-h
