Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B40C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28E217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548361091;
	bh=wVNreC0m5Eu76wZ4GvRr8R4dxG6ujkfNygAHtgTpaU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIeopxW1ssrWOPdj38QduZCQvdc8inK5QidX/wdSnVvcyCHxZNnp0ntL9fUD+6DeW
	 pDiV9pGWGPZomPHcGB4EGRqUvnJvWvntUVZRzaqJC11FEwZV+0Z/DyMSsFnG2JGPki
	 mw2qXSirVZvcBjvgDwwRH6l2ou+1C3spDc//grJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfAXUSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbfAXTWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9139218CD;
        Thu, 24 Jan 2019 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357759;
        bh=wVNreC0m5Eu76wZ4GvRr8R4dxG6ujkfNygAHtgTpaU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEogONnvKXuAVuhzloVolSzD+J3XqJe0DJ796VIU816dKMKpzUhAVm6Fj3nEmiwJQ
         DdFlYkL4iktLlbxs8ZiYUSo2q3Qu0PAE+RS/L5wCOlDKmRP2QiHsqu+WMTo58y0SUP
         Q1QyXh0Ymy4rz81/2FszHdyIOShyrDWks180teXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Zeng <yizeng@asrmicro.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 3.18 09/52] i2c: dev: prevent adapter retries and timeout being set as minus value
Date:   Thu, 24 Jan 2019 20:19:33 +0100
Message-Id: <20190124190142.515214234@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Zeng <yizeng@asrmicro.com>

commit 6ebec961d59bccf65d08b13fc1ad4e6272a89338 upstream.

If adapter->retries is set to a minus value from user space via ioctl,
it will make __i2c_transfer and __i2c_smbus_xfer skip the calling to
adapter->algo->master_xfer and adapter->algo->smbus_xfer that is
registered by the underlying bus drivers, and return value 0 to all the
callers. The bus driver will never be accessed anymore by all users,
besides, the users may still get successful return value without any
error or information log print out.

If adapter->timeout is set to minus value from user space via ioctl,
it will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
always break after the the first try, due to the time_after always
returns true.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
[wsa: minor grammar updates to commit message]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-dev.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -462,9 +462,15 @@ static long i2cdev_ioctl(struct file *fi
 		return i2cdev_ioctl_smbus(client, arg);
 
 	case I2C_RETRIES:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		/* For historical reasons, user-space sets the timeout
 		 * value in units of 10 ms.
 		 */


