Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3854ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85494208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="c5B5+mCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85494208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeGMJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42729 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMJDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so10642229pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jU3SvxQclyebK3RGIKbFsj3VaH+vViC37wh1DjUWUJU=;
        b=c5B5+mCmL2F/ypkpzfikDZU83FjbXy6zMiclqdkXfrR2HOVkYz+o3WYJimiYhF4Ssg
         cdEupkvox3XywFYdQ4JMAjDrZQIRxnCR9dUJmH22pfhAha5lTeNcM1W23Jk8JkcqsCkM
         hiDcM05IFnxWQbO3sED43fDKrkz8IdokxAUIULpygaBb95rYzj00iwrXfGn0Nb2hTVPY
         tRgyoPTf8zwblG/qVQSsXAHagUzZvRdk8yLktbpX+kyHW801B42yW59z22CxrC5wOjBf
         j+BHdHC4rhvpT4C/VjAVzPIbGaKG1nD3smY/N+OzpKATQ9firA08Zr1jt/MsiFtagsGm
         4ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jU3SvxQclyebK3RGIKbFsj3VaH+vViC37wh1DjUWUJU=;
        b=dD4yM7R4WhzUctwC15c7GmXWfpcdDes/QC4kHGsS0F0X9gE0p14U5xsUhGZvoMSZ6f
         1/D3Gj06NuVQ9BauI/Y/y/8TPRqITBM38OjxEYICMK6PVNhYtMa5KU50cazQ7rsOb0q9
         +H6USf/Yjnp28S8wk8DlxJj3XXB/iqIvlA0HS1a1lhRJebBg8HDZvskJUI9vz4Qk+1WV
         TmirkUYEvMKdvVIzPSnzveA0fjhDALPQUziYpRk3uZ3eToAZZF6GfItj+fUAm8L/gIBj
         hq9qlixXJA0rGtdXhxuexYG5hgCvzQIYwcWYB7y5pLUMdT17eIA3KcEkemWcb2kTOgMf
         l8Lg==
X-Gm-Message-State: AOUpUlEhvFeSYwggpzKzrzEQ0LpfE6pn87h4QfT8P/ud4xLNaXLhLa1Y
        O4ojpEhF1DJeY4KmcFZ5SlREn2Y0
X-Google-Smtp-Source: AAOMgpdy4m/L+PvtIhvvuOteD2cizJhslft8AVwqhGu9KywxcP+Ucr54e6zS6uUMdfFsfVEkrJE7UA==
X-Received: by 2002:a62:a8e:: with SMTP id 14-v6mr6055284pfk.57.1531471765455;
        Fri, 13 Jul 2018 01:49:25 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:24 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 04/10] lightnvm: Remove redundant rq->__data_len initialization
Date:   Fri, 13 Jul 2018 10:48:39 +0200
Message-Id: <20180713084845.19511-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Since both blk_old_get_request() and blk_mq_alloc_request() initialize
rq->__data_len to zero, it is not necessary to initialize that member
in nvme_nvm_alloc_request(). Hence remove the rq->__data_len
initialization from nvme_nvm_alloc_request().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/nvme/host/lightnvm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..a76db8820f1c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -662,12 +662,10 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
-	if (rqd->bio) {
+	if (rqd->bio)
 		blk_init_request_from_bio(rq, rqd->bio);
-	} else {
+	else
 		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
-		rq->__data_len = 0;
-	}
 
 	return rq;
 }
-- 
2.11.0

