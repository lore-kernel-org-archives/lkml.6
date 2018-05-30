Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeE3LUj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:20:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60993 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752537AbeE3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:07 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>,
        "Greg Kurz" <groug@kaod.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.385514759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 080/153] 9p/trans_virtio: discard zero-length reply
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/9p/trans_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -163,7 +163,8 @@ static void req_done(struct virtqueue *v
 		P9_DPRINTK(P9_DEBUG_TRANS, ": lookup tag %d\n", rc->tag);
 		req = p9_tag_lookup(chan->client, rc->tag);
 		req->status = REQ_STATUS_RCVD;
-		p9_client_cb(chan->client, req);
+		if (len)
+			p9_client_cb(chan->client, req);
 	}
 }
 
