Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6B621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298261;
	bh=lafk3JEsh7IKdb/r+9BFetEAaYAY6G0Jmlnc2bD8i1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/DzX/OmCBAktANLXSqCx6xkPddV7xBOPl6Bhk1J0P4SSRC2j03UQIKZ147sSZVFw
	 2Ty+P101VeSLsgVVc3SrPBSQDgimfLP7SgBKiR16cHg/MgVT62eqwfXFDQaDcH1zNC
	 u0OEr2nnWXu2P1bEG8TReehfm9cZoyBlskLhyDh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeLTJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732324AbeLTJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFBB20656;
        Thu, 20 Dec 2018 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298256;
        bh=lafk3JEsh7IKdb/r+9BFetEAaYAY6G0Jmlnc2bD8i1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQOPHFx2XwuyyBcHkM3K9kuAwtSIWBE1Joc+M5sUZNUGSAotDuf25dmuD0A9KheoH
         aR/rHhsrDFnHMxhOkmUhM4CJJ4ajuwN5JmacIY7xwfZU4fKgPgqtwb+hLPPRJj242Z
         Hdf40O1O+NovVp97dujeWsJ4Iv7Sahe8p1TL+NBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Zloch <jacek.zloch@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 56/67] acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-short"
Date:   Thu, 20 Dec 2018 10:19:08 +0100
Message-Id: <20181220085905.761330742@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit b5fd2e00a60248902315fb32210550ac3cb9f44c ]

A "short" ARS (address range scrub) instructs the platform firmware to
return known errors. In contrast, a "long" ARS instructs platform
firmware to arrange every data address on the DIMM to be read / checked
for poisoned data.

The conversion of the flags in commit d3abaf43bab8 "acpi, nfit: Fix
Address Range Scrub completion tracking", changed the meaning of passing
'0' to acpi_nfit_ars_rescan(). Previously '0' meant "not short", now '0'
is ARS_REQ_SHORT. Pass ARS_REQ_LONG to restore the expected scrub-type
behavior of user-initiated ARS sessions.

Fixes: d3abaf43bab8 ("acpi, nfit: Fix Address Range Scrub completion tracking")
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index c5d15752dfb3..75b331f8a16a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1303,7 +1303,7 @@ static ssize_t scrub_store(struct device *dev,
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-		rc = acpi_nfit_ars_rescan(acpi_desc, 0);
+		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
 	}
 	device_unlock(dev);
 	if (rc)
-- 
2.19.1



