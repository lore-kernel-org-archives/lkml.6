Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD71F20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeIDCTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:19:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeIDCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:19:20 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwwqI-0001eg-TS; Mon, 03 Sep 2018 23:57:07 +0200
Date:   Mon, 3 Sep 2018 23:57:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com
Subject: Re: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
In-Reply-To: <1534814186-37067-2-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com> <1534814186-37067-2-git-send-email-bin.yang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, Bin Yang wrote:
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -629,6 +629,22 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  	new_prot = static_protections(req_prot, address, pfn);
>  
>  	/*
> +	 * The static_protections() is used to check specific protection flags
> +	 * for certain areas of memory. The old pgprot should be checked already
> +	 * when it was applied before. If it's not, then this is a bug in some
> +	 * other code and needs to be fixed there.
> +	 *
> +	 * If new pgprot is same as old pgprot, return directly without any
> +	 * additional checking. The following static_protections() checking is
> +	 * pointless if pgprot has no change. It can avoid the redundant
> +	 * checking and optimize the performance of large page split checking.
> +	 */
> +	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {

This is actually broken.

Assume that for the start address:

       req_prot != old_prot
and
       new_prot != req_prot
and
       new_prot == old_prot
and
       numpages > number_of_static_protected_pages(address)

Then the new check will return with split = NO and the pages after the
static protected area won't be updated -> FAIL! IOW, you partially
reintroduce the bug which was fixed by adding this check loop.

So this is a new optimization check which needs to be:

	if (pgprot_val(req_prot) == pgprot_val(old_prot))

and that check wants to go above:

  	new_prot = static_protections(req_prot, address, pfn);

Both under the assumption that old_prot is correct already.

Now the question is whether this assumption can be made. The current code
does that already today in case of page splits because it copies the
existing pgprot of the large page unmodified over to the new split PTE
page. IOW, if the current mapping is incorrect it will stay that way if
it's not part of the actually modified range.

I'm a bit worried about not having such a check, but if we add that then
this should be done under a debug option for performance reasons.

The last patch which does the overlap check is equally broken:

+       /*
+        * Ensure that the requested pgprot does not violate static protection
+        * requirements.
+        */
+       new_prot = static_protections(req_prot, address,
+                                     numpages << PAGE_SHIFT, pfn);

It expands new_prot to the whole range even if the protections only
overlap. That should not happen in practice, but we have no checks for that
at all.

The whole thing needs way more thought in order not to (re)introduce subtle
and hard to debug bugs.

Thanks,

	tglx








