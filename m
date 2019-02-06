Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A472B218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ev6MT9zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBFUY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:24:59 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:42587 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfBFUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:24:58 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 15:24:58 EST
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id F2060DCE;
        Wed,  6 Feb 2019 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1549484110;
        bh=oo42DF9RXMFohwXV+c+aRrrRIwn8R0QJhT1AusUOjKA=;
        h=From:To:Cc:Subject:Date;
        b=Ev6MT9zwYfCHWPBB/dHUM9jJ2QbwL9RJD4wViSPHp3vqnWKA4KDQL2rHI8yjxJTQN
         dYHBq8UiDT+CXb5kUuXAesXhClyI/jjFsAR43eo/EAVZEbMmXgFSQl4Sj9NsridH1s
         EjAPCb+N3AOs3oWdqxmX55n4vtQk4bUad/yoD/FuwkyiLAX+FdS2zSrD9WlVJCPrnF
         q4jQutc2vg/+aYL68XNgi/Lc1HBtslzWjbkNs8IUT4W+qTPmhxi8Nm5oT5uuzTGU2D
         HOz65aYPmrBcw13OlWemBz9QRlSFVxHa8JzqM0H6YAZ5PbJ7TYvNd+ZdgKzAIky08q
         Xl99/z7rSzAFQ==
Received: from Yojimbo.sjc.aristanetworks.com (unknown [10.80.4.127])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 9E6BCD1F;
        Wed,  6 Feb 2019 12:15:10 -0800 (PST)
From:   Julien Gomes <julien@arista.com>
To:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com,
        Julien Gomes <julien@arista.com>
Subject: [PATCH net] sctp: make sctp_setsockopt_events() less strict about the option length
Date:   Wed,  6 Feb 2019 12:14:30 -0800
Message-Id: <20190206201430.18830-1-julien@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sctp_setsockopt_events() able to accept sctp_event_subscribe
structures longer than the current definitions.

This should prevent unjustified setsockopt() failures due to struct
sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
binaries that should be compatible, but were built with later kernel
uapi headers.

Signed-off-by: Julien Gomes <julien@arista.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9644bdc8e85c..f9717e2789da 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
 	int i;
 
 	if (optlen > sizeof(struct sctp_event_subscribe))
-		return -EINVAL;
+		optlen = sizeof(struct sctp_event_subscribe);
 
 	if (copy_from_user(&subscribe, optval, optlen))
 		return -EFAULT;
-- 
2.20.1

