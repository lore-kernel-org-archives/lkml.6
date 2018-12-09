Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA51C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDA32081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDA32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeLIWSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:18:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36752 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbeLIWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:02 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73R-0002po-6t; Sun, 09 Dec 2018 21:56:01 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003Eu-6r; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andrzej Hajda" <a.hajda@samsung.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Thierry Reding" <treding@nvidia.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.428540732@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 035/328] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit cd0e0ca69109d025b1a1b6609f70682db62138b0 upstream.

The ARRAY_SIZE() macro is type size_t.  If s6e8aa0_dcs_read() returns a
negative error code, then "ret < ARRAY_SIZE(id)" is false because the
negative error code is type promoted to a high positive value.

Fixes: 02051ca06371 ("drm/panel: add S6E8AA0 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180704093807.s3lqsb2v6dg2k43d@kili.mountain
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/panel/panel-s6e8aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/panel/panel-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-s6e8aa0.c
@@ -832,7 +832,7 @@ static void s6e8aa0_read_mtp_id(struct s
 	int ret, i;
 
 	ret = s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
-	if (ret < ARRAY_SIZE(id) || id[0] == 0x00) {
+	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] == 0x00) {
 		dev_err(ctx->dev, "read id failed\n");
 		ctx->error = -EIO;
 		return;

