Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D83C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217005;
	bh=4TyjfNWntF+se9gl1A7pi9J5lESY4cw9P14lSlVBsHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bCsGygmDVuPK31lTf1gncHuebYa0Ni58Yw64KM/sDfKdjTdyuenPyhIFzUS/R49DW
	 1ecW2+BloQWxNDUFMRX/DZrfpcRA/f0xIIa3xfjcw9etqFLRJDbLpYd4rZdLeShYS5
	 Uk2PXNTOcvAox6IoPuAY0pJvMBl0arpxCwy2yAk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfAKOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733058AbfAKOaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31FE2133F;
        Fri, 11 Jan 2019 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217001;
        bh=4TyjfNWntF+se9gl1A7pi9J5lESY4cw9P14lSlVBsHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcwR8vmzISAR+/mmpUIZGj2XrBufQabcbQZ4rO/JLG5dKahgLtMC87l9LJcHippL8
         DwhiFN81lJZKkYclGhRllwoYUKCSj9MxREU+WFOutix5sEDtnuthrmmu85+3Dnsh0t
         rWaPAYXGafMWloGX1weTcOsL27zm3akn6JAC0rK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.9 62/63] power: supply: olpc_battery: correct the temperature units
Date:   Fri, 11 Jan 2019 15:15:05 +0100
Message-Id: <20190111131056.301929791@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit ed54ffbe554f0902689fd6d1712bbacbacd11376 upstream.

According to [1] and [2], the temperature values are in tenths of degree
Celsius. Exposing the Celsius value makes the battery appear on fire:

  $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
  ...
      temperature:         236.9 degrees C

Tested on OLPC XO-1 and OLPC XO-1.75 laptops.

[1] include/linux/power_supply.h
[2] Documentation/power/power_supply_class.txt

Fixes: fb972873a767 ("[BATTERY] One Laptop Per Child power/battery driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/olpc_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -427,14 +427,14 @@ static int olpc_bat_get_property(struct
 		if (ret)
 			return ret;
 
-		val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
 		if (ret)
 			return ret;
 
-		val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
+		val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);


