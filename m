Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3B2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha7U/HSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D3B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeJKXNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeJKXNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634E220652;
        Thu, 11 Oct 2018 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272735;
        bh=1QVX1sAFTQSh1x391XkcBDo1l/w7tmsCuCsZ4ojsQQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha7U/HSOPfwSbEYrm1w5iKiIGMk+3dY0bFxwWBrFtdhTljLQDZsylnZAzqTFGOFti
         NNoa7PLem86zBI0oWrxIHiJ4523bQjXkGkpaPwcBwhDGHoihTdnpMB2UTypdeID7Gi
         T1XmUEyNpfAjIDfdMwcCdiabuMrIYpVQWKIaB+Bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 20/45] dm cache: fix resize crash if user doesnt reload cache table
Date:   Thu, 11 Oct 2018 17:39:47 +0200
Message-Id: <20181011152509.739306793@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 5d07384a666d4b2f781dc056bfeec2c27fbdf383 upstream.

A reload of the cache's DM table is needed during resize because
otherwise a crash will occur when attempting to access smq policy
entries associated with the portion of the cache that was recently
extended.

The reason is cache-size based data structures in the policy will not be
resized, the only way to safely extend the cache is to allow for a
proper cache policy initialization that occurs when the cache table is
loaded.  For example the smq policy's space_init(), init_allocator(),
calc_hotspot_params() must be sized based on the extended cache size.

The fix for this is to disallow cache resizes of this pattern:
1) suspend "cache" target's device
2) resize the fast device used for the cache
3) resume "cache" target's device

Instead, the last step must be a full reload of the cache's DM table.

Fixes: 66a636356 ("dm cache: add stochastic-multi-queue (smq) policy")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-target.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3097,8 +3097,13 @@ static dm_cblock_t get_cache_dev_size(st
 
 static bool can_resize(struct cache *cache, dm_cblock_t new_size)
 {
-	if (from_cblock(new_size) > from_cblock(cache->cache_size))
-		return true;
+	if (from_cblock(new_size) > from_cblock(cache->cache_size)) {
+		if (cache->sized) {
+			DMERR("%s: unable to extend cache due to missing cache table reload",
+			      cache_device_name(cache));
+			return false;
+		}
+	}
 
 	/*
 	 * We can't drop a dirty block when shrinking the cache.


