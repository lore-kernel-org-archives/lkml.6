Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9F4222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083311;
	bh=gV9Ga561QIgdubwfGq4wlki/kJAhbT5a9suKzy9KT/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8trNUExN28PxBaZ1350ufNZ8Eu+neRYCAvnJByjrGxfuj8N6+G9sb3zx7Widr5le
	 y/PleEvQM9VL4nsFSaXfin2FdvoUT8eUwMEsI+0/M+izlouvMzFZiywkboXo2b1imN
	 OycP5gbqP9J2EQrUIjqO2sAkrUVHNpsYu0BzkI90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405522AbfBMSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393881AbfBMSlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60662222D9;
        Wed, 13 Feb 2019 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083303;
        bh=gV9Ga561QIgdubwfGq4wlki/kJAhbT5a9suKzy9KT/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpjZW4fTGbsVPHAtmtDuKtYAHBdIeuqGnGpvXRrpD8+Xx8bRl3oObYSmgIT8vzyMC
         X8/SCV0CnSxgH6MgCM+TPJTMzTsqP+55mnYMOeTbdYciMYEkFD3JFfdiISwftdaHR4
         /ivJT2ezroU1rZsiVn0FS0+pmPoymsXC/Nh5GkL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 28/35] uio: Reduce return paths from uio_write()
Date:   Wed, 13 Feb 2019 19:38:23 +0100
Message-Id: <20190213183707.359254829@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

commit 81daa406c2cc97d85eef9409400404efc2a3f756 upstream.

Drive all return paths for uio_write() through a single block at the
end of the function.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -570,20 +570,29 @@ static ssize_t uio_write(struct file *fi
 	ssize_t retval;
 	s32 irq_on;
 
-	if (!idev->info->irq)
-		return -EIO;
-
-	if (count != sizeof(s32))
-		return -EINVAL;
-
-	if (!idev->info->irqcontrol)
-		return -ENOSYS;
-
-	if (copy_from_user(&irq_on, buf, count))
-		return -EFAULT;
+	if (!idev->info->irq) {
+		retval = -EIO;
+		goto out;
+	}
+
+	if (count != sizeof(s32)) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if (!idev->info->irqcontrol) {
+		retval = -ENOSYS;
+		goto out;
+	}
+
+	if (copy_from_user(&irq_on, buf, count)) {
+		retval = -EFAULT;
+		goto out;
+	}
 
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
+out:
 	return retval ? retval : sizeof(s32);
 }
 


