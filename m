Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC34CC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6048C214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTLUQof7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6048C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeHCB5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:57:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40386 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbeHCB43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so1554689edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Beh5lPorbHYEdDbjs2kr2Y/D0hiji4w8pZxP6kxv7fI=;
        b=qTLUQof7Ys0cePeFyCmlCrirW8k1kpnY8XxKBLNrb+xPMucnxitC2KEyi3wX6KE02H
         7MTQSNku+JF0aONKF6EGougptnS12x/hqNlVhIrFgKt4xTMGTU15l1fMRf7TsZVzTMvc
         NmdCRj/4V4VwwRBceLAJCdJdnBduVoESF1ct8/LE1i6qwtTA/mXGhjMV8Xcc7pHmi9ls
         L/Mh4uaENpX07yXJfLIlseS6n/LUc8PKRW0T3mPf+H5xPIx6v9IGers3ycXwtLVuCGm6
         ocjxzRjFUAUTEDYa8nqJeLfE52XRoikW8qaoDxcs1S9VWQ4kWeWBn5S9lgJzivKYksKh
         D4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Beh5lPorbHYEdDbjs2kr2Y/D0hiji4w8pZxP6kxv7fI=;
        b=lt4JN4vH7fDXCbhgpgg4BryBojM1cg/iEZfm14Rp4ZIqfjS4/Z87YXCp+ZXZdD4ts/
         uTaTE9QPwd6cIojTZmEMMm52JriUi0jQ8TVSYAjQbl1H2BYHaa1aGr8daE72xRhT0ET4
         ZsweQx21PhSrnNFbuEQWuUmbyarJ2YsRAvZiFGoRT1+oRmUrGQaQRsisM77E0HpeOEMB
         iiI5ZrDXZzIr7SZ0Rf2gzcoJMRSVXkF9wACytcpfqgUibY5Epq9N2DlKNRaM3dnBQR/t
         8cUVHji+ScLu+RMfymH8ldv6TY9mnt7da5QeSOsfvq+xYAAkJjK7+4lqXOoa4voEVnDT
         l6fw==
X-Gm-Message-State: AOUpUlGRlZ9gdoGVuWYNRHDebknUkJi6IFauo+d4DZSv6GlTjCW5WJ1e
        rgId5EV6Ycb1+2h93FEJ1TzpRXxe
X-Google-Smtp-Source: AAOMgpc66Dj+p6RHXddaD0INabge/IfqpL8AXuN2D3XKZdWghS1RLaA718XH7Tiv3Sf1rW2NXqrUiA==
X-Received: by 2002:a50:9935:: with SMTP id k50-v6mr5024908edb.45.1533254576709;
        Thu, 02 Aug 2018 17:02:56 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/18] staging:rtl8192u: Remove member reserved - Style
Date:   Fri,  3 Aug 2018 01:02:04 +0100
Message-Id: <20180803000211.10589-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure dynamic_rx_path_sel contains a u8 member variable called
reserved. This member variable is never actually used in the code.

The naming suggests that the sizeof the structure is significant but
the only use of the structure is a local static in r8192U_dm.c:

static struct dynamic_rx_path_sel DM_RxPathSelTable;

There is no apparent significance to the sizeof the declared structure
DM_RxPathSelTable. As a result the reserved member variable has been
removed from the structure.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 74742cb27a2c..66dfcbbf6e43 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -133,7 +133,6 @@ struct dynamic_rx_path_sel {
 	u8		cck_rx_path;
 
 	u8		disabled_rf;
-	u8		reserved;
 
 	u8		rf_rssi[4];
 	u8		rf_enable_rssi_th[4];
-- 
2.18.0

