Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0511EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2izg/HzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9F208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbeFNO57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936053AbeFNOFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:05:46 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14333208DA;
        Thu, 14 Jun 2018 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985145;
        bh=WTYG2ItIgRT+9t6MEu0PhKO3yQXWJHbj8Y95JXGiMHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2izg/HzUWTaRlXkbbSQXHlRuueh238/IYa/p3xd3hVTi4Mk5Mmh1zI9NIDtw3EvRl
         sWHf1+oIt9cLWD51ITY7HZM5y7fPR9v3jkwjQdB1kB53UWwKzoI///AQv1RsoQjVG6
         YOvmTlQAq2/KTf+sws09TadMfwhQ0tDxCFxboo1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Panchenko <dmytro.panchenko@globallogic.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 4.17 16/45] usb: core: message: remove extra endianness conversion in usb_set_isoch_delay
Date:   Thu, 14 Jun 2018 16:04:07 +0200
Message-Id: <20180614132127.620474085@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruslan Bilovol <ruslan.bilovol@gmail.com>

commit 48b73d0fa11aa8613d51f7be61d2fa7f0ab05fd3 upstream.

No need to do extra endianness conversion in
usb_set_isoch_delay because it is already done
in usb_control_msg()

Fixes: 886ee36e7205 ("usb: core: add support for USB_REQ_SET_ISOCH_DELAY")
Cc: Dmytro Panchenko <dmytro.panchenko@globallogic.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org> # v4.16+
Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -940,7 +940,7 @@ int usb_set_isoch_delay(struct usb_devic
 	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			USB_REQ_SET_ISOCH_DELAY,
 			USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
-			cpu_to_le16(dev->hub_delay), 0, NULL, 0,
+			dev->hub_delay, 0, NULL, 0,
 			USB_CTRL_SET_TIMEOUT);
 }
 


