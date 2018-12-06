Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A820850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108243;
	bh=zOT8TJ0004G71497yRmGTanAeEP4uGlKgcAmn3SChto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EOSZMza+1HxLrvozi6yN6c42XXOxdcXPiLGC28l0kEFwPtlQnfTLIcvFfwi2va2pg
	 k/WZF5gpbJF9ud3u1XRUWsttLIBij9jxC/WrIvKhUw4AzZVzj3vndSBv4qulXUnPWX
	 f9UbrlZqUleWWzgRcjxkPlS4ag/flOccbI1QPEXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8A820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeLFO5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbeLFOmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D912146D;
        Thu,  6 Dec 2018 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107368;
        bh=zOT8TJ0004G71497yRmGTanAeEP4uGlKgcAmn3SChto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2e5VPj2q7IYks3TTZ9CdcAQ9k22fliaAxmNyYv3+IXBFdNSFa7miLDLG4xKIRrPAc
         CZdN6r1eVxlR/bmtO5fvUWjmavvXGZKCRQJ58DhM7bdYy9KDhAqpxJ+Bjeh5ywBOWj
         /i3TezGvM0A77o3CO+WR/cXr7TCFuDKLIrpJ4tjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 36/55] Input: cros_ec_keyb - fix button/switch capability reports
Date:   Thu,  6 Dec 2018 15:39:10 +0100
Message-Id: <20181206143003.649092938@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -506,7 +506,8 @@ static int cros_ec_keyb_register_bs(stru
 	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
 		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
 
-		if (buttons & BIT(map->bit))
+		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
+		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
 			input_set_capability(idev, map->ev_type, map->code);
 	}
 


