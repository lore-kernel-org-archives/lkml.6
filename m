Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF43120661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107253;
	bh=NmrluGN++YiEVBbX3BYHqRPc9fIUmYPyX/5aH717/fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t830kdzhUhwVujhIj9aPlgPasPYTFkFy9pFaex+IDd5G7eGkE8Y+u7GwO0xQSepIp
	 d2oib0KyifRHtomEhCYfYAv4PzlO/wRbkNmEtxe0TLHhTG/2OQX5GW1xI0ifVf6NmS
	 nNRQmOiav+Mk8Cudgh3jCyvNS+YnsFGhWOqe126Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF43120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeLFOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbeLFOku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4C220661;
        Thu,  6 Dec 2018 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107249;
        bh=NmrluGN++YiEVBbX3BYHqRPc9fIUmYPyX/5aH717/fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCHPVOPED6qLngmnS8P2/wePQdRtoxki5Z2gsHFBt+cyi3PiSfcNN7scWilVDFxyQ
         2UjZDB/qSoNitWuTUeVjM2mKdy+7QCUak4FoW5v7i4IkoGAN0UFPNOtdASJIXGRh+L
         8zND+lbZAKiIvrLLLJL1FmmRLIFW+EyHE35cthWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Bond <dbond@suse.com>,
        Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 30/41] scsi: lpfc: fix block guard enablement on SLI3 adapters
Date:   Thu,  6 Dec 2018 15:39:10 +0100
Message-Id: <20181206142952.490759327@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Martin Wilck <mwilck@suse.com>

commit dfb7513374c1f8e7cd595106fbdba3fd07ebaf30 upstream.

Since f44ac12f1dcc, BG enablement is tracked with the LPFC_SLI3_BG_ENABLED
bit, which is set in lpfc_get_cfgparam before lpfc_sli_config_sli_port() is
called. The bit shouldn't be cleared before checking the feature.  Based on
problem analysis by David Bond.

Fixes: f44ac12f1dcc "scsi: lpfc: Memory allocation error during driver start-up on power8"
Tested-by: David Bond <dbond@suse.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Cc: stable@vger.kernel.org # 4.17.x
Cc: stable@vger.kernel.org # 4.18.x
Cc: stable@vger.kernel.org # 4.19.x
Reviewed-by: Hannes Reinecke <hare@suse.com>
Acked-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc_init.c |    6 +++++-
 drivers/scsi/lpfc/lpfc_sli.c  |    1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -167,7 +167,11 @@ lpfc_config_port_prep(struct lpfc_hba *p
 		       sizeof(phba->wwpn));
 	}
 
-	phba->sli3_options = 0x0;
+	/*
+	 * Clear all option bits except LPFC_SLI3_BG_ENABLED,
+	 * which was already set in lpfc_get_cfgparam()
+	 */
+	phba->sli3_options &= (uint32_t)LPFC_SLI3_BG_ENABLED;
 
 	/* Setup and issue mailbox READ REV command */
 	lpfc_read_rev(phba, pmb);
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4969,7 +4969,6 @@ lpfc_sli_config_port(struct lpfc_hba *ph
 		phba->sli3_options &= ~(LPFC_SLI3_NPIV_ENABLED |
 					LPFC_SLI3_HBQ_ENABLED |
 					LPFC_SLI3_CRP_ENABLED |
-					LPFC_SLI3_BG_ENABLED |
 					LPFC_SLI3_DSS_ENABLED);
 		if (rc != MBX_SUCCESS) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,


