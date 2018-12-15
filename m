Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D75C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FAD2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQXVX4AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeLOOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:38:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K0TEN6zKhxTPkeJUq0ZFuza1Gbk5FJ/I21zern5TdZA=; b=fQXVX4AQMkz3m80ztQBGQTxRk
        XWIt4nnwoLu+Xw2ZjNk1LSvknCJK/8TNOL1sbIs48oE4ZqgdZ5AzHKBIgdRHT61OLcNjVV3DXumUf
        f7dtPFyirH6ttCj4f8gSEugJ0slDzqYh0UPWHvJhQcvf+y9CPeDrixTcSj8iZ52ZNolCNknZk5B/N
        Jhad+t64gmvq/HZxDZBk6WtNAZmPnflYUbkkcfZ8FJbfKbaFTrOkWkFjsk2f8ZQ7BPkvxOxwykbBd
        ZUhCELP8Ah/mdvE5mZ52lhBdAMo378G8YF8991QKiEPkV91cOVPm28L3hXHGtlg8q/S9nT1hR0gpq
        Cj/axl8ww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYB5E-0006ED-94; Sat, 15 Dec 2018 14:38:24 +0000
Date:   Sat, 15 Dec 2018 06:38:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     phillip@squashfs.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181215143824.GJ10600@bombadil.infradead.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204020840.49576-1-houtao1@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:08:40AM +0800, Hou Tao wrote:
> There is no need to disable __GFP_FS in ->readpage:
> * It's a read-only fs, so there will be no dirty/writeback page and
>   there will be no deadlock against the caller's locked page
> * It just allocates one page, so compaction will not be invoked
> * It doesn't take any inode lock, so the reclamation of inode will be fine
> 
> And no __GFP_FS may lead to hang in __alloc_pages_slowpath() if a
> squashfs page fault occurs in the context of a memory hogger, because
> the hogger will not be killed due to the logic in __alloc_pages_may_oom().

I don't understand your argument here.  There's a comment in
__alloc_pages_may_oom() saying that we _should_ treat GFP_NOFS
specially, but we currently don't.

        /*
         * XXX: GFP_NOFS allocations should rather fail than rely on
         * other request to make a forward progress.
         * We are in an unfortunate situation where out_of_memory cannot
         * do much for this context but let's try it to at least get
         * access to memory reserved if the current task is killed (see
         * out_of_memory). Once filesystems are ready to handle allocation
         * failures more gracefully we should just bail out here.
         */

What problem are you actually seeing?
