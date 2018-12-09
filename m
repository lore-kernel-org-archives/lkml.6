Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE93C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077AC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077AC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeLIWT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:19:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35580 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002ic-G7; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72m-0003hw-1y; Sun, 09 Dec 2018 21:55:20 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Young_X" <YangX92@hotmail.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.493253419@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 328/328] cdrom: fix improper type cast, which can
 leat to information leak.
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Young_X <YangX92@hotmail.com>

commit e4f3aa2e1e67bb48dfbaaf1cad59013d5a5bc276 upstream.

There is another cast from unsigned long to int which causes
a bounds check to fail with specially crafted input. The value is
then used as an index in the slot array in cdrom_slot_status().

This issue is similar to CVE-2018-16658 and CVE-2018-10940.

Signed-off-by: Young_X <YangX92@hotmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2427,7 +2427,7 @@ static int cdrom_ioctl_select_disc(struc
 		return -ENOSYS;
 
 	if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
-		if ((int)arg >= cdi->capacity)
+		if (arg >= cdi->capacity)
 			return -EINVAL;
 	}
 

