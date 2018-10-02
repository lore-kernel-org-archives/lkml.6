Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0AAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500732083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxVsnjvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500732083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJBX57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:57:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44141 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:57:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so3087262wra.11;
        Tue, 02 Oct 2018 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TOx7sl96R0nUShdIiCs6GRx/ccbah/pDe8hz/irYzY=;
        b=pxVsnjvVULk55Mxmp8rZ1CPH414O+ltiAvjIDSkROuCbqRO4lRhY8KX9AHG/0avasT
         613mqIyxOcVHC1nQ8TgSbZFnXxupO3HWtc0z9qeyVix98SzQIf8fcwpb0OchEfD8jx+k
         w3UciKKf+/8SfeZ5c4D6pHda0/OBvXTnCRSb00T/zyNuYqzossIuXjUZzXctfaQvkY1F
         52S9IoOg0l0zN7RCeVrOcfFyjNfFC+tkhMHcuDBXj5DrFtxH1fkApspsuPJaJc+6OCj4
         Use/PnRTu8CzL3uiirydx1eZWaElhwNbUq7MjUkhJK1yZY6IjVTyITcXq8NeGp2UVaip
         xj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TOx7sl96R0nUShdIiCs6GRx/ccbah/pDe8hz/irYzY=;
        b=WIUFx/7e0qrfJb9UvS0iuohdq/sLNEh3wPblo9tzfBH2QEH3pk35ZoQ9I58M8eaWcf
         SkCxNT9hpVghuMo/WzxgCHjWlG26BBx0uUfV+uGdCBhdELNHef+6eGYIaGn5GvHlJCV2
         ft79IoZbqFM8zpw6kwV8iNuMYxMC+GxA7zdKaFZFgajmy8nPBJ8XeNhXRKxVAN36+rCK
         krlR2vTeXWnQ5aZbq77t6CNH0Scpbt/NCPuSFSBOSyesoWR59xFsxJAQuy7RDRBtghuY
         PCZZ1WQQvi8GMOiKB9DbMuRpFcvG4q9HXalzbyI2NWJNrP6L8017HJb/NOqeYKF/RMDT
         yzZA==
X-Gm-Message-State: ABuFfog4t02UAQvLOhVJyMBBbqJJnygvSaasCQPbzPFRS2JIU8RpHhLz
        NfSHjwcX0dnCecuK8dNLZKU=
X-Google-Smtp-Source: ACcGV62dBL4QETc72caY1BuzIKk8u61QwI/yY/lf7SZ0Qg6xv8Ndeu3G1recwD+5lQIqFsqz0+3uVA==
X-Received: by 2002:adf:f84e:: with SMTP id d14-v6mr8006704wrq.174.1538500413441;
        Tue, 02 Oct 2018 10:13:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g76-v6sm13354514wmd.25.2018.10.02.10.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:13:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] drbd: Change drbd_request_detach_interruptible's return type to int
Date:   Tue,  2 Oct 2018 10:12:49 -0700
Message-Id: <20181002171248.9853-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an implicit conversion is done between enumerated
types:

drivers/block/drbd/drbd_state.c:708:8: warning: implicit conversion from
enumeration type 'enum drbd_ret_code' to different enumeration type
'enum drbd_state_rv' [-Wenum-conversion]
                rv = ERR_INTR;
                   ~ ^~~~~~~~

drbd_request_detach_interruptible's only call site is in the return
statement of adm_detach, which returns an int. Change the return type of
drbd_request_detach_interruptible to match, silencing Clang's warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 6 ++----
 drivers/block/drbd/drbd_state.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0813c654c893..b452359b6aae 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -688,11 +688,9 @@ request_detach(struct drbd_device *device)
 			CS_VERBOSE | CS_ORDERED | CS_INHIBIT_MD_IO);
 }
 
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device)
+int drbd_request_detach_interruptible(struct drbd_device *device)
 {
-	enum drbd_state_rv rv;
-	int ret;
+	int ret, rv;
 
 	drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
 	wait_event_interruptible(device->state_wait,
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0895..cff0a34c150b 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -162,8 +162,7 @@ static inline int drbd_request_state(struct drbd_device *device,
 }
 
 /* for use in adm_detach() (drbd_adm_detach(), drbd_adm_down()) */
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device);
+int drbd_request_detach_interruptible(struct drbd_device *device);
 
 enum drbd_role conn_highest_role(struct drbd_connection *connection);
 enum drbd_role conn_highest_peer(struct drbd_connection *connection);
-- 
2.19.0

