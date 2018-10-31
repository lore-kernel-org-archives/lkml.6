Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kf8+c6Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C727D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeJaWWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so14557973wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ejdq2iAILhXuBUzBm5b1+5FdxwkTFXYLi2UC8hcWNRQ=;
        b=Kf8+c6Q102OvZvnTwjj50CdT9IfffMtzPGIY+oCBNs2T1u3rtVgD4lq0peAaDuCQpH
         P+Mvx8ob870aZX2EJaWLvFjmB9mKWCVRPnd28fVb1yDXiS+Uc/PP1WSKsxIGhotmrn/e
         d6kwOY6WBHxlc02dhOSMPvZtEFUNOZBSLyadk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ejdq2iAILhXuBUzBm5b1+5FdxwkTFXYLi2UC8hcWNRQ=;
        b=MuEjFp3ddV5F07IAuqPj+fG4TpLCNSRHoxkZVBSk9Kck36J5NLw4wuwSOtb2HxHkkG
         7L31EYhJAUHmatAOYz5Y15T/DdzXLjNBbppOqKd1in4h5fRC0bKuVKxEoH+t3A9yl/BY
         UpP42Wn/aVI5/XbSNQ01xKLzs24uIwmQwpyFjNjD99E9agDitz3OEmGPhBqWhsUlEcGc
         aYumpFIPT6wJjEYOvl8QezZgSvSJ0xDKjF60Jzm+KASwbtO6TYDHzGhwLDhTPr/LECbb
         DDhsrNscxp8ut4r3RpVo5zbMyTap2f47C2F+cYueXHhjO3GCn7Hv121cAmZpFwAhvto4
         4DBw==
X-Gm-Message-State: AGRZ1gIpSSLHdh4YZjolstpatp+ow9BktYsLBDrhGTlZYT1h53AHPhDX
        Gg2Ti92i8hqFNWNro92/WTT+UQ==
X-Google-Smtp-Source: AJdET5cgS67HPw9NbceOniS8Yv9iCAHa90PIgYODhS8OKx+Wh7VgKCGjle4Bg3NnCTTQnsXfOlr4RQ==
X-Received: by 2002:a1c:4601:: with SMTP id t1-v6mr2336964wma.102.1540992288664;
        Wed, 31 Oct 2018 06:24:48 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:48 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 7/8] mpt3sas: Fix driver modifying persistent data in Manufacturing page11
Date:   Wed, 31 Oct 2018 18:53:38 +0530
Message-Id: <1540992219-20291-8-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently driver is modifying both current & NVRAM/persistent data
in Manufacturing page11. Driver should change only current copy of
Manufacturing page11. It should not modify the persistent data.

So removed the section of code where driver is modifying
the persistent data of Manufacturing page11.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_config.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index 257b66f..8516713 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -658,10 +658,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
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

