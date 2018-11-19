Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70313C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7D21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xZgfTL+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeKTDI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388214AbeKTDIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 281FC2086A;
        Mon, 19 Nov 2018 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645854;
        bh=+QZNpIv93hJBkxFe88buioyDOZK73JoMZhw8bzleUUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZgfTL+FcaxB+ueDzWpjJwMKKsHI15y0qpVLeehNmdn1UuLvtIFUxPnO2Cpt0HA+n
         EzpkjaAd5lRtjLjvEw5H1jJXnf6bRo/ScHp75DxaE1G3bbzNAgZpML12XdElsm+nr1
         xN/+YlTeoaU0gvtxl87/ntlsdcXjSx8HHVox/wek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.18 113/171] ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while resizing
Date:   Mon, 19 Nov 2018 17:28:29 +0100
Message-Id: <20181119162636.504133061@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit f348e2241fb73515d65b5d77dd9c174128a7fbf2 upstream.

Fixes: 117fff10d7f1 ("ext4: grow the s_flex_groups array as needed ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2022,7 +2022,7 @@ retry:
 
 	err = ext4_alloc_flex_bg_array(sb, n_group + 1);
 	if (err)
-		return err;
+		goto out;
 
 	err = ext4_mb_alloc_groupinfo(sb, n_group + 1);
 	if (err)


