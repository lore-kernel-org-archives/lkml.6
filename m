Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF9C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C256218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEryN4nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbfBAPpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:45:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38882 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfBAPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:45:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3112874pgc.5;
        Fri, 01 Feb 2019 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=UEryN4nUduEmVJ4C69Z57lNGM7zZoLX+tft7t00DCnKEGPuBTYOOD2qq8FKEQq5gDf
         LDhxYra0aasfameWcFMvVXnTaRJXXyWVHIeqxJHLSqdEFQp6y+Urq9g7G2FJdrgAQ5GJ
         0lCe8tBQNWTgIxCBgb8bXwC70v4SLzOWx0I3V52BC+75u8HvK6e56zrJjo2P9mpJiCS/
         CIc5Pr8b/cUpe8vmzVv9HqFbXZHot0mdXgAluT6uHkmK9tlnb8dIaQcOichtUhEabRYA
         BP5fiPe2SfN8X+xvKaj0HKwt9oAa2k/9VwP0UZIBlJ/sFX5UZn57oetFVuM/5aoFq2l/
         lyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=fGW/4a90ntGQAnKuDRc3thOo9iBElpm/tePScvpRHb4npry7jIfulQnC3mV4S/vOc1
         +Qbn6VTzjrQhJnlYW8PmcFPevBQAgJ9EMWynQE6Cz6YTo6Xl08WiXPaat9YeTJk7Zwxu
         gespMFM+O/5DJx/FL3JzEFCGy/exMHoNboBp4fHdN6iT++Qio8T+6K8VqlkdNjH9lTIa
         uVBxJontyEVL7j+vd+CJHejd9cCBH4yI4zwMgU9fXQNdirnFKaCgo/RE09fzgC4YYtpS
         ar1RdvtrIoxD6sI0zDwo5lygpBnDI64MPwDNwTSVKyGEnYzT96xWtd9qjyqwFRlExc7P
         oPJg==
X-Gm-Message-State: AHQUAua83nTg3cKdKK0RIQvOMKhqfql5+rjDdd7r+hD91J/VoGOxDHbb
        9yPnAFJcjDKmJTITtjcQhLaeEj+nGr4=
X-Google-Smtp-Source: AHgI3IYt353tVE9V4RvNsuhOviBVfunKo0WY6+sUELYCINR40zvTisLp77rfWkv2nJrOwMijHJ0JGw==
X-Received: by 2002:a63:2263:: with SMTP id t35mr2745742pgm.69.1549035911781;
        Fri, 01 Feb 2019 07:45:11 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:45:11 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v4 07/12] socket: Add struct __kernel_sock_timeval
Date:   Fri,  1 Feb 2019 07:43:51 -0800
Message-Id: <20190201154356.15536-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
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
struct __kernel_sock_timeval will be used as the timestamp
format at that time.

struct __kernel_sock_timeval also maintains the same layout
across 32 bit and 64 bit ABIs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/time.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 04d5587f30d3..b8ad1b86b942 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,6 +70,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct __kernel_sock_timeval {
+	__s64 tv_sec;
+	__s64 tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.17.1

