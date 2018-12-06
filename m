Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4637AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B14C214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107279;
	bh=HCA7q1lghHrOjbwJuuq8xQfBng2Uqfz8a1v8cl33l1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yv0YvErkbtgRxYAdoifu2W8phT4qYgOz8uTH79KPj+xf/qyfXYJoHme9ZohuDrIMx
	 /yziLdZj2+hIJU35CbL/A/E66SWg2Tapy0MF++qCr0R6tk7c2KiZjXsx3OAJHszDpT
	 joAdsKkt+V3Pw6GaiCayOubEDQG3xtHjirQb1YEQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeLFOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730183AbeLFOlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB0E21479;
        Thu,  6 Dec 2018 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107275;
        bh=HCA7q1lghHrOjbwJuuq8xQfBng2Uqfz8a1v8cl33l1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oztmi4P35kyNwQXes9UO2ES0kSTfupvqT9USUg+r3TX+jvdzgOP/NTvJcbgrS9qAK
         h2QML8rzKjstdTd36Qy1jUM5W7dLVqKU8I74AjbO8e+2t6VhJBAbM5HRpjNS9K1wn6
         y10V3IH+RWAwTQ0ek/gTfaHl9b+csi5czhO/5sso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 34/41] Input: cros_ec_keyb - fix button/switch capability reports
Date:   Thu,  6 Dec 2018 15:39:14 +0100
Message-Id: <20181206142952.958197252@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

commit ac5722c1643a2fb75224c79b578214956d34f989 upstream.

The cros_ec_keyb_bs array lists buttons and switches together, expecting
that its users will match the appropriate type and bit fields. But
cros_ec_keyb_register_bs() only checks the 'bit' field, which causes
misreported input capabilities in some cases. For example, tablets
(e.g., Scarlet -- a.k.a. Acer Chromebook Tab 10) were reporting a SW_LID
capability, because EC_MKBP_POWER_BUTTON and EC_MKBP_LID_OPEN happen to
share the same bit.

(This has comedic effect on a tablet, in which a power-management daemon
then thinks this "lid" is closed, and so puts the system to sleep as
soon as it boots!)

To fix this, check both the 'ev_type' and 'bit' fields before reporting
the capability.

Tested with a lid (Kevin / Samsung Chromebook Plus) and without a lid
(Scarlet / Acer Chromebook Tab 10).

This error got introduced when porting the feature from the downstream
Chromium OS kernel to be upstreamed.

Fixes: cdd7950e7aa4 ("input: cros_ec_keyb: Add non-matrix buttons and switches")
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/keyboard/cros_ec_keyb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -493,7 +493,8 @@ static int cros_ec_keyb_register_bs(stru
 	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
 		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
 
-		if (buttons & BIT(map->bit))
+		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
+		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
 			input_set_capability(idev, map->ev_type, map->code);
 	}
 


