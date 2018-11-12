Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0472243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0iGLiKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0472243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbeKMGT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:19:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37365 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:19:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so3687169edb.4;
        Mon, 12 Nov 2018 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=loVmp6tvQQOcCP7QeK8oMGkh5eedM2eY+bnfEKqwg9Q=;
        b=D0iGLiKSFCKRSjv2BUYzeysowPd/5VzIYQisnQMmiKYFFQ9LOMR1b8v+zvqfEuxNPj
         yb8ppBDHAibzmewTJAkIqtVfuqFdztUzq2k3jqMXJwfuzIpQoUZRdcwnQTjUjf2oTFT1
         IOr+gyjrWMJZkwveBBpBFPN0Qz+I/1zL5LI5GpaHaMZ28WwMgL7eoWG4atE6GltmV/Xg
         C7rdYJVwcODjnI3x3LMLn7z5UfYlSlAdTSqEc25zlzywp6XbgiuzGd/pwwOV4iHDgmvA
         bGB5s2+g+eyeoKlyqHDSSwUOHS6GZ47za1OeucWmcb7FmiTvH5nBZ4WyRr+yyCM6FXr8
         FYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=loVmp6tvQQOcCP7QeK8oMGkh5eedM2eY+bnfEKqwg9Q=;
        b=HiogQAv+tj9ZMRTFmCj5Rp38wJGGZOQr65MQzYrbFIz23du9U/jKksQw5Xmau0vnjO
         yO2zOSSEniBmvvvO5a0p9HmCACpCv1AJXCzqR6ymIixsJG3HzCIr2hIwAQaKjC1Uv/DE
         GiRvnt6aDz7p7hG5EZrGRl0bJWb3Z9nwW7EKTw1Rm9I2iKn2VjzKmnDaQTV2v7cNe0LN
         Mce/DBBrVc/Ja8IRVCEuXFE7RJ3zON+kjgqfrGDuO1gWUH8b5MMTcpnqvxuTI25hrRPc
         heO3MpQYG4J66EgGF8CHGoUFFCG3qThY0tQYv9i6I6nTpmuzt6jC620qSuyQuCxwMQGe
         Jtmw==
X-Gm-Message-State: AGRZ1gKOy+FZK9KImtUcoblE9IgAAYr3dUcubq7qKEoM7E83PsaHnYfb
        M1ImQpZGSbfPoptIM3XGH7g=
X-Google-Smtp-Source: AJdET5fvLdSko5FNrIxjNt6+7QMPqTDyHhft8RSLwA7183HQUczIxeqZ/POeD/woWytTHAPMN0LdaQ==
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr10358191ejm.91.1542054305657;
        Mon, 12 Nov 2018 12:25:05 -0800 (PST)
Received: from localhost.localdomain ([159.100.241.215])
        by smtp.googlemail.com with ESMTPSA id e10-v6sm2484527ejf.28.2018.11.12.12.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:25:05 -0800 (PST)
From:   Jean-Philippe Menil <jpmenil@gmail.com>
To:     mathias.nyman@intel.com
Cc:     jpmenil@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: fix build warning - missing prototype
Date:   Mon, 12 Nov 2018 20:24:35 +0000
Message-Id: <20181112202436.20547-1-jpmenil@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning when building drivers/usb/host/xhci-mem.o due to missing
prototype for xhci_free_virt_devices_depth_first.

This function is only used in xhci-mem.c so just make it static.

Signed-off-by: Jean-Philippe Menil <jpmenil@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index b1f27aa38b10..c5236f5d917a 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -933,7 +933,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
  * that tt_info, then free the child first. Recursive.
  * We can't rely on udev at this point to find child-parent relationships.
  */
-void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_id)
+static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_id)
 {
 	struct xhci_virt_device *vdev;
 	struct list_head *tt_list_head;
-- 
2.17.1

