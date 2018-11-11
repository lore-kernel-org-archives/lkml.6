Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B925C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5281D20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUe79TIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5281D20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbeKLJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389805AbeKLIVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C9421508;
        Sun, 11 Nov 2018 22:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975502;
        bh=YMKIStaQhy9Gn0ZMng426efkQakJREPzwKy+6xa3Bes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUe79TIV3rWJIBzN7LcpFk4j3LmZvc/24GE1DDVtsozd08dddy/mN0WFwSJiWpw5S
         AieZjiU1bXWm69Z4MfMUVyDC+B+1NStDpyxegggE2XZ8AyFalLf8jnRVzWYHnfoocN
         RR95MJJA5FMXAQyQZvQZsAvZReNTmpqzs7ME+m+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 281/350] ocxl: Fix access to the AFU Descriptor Data
Date:   Sun, 11 Nov 2018 14:22:25 -0800
Message-Id: <20181111221719.805278026@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

commit 6f8e45f7eb1bee5efdbe4a9cfe4a45627403c5fb upstream.

The AFU Information DVSEC capability is a means to extract common,
general information about all of the AFUs associated with a Function
independent of the specific functionality that each AFU provides.
Write in the AFU Index field allows to access to the descriptor data
for each AFU.

With the current code, we are not able to access to these specific data
when the index >= 1 because we are writing to the wrong location.
All requests to the data of each AFU are pointing to those of the AFU 0,
which could have impacts when using a card with more than one AFU per
function.

This patch fixes the access to the AFU Descriptor Data indexed by the
AFU Info Index field.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable <stable@vger.kernel.org>     # 4.16
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

---
 drivers/misc/ocxl/config.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -280,7 +280,9 @@ int ocxl_config_check_afu_index(struct p
 	u32 val;
 	int rc, templ_major, templ_minor, len;
 
-	pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
+	pci_write_config_byte(dev,
+			fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
+			afu_idx);
 	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
 	if (rc)
 		return rc;


