Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78513ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC52151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CC52151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJQRtf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:49:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50521 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:49:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-40-FM-8Kyn4MT2FGhpcUyLEPg-1; Wed, 17 Oct 2018 10:54:36 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 17 Oct 2018 10:54:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Oct 2018 10:54:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Thread-Topic: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Thread-Index: AQHUZY51U8Z+zAYLBkKoYwavGs3hNaUjMz8g
Date:   Wed, 17 Oct 2018 09:54:38 +0000
Message-ID: <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
In-Reply-To: <20181016202525.29437-2-bigeasy@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: FM-8Kyn4MT2FGhpcUyLEPg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior
> Sent: 16 October 2018 21:25
> I've seen the WARN_ON_ONCE(__read_cr3() != build_cr3()) in
> switch_mm_irqs_off() every once in a while during a snapshotted system
> upgrade.
> I also saw the warning early during which was introduced in commit
> decab0888e6e ("x86/mm: Remove preempt_disable/enable() from
> __native_flush_tlb()"). The callchain is
> 
>   get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()
> 
> with CONFIG_DEBUG_PAGEALLOC enabled.
> 
> Turns out, once I disable preemption around __flush_tlb_all() both
> warnings do not appear.
> 
> Disable preemption during CR3 reset / __flush_tlb_all().
> 
> Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/mm/pageattr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 51a5a69ecac9f..fe6b21f0a6631 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>  	 * We should perform an IPI and flush all tlbs,
>  	 * but that can deadlock->flush only current cpu:
>  	 */
> +	preempt_disable();
>  	__flush_tlb_all();
> +	preempt_enable();

Can it make any sense to flush the tlb with preemption enabled?
Surely preemption must be disabled over something else as well?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

