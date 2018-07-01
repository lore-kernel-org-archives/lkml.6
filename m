Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A8C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49453258BC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="l2asKJbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49453258BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGAU5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:09 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51680 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbeGAU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XNKMphtdPT5aGP1rVO3G3vXufJaltfsN0i/p+HHd7uQ=; b=l2asKJbDRVWUkmHrSaI71DbA+t
        pSDjNjMQDju3Xnr7zmCDByYe9pUgsWQmoM9BB7757Spjan+wpAkkS8xxSBxoZICFRZ6xaz1WsvZhz
        iKRspINxZ5nAOrxYpyHC5y+FdsYAZs3V/b/ljTYDjXPl4uHkPzqxBCCOIIFKH9DxKr/2N/0/iLVY8
        DylYdBjtSJaR2TVONF94ApUtYFCfOkXIb49tQOFr7+WO8UMaNtSF5j7t38u63voPg1q1uwjiig3J5
        6XOPrD2l1Ae+0S4m9ctV0NtP0kwY2K8et8Aa8PIv+nk6x99VwlV+a8U2S2f/OLDR8QQtAJYAfxh0C
        eF0O6huQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48680 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjP8-007e88-6E; Sun, 01 Jul 2018 20:57:06 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] configfs: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:56:54 -0700
Message-Id: <1530478614-11341-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 complains:

fs/configfs/symlink.c:67:3: warning:
	'strncpy' output truncated before terminating nul copying as many
	bytes from a string as its length
fs/configfs/symlink.c: In function 'configfs_get_link':
fs/configfs/symlink.c:63:13: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/configfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 78ffc2699993..a5c54af861f7 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -64,7 +64,7 @@ static void fill_item_path(struct config_item * item, char * buffer, int length)
 
 		/* back up enough to print this bus id with '/' */
 		length -= cur;
-		strncpy(buffer + length,config_item_name(p),cur);
+		memcpy(buffer + length, config_item_name(p), cur);
 		*(buffer + --length) = '/';
 	}
 }
-- 
2.7.4

