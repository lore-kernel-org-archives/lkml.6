Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F71ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9652320866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOaMR+o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9652320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbeKDXJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbeKDXJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C940C2086D;
        Sun,  4 Nov 2018 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339673;
        bh=19rO2ZqSjUi4fJrjkZD+uCPM2kVw7gPNAKNwtFAom3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOaMR+o1hpA0ADMU8ltSlRN1k/cJbsWNbcqJ5K+MD9WQGOSIZi6KveVlg8RqKSlp4
         9UeYexdFVtNYIyOvDhRXayzH6TJW5NUb2bwoebaXAzdNFeT2wBSKypkhN4JMGXkF8x
         UoAVhqHacFhDTTCyBmw8P7hJSah2IABL6iWKGc8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 15/15] 9p: clear dangling pointers in p9stat_free
Date:   Sun,  4 Nov 2018 08:54:17 -0500
Message-Id: <20181104135417.88671-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
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
index 16d287565987..145f80518064 100644
--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -46,10 +46,15 @@ p9pdu_writef(struct p9_fcall *pdu, int proto_version, const char *fmt, ...);
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

