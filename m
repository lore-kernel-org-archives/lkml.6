Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449242086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsA9keTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449242086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIDHIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46857 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeIDHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so891213pfn.13;
        Mon, 03 Sep 2018 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBHYUYXanNFuc3sJAGyPoTQKmVfJwobdSV5M3vVBguw=;
        b=KsA9keTen4eBHIGRYysr/wKT6/LJFm9JqHY9ek6MGQzsHg0AGki2RmYG7mpAnnmqk9
         XtL/JoDJHeIdS0L68xXxLOQvjjmAUff7norRMYp13oHhmQSvZMa0RzSNUy7oGt4w7Oqe
         eKE7Bx1OXTvm8NERoDDZ2ws5e95ecu9kizSTm5t19pj48+cD7hKBS/FTTRWdTGCbbqHQ
         6p2QyPAO+MJmFAzQd7ovr+LZ9QM1fkma9y134UacD/JHly7d085juVVGcyJ2f6/cJiY1
         9ozc0uEX4kSQixpnxh+R194lLrXPtRqJNZFYnIqW1yMYcfULQsSw+ZCvOviNN+N+ejK8
         lPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBHYUYXanNFuc3sJAGyPoTQKmVfJwobdSV5M3vVBguw=;
        b=F/uEuhmjHfIZutiO/2XqwrjhbtwIGjYGTINDm8IpC25q4+wHY5xEc3BVGFTcbUFDyw
         u6gHGwZGZUY042HII0Ks9/dIv0n9uNP4Un8EWmgSV2CE2qaAEYAHs23GmKeIBRmwRSHO
         32eF7uD8BTmnTGlfRK3lCFX/uifpIupuqI/O4VLp0EN+Bq5CItmMVsDqJbrjcdovDbLm
         qPsEV84x61UhEXvGAGRGEsPs/SwFqzi/jbF2b1hosZLqhD2Mt8wpysaAK8hDYJPYk/5a
         QB2l9oNQhmzTGsxg32yE8I8tNpYhUGD8PCysq0zNAPwrpLpzxj8cQiltN9/7h8UnqvM5
         BInw==
X-Gm-Message-State: APzg51B7bEIRuhN/t3DatrYgZaF95Cml0pR+hjx7kJlfDEcTt0A9a5bV
        SJKU2/jaffM3wD3w8JkDJUa8DvdF
X-Google-Smtp-Source: ANB0VdYzCBWMVILtFi+R/GhzoXAy2DyPqeF+LZTCXH2uzP/uxpeLVWyVk2MZU2LfTeQYPdksyl0FSQ==
X-Received: by 2002:a62:219b:: with SMTP id o27-v6mr32386618pfj.235.1536029154665;
        Mon, 03 Sep 2018 19:45:54 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:54 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 12/25] tty: vt: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:38 +0900
Message-Id: <1536029091-4426-13-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/vt/vt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5f1183b..cc72254 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3222,10 +3222,7 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 		goto unlock;
 	}
 
-	ret = tty_port_install(&vc->port, driver, tty);
-	if (ret)
-		goto unlock;
-
+	tty_port_install(&vc->port, driver, tty);
 	tty->driver_data = vc;
 	vc->port.tty = tty;
 
-- 
2.7.4

