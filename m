Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5851C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638A620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHAT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:58:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405709AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C84FD1393;
        Wed,  1 Aug 2018 17:14:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 054/246] pnfs: Dont release the sequence slot until weve processed layoutget on open
Date:   Wed,  1 Aug 2018 18:49:24 +0200
Message-Id: <20180801165014.300306695@linuxfoundation.org>
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

[ Upstream commit ae55e59da0e401893b3c52b575fc18a00623d0a1 ]

If the server recalls the layout that was just handed out, we risk hitting
a race as described in RFC5661 Section 2.10.6.3 unless we ensure that we
release the sequence slot after processing the LAYOUTGET operation that
was sent as part of the OPEN compound.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2695,7 +2695,7 @@ static int _nfs4_open_and_get_state(stru
 	if (ret != 0)
 		goto out;
 
-	state = nfs4_opendata_to_nfs4_state(opendata);
+	state = _nfs4_opendata_to_nfs4_state(opendata);
 	ret = PTR_ERR(state);
 	if (IS_ERR(state))
 		goto out;
@@ -2731,6 +2731,7 @@ static int _nfs4_open_and_get_state(stru
 			nfs4_schedule_stateid_recovery(server, state);
 	}
 out:
+	nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
 }
 


