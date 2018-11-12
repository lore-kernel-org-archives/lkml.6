Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAACF2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s7Nsc1ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAACF2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbeKLQFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:05:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbeKLQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oUqr3U+/vWQL5n/fZ36e3JAyxny2g+Hg19qsP/b2I4M=; b=s7Nsc1iaHsC/lWzH1W7mU65dA
        GYpXsrqEnWzus96ddgLl07KIdCq85nSsNLfS80JrKyPrvl+jHM79nt5qemUdQ7wbcGKFVT/JhA9Mv
        n3ebo6JsBexjQuW6HVnkNW0tbS6EuBxwT4cD9/I2/h3yP8nwTSLF4stKgmgFV0OvZwrMFbRrAS47y
        V6QpxI9lj0oEzEwv3/x82rU0gvBM2cyuqKolCdDYZcSXpOcd6AYO04EIXDSAXuLz7ncLy3QcMKfdL
        utdoO0KH2W4Rfddjp8hoBKy2E/cX4TMrCHf7AAxRnLr9uVMNiSWORiP4kTfcv5QKbBES7w/ISziHp
        3ZlI7Ok9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM5Td-0003VW-Ii; Mon, 12 Nov 2018 06:13:37 +0000
Date:   Sun, 11 Nov 2018 22:13:37 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vatsa@codeaurora.org
Subject: Re: [PATCH v4 1/4] mm: reference totalram_pages and managed_pages
 once per function
Message-ID: <20181112061337.GG21824@bombadil.infradead.org>
References: <1542002869-16704-1-git-send-email-arunks@codeaurora.org>
 <1542002869-16704-2-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542002869-16704-2-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:37:46AM +0530, Arun KS wrote:
> +++ b/arch/um/kernel/mem.c
> @@ -51,8 +51,7 @@ void __init mem_init(void)
>  
>  	/* this will put all low memory onto the freelists */
>  	memblock_free_all();
> -	max_low_pfn = totalram_pages;
> -	max_pfn = totalram_pages;
> +	max_pfn = max_low_pfn = totalram_pages;

We don't normally do "a = b = c".  How about:

 	max_low_pfn = totalram_pages;
-	max_pfn = totalram_pages;
+	max_pfn = max_low_pfn;

> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -434,9 +434,10 @@ static ssize_t microcode_write(struct file *file, const char __user *buf,
>  			       size_t len, loff_t *ppos)
>  {
>  	ssize_t ret = -EINVAL;
> +	unsigned long totalram_pgs = totalram_pages;

Can't we use a better variable name here?  Even nr_pages would look
better to me.

> +++ b/drivers/hv/hv_balloon.c
> +	unsigned long totalram_pgs = totalram_pages;

Ditto

> +++ b/fs/file_table.c
> +	unsigned long totalram_pgs = totalram_pages;

... throughout, I guess.
