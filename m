Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F3C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DF12086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnsM8p3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfBBPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:36:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41601 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfBBPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:36:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so4761569plm.8;
        Sat, 02 Feb 2019 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ep5fptQz+b8fID220B+upt0jj7H31zdPE/L67ZyhXc=;
        b=EnsM8p3zLK0L9damTbvV+8WeEHiGL6rfBUHB8u3Gk74AD1tNY8A+Fo+7nZ8EXu5wxw
         Oh2xzkUDidyzCwA7TYYtHom0Y0yWhpzpBpDK9IDN3m/6ORdfJueGGvoWd1h4CFoLEy4P
         CXQSg0gVV+TVgrjDKhP8v/EhpaHzLjZbRwcZqNPVeAVtJgEr7/IYrnuEc9DpZYJ+NK4G
         tf1RWXKd7w0BCuTREbFVNjpFwIwqPDO7ufG8f5gNMnx/hUutxB0rI5dk0LqQHT9pJa6y
         McZONevgKHZbdPitC9h+7ccksRZQLLumRKjH2MCJb4VwQzMWLe2gF2G1XLrT+evlplwc
         dKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ep5fptQz+b8fID220B+upt0jj7H31zdPE/L67ZyhXc=;
        b=soV74BmzlIjG5lTrtBPp2hhp2qKmWZQHv3FlF3Ptz1HHVzXkM50bBdL+0bgfHxoD30
         aVSFejmKE6GBbsqmKXAWJ0EtCV5RRmvwKE+qukmdUdadCCsonChy/uSU8Qx9XgOehPUF
         emw+7ANkq9aWpKha3ISip5g8+q3ddn6A8WSxYE7A/zotnde9iN+DBaEXSV+gBKnfRBZt
         wzM14vgG/4Eohqdq24eRU9LNT6KX13Bs4vI0+nz5wSYj/MxWq4IOhWCmY81abzlaBPmq
         tnQR+PIpDYVs+a8F0NvuLsc/MG8+H5s68UxtodAuB8D3PAPWK7n9Q/UIIWPU1E4fRtJz
         +DVg==
X-Gm-Message-State: AJcUukervEFh/bLBCjP34c6c7fuexyBmRNazXPHlzo/l9bN6YI7azAWo
        Vk4Bi1Ct0kErvpc/riGbGp8OXoms9uw=
X-Google-Smtp-Source: ALg8bN7XGV2l5/gwt7d+SdPfduXfVqUyuDmu+olZrqp5NHkZjCzEfm0cMZSQ6UQhfyTFqhEeFyDMnA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr45034188plb.107.1549121759525;
        Sat, 02 Feb 2019 07:35:59 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:58 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v5 10/12] socket: Update timestamping Documentation
Date:   Sat,  2 Feb 2019 07:34:52 -0800
Message-Id: <20190202153454.7121-11-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new y2038 safe timestamping options added, update the
documentation to reflect the changes.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/networking/timestamping.txt | 43 ++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.txt b/Documentation/networking/timestamping.txt
index 9d1432e0aaa8..bbdaf8990031 100644
--- a/Documentation/networking/timestamping.txt
+++ b/Documentation/networking/timestamping.txt
@@ -6,11 +6,21 @@ The interfaces for receiving network packages timestamps are:
 * SO_TIMESTAMP
   Generates a timestamp for each incoming packet in (not necessarily
   monotonic) system time. Reports the timestamp via recvmsg() in a
-  control message as struct timeval (usec resolution).
+  control message in usec resolution.
+  SO_TIMESTAMP is defined as SO_TIMESTAMP_NEW or SO_TIMESTAMP_OLD
+  based on the architecture type and time_t representation of libc.
+  Control message format is in struct __kernel_old_timeval for
+  SO_TIMESTAMP_OLD and in struct __kernel_sock_timeval for
+  SO_TIMESTAMP_NEW options respectively.
 
 * SO_TIMESTAMPNS
   Same timestamping mechanism as SO_TIMESTAMP, but reports the
-  timestamp as struct timespec (nsec resolution).
+  timestamp as struct timespec in nsec resolution.
+  SO_TIMESTAMPNS is defined as SO_TIMESTAMPNS_NEW or SO_TIMESTAMPNS_OLD
+  based on the architecture type and time_t representation of libc.
+  Control message format is in struct timespec for SO_TIMESTAMPNS_OLD
+  and in struct __kernel_timespec for SO_TIMESTAMPNS_NEW options
+  respectively.
 
 * IP_MULTICAST_LOOP + SO_TIMESTAMP[NS]
   Only for multicast:approximate transmit timestamp obtained by
@@ -22,7 +32,7 @@ The interfaces for receiving network packages timestamps are:
   timestamps for stream sockets.
 
 
-1.1 SO_TIMESTAMP:
+1.1 SO_TIMESTAMP (also SO_TIMESTAMP_OLD and SO_TIMESTAMP_NEW):
 
 This socket option enables timestamping of datagrams on the reception
 path. Because the destination socket, if any, is not known early in
@@ -31,15 +41,25 @@ same is true for all early receive timestamp options.
 
 For interface details, see `man 7 socket`.
 
+Always use SO_TIMESTAMP_NEW timestamp to always get timestamp in
+struct __kernel_sock_timeval format.
 
-1.2 SO_TIMESTAMPNS:
+SO_TIMESTAMP_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
+
+1.2 SO_TIMESTAMPNS (also SO_TIMESTAMPNS_OLD and SO_TIMESTAMPNS_NEW):
 
 This option is identical to SO_TIMESTAMP except for the returned data type.
 Its struct timespec allows for higher resolution (ns) timestamps than the
 timeval of SO_TIMESTAMP (ms).
 
+Always use SO_TIMESTAMPNS_NEW timestamp to always get timestamp in
+struct __kernel_timespec format.
+
+SO_TIMESTAMPNS_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
 
-1.3 SO_TIMESTAMPING:
+1.3 SO_TIMESTAMPING (also SO_TIMESTAMPING_OLD and SO_TIMESTAMPING_NEW):
 
 Supports multiple types of timestamp requests. As a result, this
 socket option takes a bitmap of flags, not a boolean. In
@@ -323,10 +343,23 @@ SO_TIMESTAMP and SO_TIMESTAMPNS records can be retrieved.
 These timestamps are returned in a control message with cmsg_level
 SOL_SOCKET, cmsg_type SCM_TIMESTAMPING, and payload of type
 
+For SO_TIMESTAMPING_OLD:
+
 struct scm_timestamping {
 	struct timespec ts[3];
 };
 
+For SO_TIMESTAMPING_NEW:
+
+struct scm_timestamping64 {
+	struct __kernel_timespec ts[3];
+
+Always use SO_TIMESTAMPING_NEW timestamp to always get timestamp in
+struct scm_timestamping64 format.
+
+SO_TIMESTAMPING_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
+
 The structure can return up to three timestamps. This is a legacy
 feature. At least one field is non-zero at any time. Most timestamps
 are passed in ts[0]. Hardware timestamps are passed in ts[2].
-- 
2.17.1

