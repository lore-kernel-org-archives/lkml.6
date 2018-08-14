Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EABC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6368721570
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owwJWSMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6368721570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbeHNSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:50:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49730 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ScSZMFGN86LYxcwWu/LiVzgG0d2dSK+BA+VUjdEXtyc=; b=owwJWSMNHvYqFH2OysQ9mptgIF
        zdXb+4eP9O6iKPT0UEFeVEtPcINgtWEZXExidYydmB3o7iqZj+qTC39XTU+U3oVU8vkdAOHdPD26O
        o6/DvmhlwtJixuBDunhK2ErQmIIJ836ZYwv09MSdiXHxaLbNwKHMtl9se2VK0/WMiVbQVs4EPS82M
        GyqabpKargqHS43zarEZum1TXzJzFgzZ3IF3zRNkipRW1qf+OYkgqQV0uRp1iZ9BQQdO6dmlIdsfN
        svV0SfBXbQpa6dz9qgdBBJUG8q9GXUHgLHBago5ZKbEMlxRBGgVgqQXcbqbIK5jCAbpgop8i348gl
        T0oYkQgA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpbmE-0002U9-Ta; Tue, 14 Aug 2018 16:02:36 +0000
To:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] media: platform: fix cros-ec-cec build error
Message-ID: <314cbfef-ad4f-b0b2-d57b-3f54c062c1f8@infradead.org>
Date:   Tue, 14 Aug 2018 09:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build when MFD_CROS_EC is not enabled but COMPILE_TEST=y.
Fixes this build error:

ERROR: "cros_ec_cmd_xfer_status" [drivers/media/platform/cros-ec-cec/cros-ec-cec.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/platform/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180814.orig/drivers/media/platform/Kconfig
+++ linux-next-20180814/drivers/media/platform/Kconfig
@@ -541,6 +541,8 @@ config VIDEO_CROS_EC_CEC
 	depends on MFD_CROS_EC || COMPILE_TEST
 	select CEC_CORE
 	select CEC_NOTIFIER
+	select CHROME_PLATFORMS
+	select CROS_EC_PROTO
 	---help---
 	  If you say yes here you will get support for the
 	  ChromeOS Embedded Controller's CEC.


