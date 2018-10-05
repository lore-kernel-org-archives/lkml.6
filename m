Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D14B2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D14B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeJETmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:42:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:28570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbeJETmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:42:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687814"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:33 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 12/16] stm class: Update documentation to match the new identification rules
Date:   Fri,  5 Oct 2018 15:43:02 +0300
Message-Id: <20181005124306.54870-13-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rules and order of identification of trace sources against the
"stp-policy" have changed; update the documentation to reflect that.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/trace/stm.rst | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/stm.rst b/Documentation/trace/stm.rst
index 2c22ddb7fd3e..944994fd6368 100644
--- a/Documentation/trace/stm.rst
+++ b/Documentation/trace/stm.rst
@@ -53,12 +53,30 @@ under "user" directory from the example above and this new rule will
 be used for trace sources with the id string of "user/dummy".
 
 Trace sources have to open the stm class device's node and write their
-trace data into its file descriptor. In order to identify themselves
-to the policy, they need to do a STP_POLICY_ID_SET ioctl on this file
-descriptor providing their id string. Otherwise, they will be
-automatically allocated a master/channel pair upon first write to this
-file descriptor according to the "default" rule of the policy, if such
-exists.
+trace data into its file descriptor.
+
+In order to find an appropriate policy node for a given trace source,
+several mechanisms can be used. First, a trace source can explicitly
+identify itself by calling an STP_POLICY_ID_SET ioctl on the character
+device's file descriptor, providing their id string, before they write
+any data there. Secondly, if they chose not to perform the explicit
+identification (because you may not want to patch existing software
+to do this), they can just start writing the data, at which point the
+stm core will try to find a policy node with the name matching the
+task's name (e.g., "syslogd") and if one exists, it will be used.
+Thirdly, if the task name can't be found among the policy nodes, the
+catch-all entry "default" will be used, if it exists. This entry also
+needs to be created and configured by the system administrator or
+whatever tools are taking care of the policy configuration. Finally,
+if all the above steps failed, the write() to an stm file descriptor
+will return a error (EINVAL).
+
+Previously, if no policy nodes were found for a trace source, the stm
+class would silently fall back to allocating the first available
+contiguous range of master/channels from the beginning of the device's
+master/channel range. The new requirement for a policy node to exist
+will help programmers and sysadmins identify gaps in configuration
+and have better control over the un-identified sources.
 
 Some STM devices may allow direct mapping of the channel mmio regions
 to userspace for zero-copy writing. One mappable page (in terms of
@@ -92,9 +110,9 @@ allocated for the device according to the policy configuration. If
 there's a node in the root of the policy directory that matches the
 stm_source device's name (for example, "console"), this node will be
 used to allocate master and channel numbers. If there's no such policy
-node, the stm core will pick the first contiguous chunk of channels
-within the first available master. Note that the node must exist
-before the stm_source device is connected to its stm device.
+node, the stm core will use the catch-all entry "default", if one
+exists. If neither policy nodes exist, the write() to stm_source_link
+will return an error.
 
 stm_console
 ===========
-- 
2.19.0

