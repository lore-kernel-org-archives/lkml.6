Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA593C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C65217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFKeGx+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBCT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:28:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46871 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfBCT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:28:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so5720879pfe.13;
        Sun, 03 Feb 2019 11:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6t8z9TR6tcvYHgtBD01ohlqgFY8yYXUSVAMHpogCynw=;
        b=qFKeGx+xLNpNwSIJxxVtInJ3aOat2nkwM6Pw7zGZEv4WRoZ1F328zqz/SUq0xZtmNA
         8rxd6bT7GCCM7m4PlquXAp0e9O2/Ipazdyp5E7v2WOG+EKOW41+pvMZIzvwamAkqrmkX
         xVDwsJWD7I0T4yBvnY34QCiPDnX9ys1YtFgnXsdAV4XZUl4BmCSeKQrDcKZCZ5o0qXHC
         yjcIIzNUZ8FEERkBh1xc7ki1gsK8PV45CX3MCBuisV1SIqho5KR4RaF/3xUwgqwuhI1D
         rPby83OCyqgt/tZKPpEZUT64mlkB1mQb80LccLmhXXWWDm8N4OHX4HyW1WCaIc/6szAT
         PWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6t8z9TR6tcvYHgtBD01ohlqgFY8yYXUSVAMHpogCynw=;
        b=AIKMrPv5no/culFUn4H9q1GvZ0I9vXPbOa1KlrYPg18td7aA9avaGizqBudphfWfnU
         /Y8/qDROqL5HxjxcehciwL5zD9hvc1Dkqi9BwU4gpeXtt112zCKHjSrAi3e0M5+ClpLr
         SpHvJZZRBnrhAgvDf0WhLP24yvWvvZLsfGg1G58FKGHKhydE5X87gUjYYMljCjTM1GJe
         NajefE7tDSpGlITSzZTyzCh2bmPeJtCuckGrkkX9uMQJYflKmRhyA0dD2wwjOYol5vRl
         azfgdwBaE0ie+9p2xXnLLJkzl4FUdVIHb1sUhapjpmsZmAwzvuUMSbrxPZ43O8afKvgF
         RlnQ==
X-Gm-Message-State: AJcUukcnjkKN/ta4yW2uRkMUAj0Bj+mOFZiWGlUY/UwTeuHkmguUqZMo
        Dcz9AROx8Nrp629QBlJIGC+MugmIKYk=
X-Google-Smtp-Source: ALg8bN5BxabIYca5hmGKc+nQJ+NzrLBPHsglex8Be+XJnHlb7ib+mqkAwqkr51hTXxA5UvVHzSOxNg==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr49668482pfb.122.1549222086098;
        Sun, 03 Feb 2019 11:28:06 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h8sm15161669pgv.27.2019.02.03.11.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 11:28:05 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCHv3 net] sctp: check and update stream->out_curr when allocating stream_out
Date:   Mon,  4 Feb 2019 03:27:58 +0800
Message-Id: <91ab89c95836cfcacbe823f4bc0ecd2568bad113.1549222078.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when using stream reconfig to add out streams, stream->out
will get re-allocated, and all old streams' information will
be copied to the new ones and the old ones will be freed.

So without stream->out_curr updated, next time when trying to
send from stream->out_curr stream, a panic would be caused.

This patch is to check and update stream->out_curr when
allocating stream_out.

v1->v2:
  - define fa_index() to get elem index from stream->out_curr.
v2->v3:
  - repost with no change.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Ying Xu <yinxu@redhat.com>
Reported-by: syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/stream.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 80e0ae5..f246331 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -84,6 +84,19 @@ static void fa_zero(struct flex_array *fa, size_t index, size_t count)
 	}
 }
 
+static size_t fa_index(struct flex_array *fa, void *elem, size_t count)
+{
+	size_t index = 0;
+
+	while (count--) {
+		if (elem == flex_array_get(fa, index))
+			break;
+		index++;
+	}
+
+	return index;
+}
+
 /* Migrates chunks from stream queues to new stream queues if needed,
  * but not across associations. Also, removes those chunks to streams
  * higher than the new max.
@@ -147,6 +160,13 @@ static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
 
 	if (stream->out) {
 		fa_copy(out, stream->out, 0, min(outcnt, stream->outcnt));
+		if (stream->out_curr) {
+			size_t index = fa_index(stream->out, stream->out_curr,
+						stream->outcnt);
+
+			BUG_ON(index == stream->outcnt);
+			stream->out_curr = flex_array_get(out, index);
+		}
 		fa_free(stream->out);
 	}
 
-- 
2.1.0

