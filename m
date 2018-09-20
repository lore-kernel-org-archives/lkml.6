Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E9221529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E9221529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbeITSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:30:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:24357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387791AbeITS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:29:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:46:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="87820921"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2018 05:46:25 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [QUEUED v20180920 10/16] stm class: p_sys-t: Document the configfs interface
Date:   Thu, 20 Sep 2018 15:45:47 +0300
Message-Id: <20180920124553.56978-11-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds ABI documentation for the new configfs attributes that come
with the MIPI SyS-T protocol driver.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 .../ABI/testing/configfs-stp-policy-p_sys-t   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_sys-t

diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_sys-t b/Documentation/ABI/testing/configfs-stp-policy-p_sys-t
new file mode 100644
index 000000000000..b290d1c00dcf
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-stp-policy-p_sys-t
@@ -0,0 +1,41 @@
+What:		/config/stp-policy/<device>:p_sys-t.<policy>/<node>/uuid
+Date:		June 2018
+KernelVersion:	4.19
+Description:
+		UUID source identifier string, RW.
+		Default value is randomly generated at the mkdir <node> time.
+		Data coming from trace sources that use this <node> will be
+		tagged with this UUID in the MIPI SyS-T packet stream, to
+		allow the decoder to discern between different sources
+		within the same master/channel range, and identify the
+		higher level decoders that may be needed for each source.
+
+What:		/config/stp-policy/<device>:p_sys-t.<policy>/<node>/do_len
+Date:		June 2018
+KernelVersion:	4.19
+Description:
+		Include payload length in the MIPI SyS-T header, boolean.
+		If enabled, the SyS-T protocol encoder will include payload
+		length in each packet's metadata. This is normally redundant
+		if the underlying transport protocol supports marking message
+		boundaries (which STP does), so this is off by default.
+
+What:		/config/stp-policy/<device>:p_sys-t.<policy>/<node>/ts_interval
+Date:		June 2018
+KernelVersion:	4.19
+Description:
+		Time interval in milliseconds. Include a timestamp in the
+		MIPI SyS-T packet metadata, if this many milliseconds have
+		passed since the previous packet from this source. Zero is
+		the default and stands for "never send the timestamp".
+
+What:		/config/stp-policy/<device>:p_sys-t.<policy>/<node>/clocksync_interval
+Date:		June 2018
+KernelVersion:	4.19
+Description:
+		Time interval in milliseconds. Send a CLOCKSYNC packet if
+		this many milliseconds have passed since the previous
+		CLOCKSYNC packet from this source. Zero is the default and
+		stands for "never send the CLOCKSYNC". It makes sense to
+		use this option with sources that generate constant and/or
+		periodic data, like stm_heartbeat.
-- 
2.18.0

