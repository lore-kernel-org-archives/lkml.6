Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C631AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfBSLxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:53:36 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54087 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728347AbfBSLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:53:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0672625|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.106223-0.0833241-0.810453;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03292;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E-W9w0Q_1550577197;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E-W9w0Q_1550577197)
          by smtp.aliyun-inc.com(10.147.40.233);
          Tue, 19 Feb 2019 19:53:28 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC v9 2/5] dt-bindings: pstore-block: new support for blkoops
Date:   Tue, 19 Feb 2019 19:52:47 +0800
Message-Id: <1550577170-18761-3-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create DT binding document for blkoops.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 .../devicetree/bindings/pstore/blkoops.txt         | 53 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pstore/blkoops.txt

diff --git a/Documentation/devicetree/bindings/pstore/blkoops.txt b/Documentation/devicetree/bindings/pstore/blkoops.txt
new file mode 100644
index 0000000..5462915
--- /dev/null
+++ b/Documentation/devicetree/bindings/pstore/blkoops.txt
@@ -0,0 +1,53 @@
+Blkoops oops logger
+===================
+
+Blkoops provides a block partition for oops, excluding panics now, so they can
+be recovered after a reboot.
+
+Any space of block device will be used for a circular buffer of oops records.
+These records have a configurable size, with a size of 0 indicating that they
+should be disabled.
+
+At least one of "block-device" and "total_size" must be set.
+
+At least one of "dmesg-size" or "pmsg-size" must be set non-zero.
+
+Required properties:
+
+- compatible: must be "blkoops".
+
+Optional properties:
+
+- block-device: The block device to use. Most of the time, it is a partition of
+		device. If block-device is NULL, no block device is effective
+		and the data will be lost after rebooting.
+		It accept the following variants:
+		1) <hex_major><hex_minor> device number in hexadecimal
+		   represents itself no leading 0x, for example b302.
+		2) /dev/<disk_name> represents the device number of disk
+		3) /dev/<disk_name><decimal> represents the device number of
+		   partition - device number of disk plus the partition number
+		4) /dev/<disk_name>p<decimal> - same as the above, that form is
+		   used when disk name of partitioned disk ends on a digit.
+		5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing
+		   the unique id of a partition if the partition table provides
+		   it. The UUID may be either an EFI/GPT UUID, or refer to an
+		   MSDOS partition using the format SSSSSSSS-PP, where SSSSSSSS
+		   is a zero-filled hex representation of the 32-bit
+		   "NT disk signature", and PP is a zero-filled hex
+		   representation of the 1-based partition number.
+		6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in
+		   relation to a partition with a known unique id.
+		7) <major>:<minor> major and minor number of the device
+		   separated by a colon.
+
+- total-size: The total size in kbytes pstore/blk can use. It must be a multiple
+	      of 4. It must be less than or equal to size of block-device. If
+	      total-size is zero with block-devce valid, it will be set to equal
+	      to size of block-device.
+
+- dmesg-size: maximum size in kbytes of each dump done on oops, which must be a
+	      multiple of 4.
+
+- pmsg-size: maximum size in kbytes for userspace messages, which must be a
+	     multiple of 4.
diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a4..f49dd37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12318,6 +12318,7 @@ F:	drivers/firmware/efi/efi-pstore.c
 F:	drivers/acpi/apei/erst.c
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+F:	Documentation/devicetree/bindings/pstore-block/
 K:	\b(pstore|ramoops)
 
 PTP HARDWARE CLOCK SUPPORT
-- 
1.9.1

