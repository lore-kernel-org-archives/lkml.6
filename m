Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE95C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B96120855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543715;
	bh=+FBuBNZhT3ekO46mJmhapbKOxfwo8X1sUzInW+al/5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AMyCRkU0nVzqtS6N+dbbN7Kdp6vk/NuZhAUkRmF0oUVXr+D/TBEgVv+wR7EfyqaW3
	 w701eSAdrtWY7r9V+oSfzppw+tDhuuMc7n7POvqk3Ze1KBQmaF9WBPet1PaN0n4hRe
	 1NGiRKWe8Asq+CmqfKB1fMHz/rN5RICuJqyh+0Z8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B96120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeLKPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbeLKPyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1B320855;
        Tue, 11 Dec 2018 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543652;
        bh=+FBuBNZhT3ekO46mJmhapbKOxfwo8X1sUzInW+al/5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjC4CdzHT3gBMjp71TAlfdI+kLpvAERejxLt9BvWx9JuogJs926GknvXKykF7cJMZ
         lIYRKElWBlX63KmlipVAv2HQFumRPEVJGkjmnvQ0M8icKTkywxUbeRixiKVeuX50sZ
         tn4vh53W14eBYQWOm5293Bajodtl+OYxiwnhgPMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/118] test_firmware: fix error return getting clobbered
Date:   Tue, 11 Dec 2018 16:40:31 +0100
Message-Id: <20181211151644.726352191@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

[ Upstream commit 8bb0a88600f0267cfcc245d34f8c4abe8c282713 ]

In the case where eq->fw->size > PAGE_SIZE the error return rc
is being set to EINVAL however this is being overwritten to
rc = req->fw->size because the error exit path via label 'out' is
not being taken.  Fix this by adding the jump to the error exit
path 'out'.

Detected by CoverityScan, CID#1453465 ("Unused value")

Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b984806d7d7b..7cab9a9869ac 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -837,6 +837,7 @@ static ssize_t read_firmware_show(struct device *dev,
 	if (req->fw->size > PAGE_SIZE) {
 		pr_err("Testing interface must use PAGE_SIZE firmware for now\n");
 		rc = -EINVAL;
+		goto out;
 	}
 	memcpy(buf, req->fw->data, req->fw->size);
 
-- 
2.19.1



