Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEDCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEAA2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548841951;
	bh=YG5vSnFpvtDYAqPCnvnLS1edmadZtQEUs93rWnIybws=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KeUvJjfjHCrEubQv0Pb50aUqKPodn9Ra2wKQ40gWRscK7dphFYJkZyiZ/1lVOfyee
	 fKKthqobUkwtq/0FDY3gmWaiIsdjgEyGh0kRB9/PAAfkxwVLKsW7SO4CL/sYxLyXnt
	 zhvmCS3kRzyLHwhWj4uHyX9EVbAY//WYkFB/hlrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfA3Jw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:52:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38832 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:52:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so20145542lja.5;
        Wed, 30 Jan 2019 01:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZlUBg1jy2VyYTodkHwOP1WwC9Ojd6SlKGeKyOSQsMcY=;
        b=L1jxJOU7XpexukLD6oDkLcEujdqlpOzxDBw08K77rrh85IxS8lZSVnEFQiE0vG6xSg
         LxC546hWLP7p3iNCta4RAfko9sypf2bVjjDgcDZHLO4Ky8r9nFXje6nO3LI5/rpAqr0d
         ywqJ6IF24TMja4rKvnxZbDlcxrlmI9Q9DQ4a8W5e2k6ilV2LjHND+KSDUmPfF58sxqfg
         IoO6Z1/F5UxhgGhPvNXk9kgvhUjRhIUoQ0r7ke/x0T2hlBVT/ad/TcKDQtbw81ydb92B
         eyk9hWSu7COW5Y5QbnzVzFNpgSgTpYvjoMEQGTkdzouRNQjVKaRgUbEA/hCJEdSOdLYt
         FPOQ==
X-Gm-Message-State: AJcUukcuuc8TSThE2PR9vgAg3+G20L9jtknHdBcVLBb4A49ZnjUOFnAd
        pTkIKka2bnIEleGw0zE6p0U=
X-Google-Smtp-Source: ALg8bN6551WSkm4CfPJypsJbwYV+26W1NNBWNeAWAdw6quCU8+Tql/V941v51SOpHZjHEguajKE5Ag==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr24336632ljc.172.1548841947033;
        Wed, 30 Jan 2019 01:52:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g85-v6sm196704lji.17.2019.01.30.01.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:52:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gomXe-00019k-1W; Wed, 30 Jan 2019 10:52:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] serdev: ttyport: call tiocmget and tiocmset ops directly
Date:   Wed, 30 Jan 2019 10:52:03 +0100
Message-Id: <20190130095203.4402-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tty struct holds a pointer to the driver's tty operations so drop
the unnecessary driver dereference when calling tiocmget and tiocmset.

Note that this also makes the calls match the preceding sanity checks as
expected.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..d1cdd2ab8b4c 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -233,7 +233,7 @@ static int ttyport_get_tiocm(struct serdev_controller *ctrl)
 	if (!tty->ops->tiocmget)
 		return -ENOTSUPP;
 
-	return tty->driver->ops->tiocmget(tty);
+	return tty->ops->tiocmget(tty);
 }
 
 static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, unsigned int clear)
@@ -244,7 +244,7 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
 	if (!tty->ops->tiocmset)
 		return -ENOTSUPP;
 
-	return tty->driver->ops->tiocmset(tty, set, clear);
+	return tty->ops->tiocmset(tty, set, clear);
 }
 
 static const struct serdev_controller_ops ctrl_ops = {
-- 
2.20.1

