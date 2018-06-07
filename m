Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k1H8ALVBGVshcgAAmS7hNA
	; Thu, 07 Jun 2018 14:32:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A94FF607DC; Thu,  7 Jun 2018 14:32:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 50FD7607DC;
	Thu,  7 Jun 2018 14:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50FD7607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeFGOcu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:32:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40289 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932911AbeFGOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:32:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005Zp-Im; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00032Q-05; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Greg Kurz" <groug@kaod.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.339285762@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 222/410] 9p/trans_virtio: discard zero-length reply
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kurz <groug@kaod.org>

commit 26d99834f89e76514076d9cd06f61e56e6a509b8 upstream.

When a 9p request is successfully flushed, the server is expected to just
mark it as used without sending a 9p reply (ie, without writing data into
the buffer). In this case, virtqueue_get_buf() will return len == 0 and
we must not report a REQ_STATUS_RCVD status to the client, otherwise the
client will erroneously assume the request has not been flushed.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/9p/trans_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -164,7 +164,8 @@ static void req_done(struct virtqueue *v
 		p9_debug(P9_DEBUG_TRANS, ": rc %p\n", rc);
 		p9_debug(P9_DEBUG_TRANS, ": lookup tag %d\n", rc->tag);
 		req = p9_tag_lookup(chan->client, rc->tag);
-		p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		if (len)
+			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
 	}
 }
 
