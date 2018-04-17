Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQJ22 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:28:28 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:16088 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751927AbeDQJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:28:27 -0400
From: David Wang <davidwang@zhaoxin.com>
To: "'Borislav Petkov'" <bp@alien8.de>
CC: <tony.luck@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <brucechang@via-alliance.com>,
        <cooperyan@zhaoxin.com>, <qiyuanwang@zhaoxin.com>,
        <benjaminpan@viatech.com>, <lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH v2 1/2] x86/mce: new Centaur CPUs support MCE broadcasting
Date: Tue, 17 Apr 2018 17:27:55 +0800
Message-ID: <000101d3d62e$5dcbe6c0$1963b440$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPWKbZhUsVlAZZOT3SRjL+3rXm3aQ==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----邮件原件-----
> 发件人: Borislav Petkov [mailto:bp@alien8.de]
> 发送时间: 2018年4月16日 21:28
> 收件人: David Wang <davidwang@zhaoxin.com>
> 抄送: tony.luck@intel.com; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org; brucechang@via-alliance.com;
> cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> 主题: Re: [PATCH v2 1/2] x86/mce: new Centaur CPUs support MCE
> broadcasting
> 
> On Mon, Apr 02, 2018 at 11:33:51AM +0800, David Wang wrote:
> > This patch is used to tell the kernel that newer Centaur CPU support
> 
> Avoid writing "This patch" in the commit message of a patch. It is
> tautologically useless.

> 
> > MCE broadcasting.
> >
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> > ---
> >  arch/x86/kernel/cpu/mcheck/mce.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c
> > b/arch/x86/kernel/cpu/mcheck/mce.c
> > index 7065846..c3db7ce 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -1688,6 +1688,17 @@ static int __mcheck_cpu_apply_quirks(struct
> > cpuinfo_x86 *c)
> 
> This code doesn't belong in the "apply_quirks" function but in
> __mcheck_cpu_init_vendor(). Just add a X86_VENDOR_CENTAUR case
> there.
> 
> I know, I know, there's a similar Intel piece which does the same thing but all
> that quirks code should go to the vendor-specific init functions and the quirks
> function be deleted. One day when I get bored...
> 
> >  		if (c->x86 == 6 && c->x86_model == 45)
> >  			quirk_no_way_out = quirk_sandybridge_ifu;
> >  	}
> > +
> > +	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> > +		/*
> > +		 * All newer Centaur CPUs support MCE broadcasting. Enable
> > +		 * synchronization with a one second timeout.
> > +		 */
> > +		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf &&
> > +c->x86_mask >=0xe)) &&
> 
> arch/x86/kernel/cpu/mcheck/mce.c: In function
> ‘__mcheck_cpu_apply_quirks’:
> arch/x86/kernel/cpu/mcheck/mce.c:1688:64: error: ‘struct cpuinfo_x86’ has
> no member named ‘x86_mask’; did you mean ‘x86_model’?
>    if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask
> >=0xe)) &&
>                                                                 ^~~~~~~~
>                                                                 x86_model
> 
> and no, it needs to be x86_stepping.
> 
> Also,
> 
> ERROR: spaces required around that '>=' (ctx:WxV)
> #40: FILE: arch/x86/kernel/cpu/mcheck/mce.c:1697:
> +               if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf
> + && c->x86_mask >=0xe)) &&
>                                                                                       ^
> 
> Please integrate scripts/checkpatch.pl into your patch creation workflow.
> Some of the warnings/errors *actually* make sense.
> 
> Thx.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
I will send patch v3 to solve all questions you listed.
Thx.

---
David
