Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E014C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3332087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwTUv9OW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3332087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeJKXFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222402098A;
        Thu, 11 Oct 2018 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272254;
        bh=TojgQUO8NqMKD0NhKHtSNIpaPvarZpXTIH8gtbZ+wx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwTUv9OWJgkJyB1VWHSD6ZjD3AbsUIhVtVNV9RsOgOPJgHBC7tMc3pRmttX4Lh12/
         ELVuheWHUQdZ8nLVVGBHNC6OojGm4F031gc2N/v+9jFIhoJSLn1b3j8pmCsoEVgXa7
         +XmeZNEEOd4M4fjLgrtyXk0stQc8HJcnU3mosKBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 043/120] HID: hid-ntrig: add error handling for sysfs_create_group
Date:   Thu, 11 Oct 2018 17:33:44 +0200
Message-Id: <20181011152551.527614835@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 44d4d51de9a3534a2b63d69efda02a10e66541e4 ]

When sysfs_create_group fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling sysfs_create_group.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ntrig.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -953,6 +953,8 @@ static int ntrig_probe(struct hid_device
 
 	ret = sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
+	if (ret)
+		hid_err(hdev, "cannot create sysfs group\n");
 
 	return 0;
 err_free:


