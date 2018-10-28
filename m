Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA40ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 05:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664D520843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 05:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlh0LbeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664D520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ1NtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:49:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40725 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJ1NtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:49:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so2330716pgv.7;
        Sat, 27 Oct 2018 22:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQRNSRkV9z4WNIdjaLY9i0qg12mEN0L4/QUSkqscBJc=;
        b=nlh0LbeWBVmFOCYDkz822bKrreorkgbqXYeqW0xmLAw5VlJOWRxuH5YH48Q60qcBpX
         sadFrzxv1+xIDA89b+IIgkvKHWoqfkk80iqvdWOH9kacL4BF82BnlnyNbmRugEdLnDO1
         Kit0T/OMR0k9A6OUeBo/5Dfu+yUtcKTESRdnjHGV+JL7ats2G1ixe8Yif1vGnLqW3/Af
         84jsHl7g3nbd0obqFpH/l7DT5qpM80NGcTkJ8gyD3lUNlRwdQKXswj40KxckfVWSWkUN
         HB4lFH+UisGJidUzZbJoFO8jdHMr0WgVdsVgnMdCpEpQ8QneCjuYGj8pQFiuMHaC44iH
         gMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQRNSRkV9z4WNIdjaLY9i0qg12mEN0L4/QUSkqscBJc=;
        b=ooQidMZffq5xX9bG5vs4Ir+Orqjks7IZxriLWikGGG/o1HBfTomhHsY0CJo+Vl505J
         pLHFso+L7fCtnH5q+NNV/9P+Z/N2WXE3l6452iJExWo91KeODYF/i0awSAzDDgeXCBn5
         cUw8KcLJtPLFudpZH4dqbZnuWtd+zrblVNGcpFwqMqfrJfeUuK3HtUQgVBXQRXiPUcKs
         gaBVSF7YecZUFQtXF3iETFcviDWxLmz42cnPZ+j50EGxbrnlyZtm4XTPupCx6zfft7Jh
         2APb0NY9T+/Hs8ACF3srbAiZZUKHkJ1wv3huRCXQcUJUgZhsoC5DzcqqE26GoDmpisZa
         L26Q==
X-Gm-Message-State: AGRZ1gK1KX//GVVSb1atZTOGGTYuhSwxQdgRPDdtEkxXjXLnWXEk5AOw
        OiKT0EtkUEA4pQ9lFzgAzdM=
X-Google-Smtp-Source: AJdET5czfNEXGcbODGmW8lRccsuNK9jiap9lkLmEUnJz0Rr7uC6qWI8ivintPj5hhEeakPzhVeasHQ==
X-Received: by 2002:a62:2741:: with SMTP id n62-v6mr10112175pfn.138.1540703156119;
        Sat, 27 Oct 2018 22:05:56 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id 7-v6sm17871449pgk.31.2018.10.27.22.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 22:05:55 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 4C82E200FB5; Sun, 28 Oct 2018 14:05:52 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-scsi@vger.kernel.org, himanshu.madhani@cavium.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] scsi: qla2xxx: Fix a typo in MODULE_PARM_DESC
Date:   Sun, 28 Oct 2018 14:05:48 +0900
Message-Id: <20181028050548.3147-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.1.450.ga4b8ab5363a3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in MODULE_PARM_DESC
of ql2xplogiabsentdevice.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 8794e54f43a9..d9349408bf70 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -67,7 +67,7 @@ module_param(ql2xplogiabsentdevice, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xplogiabsentdevice,
 		"Option to enable PLOGI to devices that are not present after "
 		"a Fabric scan.  This is needed for several broken switches. "
-		"Default is 0 - no PLOGI. 1 - perfom PLOGI.");
+		"Default is 0 - no PLOGI. 1 - perform PLOGI.");
 
 int ql2xloginretrycount = 0;
 module_param(ql2xloginretrycount, int, S_IRUGO);
-- 
2.19.1.450.ga4b8ab5363a3

