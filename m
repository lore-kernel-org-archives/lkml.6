Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564962089E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564962089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeGIXy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:54:26 -0400
Received: from nautica.notk.org ([91.121.71.147]:47747 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754568AbeGIXyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:54:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7959AC009; Tue, 10 Jul 2018 01:54:18 +0200 (CEST)
Date:   Tue, 10 Jul 2018 01:54:03 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [V9fs-developer]  [PATCH] p9_check_errors() validate PDU length
Message-ID: <20180709235403.GB19917@nautica>
References: <20180709224323.20597-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709224323.20597-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(extra Cc: Al Viro, as it's kind of the continuation of the other
thread)

Tomas Bortoli wrote on Tue, Jul 10, 2018:
> p9_check_errors() does not validate the size of the PDU read
> in p9_parse_header(). Any size can be passed, provoking out-of-bound reads.

cf. what I just said in other patch, I think this check needs to be
moved up to p9_parse_header as p9_check_zc_error has the same problem.

Also, they really need to check against the actual read size, not just
capacity.
For virtio/rdma, something like this ought to fix pdu->size, then
p9_parse_header can just never overwrite it (untested but it's useless
on its own, I'll test the full patch with the parse header change)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 3d414acb7015..2649b2ebf961 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -320,6 +320,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto err_out;
 
+	c->rc->size = wc->byte_len;
 	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
 	if (err)
 		goto err_out;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..fc6dc9ca86a4 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -159,8 +159,10 @@ static void req_done(struct virtqueue *vq)
 		spin_unlock_irqrestore(&chan->lock, flags);
 		/* Wakeup if anyone waiting for VirtIO ring space. */
 		wake_up(chan->vc_wq);
-		if (len)
+		if (len) {
+			req->rc->size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		}
 	}
 }
-- 
Dominique Martinet | Asmadeus
