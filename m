Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D1C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E7020836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E7020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeI0PaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:30:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbeI0PaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:30:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 487441117;
        Thu, 27 Sep 2018 09:12:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pinzhen Xu <pinzhen.xu@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.18 42/88] platform/x86: dell-smbios-wmi: Correct a memory leak
Date:   Thu, 27 Sep 2018 11:03:23 +0200
Message-Id: <20180927090305.874661525@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@dell.com>

commit affab51082174f60ef71ced8ab5fbe71f00e9ae3 upstream.

ACPI buffers were being allocated but never freed.

Reported-by: Pinzhen Xu <pinzhen.xu@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Cc: stable@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/dell-smbios-wmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -78,6 +78,7 @@ static int run_smbios_call(struct wmi_de
 	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
 		priv->buf->std.output[0], priv->buf->std.output[1],
 		priv->buf->std.output[2], priv->buf->std.output[3]);
+	kfree(output.pointer);
 
 	return 0;
 }


