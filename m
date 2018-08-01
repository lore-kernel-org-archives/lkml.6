Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6986F20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6986F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbeHAUJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:09:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404425AbeHATDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25D42119E;
        Wed,  1 Aug 2018 17:07:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Kubushyn <ksi@koi8.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 263/336] platform/x86: dell-smbios: Match on www.dell.com in OEM strings too
Date:   Wed,  1 Aug 2018 18:49:58 +0200
Message-Id: <20180801165039.110623083@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@dell.com>

[ Upstream commit b004b21cc664ca00782508514dade43e29eebf94 ]

Sergey reported that some much older Dell systems don't support
the OEM string "Dell System" but instead supported www.dell.com
in OEM strings.

Match both of these to indicate that this driver is running on
a Dell system.

Reported-by: Sergey Kubushyn <ksi@koi8.net>
Tested-by: Sergey Kubushyn <ksi@koi8.net>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
[dvhart: Simplify DMI logic and eliminate unnecessary variables]
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell-smbios-base.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -555,11 +555,10 @@ static void free_group(struct platform_d
 
 static int __init dell_smbios_init(void)
 {
-	const struct dmi_device *valid;
 	int ret, wmi, smm;
 
-	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
-	if (!valid) {
+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
 	}


