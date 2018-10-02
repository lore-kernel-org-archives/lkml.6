Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83330C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5369A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5369A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeJBUdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:33:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbeJBURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:23 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F34BC3F;
        Tue,  2 Oct 2018 13:34:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 093/137] regulator: fix crash caused by null driver data
Date:   Tue,  2 Oct 2018 06:24:54 -0700
Message-Id: <20181002132505.018436705@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

commit fb6de923ca3358a91525552b4907d4cb38730bdd upstream.

dev_set_drvdata() needs to be called before device_register()
exposes device to userspace. Otherwise kernel crashes after it
gets null pointer from dev_get_drvdata() when userspace tries
to access sysfs entries.

[Removed backtrace for length -- broonie]

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4115,13 +4115,13 @@ regulator_register(const struct regulato
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
+	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
 		put_device(&rdev->dev);
 		goto unset_supplies;
 	}
 
-	dev_set_drvdata(&rdev->dev, rdev);
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators supply since a new one was registered */


