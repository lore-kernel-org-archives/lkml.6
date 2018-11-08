Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51162ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8662089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrxjgR38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8662089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbeKIHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbeKIHrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:06 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC42A2147A;
        Thu,  8 Nov 2018 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714974;
        bh=28iVcZyyRuGpTcZh4ZLX26lUnJR/kBlSW7jTTv8Muwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrxjgR38e4Y5h3aPuCZmDaBR1r0UgwGTtLQetwC+vvNJ9WjBbR9bnWG4CWl9i6Oql
         8axz6C4PWEQr0nFLdndq4Zf12Nm01rTKZa9UjljtyAMpV+MoH5nHPEjD0W0fQc74xh
         OhxBfajOeFdPJYdkcFXzd8SoziWKOEsGKE79h+KI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.18 17/34] cdc-acm: fix race between reset and control messaging
Date:   Thu,  8 Nov 2018 13:52:46 -0800
Message-Id: <20181108215139.972329313@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 9397940ed812b942c520e0c25ed4b2c64d57e8b9 upstream.

If a device splits up a control message and a reset() happens
between the parts, the message is lost and already recieved parts
must be dropped.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 1aba579f3cf51 ("cdc-acm: handle read pipe errors")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1641,6 +1641,7 @@ static int acm_pre_reset(struct usb_inte
 	struct acm *acm = usb_get_intfdata(intf);
 
 	clear_bit(EVENT_RX_STALL, &acm->flags);
+	acm->nb_index = 0; /* pending control transfers are lost */
 
 	return 0;
 }


