Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E9ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 02:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8912082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 02:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XK7EbhOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8912082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeJ1LAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 07:00:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeJ1LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 07:00:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so2227989pgs.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 19:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OV6S97yPusLF/VlbA3fQFOUSkIHv/BsXXCR1OOGy5MQ=;
        b=XK7EbhOmj2G1uDO6x13DXKL0ElEMA5hZaN++H0/jRYwPnC2Q7ri4tu+iQo3OWNHiUn
         3nR3Mp745gNEQVxzdDK6eThaSGGOQ7oqqs0e6w2NE3ZDUnpDPt/2OtYvuImMJhZ5tC+y
         ZtBVUrPctsDtbQi2qxmjuw+Ne6seYDWwxuR24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OV6S97yPusLF/VlbA3fQFOUSkIHv/BsXXCR1OOGy5MQ=;
        b=esOHx5S4n5jNiQU5tmi9opqaDSe+I4NHHVFFHnfOzcZXGjlhu/OIoCsw8ZmRgWANQG
         lL2WeHM1JoeVP8sJXnMEkPmS3PaOFqedFXBbGm7J89DCuRSHY4l6AJVctlz3qRkS479o
         0OVo6om3OfekC09hLmTsz8Vr34I+1X4t59s+IlyhOXizN+wLSsHtI730P62WGaFLuzx0
         nbXa5oXk0zhkp2jtlytGe2S0CkSqPbZPH32Ovr+UBozPb73OAkqmOmcBX0uF28/Za27G
         O73Xhmbbxje5KJbu0tzpXs5RyS0CQixIgXfmbbBvBy/vV+odbZBjIJHJbjjJuKE/yjGm
         N47A==
X-Gm-Message-State: AGRZ1gIQwtCBbd+v6zFIQKDl3a+Pjc6QT9abJUgPnDubQBwg1IFgBhPz
        VVuJ1Dcn5n9xCYbRyG/KTcAq6Pavb0E=
X-Google-Smtp-Source: AJdET5fz0Wokeq8y8IrrZZ8Y/h14Zy/EiPQI17Jh6BPTTaii+ImCJdI1orVfmWg+/sdWRqpxcBhGXA==
X-Received: by 2002:a62:c252:: with SMTP id l79-v6mr9570970pfg.141.1540693022585;
        Sat, 27 Oct 2018 19:17:02 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id f18-v6sm4471312pfh.0.2018.10.27.19.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 19:17:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [RFC] rcu: doc: update example about stale data
Date:   Sat, 27 Oct 2018 19:16:53 -0700
Message-Id: <20181028021653.155513-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU example for 'rejecting stale data' on system-call auditting
stops iterating through the rules if a deleted one is found. It makes
more sense to continue looking at other rules once a deleted one is
rejected. Although the original example is fine, this makes it more
meaningful.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/listRCU.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
index adb5a3782846..09e9a4fc723e 100644
--- a/Documentation/RCU/listRCU.txt
+++ b/Documentation/RCU/listRCU.txt
@@ -250,8 +250,7 @@ as follows:
 				spin_lock(&e->lock);
 				if (e->deleted) {
 					spin_unlock(&e->lock);
-					rcu_read_unlock();
-					return AUDIT_BUILD_CONTEXT;
+					continue;
 				}
 				rcu_read_unlock();
 				return state;
-- 
2.19.1.568.g152ad8e336-goog

