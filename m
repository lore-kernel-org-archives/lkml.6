Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E53C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21535208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21535208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeHWLjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:39:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeHWLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:39:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9118C83;
        Thu, 23 Aug 2018 08:10:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/130] nfit: fix unchecked dereference in acpi_nfit_ctl
Date:   Thu, 23 Aug 2018 09:53:33 +0200
Message-Id: <20180823074933.414961427@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit ee6581ceba7f8314b81b2f2a81f1cf3f67c679e2 ]

Incremental patch to fix the unchecked dereference in acpi_nfit_ctl.
Reported by Dan Carpenter:

"acpi/nfit: fix cmd_rc for acpi_nfit_ctl to
always return a value" from Jun 28, 2018, leads to the following
Smatch complaint:

    drivers/acpi/nfit/core.c:578 acpi_nfit_ctl()
     warn: variable dereferenced before check 'cmd_rc' (see line 411)

drivers/acpi/nfit/core.c
   410
   411		*cmd_rc = -EINVAL;
                ^^^^^^^^^^^^^^^^^^
Patch adds unchecked dereference.

Fixes: c1985cefd844 ("acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value")

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/nfit/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -201,7 +201,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	const u8 *uuid;
 	int rc, i;
 
-	*cmd_rc = -EINVAL;
+	if (cmd_rc)
+		*cmd_rc = -EINVAL;
 	func = cmd;
 	if (cmd == ND_CMD_CALL) {
 		call_pkg = buf;
@@ -289,7 +290,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		 * If we return an error (like elsewhere) then caller wouldn't
 		 * be able to rely upon data returned to make calculation.
 		 */
-		*cmd_rc = 0;
+		if (cmd_rc)
+			*cmd_rc = 0;
 		return 0;
 	}
 


