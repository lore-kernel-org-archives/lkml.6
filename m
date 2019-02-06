Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E9C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542F218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Xwfr6FR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfBFALV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43163 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBFALR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so4445097eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GUoFTNniPDyfiwRgUfcUTytEWqh8nWBu+fPwR0GKeU=;
        b=Xwfr6FR+bNuw9+nDOx1MqTF73/dIFKH1BCfSHk0iRQeWdPIywbbNzre0HQbfl5Y1sE
         l45wvpqXYMn+LI3TSyTA/Eq9SqEEQB2oHUh6BnauWEQALUUzyDdGLE7ZzY80H3mmmZBf
         qgXaaGllr3VnSZl0VofxUFMuszqG0D9Iru1Gv6LXSUodJVrtB9WJg8clZRuiDwOtCyXh
         kMBtzWTNfzNf22LIF6hjtfz46RRjKaXrJxReSVOW6BCpVNYzNnee2AplfFlogGnEZXpC
         rHIQExcXZilYlrC/HzQkO6wcEt2X0hcsz+82m9nEE3naKEUM/0n+kIDiee6HI7Kh53CK
         mTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GUoFTNniPDyfiwRgUfcUTytEWqh8nWBu+fPwR0GKeU=;
        b=r83L1HX4trSyd0dYX3UuwzHsPiB5QT2D6A/CqepKh/mqaCmTbLiRnpzODZslNGEHXa
         yPi0xIXdQL4LuhAJWxJL2TNk9JzJjRQ+pvO+M8ZEIsEQcLt0ttnvLR2lnnHU5Snoi7lR
         e7ukPJ70Cam3iUm3h3GOF/TFfoOh1PrDRfEl70mUqPNsgiiORetk1Km3Q1X19kT7lgtr
         QPDtsDQZnHJGu8UrH2Tr6P4oGqyhITLox2jKZHoHxbS2mo6MH262vS6GG0CQjJmx0DNe
         twmcHemHaxP1/BsE0xNYw1DImt+FEZnqAtOx+VUbsa6QBngcRw6cV6pSCQFUpS8cz92R
         VLAg==
X-Gm-Message-State: AHQUAubbTIdQ+qeZxyUKv2WSE+1/wfbd7DOJ+hv+aBWv3CKwTJqf5VIn
        96LhKfFRPnNKqC9fg21RwkcDN7pFQNg=
X-Google-Smtp-Source: AHgI3IajfByzsByLcwWGFDx09EEv4S5qW/LSMyItlLRTvHFQJxsPpnM0cdzN9vk360joiem9HVXkSA==
X-Received: by 2002:a17:906:9611:: with SMTP id s17mr5467367ejx.37.1549411874645;
        Tue, 05 Feb 2019 16:11:14 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:14 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 04/32] timens: Introduce CLOCK_BOOTTIME offset
Date:   Wed,  6 Feb 2019 00:10:38 +0000
Message-Id: <20190206001107.16488-5-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Adds boottime virtualisation for time namespace.
Introduce timespec for boottime clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 1 +
 kernel/time/posix-timers.c     | 1 +
 kernel/time_namespace.c        | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 248b0c0bb92a..777530c46852 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -4,6 +4,7 @@
 
 struct timens_offsets {
 	struct timespec64  monotonic_time_offset;
+	struct timespec64  monotonic_boottime_offset;
 };
 
 #endif
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b6d5145858a3..782708054df2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1314,6 +1314,7 @@ static const struct k_clock clock_tai = {
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_boottime,
+	.clock_timens_adjust	= true,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 57694be9e9db..36b31f234472 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -208,6 +208,9 @@ static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
 	case CLOCK_MONOTONIC_COARSE:
 		offsets = &ns_offsets->monotonic_time_offset;
 		break;
+	case CLOCK_BOOTTIME:
+		offsets = &ns_offsets->monotonic_boottime_offset;
+		break;
 	}
 
 	if (!offsets)
-- 
2.20.1

