Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DB2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbQcRlzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfBLKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:51:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37464 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfBLKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:51:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1083452pgq.4;
        Tue, 12 Feb 2019 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5JxqX8/KPhZ5ksvIq0G/bu7zCyf8OsXuVKLCDi1/GRs=;
        b=sbQcRlztm7g8v5tI7OHh9ejojBw7b12Nv0u7hSbA0zRv2PY9zY42b021TyS0rB9rKd
         JriXcxgQR/H2lMGvV9GSzbZFUi8GlgKNCXtGs4hq1FUW49fgz/eITxsQCYltj+yYHTy0
         Ba5/QHd83GAqOS1SNKI98NeeGB7uzSldIxh4zdI7fSYeP1aFsLNTx8fHkWcnh3UUDeC0
         XpXDw0br5VvFvFE690FjmDx21T3z26Fv7kP48reFZVy9QKeIOqKpD0P686NOCGbCUBpt
         y8bKZYarOo5gSNMfIV3SN3VbChqK/V3JSdvidZFdSGS7LterhQ6PxwYi7voI58ZIPLXE
         wRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5JxqX8/KPhZ5ksvIq0G/bu7zCyf8OsXuVKLCDi1/GRs=;
        b=QlJkb5wvMges1fKECpvUg58r4qR73vRP5y7nShGZHSmXE52/mlggfHsIU+CAjYIOCl
         aKEDW/c0F4gH5sqygfnzTxvgn4A1Gv2I2vY9PqF3k7ciVWKBYOrScxly5RDh4nyf/0Xj
         3Oy0xgYsn9PvbAYXcurseDZ7ZZDzbYYLl22znXK4O5YmiNfvsresx0Lo5RsC7TprQjoN
         e9f7KGO6eon8q0qIyLY3bLdhw2IQS5IHSeHf3/1P/LPt7FBNWHIT75r1sF/NM2tvtp0y
         xDZznUCPUw0P8M/AW/9zDEqAOTZTc8/VguTZP3AT9f4iAW9EEjPbP0am88zlQp1GW70b
         Mu1Q==
X-Gm-Message-State: AHQUAuaDlOjiFXhnBHAbgdHxQGJx6FCS6wcHVVT7BAD2QPPOvBKUtFoA
        pPvXIs1eNd22wTTwwE3NyfYOnrmF
X-Google-Smtp-Source: AHgI3IZRxDIxIue+IFro6fJPxBJ0rXHdoOJWRL7moYzD/bWKcpg9dr7lR+5q8Swti5szyYlp5Ia4/w==
X-Received: by 2002:a65:6294:: with SMTP id f20mr3043263pgv.174.1549968669037;
        Tue, 12 Feb 2019 02:51:09 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 14sm15748965pgq.22.2019.02.12.02.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:51:08 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: set stream ext to NULL after freeing it in sctp_stream_outq_migrate
Date:   Tue, 12 Feb 2019 18:51:01 +0800
Message-Id: <0cb9e543c21495df48c3723044d6c9f64f238eca.1549968661.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sctp_stream_init(), after sctp_stream_outq_migrate() freed the
surplus streams' ext, but sctp_stream_alloc_out() returns -ENOMEM,
stream->outcnt will not be set to 'outcnt'.

With the bigger value on stream->outcnt, when closing the assoc and
freeing its streams, the ext of those surplus streams will be freed
again since those stream exts were not set to NULL after freeing in
sctp_stream_outq_migrate(). Then the invalid-free issue reported by
syzbot would be triggered.

We fix it by simply setting them to NULL after freeing.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index f246331..2936ed1 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -144,8 +144,10 @@ static void sctp_stream_outq_migrate(struct sctp_stream *stream,
 		}
 	}
 
-	for (i = outcnt; i < stream->outcnt; i++)
+	for (i = outcnt; i < stream->outcnt; i++) {
 		kfree(SCTP_SO(stream, i)->ext);
+		SCTP_SO(stream, i)->ext = NULL;
+	}
 }
 
 static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
-- 
2.1.0

