Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F93C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4871A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeKLGZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:25:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49848 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730122AbeKLFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:12 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0000l5-Rq; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001io-BA; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sabrina Dubroca" <sd@queasysnail.net>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.267568155@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 248/366] skbuff: Unconditionally copy pfmemalloc in
 __skb_clone()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

commit e78bfb0751d4e312699106ba7efbed2bab1a53ca upstream.

Commit 8b7008620b84 ("net: Don't copy pfmemalloc flag in
__copy_skb_header()") introduced a different handling for the
pfmemalloc flag in copy and clone paths.

In __skb_clone(), now, the flag is set only if it was set in the
original skb, but not cleared if it wasn't. This is wrong and
might lead to socket buffers being flagged with pfmemalloc even
if the skb data wasn't allocated from pfmemalloc reserves. Copy
the flag instead of ORing it.

Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 8b7008620b84 ("net: Don't copy pfmemalloc flag in __copy_skb_header()")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: We didn't set the pfmemalloc flag in either copy
 or clone path until now]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -768,6 +768,7 @@ static struct sk_buff *__skb_clone(struc
 	n->cloned = 1;
 	n->nohdr = 0;
 	n->peeked = 0;
+	C(pfmemalloc);
 	n->destructor = NULL;
 	C(tail);
 	C(end);

