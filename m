Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504942086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z3Si3XZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504942086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeKIHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbeKIHcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:11 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58932086C;
        Thu,  8 Nov 2018 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714084;
        bh=feab0Jstr74SukIhilBumdom35X7uHzfl2UTY1nDfn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3Si3XZCUmqvj8yYaZ0QgLF1IfryOU2CFcZm2KDnvKMEolTifpYKR1JCJ5Nwdc8VC
         Ftn2VaLrBe5VPabcFNJDLsmjwAUXqbGnMbXfnV/9ssCVzOdK6BWhrWplMVVV8Q2qXF
         dufn9NOb6ZPEp9lz9gvWbDAGQJuHMFQy577j5WMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 049/144] phy-sun4i-usb: Change disconnect threshold value for sun6i
Date:   Thu,  8 Nov 2018 13:50:20 -0800
Message-Id: <20181108215058.403016948@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 372400344afb60e275a271f3f5ccce17af0e45cb ]

The allwinner SDK uses a value of 3 for the disconnect threshold setting on
sun6i, do the same in the kernel.

In my previous experience with sun5i problems getting the threshold right
is important to avoid usb2 devices being unplugged sometimes going unnoticed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/phy-sun4i-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0baf5efc8a40..1a2b045d6a67 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -240,7 +240,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	else
 		data->num_phys = 3;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
 		data->disc_thresh = 3;
 	else
 		data->disc_thresh = 2;
-- 
2.17.1



