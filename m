Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B4DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182DF208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LjKZgPZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182DF208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbeHAU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:29:42 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:44406 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeHAU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:29:42 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 262EC10C0537;
        Wed,  1 Aug 2018 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533148956; bh=8Yiyf4GCKO1xo26bwaxbjG/+LSiWTb2Wb2qmK/WcQlA=;
        h=From:To:CC:Subject:Date:References:From;
        b=LjKZgPZk5V4X5Ps/dspeKNl2idUh1ZTcQheA6OoRk2bYJUdaWkA8g0Xtv0Rwh5WIv
         7mkWryI15UAQlJQ6jKMHdwxeY/rS2V0NrGHmml3dOeIkucAQgZFs1tnE40bbn4nRpQ
         G4HXU6974DymcHix2wKpIAk9QEFmd649Iz0cnAmLiMRPuJXQSdg0kH64baBlpBmfMJ
         NfS7kuwGKbz2uRojpGxROPrqvgijNflplaNLM6enmP+c6ucVqzEeyv68WQm/+u3a5P
         Kzh9AzY8H6uQBzCfL61YoB+3aRabASwYtl2k4CQjd8pun78vVKrrU3FSlbPqTJAax3
         x+3QA2+CBjDGw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id E60D93859;
        Wed,  1 Aug 2018 11:42:35 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed, 1
 Aug 2018 11:42:35 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: ARC show_regs() triggers preempt debug splat, lockdep
Thread-Topic: ARC show_regs() triggers preempt debug splat, lockdep
Thread-Index: AQHUKRVH/3j8ZKqtM0K042sEqj7ing==
Date:   Wed, 1 Aug 2018 18:42:34 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B088811@us01wembx1.internal.synopsys.com>
References: <5c3cfd4d-46d2-d817-a29a-1890d84c1fbb@synopsys.com>
 <20180801075317.GZ2494@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 12:53 AM, Peter Zijlstra wrote:=0A=
> On Tue, Jul 31, 2018 at 02:26:32PM -0700, Vineet Gupta wrote:=0A=
>> Hi Peter, Al,=0A=
>>=0A=
>> Reaching out about a problem I understand, but not quite sure how to fix=
 it.=0A=
>> Its the weird feeling of how was this working all along, if at all.=0A=
>>=0A=
>> With print-fatal-signals enabled, there's CONFIG_DEBUG_PREEMPT splat all=
 over,=0A=
>> even with a simple single threaded segv inducing program (console log be=
low). This=0A=
>> originally came to light with a glibc test suite tst-tls3-malloc which i=
s a=0A=
>> multi-threaded monster.=0A=
>>=0A=
>> ARC show_regs() is a bit more fancy as it tries to print the executable =
path,=0A=
>> faulting vma name (in case it was a shared lib etc). This involves takin=
g a bunch=0A=
>> of customary locks which seems to be tripping the debug infra.=0A=
> Right, so I think that that is a fairly dodgy thing to do. As shown in=0A=
> your subsequent email, if a pagefault generates a signal we might=0A=
> already be holding the mmap_sem.=0A=
>=0A=
> The thing you could do is maybe use down_read_trylock() there.=0A=
>=0A=
> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoo=
t.c=0A=
> index 783b20354f8b..bb7bde11d2c8 100644=0A=
> --- a/arch/arc/kernel/troubleshoot.c=0A=
> +++ b/arch/arc/kernel/troubleshoot.c=0A=
> @@ -92,7 +92,10 @@ static void show_faulting_vma(unsigned long address, c=
har *buf)=0A=
>  	/* can't use print_vma_addr() yet as it doesn't check for=0A=
>  	 * non-inclusive vma=0A=
>  	 */=0A=
> -	down_read(&active_mm->mmap_sem);=0A=
> +	if (!down_read_trylock(&active_mm->mmap_sem)) {=0A=
> +		pr_info("    @Trylock failed\n");=0A=
> +		return;=0A=
> +	}=0A=
>  	vma =3D find_vma(active_mm, address);=0A=
>  =0A=
>  	/* check against the find_vma( ) behaviour which returns the next VMA=
=0A=
=0A=
That's not the only issue here. We also call page allocator in show_regs co=
de path=0A=
and that barfs as well with __might_sleep.=0A=
=0A=
I think for us, it would make sense to re-enable preemption inside ARC show=
_regs()=0A=
- undoing the generic disable from get_signal()=0A=
The rationale for that in first place, per commit 3a9f84d354ce1 was some ar=
ch=0A=
(x86?) show_regs() calling smp_processor_id(). Arguable that could call the=
=0A=
raw_smp variant, but we don't want to needlessly bother rest of the world.=
=0A=
=0A=
Do you see any pitfall with my proposal ?=0A=
=0A=
-Vineet=0A=
