Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705B720870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pApMB8xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705B720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbeKXNJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:09:13 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36011 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbeKXNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:47 -0500
Received: by mail-yw1-f67.google.com with SMTP id y194so5433599ywg.3;
        Fri, 23 Nov 2018 18:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZlfJRLUkke/oxeKgWj35vHiMedOGQ7TgITYvquok2s=;
        b=pApMB8xv4PVwmrZtdqmbGrDYqr0I1UheYtSJlRzDzOQvZctf4HRIaJcF4Yxah91+4Q
         +tLkoAgFVsGQuQrMGh9S3zJWtWy7ie+LohipxNt6wEvczD09NqM5BoeO2rOQqtlqKkyO
         UrMB55IjD9I+R3Puu6KajeELSJKRUo+ZSFzLavZGMOpbawkvAdfzE+5t5RzK3wQ7v5mN
         ommtVYtWOpjasWs3+KI6IEdev90qQutNIPO4VYzvn5p0+UvDT5UIm2/ECtd0PfmyHxBd
         traqVQ0GS+vug7vgpF0K9LXRdVnH+vkJIWVYSbmxLKhtSLABUAsEAQjruWogfi4lTvqX
         Hxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZlfJRLUkke/oxeKgWj35vHiMedOGQ7TgITYvquok2s=;
        b=aU0yVGCbtjkeF34XyYwBQiJ0DNJP7LEKbWwugf/MutqqWvE4peSydMD2uWVZ3LRFbo
         LNAmA09emXxLVVY2aSAgbCnF/axNvgcpnywbp8wFFNN5GmLqFZe1JlfmMwsO8P8EsLvZ
         4wHPYjCjnZDxKomQJErbGfYyLOwYfrgSj9GH5blij48mRtvvQCf3gb67VS2vPVSKkQwT
         gKD3N0qP6o20kpJnYjHIwN26snZiaEYt/yEBISpAUPir4yjE3bRLvsEDxPSXr/ICJ67t
         T6zBSnehDqYoD9c1LCdfdyVLh6H+zEKmWHRAk5o0tLPz6hsaJWJ7RCrHkmfizQe19Ae7
         x+3w==
X-Gm-Message-State: AGRZ1gIHEvGTvW5grKilg8r6RW/9fryizti2pAOAd20PIYRhGoKwj/wZ
        u52G6RvPbxq3ua7pKeRR+m8=
X-Google-Smtp-Source: AJdET5e0CfICM5TzAiiKAAaIs44gzN+j7pJykxVdhW7h/nthobuBo+QhEjpUfmx1R1AOos9SHM/zMA==
X-Received: by 2002:a81:2f4b:: with SMTP id v72-v6mr19593175ywv.117.1543026130250;
        Fri, 23 Nov 2018 18:22:10 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:09 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 6/8] socket: Add struct sock_timeval
Date:   Fri, 23 Nov 2018 18:20:33 -0800
Message-Id: <20181124022035.17519-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new type is meant to be used as a y2038 safe structure
to be used as part of cmsg data.
Presently the SO_TIMESTAMP socket option uses struct timeval
for timestamps. This is not y2038 safe.
Subsequent patches in the series add new y2038 safe socket
option to be used in the place of SO_TIMESTAMP_OLD.
struct sock_timeval will be used as the timestamp format
at that time.

struct sock_timeval also maintains the same layout across
32 bit and 64 bit ABIs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/time.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 04d5587f30d3..106f9398c285 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,6 +70,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct sock_timeval {
+	long long tv_sec;
+	long long tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.17.1

