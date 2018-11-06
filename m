Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE022083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EowAh7NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE022083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeKFKLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:11:01 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50904 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:11:00 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5677110C0266;
        Mon,  5 Nov 2018 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541465312; bh=edo+WmzUiBruAdNRiTVkFrkXQXJ/Q3lX7GQp7PE5elk=;
        h=From:To:CC:Subject:Date:References:From;
        b=EowAh7NYwGokBAqOltdnAnk+19ued/4TkD/w2qTJ0ocJ+LazjiS3uucYyRlKI8i0p
         BhcPWSHo3tP2HUvvUuJRA14MKUW9y6BLNbiqYctTgt2YS0xajODVYnSIYp2/Etk9sc
         CNYSvsYpQT5UGaDcAnzE4GGRKxBelqU7b624D9c7wx0/U/wpkGcoW88NPv+z3rbsv5
         H9aBjp/hBVjjhOV7N+99GR1clwDNEZ25iNrlg5kE4lroSSLtHyx4FkiRnzrokUHfOu
         GTSZ/Kh8iUq58WaRRKoTe4pvC2CYtDL7IvoiC1PNga98cmVojhb8hX7MnRjdVYyGSG
         NsxXvjzOdyCQA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1776156FD;
        Mon,  5 Nov 2018 16:48:32 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 5
 Nov 2018 16:48:32 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Peter Xu <peterx@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Souptick Joarder" <jrdr.linux@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH RFC] mm: arc: fix potential double realease of mmap_sem
Thread-Topic: [PATCH RFC] mm: arc: fix potential double realease of mmap_sem
Thread-Index: AQHUcZJWAhL05uLd1Uaujch30fnJhg==
Date:   Tue, 6 Nov 2018 00:48:31 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075013A590E5E@us01wembx1.internal.synopsys.com>
References: <20181101032354.19351-1-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 8:24 PM, Peter Xu wrote:=0A=
> In do_page_fault() of ARC we have:=0A=
>=0A=
>         ...=0A=
> 	fault =3D handle_mm_fault(vma, address, flags);=0A=
>=0A=
>         /* If Pagefault was interrupted by SIGKILL, exit page fault "earl=
y" */=0A=
>         if (unlikely(fatal_signal_pending(current))) {=0A=
>                 if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY)=
)=0A=
>                         up_read(&mm->mmap_sem);     <---------------- [1]=
=0A=
>                 if (user_mode(regs))=0A=
>                         return;=0A=
>         }=0A=
>         ...=0A=
> 	if (likely(!(fault & VM_FAULT_ERROR))) {=0A=
>                 ...=0A=
> 		return;=0A=
> 	}=0A=
>=0A=
> 	if (fault & VM_FAULT_OOM)=0A=
> 		goto out_of_memory;                <----------------- [2]=0A=
> 	else if (fault & VM_FAULT_SIGSEGV)=0A=
> 		goto bad_area;                     <----------------- [3]=0A=
> 	else if (fault & VM_FAULT_SIGBUS)=0A=
> 		goto do_sigbus;                    <----------------- [4]=0A=
>=0A=
> Logically it's possible that we might try to release the mmap_sem twice=
=0A=
> by having a scenario like:=0A=
>=0A=
>         - task received SIGKILL,=0A=
>         - task handled kernel mode page fault,=0A=
>         - handle_mm_fault() returned with one of VM_FAULT_ERROR,=0A=
>=0A=
> Then we'll go into path [1] to release the mmap_sem, however we won't=0A=
> return immediately since user_mode(regs) check will fail (a kernel page=
=0A=
> fault).  Then we might go into either [2]-[4] and either of them will=0A=
> try to release the mmap_sem again.=0A=
>=0A=
> To fix this, we only release the mmap_sem at [1] when we're sure we'll=0A=
> quit immediately (after we checked with user_mode(regs)).=0A=
=0A=
Hmm, do_page_fault() needs a serious makeover. There's a known problem in t=
he area=0A=
you touched (with test case) where we fail to relinquish the mmap_sem for w=
hich=0A=
Alexey had provided a fix. But I'm going to redo this part now and CC you f=
olks=0A=
for review. OK ?=0A=
=0A=
>=0A=
> CC: Vineet Gupta <vgupta@synopsys.com>=0A=
> CC: "Eric W. Biederman" <ebiederm@xmission.com>=0A=
> CC: Peter Xu <peterx@redhat.com>=0A=
> CC: Andrew Morton <akpm@linux-foundation.org>=0A=
> CC: Souptick Joarder <jrdr.linux@gmail.com>=0A=
> CC: Andrea Arcangeli <aarcange@redhat.com>=0A=
> CC: linux-snps-arc@lists.infradead.org=0A=
> CC: linux-kernel@vger.kernel.org=0A=
> Signed-off-by: Peter Xu <peterx@redhat.com>=0A=
> ---=0A=
>=0A=
> I noticed this only by reading the code.  Neither have I verified the=0A=
> issue, nor have I tested the patch since I even don't know how to (I'm=0A=
> totally unfamiliar with the arc architecture).  However I'm posting this=
=0A=
> out first to see whether there's any quick feedback, and in case it's a=
=0A=
> valid issue that we've ignored.=0A=
> ---=0A=
>  arch/arc/mm/fault.c | 7 +++----=0A=
>  1 file changed, 3 insertions(+), 4 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c=0A=
> index c9da6102eb4f..2d28c3dad5c1 100644=0A=
> --- a/arch/arc/mm/fault.c=0A=
> +++ b/arch/arc/mm/fault.c=0A=
> @@ -142,11 +142,10 @@ void do_page_fault(unsigned long address, struct pt=
_regs *regs)=0A=
>  	fault =3D handle_mm_fault(vma, address, flags);=0A=
>  =0A=
>  	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */=
=0A=
> -	if (unlikely(fatal_signal_pending(current))) {=0A=
> -		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))=0A=
> +	if (unlikely(fatal_signal_pending(current) && user_mode(regs))) {=0A=
> +		if (!(fault & VM_FAULT_RETRY))=0A=
>  			up_read(&mm->mmap_sem);=0A=
> -		if (user_mode(regs))=0A=
> -			return;=0A=
> +		return;=0A=
>  	}=0A=
>  =0A=
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);=0A=
=0A=
