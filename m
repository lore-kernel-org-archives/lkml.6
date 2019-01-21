Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A2C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DAB217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngihcul7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfAUSkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:40:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44133 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfAUSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:40:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so9835920pgr.11;
        Mon, 21 Jan 2019 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sZsk6vvGCcnh9xoFjveyaxa38aXnCTNvSw7q14lYqqw=;
        b=Ngihcul7EBqKIopYwKq2tAWaEGIy7Mhuy+dCyFzmT1HU1+kQCopmRfz9ujVaE8QmNY
         8F01Y2+q6g/7/k7YZrxHjB0fjgqLYiMKNrUaCaa28t9waVy8ASMrsZUTM1xVx4ERJmh1
         Et5jwnC30u/0CCQBcatKM3cDQKOxZ7Hmoy/2bRbDYHUAxSKXHuCfBcpK8CyQtFiSIMqU
         KQ+xDJE5pE0YtcuBMgPOXU68Jr8ejigvxKfT9N6wMMXj89oEK1zaVUr8wPYdEaz75t/1
         WKSj1vUsFpk4JDSACBMJgdrLaN9+V+XE728V0py54KSJdTMPo1WhKzaOksMGhljKZPGW
         G/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sZsk6vvGCcnh9xoFjveyaxa38aXnCTNvSw7q14lYqqw=;
        b=jgua2NlcVcHmKjWwFIVUAjOmg9rC7MprSXn3GBtQO+Q5Kp+LLUACO0LyVZ21YbjeWH
         /tt39AlU36/WoE39vwpb7zw4OUqLTHOTSvPAKU9Lh0FbxWZaVJjp6vU2dTrTQMZsLBb0
         bzUCEFgbZa04jACaA8KZy34zQN/epU1/MvcPduinknd5/MVEiICnTEyM6hFZOZrImc8W
         9pBz9zyrv48x2y0/q/UD75Jh4uyx3hqSVCJ7uOH0MUjVr476bf84k01PiB6mBz9kzZzJ
         2K2ZDTA43Ki8WWHe9CJBLglxscnJr4fXD+/JJwPkr2+R403odw3hveUMpOkTDOtsgPLR
         jU6A==
X-Gm-Message-State: AJcUuke+4ZXm3trme8H7tjfc0aHcMkDCfQQm+L87a2MyCoBuJYKrJNOW
        xXo9Pxn46Qe7C9H7lQPlvCiGpkLK
X-Google-Smtp-Source: ALg8bN7QILEW1VPM4lDNNcAF+7tm6zZ5NN7tO6GL7t1ERKNQhCgKxovGvIMNgq4HU9r+4erpuAGaSw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr28814543pge.130.1548096019839;
        Mon, 21 Jan 2019 10:40:19 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i62sm15870285pge.44.2019.01.21.10.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:40:19 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: improve the events for sctp stream adding
Date:   Tue, 22 Jan 2019 02:40:12 +0800
Message-Id: <a4261c440ed5821ddd5943ec7ed163004953d8b8.1548096012.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to improve sctp stream adding events in 2 places:

  1. In sctp_process_strreset_addstrm_out(), move up SCTP_MAX_STREAM
     and in stream allocation failure checks, as the adding has to
     succeed after reconf_timer stops for the in stream adding
     request retransmission.

  3. In sctp_process_strreset_addstrm_in(), no event should be sent,
     as no in or out stream is added here.

Fixes: 50a41591f110 ("sctp: implement receiver-side procedures for the Add Outgoing Streams Request Parameter")
Fixes: c5c4ebb3ab87 ("sctp: implement receiver-side procedures for the Add Incoming Streams Request Parameter")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/stream.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 6c188b0..80e0ae5 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -866,6 +866,14 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 	if (!(asoc->strreset_enable & SCTP_ENABLE_CHANGE_ASSOC_REQ))
 		goto out;
 
+	in = ntohs(addstrm->number_of_streams);
+	incnt = stream->incnt + in;
+	if (!in || incnt > SCTP_MAX_STREAM)
+		goto out;
+
+	if (sctp_stream_alloc_in(stream, incnt, GFP_ATOMIC))
+		goto out;
+
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
@@ -889,14 +897,6 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 		}
 	}
 
-	in = ntohs(addstrm->number_of_streams);
-	incnt = stream->incnt + in;
-	if (!in || incnt > SCTP_MAX_STREAM)
-		goto out;
-
-	if (sctp_stream_alloc_in(stream, incnt, GFP_ATOMIC))
-		goto out;
-
 	stream->incnt = incnt;
 
 	result = SCTP_STRRESET_PERFORMED;
@@ -966,9 +966,6 @@ struct sctp_chunk *sctp_process_strreset_addstrm_in(
 
 	result = SCTP_STRRESET_PERFORMED;
 
-	*evp = sctp_ulpevent_make_stream_change_event(asoc,
-		0, 0, ntohs(addstrm->number_of_streams), GFP_ATOMIC);
-
 out:
 	sctp_update_strreset_result(asoc, result);
 err:
-- 
2.1.0

