Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B220847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAZKcvzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3B220847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeKCD6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:45 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4679320843;
        Fri,  2 Nov 2018 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184630;
        bh=OljdPCGDY68t8aTkY2s8VfSjSnI2dAWLy0Y+/xRwWco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAZKcvzY2HDvidDmQQVrVGPvyJlYRIOC1c1qfWSepyJZLcSGfmP2fUzpfba3VYymR
         FmYERVnpXTGWkFL3RUzwlJmMU4X4nbqoiebbrVbDaWgHpoFxod6HLfrTxuQcRhwnTj
         qJdzGsvSYuF4wdbOKiMbZdVo648/DSanl3NwBBkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/143] tools/testing/nvdimm: unit test clear-error commands
Date:   Fri,  2 Nov 2018 19:33:59 +0100
Message-Id: <20181102182901.360525202@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fb2a1748355161e050e9f49f1ea9a0ae707a148b ]

Validate command parsing in acpi_nfit_ctl for the clear error command.
This tests for a crash condition introduced by commit 4b27db7e26cd
"acpi, nfit: add support for the _LSI, _LSR, and _LSW label methods".

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index bef419d4266d..3ad0b3a3317b 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1589,6 +1589,7 @@ static int nfit_ctl_test(struct device *dev)
 	unsigned long mask, cmd_size, offset;
 	union {
 		struct nd_cmd_get_config_size cfg_size;
+		struct nd_cmd_clear_error clear_err;
 		struct nd_cmd_ars_status ars_stat;
 		struct nd_cmd_ars_cap ars_cap;
 		char buf[sizeof(struct nd_cmd_ars_status)
@@ -1767,6 +1768,23 @@ static int nfit_ctl_test(struct device *dev)
 		return -EIO;
 	}
 
+	/* test clear error */
+	cmd_size = sizeof(cmds.clear_err);
+	cmds.clear_err = (struct nd_cmd_clear_error) {
+		.length = 512,
+		.cleared = 512,
+	};
+	rc = setup_result(cmds.buf, cmd_size);
+	if (rc)
+		return rc;
+	rc = acpi_nfit_ctl(&acpi_desc->nd_desc, NULL, ND_CMD_CLEAR_ERROR,
+			cmds.buf, cmd_size, &cmd_rc);
+	if (rc < 0 || cmd_rc) {
+		dev_dbg(dev, "%s: failed at: %d rc: %d cmd_rc: %d\n",
+				__func__, __LINE__, rc, cmd_rc);
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
2.17.1



