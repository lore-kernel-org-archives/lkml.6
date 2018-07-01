Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3AC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC000258D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="K7/8Mb9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC000258D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeGAU5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:48 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50795 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeGAU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JvY670TaqG99rPFbg39/HbJT5BxfTEv95uoo2/DzBdY=; b=K7/8Mb9+yBbvvW6icCXtOxr55O
        iFkbchLQpLEGd8MgSqc0fjsJwT/zp4cW0DdEKOiKOYBK/ZJ+1H3L+Tr3Gd6ZzD+5OmYQbaEgssgk+
        an2zJShUY1N38SAjnxED5hna0cyfohcJmse7HgpMXWgajxKKkyQizO6Fad5+ouBlPLBGSv/E/UZeS
        4Gcaq/rTt0ojSIDjhjWc55P62lX3r0jCBpspb8YQp5GBeD1g3NoOlQL58XP4O9wkBiQYgptMdafxL
        muPIzc2AYZqiYA5sj+7Baeq8gVvmvIt+8OGSpe8bo0benRgcTwyx2zX9LB+MlHCA7+m17RCBuFKxx
        uhPbhZQg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48700 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjPh-007eVB-DM; Sun, 01 Jul 2018 20:57:41 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] TTY: isdn: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:57:38 -0700
Message-Id: <1530478658-23070-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 complains:

drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_suspend.isra.1':
drivers/isdn/i4l/isdn_tty.c:790:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
drivers/isdn/i4l/isdn_tty.c:778:6: note: length computed here

drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_resume':
drivers/isdn/i4l/isdn_tty.c:880:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
drivers/isdn/i4l/isdn_tty.c:817:6: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/isdn/i4l/isdn_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 960f26348bb5..b730037a0e2d 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -787,7 +787,7 @@ isdn_tty_suspend(char *id, modem_info *info, atemu *m)
 		cmd.parm.cmsg.para[3] = 4; /* 16 bit 0x0004 Suspend */
 		cmd.parm.cmsg.para[4] = 0;
 		cmd.parm.cmsg.para[5] = l;
-		strncpy(&cmd.parm.cmsg.para[6], id, l);
+		memcpy(&cmd.parm.cmsg.para[6], id, l);
 		cmd.command = CAPI_PUT_MESSAGE;
 		cmd.driver = info->isdn_driver;
 		cmd.arg = info->isdn_channel;
@@ -877,7 +877,7 @@ isdn_tty_resume(char *id, modem_info *info, atemu *m)
 		cmd.parm.cmsg.para[3] = 5; /* 16 bit 0x0005 Resume */
 		cmd.parm.cmsg.para[4] = 0;
 		cmd.parm.cmsg.para[5] = l;
-		strncpy(&cmd.parm.cmsg.para[6], id, l);
+		memcpy(&cmd.parm.cmsg.para[6], id, l);
 		cmd.command = CAPI_PUT_MESSAGE;
 		info->dialing = 1;
 //		strcpy(dev->num[i], n);
-- 
2.7.4

