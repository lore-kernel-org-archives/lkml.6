Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E5ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1658E21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtK0r23K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1658E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJTEdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:33:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeJTEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:33:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id v22-v6so14364403lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cCUIugiLMER/xH04Wj+/MbJ4pAGG/uz7i8oFI3ij0Ng=;
        b=FtK0r23Kh0jE/3fhL8VZuaaxhigqSsxswmbZnWotWhn+GLFFl9YJF6oQKKKvX4L8P/
         ik9hRIk+Ftx4ZOxfvwv3BgSTed8tTScqSfoZWzcCs6Iy76tzE1nI+EIQpob+9o7ttsEx
         tXgMN5IYm06bjfbHCPKYOiN2INRMBfQx3tdgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cCUIugiLMER/xH04Wj+/MbJ4pAGG/uz7i8oFI3ij0Ng=;
        b=fxEK650Ir6nEDqgKHiSJMIa7zFwysDiMEzJFn6K7h0b0G8+ST3SGqv5apl8Ve7FK9k
         pCjzQd7sYDKA1moImGdvaE0eG6TTmHpFcgL6ZAd+PEuFweR83r2JpzhCMGU4B3dhR67e
         QzlBX9jPTWlv/DJVT/8pVBgjbOEXJKimBNLi5SDESjFb9dtQv8hJHE3ScRIHTXHXnM1Y
         WmTE0OrCpJZvfaWLnxMFy9JaKSoOk/HsVZBEepMnfmemt8FufZZI8PU6aX4WsvqBqMrf
         dE9pMHqHJ+0U2ulnKTbhYKydJwYLHGS+oJrISR+GNxwFc1s/xYsi12ZcaulTc2Le8yfp
         i9bQ==
X-Gm-Message-State: ABuFfoiMS49jXrMHk0Rowr9lN9cTVkRKG8gpwJOQBOiW1+/Zg+/65LxK
        dAt6zoxik26AMBcwSasE/wCsmQ==
X-Google-Smtp-Source: ACcGV61CT+jy+Skd5SbcQPHLucNtfZIvUPOsdEeZOQZtEFTWFLtQGdhBqSrhsxNNo+QyY0KBzFkbNg==
X-Received: by 2002:a19:c4c5:: with SMTP id u188-v6mr511450lff.141.1539980745287;
        Fri, 19 Oct 2018 13:25:45 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p63-v6sm5425995lfg.46.2018.10.19.13.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:25:44 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries while switch promisc mode
Date:   Fri, 19 Oct 2018 23:25:41 +0300
Message-Id: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After flushing all mcast entries from the table, the ones contained in
mc list of ndev are not restored when promisc mode is toggled off,
because they are considered as synched with ALE, thus, in order to
restore them after promisc mode - reset syncing info. This fix
touches only switch mode devices, including single port boards
like Beagle Bone.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-nex/master
and is logical continuation of the
https://lore.kernel.org/patchwork/patch/1001633/

 drivers/net/ethernet/ti/cpsw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 226be2a56c1f..f7753b240ced 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -640,6 +640,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 
 			/* Clear all mcast from ALE */
 			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
+			__dev_mc_unsync(ndev, NULL);
 
 			/* Flood All Unicast Packets to Host port */
 			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
-- 
2.17.1

