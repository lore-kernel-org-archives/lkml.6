Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79729ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407B3214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEJHTuOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407B3214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbeKIHpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbeKIHph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21A7214DA;
        Thu,  8 Nov 2018 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714885;
        bh=CIoyKv+eaueeIZpFvlMqpc5H8Ic+osWi3E2jp3YurHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEJHTuOERCFUIhLIipVnHai9SFx1T5XzqIZJ/4cNCBlQMqwzd7IBZlUu0r92INou3
         tV1j/7frWqMYPeDcK0u1iBZIpYkEcVEjR3tkc7j/Id6feDP6/T3+QqiNLHQttR+ybt
         AHhidn3+JrtyDJuHN1e9rWLQr0z1CWTxz2mo31FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>,
        Andy Yeh <andy.yeh@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/31] eeprom: at24: Add support for address-width property
Date:   Thu,  8 Nov 2018 13:52:25 -0800
Message-Id: <20181108215129.753982396@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a2b3bf4846e5eed62ea6abb096af2c950961033c ]

Provide a flexible way to determine the addressing bits of eeprom.
Pass the addressing bits to driver through address-width property.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/at24.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 4cc0b42f2acc..ded48a0c77ee 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -577,6 +577,23 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 	if (device_property_present(dev, "read-only"))
 		chip->flags |= AT24_FLAG_READONLY;
 
+	err = device_property_read_u32(dev, "address-width", &val);
+	if (!err) {
+		switch (val) {
+		case 8:
+			if (chip->flags & AT24_FLAG_ADDR16)
+				dev_warn(dev, "Override address width to be 8, while default is 16\n");
+			chip->flags &= ~AT24_FLAG_ADDR16;
+			break;
+		case 16:
+			chip->flags |= AT24_FLAG_ADDR16;
+			break;
+		default:
+			dev_warn(dev, "Bad \"address-width\" property: %u\n",
+				 val);
+		}
+	}
+
 	err = device_property_read_u32(dev, "pagesize", &val);
 	if (!err) {
 		chip->page_size = val;
-- 
2.17.1



