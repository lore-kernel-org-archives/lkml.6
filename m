Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE881C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AD520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIDCt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:49:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeIDCt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:49:57 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwxJr-0001yd-5v; Tue, 04 Sep 2018 00:27:39 +0200
Date:   Tue, 4 Sep 2018 00:27:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     mingo@kernel.org, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, mark.gross@intel.com
Subject: Re: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
In-Reply-To: <1534814186-37067-6-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1809040023450.1462@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com> <1534814186-37067-6-git-send-email-bin.yang@intel.com>
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
> @@ -625,6 +625,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  
>  	psize = page_level_size(level);
>  	pmask = page_level_mask(level);
> +	addr = address & pmask;
>  
>  	/*
>  	 * Calculate the number of pages, which fit into this large
> @@ -636,6 +637,12 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  		cpa->numpages = numpages;
>  
>  	/*
> +	 * The old pgprot should not have any protection bit. Otherwise,
> +	 * the existing mapping is wrong already.
> +	 */
> +	WARN_ON_ONCE(needs_static_protections(old_prot, addr, psize, old_pfn));

The check itself is fine, but it just emits a warning and goes on as if
nothing happened.

We really want to think about a proper way to fix that up without overhead
for the sane case.

Thanks,

	tglx
