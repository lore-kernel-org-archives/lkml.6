Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE5BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7905420838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwJMElIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7905420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJ3WUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJ3WUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:20:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80CD2084A;
        Tue, 30 Oct 2018 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906034;
        bh=wYPLamTqlR6u3PgV7Mliop5wBaf6bA0NNQ36AapjNaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwJMElIo4Gc1klPxJqNjGX3cpmeo0+BcKPz4N/vthlMzwpAyq6VeS0DVu6Yr0UkRZ
         I8QbruThxQuuzUaETRtFvpws6O/4ntZKbK3mKlHbL/MZj2BWy3pJ/ZjSXhYMdTF7wU
         pPDaouuS/yIEJYSstZav6P3HyeC3UDM6RxT5ZaME=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 05/33] selftests: usbip: add wait after attach and before checking port status
Date:   Tue, 30 Oct 2018 09:26:29 -0400
Message-Id: <20181030132657.217970-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit 4b0aaacee51eb6592a03fdefd5ce97558518e291 ]

Add sleep between attach and "usbip port" check to make sure status is
updated. Running attach and query back shows incorrect status.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
index 1893d0f59ad7..059b7e81b922 100755
--- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -143,6 +143,10 @@ echo "Import devices from localhost - should work"
 src/usbip attach -r localhost -b $busid;
 echo "=============================================================="
 
+# Wait for sysfs file to be updated. Without this sleep, usbip port
+# shows no imported devices.
+sleep 3;
+
 echo "List imported devices - expect to see imported devices";
 src/usbip port;
 echo "=============================================================="
-- 
2.17.1

