Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D47C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ED8222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVsQgHTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439334AbfBNOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:49:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36215 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407275AbfBNOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so6815047qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmV7tN/knUgUsr5/TOMZopkZ7lVFuxceU9ssNxtaR8I=;
        b=pVsQgHTensRPPDJjhW9eW0OSmKFdVMsJXvTV9Wc4PvA8CHgSyb7wXjaB8cRdBYremx
         9U6G05RYzbgS7R1ZHlXok7xqM/+QFjru+/prg0CxFiVwEDe1HsXgyODuhH7WoIGJcqIL
         jjw/FU1o4ox5q8fL9ICBTC0TQbO0wF5O4qVEsz8+9dk+GAWrl7lvvrrOdPQEkOmYdREb
         s8qe4Gg3w9D1jaCDMQo196jzjVlrWXaybqK1kDWmj7WniLHSzByyuRTmkRk5KOcIuZqE
         Ad94JzkLfd0SUPIVi5ThlGcigDgaXNyTqQpyXth93478x4TJdqnfPokQFBpY2v0zTvGE
         AX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmV7tN/knUgUsr5/TOMZopkZ7lVFuxceU9ssNxtaR8I=;
        b=qUZpGVgE7/k6TegdnCI7sEX/DGD2tGF4oZGkVsJ/whIX9Yju9YSRc7w8cRmMYsXUJX
         6lxH4pI4n812mKeHLgwLHn//xVWJV4WYbWFerECey7HGMEYQNmBXIeY8S5hwWm8pwQHV
         8nD/brtUSpSuBSmAPKMLH/aKsnVLhlZ5pSUVcTzQcDu3W70B1hhEL/STJBhH8b79dp93
         d5uTibTK61wkRVyhZzPFCAv/t+i48gi3pTUZCDk5qybPkianTHR5WnvM5TPNGFNPVoYA
         or+0YSvzaUP6leztZYcISpeJ06yUM4ZAIR0u/hXsdycJ8rSQ8EDFRynLzoHZjxhhUz88
         /rCw==
X-Gm-Message-State: AHQUAuZaT1DouVu6NsklRtAxqG8M24/Z+Yf7PU6D6kG0Cudv3X9W6gJW
        PwHPHufO6VyS+9MTwRFXYe4QIg==
X-Google-Smtp-Source: AHgI3IbLsO6VEuV/Z+JIsyBOU+wJEJMgVHjY6xzsf3vyOhlYoTJwa8+CCw0djgURk4585epwQbVivA==
X-Received: by 2002:ac8:1413:: with SMTP id k19mr785431qtj.134.1550155777063;
        Thu, 14 Feb 2019 06:49:37 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:36 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 03/16] ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
Date:   Thu, 14 Feb 2019 09:49:17 -0500
Message-Id: <20190214144930.27539-4-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 319508902600c2688e057750148487996396e9ca upstream.

Copy events to user using __copy_to_user() rather than copy members of
individually with __put_user_error().
This has the benefit of disabling/enabling PAN once per event intead of
once per event member.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/sys_oabi-compat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 640748e27035..d844c5c9364b 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -276,6 +276,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
+	struct oabi_epoll_event e;
 	mm_segment_t fs;
 	long ret, err, i;
 
@@ -294,8 +295,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	set_fs(fs);
 	err = 0;
 	for (i = 0; i < ret; i++) {
-		__put_user_error(kbuf[i].events, &events->events, err);
-		__put_user_error(kbuf[i].data,   &events->data,   err);
+		e.events = kbuf[i].events;
+		e.data = kbuf[i].data;
+		err = __copy_to_user(events, &e, sizeof(e));
+		if (err)
+			break;
 		events++;
 	}
 	kfree(kbuf);
-- 
2.17.1

