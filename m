Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB1C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A2215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsFKDOGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A2215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbeKLITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387789AbeKLITd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C69A215EA;
        Sun, 11 Nov 2018 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975377;
        bh=kvtG5gg2lQQpa/D5mXrWetmit3xNmIAe8xCVlzaNEFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsFKDOGdJ1vfnu9SIST6ba0N2+5MhahNXl3KUT9G7vMJfVMz9xutll9l7BYYiz8m3
         euYJHSLYy6hvd9w1vE65thL/rKWHnvxUpzdkglCEXSx589Qx7YXlXYa3xAL/h/jOCw
         slbzAGeCJQRE7KFsszEjqpHD5GuK6Oa1FszpjcXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 046/350] selftests: usbip: add wait after attach and before checking port status
Date:   Sun, 11 Nov 2018 14:18:30 -0800
Message-Id: <20181111221709.091051719@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit 4b0aaacee51eb6592a03fdefd5ce97558518e291 ]

Add sleep between attach and "usbip port" check to make sure status is
updated. Running attach and query back shows incorrect status.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -143,6 +143,10 @@ echo "Import devices from localhost - sh
 src/usbip attach -r localhost -b $busid;
 echo "=============================================================="
 
+# Wait for sysfs file to be updated. Without this sleep, usbip port
+# shows no imported devices.
+sleep 3;
+
 echo "List imported devices - expect to see imported devices";
 src/usbip port;
 echo "=============================================================="


