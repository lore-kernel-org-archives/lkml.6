Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF21C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeJNXWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:22:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36204 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbeJNXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cS-Ar; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000Zn-3X; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andrey Ignatov" <rdna@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.650871352@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 280/366] ipv4: fix memory leaks in udp_sendmsg,
 ping_v4_sendmsg
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ignatov <rdna@fb.com>

commit 1b97013bfb11d66f041de691de6f0fec748ce016 upstream.

Fix more memory leaks in ip_cmsg_send() callers. Part of them were fixed
earlier in 919483096bfe.

* udp_sendmsg one was there since the beginning when linux sources were
  first added to git;
* ping_v4_sendmsg one was copy/pasted in c319b4d76b9e.

Whenever return happens in udp_sendmsg() or ping_v4_sendmsg() IP options
have to be freed if they were allocated previously.

Add label so that future callers (if any) can use it instead of kfree()
before return that is easy to forget.

Fixes: c319b4d76b9e (net: ipv4: add IPPROTO_ICMP socket kind)
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/ping.c | 7 +++++--
 net/ipv4/udp.c  | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -779,8 +779,10 @@ static int ping_v4_sendmsg(struct kiocb
 	ipc.addr = faddr = daddr;
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 	}
 	tos = get_rttos(&ipc, inet);
@@ -845,6 +847,7 @@ back_from_confirm:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -997,8 +997,10 @@ int udp_sendmsg(struct kiocb *iocb, stru
 	ipc.addr = faddr = daddr;
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
@@ -1103,6 +1105,7 @@ do_append_data:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)

