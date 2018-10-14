Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494A5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167A120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167A120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJNXsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:48:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35577 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cY-Gs; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-000099-Az; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jason Andryuk" <jandryuk@gmail.com>,
        "Jiri Kosina" <jkosina@suse.cz>, "John Smith" <john-s-84@gmx.net>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.320369129@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 010/366] HID: i2c-hid: Fix "incomplete report" noise
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Andryuk <jandryuk@gmail.com>

commit ef6eaf27274c0351f7059163918f3795da13199c upstream.

Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage") started
writing messages when the ret_size is <= 2 from i2c_master_recv.  However, my
device i2c-DLL07D1 returns 2 for a short period of time (~0.5s) after I stop
moving the pointing stick or touchpad.  It varies, but you get ~50 messages
each time which spams the log hard.

[  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)

This has also been observed with a i2c-ALP0017.

[ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)

Only print the message when ret_size is totally invalid and less than 2 to cut
down on the log spam.

Fixes: ac75a041048b ("HID: i2c-hid: fix size check and type usage")
Reported-by: John Smith <john-s-84@gmx.net>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -399,7 +399,7 @@ static void i2c_hid_get_input(struct i2c
 		return;
 	}
 
-	if ((ret_size > size) || (ret_size <= 2)) {
+	if ((ret_size > size) || (ret_size < 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;

