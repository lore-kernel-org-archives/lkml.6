Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA92146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbeIRE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:28:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeIRE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:28:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2F63C49;
        Mon, 17 Sep 2018 22:58:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 63/70] NFSv4.1: Fix a potential layoutget/layoutrecall deadlock
Date:   Tue, 18 Sep 2018 00:42:36 +0200
Message-Id: <20180917211654.077049301@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit bd3d16a887b0c19a2a20d35ffed499e3a3637feb ]

If the client is sending a layoutget, but the server issues a callback
to recall what it thinks may be an outstanding layout, then we may find
an uninitialised layout attached to the inode due to the layoutget.
In that case, it is appropriate to return NFS4ERR_NOMATCHING_LAYOUT
rather than NFS4ERR_DELAY, as the latter can end up deadlocking.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/callback_proc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -175,9 +175,9 @@ static u32 pnfs_check_callback_stateid(s
 {
 	u32 oldseq, newseq;
 
-	/* Is the stateid still not initialised? */
+	/* Is the stateid not initialised? */
 	if (!pnfs_layout_is_valid(lo))
-		return NFS4ERR_DELAY;
+		return NFS4ERR_NOMATCHING_LAYOUT;
 
 	/* Mismatched stateid? */
 	if (!nfs4_stateid_match_other(&lo->plh_stateid, new))


