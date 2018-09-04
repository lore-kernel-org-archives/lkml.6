Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50420843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnO4l0Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B50420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIDHIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36056 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeIDHIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so895820plb.3;
        Mon, 03 Sep 2018 19:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qchqH0U+NKnSgzy5OmR5JDqm4OjRzNr3FPKLhiuVQoE=;
        b=bnO4l0FlSd3A2icpo/kTlsTkWn/ZlEY4nhsjN5kMBX2M35z1GeH3Fp8gMMCrc7CRGH
         s1H7IryVse3PMjNmL1Iag8RPmsg4h3/E3gN+ORMU6kg4aZ1zfhvSmKSUSkx+dCv0IXRS
         d9pksj15ontYb+Ah92cmixiRXepDQc7ZqXTkeT8Ti1iNM7nYPkyBWHR9HvDrlslI+If4
         kqWTy+Zksdap9rZmRhg/Ti0hIBXf+V/cTZhk6dZDQnUbKt7XwDUzyknQIdMgcrnxvoMP
         2OrcwxGD9OtsfeQtduZVeYQXCwlFhxm42afiy2TvOriuKLYx3YYzmlBk6rAPS4QGXKkA
         mx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qchqH0U+NKnSgzy5OmR5JDqm4OjRzNr3FPKLhiuVQoE=;
        b=oM+HYXez5oz8mYt3QEUKKHJFGDWrPD8HdsmXXz3cBr9yTdpCvy175iE/WBhGR9w4JU
         w5UqRZ9WV3e1Mh8M4qW3DcPvxDJMzZZMNSgqsTEtt5JrH0vcU/aYxce9QgRg/3Wf6xVq
         gGVtSVOgx7CfL5ZyeAe8N5Zfy30LuITmFyoWXBZEM8mAY0pN9VG5pa3x4xqlYFGzWXe3
         WhySd7Ix/j0bLpWD6ktc1XAOHs3RAGcNnr6/llGW6gnCXdT/DeNONAOg0Yb0juBTAV1N
         TGWVVjCclnv+165phI+LtMW64ZNjm+9ktfX0calWS1siA6QpuocUt6mnQKA9uMz8j015
         M89Q==
X-Gm-Message-State: APzg51BwwnWyZse4Gb3BDIyBY7qymWjIzsRrHT5mk+QrNx7F767ybn0y
        3VGixHpJ4bbcnW4BOZ80xzw=
X-Google-Smtp-Source: ANB0Vdayc89WAx5QvMYalBWiFf+hwaCiCP1x/b4rIi5gy3mles9JXL3EltbI3lYc1LsQREQWAmowtA==
X-Received: by 2002:a17:902:5a02:: with SMTP id q2-v6mr31533319pli.253.1536029145329;
        Mon, 03 Sep 2018 19:45:45 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:44 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 10/25] tty: synclink: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:36 +0900
Message-Id: <1536029091-4426-11-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/synclink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index fbdf4d0..6e7e4d6 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3355,8 +3355,9 @@ static int mgsl_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_open"))
 		return -ENODEV;
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /* mgsl_open()
-- 
2.7.4

