Date: Tue, 13 Feb 2018 16:29:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
Message-ID: <20180213152907.GA29190@kroah.com>
References: <20180209133931.211869118@linuxfoundation.org>
 <556ea00b-e265-7f14-395c-c5e6629bf194@roeck-us.net>
 <20180213093651.GA29675@kroah.com>
 <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1ed8b1-bd9c-4b9f-051b-f9f19591cdbb@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 06:30:36AM -0800, Guenter Roeck wrote:
> On 02/13/2018 01:36 AM, Greg Kroah-Hartman wrote:
> > On Sat, Feb 10, 2018 at 07:46:50AM -0800, Guenter Roeck wrote:
> > > On 02/09/2018 05:38 AM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.81 release.
> > > > There are 92 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 145 pass: 140 fail: 5
> > > Failed builds:
> > > 	powerpc:defconfig
> > > 	powerpc:allmodconfig
> > > 	powerpc:ppc64e_defconfig
> > > 	powerpc:cell_defconfig
> > > 	powerpc:maple_defconfig
> > > Qemu test results:
> > > 	total: 118 pass: 113 fail: 5
> > > Failed tests:
> > > 	powerpc:mac99:ppc64_book3s_defconfig:nosmp
> > > 	powerpc:mac99:ppc64_book3s_defconfig:smp4
> > > 	powerpc:pseries:pseries_defconfig
> > > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:nosmp
> > > 	powerpc:mpc8544ds:ppc64_e5500_defconfig:smp
> > > 
> > > All builds and tests fail with the following error.
> > > 
> > > arch/powerpc/kernel/setup_64.c:41:25: fatal error: asm/debugfs.h: No such file or directory
> > > 
> > > For older kernels, the backport of 236003e6b5443c4 ("powerpc/64s: Allow control of RFI
> > > flush via debugfs") should include linux/debugfs.h, not asm/debugfs.h.
> > 
> > Thanks for letting me know, I've now fixed this up.  Will go work on the
> > 4.4 patch as well.
> > 
> 
> Unfortunately it wasn't the only problem. Now we have:
> 
> arch/powerpc/kernel/entry_64.S: Assembler messages:
> arch/powerpc/kernel/entry_64.S:260: Error: unrecognized opcode: `rfi_to_user'
> arch/powerpc/kernel/entry_64.S:270: Error: unrecognized opcode: `rfi_to_kernel'
> arch/powerpc/kernel/entry_64.S:885: Error: unrecognized opcode: `rfi_to_user'
> arch/powerpc/kernel/entry_64.S:900: Error: unrecognized opcode: `rfi_to_kernel'
> 
> Looks like 222f20f140623 ("powerpc/64s: Simple RFI macro conversions") is missing,
> or at least part of it. Unfortunately it doesn't apply cleanly.

Ugh.  Let's see if the ppc developers care about this or not :)

> 4.4 also now has a different failure.
> 
> In file included from drivers/staging/rdma/ehca/hcp_if.c:45:0:
> arch/powerpc/include/asm/hvcall.h:439:2: error: unknown type name 'u64'
>   u64 character;
>   ^
> arch/powerpc/include/asm/hvcall.h:440:2: error: unknown type name 'u64'
>   u64 behaviour;
> 
> You'll need 1b689a95ce742 to fix that problem.

Now queued up, thanks.

greg k-h
