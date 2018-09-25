Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08981C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06A320842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06A320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIYXeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:32816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeIYXeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F47EACD1;
        Tue, 25 Sep 2018 17:26:05 +0000 (UTC)
Date:   Tue, 25 Sep 2018 19:26:08 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Kairui Song <kasong@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Message-ID: <20180925172608.GB15464@zn.tnic>
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:33:48PM +0000, Lendacky, Thomas wrote:
> On 09/25/2018 06:10 AM, Kairui Song wrote:
> > Commit 1958b5fc4010 ("x86/boot: Add early boot support when running
> > with SEV active") is causing kexec becomes sometimes unstable, kexec
> > reboot won't start a second kernel bypassing BIOS boot process, instead,
> > the system got reset.
> > 
> > That's because, in get_sev_encryption_bit function, we are using
> > 32-bit RIP-relative addressing to read the value of enc_bit, but
> > kexec may alloc the early boot up code to a higher location, which
> > is beyond 32-bit addressing limit. Some garbage will be read and
> > get_sev_encryption_bit will return the wrong value, which lead to
> > wrong memory page flag.
> > 
> > This patch adds a get_sev_encryption_bit_64 function to avoid this
> > problem. 64-bit early boot code will use this function instead, it
> > uses native RIP addressing to read the enc_bit which have no problem
> > with any location.
> > 
> > Fixes: 1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> > ---
> >  arch/x86/boot/compressed/mem_encrypt.S | 64 ++++++++++++++++++--------
> >  1 file changed, 45 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> > index eaa843a52907..41933550449a 100644
> > --- a/arch/x86/boot/compressed/mem_encrypt.S
> > +++ b/arch/x86/boot/compressed/mem_encrypt.S
> > @@ -18,27 +18,13 @@
> >  
> >  	.text
> >  	.code32
> > -ENTRY(get_sev_encryption_bit)
> > +do_get_sev_encryption_bit:
> >  	xor	%eax, %eax
> >  
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >  	push	%ebx
> >  	push	%ecx
> >  	push	%edx
> > -	push	%edi
> > -
> > -	/*
> > -	 * RIP-relative addressing is needed to access the encryption bit
> > -	 * variable. Since we are running in 32-bit mode we need this call/pop
> > -	 * sequence to get the proper relative addressing.
> > -	 */
> > -	call	1f
> > -1:	popl	%edi
> > -	subl	$1b, %edi
> > -
> > -	movl	enc_bit(%edi), %eax
> > -	cmpl	$0, %eax
> > -	jge	.Lsev_exit
> >  
> >  	/* Check if running under a hypervisor */
> >  	movl	$1, %eax
> > @@ -69,25 +55,65 @@ ENTRY(get_sev_encryption_bit)
> >  
> >  	movl	%ebx, %eax
> >  	andl	$0x3f, %eax		/* Return the encryption bit location */
> > -	movl	%eax, enc_bit(%edi)

IINM, the problem can be addressed in a simpler way by getting rid of
enc_bit and thus getting rid of the need to do relative addressing of
anything and simply doing the whole dance of figuring out the C-bit each
time. It probably wouldn't be even measurable...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
