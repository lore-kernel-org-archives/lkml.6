Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5D208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv7/p0+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E5D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeKIHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732558AbeKIHpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114902089F;
        Thu,  8 Nov 2018 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714901;
        bh=G4sKbp/3wODUt4y0Ktedl1jE16pnyYIlN266S7W3rg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mv7/p0+bLl3Ub1Zg8SaFRh7x+jBqVs9Ve2ImCIYE6cdH9+UeyEZID2X1GbMN+2Aj6
         INGf5Z0IsibQljFQKcZ9zF4qt6cq8N1E6RPb4MTt+JhjDF34higUDUj6I/H2vqPc+n
         q5gpTejdkRCD+pk3z5Jp5V5PywPpbgV3X+GQUl1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Herzog <t-herzog@gmx.de>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 18/31] cdc-acm: do not reset notification buffer index upon urb unlinking
Date:   Thu,  8 Nov 2018 13:52:42 -0800
Message-Id: <20181108215131.184420290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

From: Tobias Herzog <t-herzog@gmx.de>

commit dae3ddba36f8c337fb59cef07d564da6fc9b7551 upstream.

Resetting the write index of the notification buffer on urb unlink (e.g.
closing a cdc-acm device from userspace) may lead to wrong interpretation
of further received notifications, in case the index is not 0 when urb
unlink happens (i.e. when parts of a notification already have been
transferred). On the device side there is no "reset" of the notification
transimission and thus we would get out of sync with the device.

Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -367,7 +367,6 @@ static void acm_ctrl_irq(struct urb *urb
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
-		acm->nb_index = 0;
 		dev_dbg(&acm->control->dev,
 			"%s - urb shutting down with status: %d\n",
 			__func__, status);


