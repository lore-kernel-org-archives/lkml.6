Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C2ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F2E21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F2E21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbeITS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:56674 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387789AbeITS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820927"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:27 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 11/16] stm class: Document the MIPI SyS-T protocol usage
Date:   Thu, 20 Sep 2018 15:45:48 +0300
Message-Id: <20180920124553.56978-12-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a document describing MIPI SyS-T protocol driver usage.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/trace/sys-t.rst | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/trace/sys-t.rst

diff --git a/Documentation/trace/sys-t.rst b/Documentation/trace/sys-t.rst
new file mode 100644
index 000000000000..3d8eb92735e9
--- /dev/null
+++ b/Documentation/trace/sys-t.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+MIPI SyS-T over STP
+===================
+
+The MIPI SyS-T protocol driver can be used with STM class devices to
+generate standardized trace stream. Aside from being a standard, it
+provides better trace source identification and timestamp correlation.
+
+In order to use the MIPI SyS-T protocol driver with your STM device,
+first, you'll need CONFIG_STM_PROTO_SYS_T.
+
+Now, you can select which protocol driver you want to use when you create
+a policy for your STM device, by specifying it in the policy name:
+
+# mkdir /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/
+
+In other words, the policy name format is extended like this:
+
+  <device_name>:<protocol_name>.<policy_name>
+
+With Intel TH, therefore it can look like "0-sth:p_sys-t.my-policy".
+
+If the protocol name is omitted, the STM class will chose whichever
+protocol driver was loaded first.
+
+You can also double check that everything is working as expected by
+
+# cat /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/protocol
+p_sys-t
+
+Now, with the MIPI SyS-T protocol driver, each policy node in the
+configfs gets a few additional attributes, which determine per-source
+parameters specific to the protocol:
+
+# mkdir /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/default
+# ls /config/stp-policy/dummy_stm.0:p_sys-t.my-policy/default
+channels
+clocksync_interval
+do_len
+masters
+ts_interval
+uuid
+
+The most important one here is the "uuid", which determines the UUID
+that will be used to tag all data coming from this source. It is
+automatically generated when a new node is created, but it is likely
+that you would want to change it.
+
+do_len switches on/off the additional "payload length" field in the
+MIPI SyS-T message header. It is off by default as the STP already
+marks message boundaries.
+
+ts_interval and clocksync_interval determine how much time in milliseconds
+can pass before we need to include a protocol (not transport, aka STP)
+timestamp in a message header or send a CLOCKSYNC packet, respectively.
+
+See Documentation/ABI/testing/configfs-stp-policy-p_sys-t for more
+details.
+
+* [1] https://www.mipi.org/specifications/sys-t
-- 
2.18.0

