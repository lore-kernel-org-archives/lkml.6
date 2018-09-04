Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6765D2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlTOXR/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6765D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIDHI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33214 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so923965pfn.0;
        Mon, 03 Sep 2018 19:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d4uMapg7a40FZXgMObYbX05m8ShQ3XMWRXAdF2pRRos=;
        b=mlTOXR/F7P7ZYpJ8D5PgWw4Ka1zwBvryxWCinCn6sxgLAIkfesdqWDo+cYzqycpsBi
         a+X11KpVCq5BahL9+w9dhLIOXr9gKGs17WwbcCdjDxhEYR2S0yCpAq6jSFnENmvrxNEw
         l5BVnllMMsS0KQpS2OXNmJXrzgYGjclZqEZq4gaA/z3HraWoU2hpFsVSqoFBo4wJ0PqN
         3KHsZ8sOgXjSAoaL2rEe1iVlIaP5J8QdbJBQLMTyebGyb4eLeyIRTaVMLwCVk8XxKERo
         bahqBiiYOODVAWzNKCqfnKD6OAc6hB38q6qVLBFedb6hBv4+u0Hl2rGYaP2Gvd7jWqBm
         UrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d4uMapg7a40FZXgMObYbX05m8ShQ3XMWRXAdF2pRRos=;
        b=ucAh4zO8s1ctDto9roL/GlkEeSl9gy/9bXB3dkfkmhIKQS+CXgv4hJO8PXGlabNapf
         4xze5E7BA1jPxtXoc/UelAvpX+ohuvrPVhlj0pblikRTdhgvPp1L2pKp4uB1L4Xmpdg1
         FVHmYpUgJuH4S3cV+VbdYJMO4ael503lgpoSfYTwcV1ZRryDzqH+qcWxIQ9YyaxjqUvz
         v8piPdAg56rLIj+pFsLprbDo4oBTrOooMb+cYtvNJXBzC02mwipv3A/SOSxNSt2CijjD
         J1spFPqfHYbmBZL7qhaIfK5jdwoh3P9AzcwGINTRVJM5ExElMVVPJW/J/+DctcK8RA8j
         NMXw==
X-Gm-Message-State: APzg51DVqapjCrRTvsAJ5ejREOSS2eIiUS857bocnWZozkwIidnIxHVY
        CvEU6diZ+AEE9AeYOYhKx7I=
X-Google-Smtp-Source: ANB0VdYCjVJ7rPwK9bG8dXzZHAlvxl563unPs9NV910s0sktizLeMEaQiAlOvxWJ4/oEOQhEk/2E4A==
X-Received: by 2002:a63:f26:: with SMTP id e38-v6mr28423403pgl.354.1536029131838;
        Mon, 03 Sep 2018 19:45:31 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:31 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 07/25] tty: mips_ejtag_fdc: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:33 +0900
Message-Id: <1536029091-4426-8-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/mips_ejtag_fdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 4c1cd49..33e06b4 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -763,7 +763,9 @@ static int mips_ejtag_fdc_tty_install(struct tty_driver *driver,
 	struct mips_ejtag_fdc_tty *priv = driver->driver_state;
 
 	tty->driver_data = &priv->ports[tty->index];
-	return tty_port_install(&priv->ports[tty->index].port, driver, tty);
+	tty_port_install(&priv->ports[tty->index].port, driver, tty);
+
+	return 0;
 }
 
 static int mips_ejtag_fdc_tty_open(struct tty_struct *tty, struct file *filp)
-- 
2.7.4

