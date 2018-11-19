Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4CFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75821104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvVv7txi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D75821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404148AbeKTDUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbeKTDUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC40206BA;
        Mon, 19 Nov 2018 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646557;
        bh=DOjEd9jxxt8G1uIUwR14/VW/n4R5fBmKnRE0zEqc4H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvVv7txiL360FiofYDdNYz55NJneZZKVGRyk7soKU5jV4USDmdEiljlxcmEuYusYu
         9Qkr+HwqGwvjp4rQKRFMzmqmGCiJ51/8tJRus9lsodJ9tMb352XNPmPUe2vO2vL5/J
         AKdOqtQbtVYjNOhq5uzayeQQyV8MAu/XVxX8eT3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
Subject: [PATCH 4.9 74/83] configfs: replace strncpy with memcpy
Date:   Mon, 19 Nov 2018 17:29:40 +0100
Message-Id: <20181119162626.408388577@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 1823342a1f2b47a4e6f5667f67cd28ab6bc4d6cd upstream.

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
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/configfs/symlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -64,7 +64,7 @@ static void fill_item_path(struct config
 
 		/* back up enough to print this bus id with '/' */
 		length -= cur;
-		strncpy(buffer + length,config_item_name(p),cur);
+		memcpy(buffer + length, config_item_name(p), cur);
 		*(buffer + --length) = '/';
 	}
 }


