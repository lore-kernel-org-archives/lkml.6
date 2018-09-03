Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89388C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E39A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kdjpFoLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E39A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeICJIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:08:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeICJIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xssHXQ9TFloh+QLsqre9b/6qtjcnjcD+GmpNadCPBy8=; b=kdjpFoLhERhb+vRc5Q0eIQW3j
        z0vSd1/ZcKFUP+es+fIToqFeu91wUiH8P6FOsh4Kqbado7YmKAl3CCaepb41ezMbxDEjg76gwSlmH
        k2DX/X9LVIAmJUi3cwDp9Lg2L26CMzyqyxnATSU/ecpE2DJcSAryNfyyknUlMtaOc9o892kY1/yym
        vc7YRU1Uc9THwUxGu8WQcEm8WaQtyPL51gGZYSj5hZB61BZjBMX9PaOqk2f8yT76/rbKEi/5+hAcd
        V3pwSXPDjauTMjVr1S6YdkiQGjidVZu8vyiHPdMK34gnGmJRg7VO+bJr79S9Bsx3zF+JWdXjwrtX/
        QI/w3cakA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwgo9-0004Zy-Iz; Mon, 03 Sep 2018 04:49:49 +0000
Date:   Sun, 2 Sep 2018 21:49:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, konishi.ryusuke@lab.ntt.co.jp,
        viro@zeniv.linux.org.uk, tytso@mit.edu, adilger.kernel@dilger.ca,
        axboe@kernel.dk, darrick.wong@oracle.com, ebiggers@google.com,
        pombredanne@nexb.com, agruenba@redhat.com,
        gregkh@linuxfoundation.org, kemi.wang@intel.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
Message-ID: <20180903044949.GB17856@bombadil.infradead.org>
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:55:47PM +0530, Souptick Joarder wrote:
> +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> +			 get_block_t get_block, int *err)

I don't like returning both the errno and the vm_fault_t.  To me that's a
sign we need to rethink this interface.

I have two suggestions.  First, we could allocate a new VM_FAULT_NOSPC
bit.  Second, we could repurpose one of the existing bits, such as
VM_FAULT_RETRY for this purpose.

> -int ext4_page_mkwrite(struct vm_fault *vmf)
> +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)

I also think perhaps we could start by _not_ converting block_page_mkwrite().
Just convert ext4_page_mkwrite(), and save converting block_page_mkwrite()
for later.

