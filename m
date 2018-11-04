Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2632E204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ygd45vEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2632E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbeKDXJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731901AbeKDXJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF0E2086D;
        Sun,  4 Nov 2018 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339687;
        bh=wBduRsfu1jsZcLPPEa8/YlSf4rt+3SiZ0PTgZARmq1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygd45vEAqdr9scs4RTgwlZwrhMd5T8n4XcFXxbTLL2Olhm/rgXzGmSalYgSKWoiTt
         LAb9LykbyDzc5U/MRGZVqvB+qqW+fG+S/6lOO/E1jYpA4D+k/NuUIrFycpcs7jy9Iu
         UAfuDbNsk2O7G3jVyTGGRSC/7FdR1NY8isMkL9JM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 13/13] 9p: clear dangling pointers in p9stat_free
Date:   Sun,  4 Nov 2018 08:54:33 -0500
Message-Id: <20181104135433.88734-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135433.88734-1-sashal@kernel.org>
References: <20181104135433.88734-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

[ Upstream commit 62e3941776fea8678bb8120607039410b1b61a65 ]

p9stat_free is more of a cleanup function than a 'free' function as it
only frees the content of the struct; there are chances of use-after-free
if it is improperly used (e.g. p9stat_free called twice as it used to be
possible to)

Clearing dangling pointers makes the function idempotent and safer to use.

Link: http://lkml.kernel.org/r/1535410108-20650-2-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/9p/protocol.c b/net/9p/protocol.c
index ab9127ec5b7a..bceb6999614f 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -45,10 +45,15 @@ p9pdu_writef(struct p9_fcall *pdu, int proto_version, const char *fmt, ...);
 void p9stat_free(struct p9_wstat *stbuf)
 {
 	kfree(stbuf->name);
+	stbuf->name = NULL;
 	kfree(stbuf->uid);
+	stbuf->uid = NULL;
 	kfree(stbuf->gid);
+	stbuf->gid = NULL;
 	kfree(stbuf->muid);
+	stbuf->muid = NULL;
 	kfree(stbuf->extension);
+	stbuf->extension = NULL;
 }
 EXPORT_SYMBOL(p9stat_free);
 
-- 
2.17.1

