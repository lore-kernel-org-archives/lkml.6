Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B653C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7C4222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgLNxFkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393954AbfBNCKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38362 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393896AbfBNCKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id 2so5198859qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ao2zNPPAVKm6DVngcSIODmeIuZt8Da7c4FKcqwlcUWs=;
        b=UgLNxFkXN5F63atBRrO/+dam22AD9xcXt581af1qQdlsAytsMpzMy2XlygaxbDcy9/
         IdR0Gl78bheX/LuIAHEvlKI4oUOuU+pKQ5vBGreBFVzSfcJK+pexDAHvgXYuJW6qEPBl
         MIfREGA1UDearL0vzEYwwS5sS6+qjjF/6wb3Gcbym8V1KeqLvP4ipKSLe9McwMp3CSNH
         UpqVvpyjWo1zfaHelNPDMWd0FCLwZQe6PSRRiNJ9ddj4VafKY8itk0YlzY/dUVil6rO6
         VMMOZPJ9urwPQ3QFJCgCy+asEJADrs9qRwaTlQN7U0ZCrG5bwTg2m/ixn299DpCyB0bU
         wGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ao2zNPPAVKm6DVngcSIODmeIuZt8Da7c4FKcqwlcUWs=;
        b=TWJsWS64Fnfhd5loSgc8nz+DlJ0G4BoLl6vfQfaVHQoih5jn8qK6j6hbQ+qJ/tpAS6
         cZl3RD1fijdRcRy/GZteM+X3iX+04wGazuWpK51UbxHW5MQS98d4yspJiyPy9chzrtIW
         /qpPaiHlZYruoOXtDZsWRpr4k2PPncqS3N/H/6OHmMbu5U1A47kFkMjp635V8y2jfsVE
         +z4TLHbhexcLUFydF1DD71u/2wR+zzKQy7jORsNKV7T9Hb2NKsqC0Zl7wGBIlHon9r4e
         taqW2+xLO9t5FaPanS3HVHA2U0y91XztDWT4jQe8eXlDMViQaPKYVdRA9AY+8fad1rLT
         0iMg==
X-Gm-Message-State: AHQUAuZ8dW2BrPPLiucxTf3+7/mnSOq1nyeBfTiwCc4eL93dhSmCtzya
        wHiwE32VffsNVyLyJT/KE+yznA==
X-Google-Smtp-Source: AHgI3Ib063IR4oXphlNEnw5EUM6dccVs/KVPVRN+fklLvH0axGg1PfPynsFO4dxwzyS+e/OVR7NFCw==
X-Received: by 2002:ac8:2c51:: with SMTP id e17mr1032432qta.254.1550110230310;
        Wed, 13 Feb 2019 18:10:30 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:29 -0800 (PST)
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
Subject: [PATCH 4.14 V2 04/17] ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
Date:   Wed, 13 Feb 2019 21:10:09 -0500
Message-Id: <20190214021022.5313-5-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index 4abe4909417f..a87684532327 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -277,6 +277,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
+	struct oabi_epoll_event e;
 	mm_segment_t fs;
 	long ret, err, i;
 
@@ -295,8 +296,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
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

