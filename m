Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7FBC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634AC208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790986;
	bh=q3VW0EhI6kg7jaxsPySNJnDmvdPTMn1yoijvbGTj1aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIwBOeQuwhrlw+GcQZhJ9hU+0MpWFr9MlA2kbfy9EtuLUxvScABtcseWjKVsqbSj5
	 /bLYAzfeoGn9FTb/ktYR67T5HERVpec4V+z8BegMVAhTrCK6SlstLVc31Juub2Weig
	 +FHBIOrpPA1z8L9tbs+WyGk5X4+rFme8kEzo/OMs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634AC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeLNMgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbeLNMGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783BA2147D;
        Fri, 14 Dec 2018 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789201;
        bh=q3VW0EhI6kg7jaxsPySNJnDmvdPTMn1yoijvbGTj1aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWbv/isSKp3Upyef94HSo1c7vzAhXxYkPt2oIjkGJg7fJiktK0bkWzN4nlyFgvYxM
         7a1bWLOZii0RGYc8SVj3uHZa/YyqAnfX0Y14Ao9GISACVJYxooInY7SopYlsoYeNT2
         WqTVd09gA+Y9ARqz7vW5aK3CSfqncFA1nWzphJQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 134/142] dax: Check page->mapping isnt NULL
Date:   Fri, 14 Dec 2018 13:00:19 +0100
Message-Id: <20181214115752.395057974@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@infradead.org>

commit c93db7bb6ef3251e0ea48ade311d3e9942748e1c upstream.

If we race with inode destroy, it's possible for page->mapping to be
NULL before we even enter this routine, as well as after having slept
waiting for the dax entry to become unlocked.

Fixes: c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
Cc: <stable@vger.kernel.org>
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -423,7 +423,7 @@ bool dax_lock_mapping_entry(struct page
 	for (;;) {
 		mapping = READ_ONCE(page->mapping);
 
-		if (!dax_mapping(mapping))
+		if (!mapping || !dax_mapping(mapping))
 			break;
 
 		/*


