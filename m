Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B7AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E522054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aCd519UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E522054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeJaWWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55279 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so15147403wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K8bdmzdCD6/FVEJbWcsk91/Cm0CMVZCwrsR7PwgulYk=;
        b=aCd519UPQ3hny7OwIL0tPOJ9jQrRpRaN99lvq6dcoDQGJ2YQDXLDMUjPriUVDyGs/V
         bMNgMT7xS+u9BtcUKpztOcRi8qG0YSNihqLJsrk1ounANOiGMZR37301tkrCqiFo42+T
         mYXP7aTmQxFatF95xDDybbdfd+m9iGLJWCyJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K8bdmzdCD6/FVEJbWcsk91/Cm0CMVZCwrsR7PwgulYk=;
        b=c7E9OoZZTcZmYjTj/t2+j2XUCt4PtNB3aoYBxvU+E6xmzkWh8RpMIxxfFha4ytM+Id
         WccEAWhfvnJa++nOL62nrFVX9Gx1QVDjM2/9R4Qc3UiHF+JarrrQ+463qplQpz5awWoJ
         Ice2G6HQGE7aM1EqZttPNcU20SisY3J1Tcm/UiNhpUMmxoOIETh+JZot2cqQ6eKjQ7Co
         DCnsKcIpgXFB1Qpt5B1OclNfqfUgOJBwThkrh+63/qsi7KdfxKu4JwZ4V0wQwGgqEIY5
         W1qm+2kOkgT5Gt0M76RVgzClMnA65k2IHfmO3TUD7SwDCDigDqZ/Ubn6NcM93nR1qNPj
         nSjA==
X-Gm-Message-State: AGRZ1gJTWLzMyjSAL/v2X+P7Y7defQbuvYQZwVjud1x15pO47h0eDlUd
        lloN/kiVGFFDULmn5xU4AdYRLg==
X-Google-Smtp-Source: AJdET5e8/gm7++C/MyadgRZds0fXtouCUjkFHm/N1wSx6Sx1yccS7ErsyciEiHetzpMv4OVsTE5EAQ==
X-Received: by 2002:a1c:b645:: with SMTP id g66-v6mr2468155wmf.25.1540992285107;
        Wed, 31 Oct 2018 06:24:45 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:44 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 6/8] mpt3sas: Don't modify EEDPTagMode field setting on SAS3.5 HBA devices
Date:   Wed, 31 Oct 2018 18:53:37 +0530
Message-Id: <1540992219-20291-7-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If EEDPTagMode field in manufacturing page11 is set then
unset it. This is needed to fix a hardware bug only
in SAS3/SAS2 cards. So, skipping EEDPTagMode changes
in Manufacturing page11 for SAS 3.5 controllers.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index f25bc3c..9254b52 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4060,7 +4060,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	 * flag unset in NVDATA.
 	 */
 	mpt3sas_config_get_manufacturing_pg11(ioc, &mpi_reply, &ioc->manu_pg11);
-	if (ioc->manu_pg11.EEDPTagMode == 0) {
+	if (!ioc->is_gen35_ioc && ioc->manu_pg11.EEDPTagMode == 0) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
 		ioc->manu_pg11.EEDPTagMode &= ~0x3;
-- 
1.8.3.1

