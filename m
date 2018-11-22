Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B406C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E420820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75E420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392835AbeKVSp1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:45:27 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:47718 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbeKVSp1 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Thu, 22 Nov 2018 13:45:27 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 22 Nov 2018 01:07:07 -0700
Message-Id: <5BF663A902000078001FEBB6@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Thu, 22 Nov 2018 01:07:05 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Andrew Lutomirski" <luto@kernel.org>
Cc:     <mingo@elte.hu>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH v2] x86-64/Xen: fix stack switching
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <5AF03EBD02000000000F91D6@prv1-mh.provo.novell.com>
 <5AF03EBD02000078001FE590@prv1-mh.provo.novell.com>
 <5BF52F0E02000078001FE5BE@prv1-mh.provo.novell.com>
 <CALCETrUa4iw+y+EXSqq_ibJQAfR0+U52Q=tO8_bj1YJgtMUP+Q@mail.gmail.com>
In-Reply-To: <CALCETrUa4iw+y+EXSqq_ibJQAfR0+U52Q=tO8_bj1YJgtMUP+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 21.11.18 at 16:24, <luto@kernel.org> wrote:
> On Wed, Nov 21, 2018 at 2:10 AM Jan Beulich <JBeulich@suse.com> wrote:
>> --- 4.20-rc3/arch/x86/entry/entry_64.S
>> +++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64.S
>> @@ -1380,6 +1380,12 @@ ENTRY(nmi)
>>         swapgs
>>         cld
>>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
>> +
>> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rdx
>> +       subq    $8, %rdx
>> +       xorq    %rsp, %rdx
>> +       shrq    $PAGE_SHIFT, %rdx
>> +       jz      .Lnmi_keep_stack
> 
> This code shouldn't even be reachable on Xen:
> 
> commit 43e4111086a70c78bedb6ad990bee97f17b27a6e
> Author: Juergen Gross <jgross@suse.com>
> Date:   Thu Nov 2 00:59:07 2017 -0700
> 
>     xen, x86/entry/64: Add xen NMI trap entry
> 
>     Instead of trying to execute any NMI via the bare metal's NMI trap
>     handler use a Xen specific one for PV domains, like we do for e.g.
>     debug traps. As in a PV domain the NMI is handled via the normal
>     kernel stack this is the correct thing to do.
> 
>     This will enable us to get rid of the very fragile and questionable
>     dependencies between the bare metal NMI handler and Xen assumptions
>     believed to be broken anyway.

Oh, I didn't notice this. The beginnings of the patch here pre-date
this, though, and then I didn't notice the addition. Thanks for
pointing this out.

>> --- 4.20-rc3/arch/x86/entry/entry_64_compat.S
>> +++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64_compat.S
>> @@ -361,17 +361,23 @@ ENTRY(entry_INT80_compat)
>>
>>         /* Need to switch before accessing the thread stack. */
>>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
>> +
>> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rdi
>> +       subq    $8, %rdi
>> +       xorq    %rsp, %rdi
>> +       shrq    $PAGE_SHIFT, %rdi
>> +       jz      .Lint80_keep_stack
> 
> This comparison is IMO the wrong test entirely.  How about something like:
> 
> /* On Xen PV, entry_INT80_compat is called on the thread stack, so
> rewinding to the top of the thread stack would allow an NMI to
> overwrite the hardware frame before we copy it. */
> ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV

Indeed I had noted this as an alternative option in v1, but
didn't get respective feedback. If that's the preferred route, I'll
certainly switch.

Jan


