Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FD7214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsNU1eK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FD7214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406867AbeKTD3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405919AbeKTD3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE411214D9;
        Mon, 19 Nov 2018 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647131;
        bh=nkuQhAN9FZ+I1HpO1NOGchcseCMy+PyLbZvtKsnrxOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsNU1eK/H7VUyOv6IQGP5ny1YkR89YmrlPRazetQQyk8oiY4DItAdqWYQ9RvV+7bI
         iEUeZYGv/tqFpJurKPjhLdqa/Rds+Arrwz6mfTZ75H8/90ISt5Zk8UflsgtJPzuNWh
         MSJ0SoTE01HWq/wsyZr89R0ielCpDhhIW/ROsYlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        syzbot+d4252148d198410b864f@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 61/90] 9p: clear dangling pointers in p9stat_free
Date:   Mon, 19 Nov 2018 17:29:43 +0100
Message-Id: <20181119162630.496800023@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/protocol.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -45,10 +45,15 @@ p9pdu_writef(struct p9_fcall *pdu, int p
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
 


