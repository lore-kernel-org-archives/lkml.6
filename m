Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A2C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D787B20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5D19KxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D787B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeINKNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:13:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55542 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeINKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:13:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21-v6so629737wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CwcjGCOrKORGMIV7q3M8zN1B7I7I3fSMwgRcrap/c94=;
        b=l5D19KxByP0D5/v7jxXRBrvOfqjaHe2+zXVbpVUf3OdGDsmAK9dCg5EVmG6JXNVehM
         jHuOgd7MNfPl+4DIf1qdL2HELrj7YaxIOSC8v+ecgD0q01NbJIqbDh9bOxrQJBv3f0b5
         36yI5Fi+7tfunI1tqBsQjOCy2G+3cbK9i0CWTqYdR+ll7FAfqdqqITV1zOsnIxilCUIw
         ygpvIrRjV4mdWeuU+ZEbuS5TmWb8z/jCeykzvPx34OMZI6C3f7+UoYQcdGPgw3hAwBE+
         lwiwTSgsZEtsEQnmFydYW7ge64jBH4nhYdL0Rk1Su7RujqBuqHSebqHhiMx+5kbfpwMw
         r8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CwcjGCOrKORGMIV7q3M8zN1B7I7I3fSMwgRcrap/c94=;
        b=Ho0R/DMB9x09Y4x2eOD1Q4t6827CJCxe6Kw8xHW4dLBcLqp/aSSzsf7rhNHhsR28kw
         2mSiMqo5aPBcj/Vy8ZyzPT74NbX3vFzR6K+ppO3BEZv+5zggMA932MnKnD2kdvlmkU46
         fiuEs+opKh/RqtrZ1JB18FjN1qimyb2BsjnDEeYO/Dl6nSCmbtHPWhaT6TIcTKG0l4vJ
         a9/EqGxTL7e4y5WvHzNv+kCJv2qriWguFjrWflPeWr3+D7K0M4120NOeqB7nNT+PODU8
         29bCit8Yy4ariRlPv2/PPGV4bBhJ2C1u2NKWkiS+LEDDGaatcrN0E37DpnNqWHgF4dU9
         P5PA==
X-Gm-Message-State: APzg51Dsa3K/TDzse0dSktX0nwSV5RLjTW+yWNbA0W5eYE3Dew2zHDaO
        DebvxxIc4/sb8bUmW8StZTY=
X-Google-Smtp-Source: ANB0VdZydgTdk4XJjjgM8/m0xHq1lN+7f27inpbAYHzU6OGv5DIT2AQPweXfguh9GQD9eQ3CDwXaMQ==
X-Received: by 2002:a1c:c64c:: with SMTP id w73-v6mr780399wmf.98.1536901264509;
        Thu, 13 Sep 2018 22:01:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 198-v6sm766876wmm.0.2018.09.13.22.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 22:01:03 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drbd: Change drbd_request_detach_interruptible's return type to int
Date:   Thu, 13 Sep 2018 22:00:47 -0700
Message-Id: <20180914050047.7079-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
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
2.18.0

