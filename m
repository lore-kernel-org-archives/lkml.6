Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFBC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3567120880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763202;
	bh=utnu5/aMntglDNyM1I0ddjSSWrlLDsYTpCcTSxhLTeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ox/420/bfh8vjlNf/PXz0WTOf8QM9dowmvID3KdR3/XiUKaQPnQLbCy0+aRan5Y7i
	 MnVRillNDv9MrCj9pdyvfzzq0jRF21ZcmkE9K6UD6uaAWkhQj4FNgT25ifw9flHc71
	 pesyRqfVzZ4cx8WqUt5SMDDxh/PaDB9Eb0A7pJaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfA2MAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbfA2Lqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E0F21874;
        Tue, 29 Jan 2019 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762402;
        bh=utnu5/aMntglDNyM1I0ddjSSWrlLDsYTpCcTSxhLTeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMtnbsSukX5TvjDo94gLA3EzQSboD/VzE2LE/YnZmeSv3CeDYJaUp7u4kjKMpWhkX
         x33UIjl8L7l4CwDHDp2ddj1FPhDqKtmAvjNDFAewFwdIgd5u0F7GlYjhZCbIUlx2ud
         GT6QL4b2AOWhwwQHZEVcX5iIGYQXZYFoPGFEXyqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sujith Pandel <sujith_pandel@dell.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 062/103] acpi/nfit: Fix command-supported detection
Date:   Tue, 29 Jan 2019 12:35:39 +0100
Message-Id: <20190129113204.390273315@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 11189c1089da413aa4b5fd6be4c4d47c78968819 upstream.

The _DSM function number validation only happens to succeed when the
generic Linux command number translation corresponds with a
DSM-family-specific function number. This breaks NVDIMM-N
implementations that correctly implement _LSR, _LSW, and _LSI, but do
not happen to publish support for DSM function numbers 4, 5, and 6.

Recall that the support for _LS{I,R,W} family of methods results in the
DIMM being marked as supporting those command numbers at
acpi_nfit_register_dimms() time. The DSM function mask is only used for
ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.

Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
Cc: <stable@vger.kernel.org>
Link: https://github.com/pmem/ndctl/issues/78
Reported-by: Sujith Pandel <sujith_pandel@dell.com>
Tested-by: Sujith Pandel <sujith_pandel@dell.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   54 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 14 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -391,6 +391,32 @@ static u8 nfit_dsm_revid(unsigned family
 	return id;
 }
 
+static int cmd_to_func(struct nfit_mem *nfit_mem, unsigned int cmd,
+		struct nd_cmd_pkg *call_pkg)
+{
+	if (call_pkg) {
+		int i;
+
+		if (nfit_mem->family != call_pkg->nd_family)
+			return -ENOTTY;
+
+		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
+			if (call_pkg->nd_reserved2[i])
+				return -EINVAL;
+		return call_pkg->nd_command;
+	}
+
+	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
+	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
+		return cmd;
+
+	/*
+	 * Force function number validation to fail since 0 is never
+	 * published as a valid function in dsm_mask.
+	 */
+	return 0;
+}
+
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
@@ -404,30 +430,23 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	unsigned long cmd_mask, dsm_mask;
 	u32 offset, fw_status = 0;
 	acpi_handle handle;
-	unsigned int func;
 	const guid_t *guid;
-	int rc, i;
+	int func, rc, i;
 
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
-	func = cmd;
-	if (cmd == ND_CMD_CALL) {
-		call_pkg = buf;
-		func = call_pkg->nd_command;
-
-		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
-			if (call_pkg->nd_reserved2[i])
-				return -EINVAL;
-	}
 
 	if (nvdimm) {
 		struct acpi_device *adev = nfit_mem->adev;
 
 		if (!adev)
 			return -ENOTTY;
-		if (call_pkg && nfit_mem->family != call_pkg->nd_family)
-			return -ENOTTY;
 
+		if (cmd == ND_CMD_CALL)
+			call_pkg = buf;
+		func = cmd_to_func(nfit_mem, cmd, call_pkg);
+		if (func < 0)
+			return func;
 		dimm_name = nvdimm_name(nvdimm);
 		cmd_name = nvdimm_cmd_name(cmd);
 		cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -438,6 +457,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	} else {
 		struct acpi_device *adev = to_acpi_dev(acpi_desc);
 
+		func = cmd;
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
 		dsm_mask = cmd_mask;
@@ -452,7 +472,13 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	if (!desc || (cmd && (desc->out_num + desc->in_num == 0)))
 		return -ENOTTY;
 
-	if (!test_bit(cmd, &cmd_mask) || !test_bit(func, &dsm_mask))
+	/*
+	 * Check for a valid command.  For ND_CMD_CALL, we also have to
+	 * make sure that the DSM function is supported.
+	 */
+	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
+		return -ENOTTY;
+	else if (!test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
 
 	in_obj.type = ACPI_TYPE_PACKAGE;


