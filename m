Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9686BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAEC21528
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fUL07kd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAEC21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbeITCbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:31:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42325 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733016AbeITCal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so6024441edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztf8YpTkVvtiEmzZs16uUOXuqV4u0/0rWUgb0ZmP8Vk=;
        b=fUL07kd+lgL1PnLP83CB/PygTsNMJFVP4er83zwyzoysiSgVpfc4onoBo1nAY1beXg
         /PK1BqtuDJw5z9EPu1TC9WP+8K5pM8HRjfC5fKWNvPDi8OkPonwl3iU5Ut3MoSrjf17Z
         1sPo+y/7WG5ajg0Xx4M3boLroGG7LzpeAgG37S0EFTRBb8jEFCh3QqSHmHwRk//qOJXU
         pg3Nex9LqYtdk1yxE02zXjJq9i0ql/69F9M25PD+uzeb7Y93ThTZc6cZX1HW5OgEDEcf
         cTGGvkaHuQAzP7Q3xNJWKKyUxss0Bhea8s+fQSKv9A2HR8IRT+egcu0Crqb9r8SnITKq
         CsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztf8YpTkVvtiEmzZs16uUOXuqV4u0/0rWUgb0ZmP8Vk=;
        b=SJ5WHzmHftGIDR4VhrS7RLHMf4+zWj54pJIadfs8LdRFVXomJngKUnffkrWEGH8NKm
         kCq3vlqAbmG7l/Cs6yL+TriYD4wRip7tPwKkihyNg/zvqldwFK/fB4a47pUC6jfPsxTL
         9vK5cchu5Tqq1swtA2pQfh74r8B/OcPre8l5pp7hUoFr+VEdNa9bgf62159NWjZddQZA
         WA8BtBXdADbOQ41mfctblPr2RzkGMq+pwh8mlfZTm4+/egVu12ruCRCfqO1S1envYAfa
         UR1I9MsaF2fnmLBAX0GrW2mMJ4Uw18cK1VwRDTXMc+OFPS35OLqvK7zhTme0ol+MCW3R
         W3xw==
X-Gm-Message-State: APzg51AdLe4E8MYhpEiooP7/uAbJeJQRvFSm+zR3D89JhPd2EBgM//Dp
        2XWJSkJYF2HX5W+e1I7ymzCk87QyZM0=
X-Google-Smtp-Source: ANB0Vda0DMyDRmUjVYj0k4Lzm4JJFa7qufOcN4wUSmjIm1UKQQLXUmgr4c4+rtY3c3iovTJiaNokQA==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr63246932eda.33.1537390260155;
        Wed, 19 Sep 2018 13:51:00 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:59 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [RFC 14/20] timens: Add align for timens_offsets
Date:   Wed, 19 Sep 2018 21:50:31 +0100
Message-Id: <20180919205037.9574-15-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align offsets so that Time Namespace will work for ia32 applications on
x86_64 host.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 777530c46852..92a8ea5601eb 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,16 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on vvar page,
+ * which should have tail paddings on ia32 vdso.
+ * Otherwise as u64 has align(4), vvar offsets will differ.
+ * On 64-bit big-endian systems vdso should convert to timespec64
+ * to timespec because of a padding occuring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64  monotonic_time_offset;
-	struct timespec64  monotonic_boottime_offset;
+	struct timespec64  monotonic_time_offset __aligned(8);
+	struct timespec64  monotonic_boottime_offset __aligned(8);
 };
 
 #endif
-- 
2.13.6

