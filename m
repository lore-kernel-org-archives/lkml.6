Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB09ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FA62150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Df1BR2ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FA62150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeITCaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46265 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbeITCae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so6004563edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/GN/0v5e4mpHpuFOFRnCIZwBKmgxXnFMSxpKitNeAXo=;
        b=Df1BR2eiVg0pMMtMSqaZcj/d+myni8ow5rNj21y3uhN2h5TdxnAml73SnELbQbAuRe
         lCWAiGW2bkvRTXVnVDhouOUtk9Bg+yupo2pUB97gXdgRJNNez65RCN2iATn1wAB8jKHQ
         BIrggy/J3XKDOIF3OProbVFHR7rjc1rZVux55zziNvuWLLyRBqOlQDsJDC9fqWHHoCOD
         bIexySZybD5BdlT5Et8435pIVB9xwAqDvTUVm4NXy54X88AiCm3KgECNppmu7sfmImMk
         i6RhJ96bdVYVnlcxedlYGqRkOCT3XdKfer/hPupKZzpKfVTNluXhijNVeN9O2PGX2h3O
         Oo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/GN/0v5e4mpHpuFOFRnCIZwBKmgxXnFMSxpKitNeAXo=;
        b=nIgj50DD+DNzQC2FIda9l0UPpl8T8VmH3UV/lTQkdBVinGu8U2Z/XCRWsJJV9tVrn5
         QZoudZhSqJf08htqeuO2lmBw5g146J2dbGKmbXBXkVh7ILeEkZjoGJnPywMYzsLDrFRv
         GDTAovUgsjMZkHklwnAwL25qeoTltJeMDDh5LuI3GkrpkmH+8vkbSw3hXju9ug4vD+Dn
         wWaEiqlHNQCht3cmO04tKMy1N/ybd7oMD5ecZ9xgqjvCmj/GLM56haOivTkfcJKGD/x0
         4Uv/oh/lTBSvciDH/bt0HsSy8tPdpqr2v9+dnQOfz2R3JhQ1QlpqXBK4WlI+6x5d9e6U
         d+EQ==
X-Gm-Message-State: APzg51CbEhddJiFatnSDIIov/Ydfu6Jq+MMyMof6vY5yoGzVb805w1Cn
        00lgziXIETyG65RlujWe+wWO04rjs38=
X-Google-Smtp-Source: ANB0VdaTR6MAQ9mODf/tFwY/lDopHyqQzpk6vVzStplztbPZcyXWlJB3DDoD+1hE6WD6SP9BHmPp5g==
X-Received: by 2002:aa7:c881:: with SMTP id p1-v6mr59783289eds.295.1537390253998;
        Wed, 19 Sep 2018 13:50:53 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 10/20] x86/vdso: Use set_normalized_timespec() to avoid 32 bit overflow
Date:   Wed, 19 Sep 2018 21:50:27 +0100
Message-Id: <20180919205037.9574-11-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

ts->tv_nsec + offset->tv_nsec

On 32 bit machines that sum can be larger than (1 << 31) and therefor
result in a negative value which screws up the result completely.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vclock_gettime.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 0594266740b9..a265e2737a9a 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -231,20 +231,37 @@ notrace static int __always_inline do_realtime(struct timespec *ts)
 	return mode;
 }
 
+notrace void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec)
+{
+	while (nsec >= NSEC_PER_SEC) {
+		/*
+		 * The following asm() prevents the compiler from
+		 * optimising this loop into a modulo operation. See
+		 * also __iter_div_u64_rem() in include/linux/time.h
+		 */
+		asm("" : "+rm"(nsec));
+		nsec -= NSEC_PER_SEC;
+		++sec;
+	}
+	while (nsec < 0) {
+		asm("" : "+rm"(nsec));
+		nsec += NSEC_PER_SEC;
+		--sec;
+	}
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+}
+
 notrace static __always_inline void monotonic_to_ns(struct timespec *ts)
 {
 #ifdef CONFIG_TIME_NS
 	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
+	struct timespec offset;
+
+	offset = timespec64_to_timespec(timens->monotonic_time_offset);
+
+	*ts = timespec_add(*ts, offset);
 
-	ts->tv_sec += timens->monotonic_time_offset.tv_sec;
-	ts->tv_nsec += timens->monotonic_time_offset.tv_nsec;
-	if (ts->tv_nsec > NSEC_PER_SEC) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	} else if (ts->tv_nsec < 0) {
-		ts->tv_nsec += NSEC_PER_SEC;
-		ts->tv_sec--;
-	}
 #endif
 }
 
-- 
2.13.6

