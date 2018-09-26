Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52921C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070B320657
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070B320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeIZTeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16237 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeIZTeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 929ABC057866;
        Wed, 26 Sep 2018 13:21:24 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6733E600C3;
        Wed, 26 Sep 2018 13:21:20 +0000 (UTC)
Date:   Wed, 26 Sep 2018 21:21:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Kairui Song <kasong@redhat.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Message-ID: <20180926132118.GF2555@MiWiFi-R3L-srv>
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic>
 <20180926073252.GC2555@MiWiFi-R3L-srv>
 <20180926112208.GE2555@MiWiFi-R3L-srv>
 <3b41fee3-e2f6-2e36-d2ca-1074c5f62bb8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b41fee3-e2f6-2e36-d2ca-1074c5f62bb8@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 26 Sep 2018 13:21:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/18 at 01:01pm, Lendacky, Thomas wrote:
> On 09/26/2018 06:22 AM, Baoquan He wrote:
> > On 09/26/18 at 03:32pm, Baoquan He wrote:
> >> On 09/25/18 at 07:26pm, Borislav Petkov wrote:
> >>> IINM, the problem can be addressed in a simpler way by getting rid of
> >>> enc_bit and thus getting rid of the need to do relative addressing of
> >>> anything and simply doing the whole dance of figuring out the C-bit each
> >>> time. It probably wouldn't be even measurable...
> >>
> >> Couldn't agree more.
> >>
> >> Obviously enc_bit is redundent here. We only check eax each time,
> >> removing it can fix the RIP-relative addressing issue in kexec.
> > 
> > OK, in distros CONFIG_AMD_MEM_ENCRYPT=y is set by default usually.
> > enc_bit can save once in normal boot, then fetch and skip the cpuid
> > detection in initialize_identity_maps(). However this only speeds up in
> > amd system with SME, on intel cpu and amd cpu w/o sme, it still needs to
> > do cpuid twice. Removing it should be not measurable as Boris said.
> > Not sure if Tom has other concern.
> 
> No concern from me.  The original version of the patch did not cache the
> value, that was added based on the patch series feedback.  So, if there
> is no concern about executing some extra CPUID/RDMSR instructions, then
> it would certainly simplify the code quite a bit.

OK, thanks for confirming this, Tom.

Then, maybe Kairui can repost below code with formal patch log after
testing. I have tested on a intel machine with 48G memory, and
CONFIG_AMD_MEM_ENCRYPT=y, it works well. Maybe add Boris's Suggested-By,
and CC me.

Thanks
Baoquan

> >>
> >> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> >> index eaa843a52907..0b60eb867d25 100644
> >> --- a/arch/x86/boot/compressed/mem_encrypt.S
> >> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> >> @@ -27,19 +27,6 @@ ENTRY(get_sev_encryption_bit)
> >>  	push	%edx
> >>  	push	%edi
> >>  
> >> -	/*
> >> -	 * RIP-relative addressing is needed to access the encryption bit
> >> -	 * variable. Since we are running in 32-bit mode we need this call/pop
> >> -	 * sequence to get the proper relative addressing.
> >> -	 */
> >> -	call	1f
> >> -1:	popl	%edi
> >> -	subl	$1b, %edi
> >> -
> >> -	movl	enc_bit(%edi), %eax
> >> -	cmpl	$0, %eax
> >> -	jge	.Lsev_exit
> >> -
> >>  	/* Check if running under a hypervisor */
> >>  	movl	$1, %eax
> >>  	cpuid
> >> @@ -69,12 +56,10 @@ ENTRY(get_sev_encryption_bit)
> >>  
> >>  	movl	%ebx, %eax
> >>  	andl	$0x3f, %eax		/* Return the encryption bit location */
> >> -	movl	%eax, enc_bit(%edi)
> >>  	jmp	.Lsev_exit
> >>  
> >>  .Lno_sev:
> >>  	xor	%eax, %eax
> >> -	movl	%eax, enc_bit(%edi)
> >>  
> >>  .Lsev_exit:
> >>  	pop	%edi
> >> @@ -113,9 +98,6 @@ ENTRY(set_sev_encryption_mask)
> >>  ENDPROC(set_sev_encryption_mask)
> >>  
> >>  	.data
> >> -enc_bit:
> >> -	.int	0xffffffff
> >> -
> >>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >>  	.balign	8
> >>  GLOBAL(sme_me_mask)
