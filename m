Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0509208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0509208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbeHATjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:39:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406010AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4815B13AC;
        Wed,  1 Aug 2018 17:15:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 026/246] NFSv4.1: Fix the client behaviour on NFS4ERR_SEQ_FALSE_RETRY
Date:   Wed,  1 Aug 2018 18:48:56 +0200
Message-Id: <20180801165012.954727937@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit f9312a541050007ec59eb0106273a0a10718cd83 ]

If the server returns NFS4ERR_SEQ_FALSE_RETRY or NFS4ERR_RETRY_UNCACHED_REP,
then it thinks we're trying to replay an existing request. If so, then
let's just bump the sequence ID and retry the operation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -745,6 +745,13 @@ static int nfs41_sequence_process(struct
 			slot->slot_nr,
 			slot->seq_nr);
 		goto out_retry;
+	case -NFS4ERR_RETRY_UNCACHED_REP:
+	case -NFS4ERR_SEQ_FALSE_RETRY:
+		/*
+		 * The server thinks we tried to replay a request.
+		 * Retry the call after bumping the sequence ID.
+		 */
+		goto retry_new_seq;
 	case -NFS4ERR_BADSLOT:
 		/*
 		 * The slot id we used was probably retired. Try again
@@ -769,10 +776,6 @@ static int nfs41_sequence_process(struct
 			goto retry_nowait;
 		}
 		goto session_recover;
-	case -NFS4ERR_SEQ_FALSE_RETRY:
-		if (interrupted)
-			goto retry_new_seq;
-		goto session_recover;
 	default:
 		/* Just update the slot sequence no. */
 		slot->seq_done = 1;


