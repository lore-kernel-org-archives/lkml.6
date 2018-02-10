Return-Path: <lukas@wunner.de>
X-Google-Smtp-Source: AH8x227/Fa2DPB9Gb0AzxLc5ViTlseUv0wza1LzGensg7G5CPdnoQFT6xMznR2g5pSi42AYYwfTr
ARC-Seal: i=1; a=rsa-sha256; t=1518286440; cv=none;
        d=google.com; s=arc-20160816;
        b=afyuZ/q0gPplhyjfq7qDu2+pK8HUSksrv9jIwJQrJZMNvXUTfardgGf8Yz4AyM5wE7
         FX4pnPt3D4jD6Buc3zMQ/7+7O3n6tSpEhY704XDFzZP68RBsXjLKggVcKpoHKQEFYtY2
         M4mFNMaCK111UZ/+Tke+W6A5eAYAJ/KHQeTVj5ADsFMVJhUaWwOQVhaHocbiDLhAP82A
         uRWDvZKbc3F3qIr1+kt9xz7eUXBBX0HZWzYkRp0Kn9caN/806eboR3539DKCcfQDr3TB
         nUdNLY4ubyfRKUVdIRZVHgnaczDsyMMYU1pBwrKLksuobYy1xQltQVYVMuM67zRf3VTS
         4Fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:date:from:message-id:arc-authentication-results;
        bh=YFnn9ZxZKztxHUWnCTNpnOShqUC6ePgIt6p9JrNzY6s=;
        b=g8Ikm7L8K93QA6+09iO+iPyzNV1muXRdE4QgjqrgnIGtmc8Sk0MT4X93kr5npSh56y
         CPb1sc+Ls7GC9wWbeBT1eDbzuSmyQeRVgCyqx5mBeauO/xSkWx/H5m5HPfM2TT/8+rQy
         JRESA1dIE47EH43KltXL/Jx5h4IFKgpPCfcLDe9qhdueQEq8VYvxErzIAVI3A/m5+fMz
         ktqoUQrrK2ZyzpNIINAhYENXud8FtYCpLSRIAKhYRT+sGKAgsBastS/iOCIroP1GCy3e
         4mcHoTXE+QfZq3OTinkxH1im6YDtL7vxkijZPqQHblksbbdXDKPSsKTeTHH/VN+XrpB5
         uSYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 83.223.95.204 is neither permitted nor denied by best guess record for domain of lukas@wunner.de) smtp.mailfrom=lukas@wunner.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 83.223.95.204 is neither permitted nor denied by best guess record for domain of lukas@wunner.de) smtp.mailfrom=lukas@wunner.de
X-Mailbox-Line: From 68feef8bf476ab150e6481b54f1b6f5c401b8e10 Mon Sep 17 00:00:00 2001
Message-Id: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 10 Feb 2018 19:13:58 +0100
Subject: [PATCH] PM / runtime: Update links_count also if !CONFIG_SRCU
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592038722413280584?=
X-GMAIL-MSGID: =?utf-8?q?1592038722413280584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit baa8809f6097 ("PM / runtime: Optimize the use of device links")
added an invocation of pm_runtime_drop_link() to __device_link_del().
However there are two variants of that function, one for CONFIG_SRCU and
another for !CONFIG_SRCU, and the commit only modified the former.

Fixes: baa8809f6097 ("PM / runtime: Optimize the use of device links")
Cc: stable@vger.kernel.org # v4.10+
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b2261f92f2f1..5847364f25d9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -310,6 +310,9 @@ static void __device_link_del(struct device_link *link)
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DL_FLAG_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del(&link->s_node);
 	list_del(&link->c_node);
 	device_link_free(link);
-- 
2.15.1
