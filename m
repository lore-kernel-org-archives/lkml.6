Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66516C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A982083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=researchut.com header.i=@researchut.com header.b="ghkMARCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A982083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeITMI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:08:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeITMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:08:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3860683pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 23:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=researchut.com; s=google;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Qvrj5Nvqkk17gxwCpEhkXKoktSQKr/QzeTM8FxCe/9k=;
        b=ghkMARClcwhcbJNvqwH1mX2KhflJ0Zvw3qO0eIqYA5G7v5X8bnEOosP83VSVxIA1Jz
         lfSOr7df4KRQ+vgFLGc1W6lHe7bxhgs+ijDIt6tidt8VKfR4FO19L79ymQvfsBy5LKAU
         DDCfOTgfnWMQoQnHWWaAWQwS8vQ/PwlE8xdQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Qvrj5Nvqkk17gxwCpEhkXKoktSQKr/QzeTM8FxCe/9k=;
        b=kmOGpmXFN+rQRFvXSiE9n7VkrchopHDcLcFukDRvVKjBX2WUQIAwRsM6xu8bDm0nV1
         7ERprZ7ubFCzIEL8oi/bCLbKkFSSzImX3U1gSg43JKSCDi3fHms7mIW2no7G/GMdWNNH
         Siv4is8sUAGhUsBpJAYTFl4+zu/w0FJsw/Pnm/JeCoW+A/8chYTt8MuPISxWTSttZRTI
         Bb6EKcLbKMAtjFRisHg1V+zKw6KIHAlou39ouBsX8Bhz9No/XLZa3rbheIKqH6VnTAoj
         +7G8bymgNj2/puMz6BLvrbiII5arS2Mgjy4avTLqR7q+sXrjTnu5CsH5LJ5PRjX6S5Ek
         zbpg==
X-Gm-Message-State: APzg51B8cJnmNu22kkyiKr3BOvZniyrdh9UFHbHwYjGPklR2z1mEs96f
        LrI5Pfn7vAbLuyRCIBvIwlM3PQ==
X-Google-Smtp-Source: ANB0VdahixOIr40wvUcg3RR5pd8R8XJA8yFR1pgjnvk9Ttn2Duzr3QV/VFE6Q2EoQZfJJQXeDP5kTA==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr34053331pgo.378.1537424825451;
        Wed, 19 Sep 2018 23:27:05 -0700 (PDT)
Received: from priyasi ([2405:204:538d:e0a:e40c:323:48ae:893])
        by smtp.gmail.com with ESMTPSA id k8-v6sm62185979pga.80.2018.09.19.23.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 23:27:04 -0700 (PDT)
Received: from localhost ([::1] helo=priyasi.researchut.com)
        by priyasi with esmtp (Exim 4.91)
        (envelope-from <rrs@debian.org>)
        id 1g2sQX-00061n-Em; Thu, 20 Sep 2018 11:57:01 +0530
From:   Ritesh Raj Sarraf <rrs@debian.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ritesh Raj Sarraf <rrs@debian.org>,
        Ritesh Raj Sarraf <rrs@researchut.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Don't hardcode path as it is architecture dependent
Date:   Thu, 20 Sep 2018 11:56:38 +0530
Message-Id: <20180920062640.23038-1-rrs@debian.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code fails to run on amd64 because of hardcoded reference to
i386

Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>
---
 arch/um/drivers/port_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 9a8e1b64c22e..5f56d11b886f 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -168,7 +168,7 @@ int port_connection(int fd, int *socket, int *pid_out)
 {
 	int new, err;
 	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
-			 "/usr/lib/uml/port-helper", NULL };
+			 OS_LIB_PATH "/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
 	new = accept(fd, NULL, 0);
-- 
2.18.0

