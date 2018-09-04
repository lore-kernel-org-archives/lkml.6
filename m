Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47669C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F4B2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F4B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIDQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:47:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56932 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeIDQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:47:10 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxALO-0005HI-IV; Tue, 04 Sep 2018 14:22:06 +0200
Date:   Tue, 4 Sep 2018 14:22:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com
Subject: Re: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
In-Reply-To: <1534814186-37067-5-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com> <1534814186-37067-5-git-send-email-bin.yang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Bin Yang wrote:
>  
> +static inline bool
> +overlap(unsigned long start1, unsigned long end1,
> +		unsigned long start2, unsigned long end2)
> +{
> +	/* Is 'start2' within area 1? */
> +	if (start1 <= start2 && end1 > start2)
> +		return true;
> +
> +	/* Is 'start1' within area 2? */
> +	if (start2 <= start1 && end2 > start1)
> +		return true;
> +
> +	return false;

>  static inline unsigned long highmap_start_pfn(void)
> @@ -293,7 +308,7 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
>   * checks and fixes these known static required protection bits.
>   */
>  static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
> -				   unsigned long pfn)
> +				   unsigned long len, unsigned long pfn)
>  {
>  	pgprot_t forbidden = __pgprot(0);
>  
> @@ -302,7 +317,9 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
>  	 * PCI BIOS based config access (CONFIG_PCI_GOBIOS) support.
>  	 */
>  #ifdef CONFIG_PCI_BIOS
> -	if (pcibios_enabled && within(pfn, BIOS_BEGIN >> PAGE_SHIFT, BIOS_END >> PAGE_SHIFT))
> +	if (pcibios_enabled &&
> +	    overlap(pfn, pfn + PFN_DOWN(len),
> +		    PFN_DOWN(BIOS_BEGIN), PFN_DOWN(BIOS_END)))

This is completely unreadable and aside of that it is wrong. You cannot do
an overlap check with the following constraints:

   	   range1_end = range1_start + size;
   	   range2_end = range2_start + size;

See the definition of BIOS_END. It's 0x100000, i.e. 1MB, so the following
overlap check will give you the false result:

	overlap(256, 258, 0x000a0000 >> 12, 0x0010000 >> 12)

because

	0x0010000 >> 12 = 256

ergo will overlap return true. All of your overlap checks are broken.

Oh well.

Thanks,

	tglx


