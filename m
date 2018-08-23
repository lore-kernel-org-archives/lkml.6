Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C66220839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C66220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbeHWMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbeHWMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D521C74;
        Thu, 23 Aug 2018 08:52:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 158/324] acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value
Date:   Thu, 23 Aug 2018 09:53:44 +0200
Message-Id: <20180823075003.946858747@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit c1985cefd844e26bd19673a6df8d8f0b1918c2db ]

cmd_rc is passed in by reference to the acpi_nfit_ctl() function and the
caller expects a value returned. However, when the package is pass through
via the ND_CMD_CALL command, cmd_rc is not touched. Make sure cmd_rc is
always set.

Fixes: aef253382266 ("libnvdimm, nfit: centralize command status translation")

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/nfit/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -408,6 +408,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	const guid_t *guid;
 	int rc, i;
 
+	*cmd_rc = -EINVAL;
 	func = cmd;
 	if (cmd == ND_CMD_CALL) {
 		call_pkg = buf;
@@ -518,6 +519,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		 * If we return an error (like elsewhere) then caller wouldn't
 		 * be able to rely upon data returned to make calculation.
 		 */
+		*cmd_rc = 0;
 		return 0;
 	}
 


