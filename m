Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60512C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2D420874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rIhu6Xwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2D420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFUAF6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:05:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeFUAF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OivHKFXCx70TsH566UELf91Znq0D4VmF2tUjmpKJy7U=; b=rIhu6XwcUUpB1iUip4lDNwPTL
        cNWCDZ5VGV1tposkQoBPujFRAZWJlwxIzhcrWwoQ4u6DyYPZ3bpf0GmA4s7AdHZisJPwS6AtMwTWM
        oksGg4b5vt1uv40aPc3PcBECWzj1gdxaeWb3ccySngnsY7M2G89xVHNlanTcoDxneN+b4QDggakM0
        8gQ4n/FWo1sxkP5YPkNbdBlQ4LDRmrCzKRJ8xsZ+Kzl9mKVAO1QnS+jnqxeYl2ODiCwGhZUrw7/yA
        ZktQFd2gWmLSykMb4401CIKnjUxDHjY6giNjdR/Vk/Pd9OwOa+weWm/FxADoCS/dP27BCaaI3aX25
        /NKEh8Mww==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVn6g-0002Up-Ej; Thu, 21 Jun 2018 00:05:46 +0000
To:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, kbuild-all@01.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] staging/typec: fix tcpci_rt1711h build errors
Message-ID: <f344e5f3-4e92-1fd0-ef4d-7b96065466b8@infradead.org>
Date:   Wed, 20 Jun 2018 17:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Kconfig warning and build errors in staging/typec/rt1711h.c.
The driver uses I2C interfaces so it should depend on I2C.

WARNING: unmet direct dependencies detected for TYPEC_TCPCI
  Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
  Selected by [y]:
  - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]

and then:
drivers/staging/typec/tcpci.o: In function `tcpci_probe':
../drivers/staging/typec/tcpci.c:536: undefined reference to `__devm_regmap_init_i2c'
drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_init':
../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_register_driver'
drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_exit':
../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_del_driver'
drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_check_revision':
../drivers/staging/typec/tcpci_rt1711h.c:218: undefined reference to `i2c_smbus_read_word_data'
../drivers/staging/typec/tcpci_rt1711h.c:225: undefined reference to `i2c_smbus_read_word_data'
drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_probe':
../drivers/staging/typec/tcpci_rt1711h.c:251: undefined reference to `__devm_regmap_init_i2c'
drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_init':
../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_register_driver'
drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_exit':
../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_del_driver'

Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: kbuild-all@01.org
---
 drivers/staging/typec/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-418-rc1.orig/drivers/staging/typec/Kconfig
+++ lnx-418-rc1/drivers/staging/typec/Kconfig
@@ -11,6 +11,7 @@ config TYPEC_TCPCI
 
 config TYPEC_RT1711H
 	tristate "Richtek RT1711H Type-C chip driver"
+	depends on I2C
 	select TYPEC_TCPCI
 	help
 	  Richtek RT1711H Type-C chip driver that works with


