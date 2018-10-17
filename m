Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30310C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9A5214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C5hM8wTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A5214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJQNxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46371 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJQNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:53:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so9877632ybk.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 22:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PkfXlMZupblJe1vzCW6LkLbmNH7XcD5/rnzvalEdrPs=;
        b=C5hM8wTQfQ0iKNgAEtDRnTrUUgXgugDdBnjLKV5JC6viEbW1SfMbVzS9faAT+T2RhY
         TRXNTo7TiNHDgbFQ8UAvVrJkJVTzXOJ36bkk0u0iQU2P7BPjRaEK5oKp31NXY8GL1HWy
         o5nzH6OLMyYJg1cqHp7yIjslMrxPxwrIcFDH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PkfXlMZupblJe1vzCW6LkLbmNH7XcD5/rnzvalEdrPs=;
        b=MHymyi0YTlMIxw6T2wXBEl9HRCj3y1nJECnx5FadaCFZ4AIV7DcIpwKiJIpFQtj+8X
         PPHdW5CyQdnaFYfkE1F+9gYqk+9MOTiCnQDJ/g60RToAoB3qK+gNtpnOLHDmxNYsXKik
         0mc5fbhXIkkPzqGu/q5UOnWuJbzeR/yJTmcwEGJN6k29x8vIPYjTMKW0wwhbytRqFlpN
         tMzSRIqsWkQf48ffaQLjE8y/g+pLvkz6ImzNzntceMs3b3BrQFw5W8AxYizenOX1VFN2
         wsZ5CGAnrg1aXSZfg6q32b4GoqoEhN5uWCd7ITSijD3A1mElYn5FhUfRtX5I/Br1B2EM
         P8VQ==
X-Gm-Message-State: ABuFfoiVEbh1AlZMG65PLTgL14Bk7SHQ7N0/zbQnzWGBeu20aC4l0Eo0
        V8W87MHf3NmgO4SUQzqvOSMz8gjIJD4=
X-Google-Smtp-Source: ACcGV62xhmptM5KLCZuaa7HJcBiE75CyMSXbGl754fV9kZvfIMxXN6oBBkPePrqHwwAjWNZnzBNdJg==
X-Received: by 2002:a25:8745:: with SMTP id e5-v6mr5177694ybn.119.1539755975409;
        Tue, 16 Oct 2018 22:59:35 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y1-v6sm3930329ywf.34.2018.10.16.22.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 22:59:34 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        andy.shevchenko@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [v5 3/4] mpt3sas:Fix driver modifying persistent data.
Date:   Wed, 17 Oct 2018 11:29:06 +0530
Message-Id: <1539755947-27014-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* If EEDPTagMode field in manufacturing page11 is set,
unset it. This is needed to fix a hardware bug
in SAS3/SAS2 cards, So, skipping EEDPTagMode changes
in Manufacturing page11 for SAS35 controllers.

* Fix driver modifying NVRAM/persistent data in
Manufacturing page11 along with current copy. Driver should
change only current copy of Manufacturing page11.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a6c217c..770f52b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4062,7 +4062,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 	 * flag unset in NVDATA.
 	 */
 	mpt3sas_config_get_manufacturing_pg11(ioc, &mpi_reply, &ioc->manu_pg11);
-	if (ioc->manu_pg11.EEDPTagMode == 0) {
+	if ((!ioc->is_gen35_ioc) && (ioc->manu_pg11.EEDPTagMode == 0)) {
 		pr_err("%s: overriding NVDATA EEDPTagMode setting\n",
 		    ioc->name);
 		ioc->manu_pg11.EEDPTagMode &= ~0x3;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 14a195c..aa41cb9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -660,10 +660,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
 	r = _config_request(ioc, &mpi_request, mpi_reply,
 	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
 	    sizeof(*config_page));
-	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_WRITE_NVRAM;
-	r = _config_request(ioc, &mpi_request, mpi_reply,
-	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
-	    sizeof(*config_page));
  out:
 	return r;
 }
-- 
1.8.3.1

