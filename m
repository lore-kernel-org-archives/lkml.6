Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937321AbeE3IIw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:08:52 -0400
Received: from foss.arm.com ([217.140.101.70]:51762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935852AbeE3II1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:08:27 -0400
Date: Wed, 30 May 2018 09:08:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Nixiaoming <nixiaoming@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180530080816.f74elebj4demiohl@salmiak>
References: <20180529133615.26889-1-nixiaoming@huawei.com>
 <20180529154523.GK17159@arm.com>
 <E490CD805F7529488761C40FD9D26EF12A672E03@dggemm507-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A672E03@dggemm507-mbx.china.huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 03:31:38AM +0000, Nixiaoming wrote:
> Unable to set CONFIG_STRICT_KERNEL_RWX=n by make menuconfig ARCH=arm64

Indeed. Making this mandatory was a deliberate decision, in part because this
allows simplification of code (e.g. removal of #ifdef guards).

> When reading the code, I feel it is more appropriate to add macro control
> here.

I must disagree. I do not think it makes sense to add an #ifdef for a
configuration option that is mandatory.

There are other places in the kernel that should behave differently if
CONFIG_STRICT_KERNEL_RWX were disabled, so this wouldn't be sufficient even if
we were to make CONFIG_STRICT_KERNEL_RWX optional. i.e. the #ifdef would give
the misleading impression that STRICT_KERNEL_RWX *could* be made optional, even
though this might not function correctly.

Having an #ifdef here makes the code more complicated and confusing, for the
benefit of a case which cannot occur.

Thanks,
Mark.

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com] 
> Sent: Tuesday, May 29, 2018 11:45 PM
> To: Nixiaoming <nixiaoming@huawei.com>
> Cc: catalin.marinas@arm.com; ard.biesheuvel@linaro.org; marc.zyngier@arm.com; james.morse@arm.com; kristina.martsenko@arm.com; steve.capper@arm.com; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; akpm@linux-foundation.org; vbabka@suse.cz; mhocko@suse.com; dave.hansen@linux.intel.com; dan.j.williams@intel.com; kirill.shutemov@linux.intel.com; zhang.jia@linux.alibaba.com; schwidefsky@de.ibm.com; heiko.carstens@de.ibm.com; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; x86@kernel.org; linux-s390@vger.kernel.org
> Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
> 
> On Tue, May 29, 2018 at 09:36:15PM +0800, nixiaoming wrote:
> > mark_rodata_ro is only called by the function mark_readonly when
> > CONFIG_STRICT_KERNEL_RWX=y,
> > if CONFIG_STRICT_KERNEL_RWX is not set
> > a compile warning may be triggered: unused function
> 
> How are you achieving this configuration? In our Kconfig we select this
> unconditionally.
> 
> Will
