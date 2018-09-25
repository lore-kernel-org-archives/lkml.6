Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72C8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AE208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpZGCWvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0AE208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIYRoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:44:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43847 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeIYRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:44:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id v18-v6so3660865qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=31SLiP4UwANgmEvkVjx1GNSM/O3fw/xJF5X/bSbwIpY=;
        b=BpZGCWvQ7HXfAMIItzBDOAb+SddBm9Hlfo0svYDHTTx8XfH9vxGkmTHm4xWVmJelID
         ngZ2xMdK1XJlJhYtnTH5bmndmxHIK258x9h4COjcxPMojWohuorawdOGpzkqpT+9Wa+S
         2Ydg8DSRUMUQKPIi4nne5IZUXM65GQNaoHANrr2Ebmy+jIIJC1v1pqVIUdRucZZ/iYRf
         Un42CuA5o7UG+iOp+6aDi5l1X76s64pJ4gDH9mtPXDDRItzOPHRMSX23ApjgNQYg/zTQ
         HwouMr7oMgMxZvD3ug31QofTz67qyiASXool9aDDytcqOAmkua9FDUFH2vxZknnnUasC
         5Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=31SLiP4UwANgmEvkVjx1GNSM/O3fw/xJF5X/bSbwIpY=;
        b=qVdL7LzgBMair0vOL1wkSw4lteSP+X/8uFVXqfhRPy04h4V9ObhFDnDIMmaufy0Nho
         XqLAnHBvkv/Pj4TDLjhumAWNircv+76JzQnru8PKNmwWsMGUmBLExT5NE7qbDAhdSCyK
         oFpoCpbfk+YIoI9IOWesuusSZWw2CUSkX9IRSniKLBpswj1lTNFju9ayPTnrvXuIXv1W
         N/trrDX3+FH3UAr2hM38ThYW2lbYysvv0sk5ymX1+ZFTdKLxFjgxr/ty8lALn1JU/llS
         9bdbctav7DuAEZnfamz5QMkk4cvjKmCvXIIzDG646t0+NSEdIa6KmKSwm2zsHYQFMxKd
         dCFA==
X-Gm-Message-State: ABuFfogGTIKPMQ8lThaO4//HbFoqrHW/5/XOTn76mB5363wpc6eDnO2s
        STp0k6IXsKF0avF4boACklU=
X-Google-Smtp-Source: ACcGV62Jbt9q//aoeXZLt7dFBnhzZQpmnRthXm7yKlkl13yPp0xAHrLjI56QiG+Oyo2mfs+Hprh+ZA==
X-Received: by 2002:a37:14d4:: with SMTP id 81-v6mr355936qku.201.1537875436716;
        Tue, 25 Sep 2018 04:37:16 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:1d94:9684:2890:372c])
        by smtp.gmail.com with ESMTPSA id t29-v6sm1356221qkt.44.2018.09.25.04.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 04:37:15 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        Jason Andryuk <jandryuk@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xen: Make XEN_BACKEND selectable by DomU
Date:   Tue, 25 Sep 2018 07:36:55 -0400
Message-Id: <20180925113655.4501-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XEN_BACKEND doesn't actually depend on XEN_DOM0.  DomUs can serve
backends to other DomUs.  One example is a service VM providing network
backends.

The original Kconfig defaulted Dom0 to y and it could be disabled.  DomU
could not select the option.  With the new Kconfig, we default y for
Dom0 and n for DomU.  Either can then toggle the selection.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2: omit superfluous "y if" per Jan Beulich
---
 drivers/xen/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b459edfacff3..692e82fcad1f 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -101,8 +101,7 @@ config XEN_DEV_EVTCHN
 
 config XEN_BACKEND
 	bool "Backend driver support"
-	depends on XEN_DOM0
-	default y
+	default XEN_DOM0
 	help
 	  Support for backend device drivers that provide I/O services
 	  to other virtual machines.
-- 
2.17.1

