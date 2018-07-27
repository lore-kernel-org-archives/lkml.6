Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC8CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428DC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkOO0uk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428DC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeG0Ejn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:39:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45543 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0Ejn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:39:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so1238605pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to;
        bh=oLNGfYlCdSOb8+n/ssJzynpxf6Wyu3GDmLETsKKWvYk=;
        b=lkOO0uk3L9RpNLnUGckI2az6nFwqyCfr2BGp+oM47uryJhDrcEMUo8bo5m9SAAzig1
         omyyTauXCtft+9s41Fyb7OXn/FEjL7Eo4bTZFIOpaRUncVWnwckZTiFIUzvHkVtghmOZ
         bspDNOItfIrt3bcmndT6DgNmT1bjAJItg52sVIDFPx2HU0ozOXfuyIlG6luUhCBbd4ZR
         g5vz24mKb6Numl3wzXSxcCiGVxVVCKk9uArOkk0iHhaDk16mOALX7adpUozr7Pxb8LEA
         Vy29x4nHD2W1l7XYD5zrTzDczVaKFHrpJ1Vp3iLrlzcj7IopiawxogM2rx9SGCtIlPvG
         9h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to;
        bh=oLNGfYlCdSOb8+n/ssJzynpxf6Wyu3GDmLETsKKWvYk=;
        b=rvGBsxT1NwyazdSEGAsT2YCjCsS4FIpiTyFMsawYpJs4i2AwTF/2Spilsk7EoLDraQ
         vtHiCLxhExPDA6OjKbbNUQ40q8XOvO7kYU80FLjUM439tkCO29UVw0S0dBEHf1kZA+4H
         sQCH46j75UljPxPNshv1Ytu0IJ295tzYQ9fGxGhG/gMcvPN7jBVn2d6nmdnhkuVfKjuA
         po3jcwjPpwJRzxKwQEGRKcyEx3FOOx7VKrpOBjOs7Tnt3TxzsKYE/5pkH6KwwmorN+yb
         q8Nrx8axVc6bbTfq76gyPs+a3FSTfA+WMxGs0RMxMCoF3rHpqy2Q3cA8O7DnHhvgFo0V
         V51w==
X-Gm-Message-State: AOUpUlFCHO0uoXFYdpd4KI92FzNOBH7ZnJ0e1EotgsgHjKRMOSSPjwKF
        SA9lNhvVKPR0/c+fGpTcdzw=
X-Google-Smtp-Source: AAOMgpdqBOrMxXbaztZ5gNSzZ7VyWbuax7xMmYnfRzW0r/bWkoWAuyemM09EWQSplqFwjS5knjEQRg==
X-Received: by 2002:a62:3d86:: with SMTP id x6-v6mr4783318pfj.192.1532661597206;
        Thu, 26 Jul 2018 20:19:57 -0700 (PDT)
Received: from localhost (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id e21-v6sm7811731pfl.187.2018.07.26.20.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:19:56 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:16:35 -0700
From:   rd_dunlab <rd.dunlab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH 3/4 v2] arc: fix data type errors in platform headers
Message-ID: <1532661395712@infradead.org>
In-Reply-To: <15326613951079@infradead.org>
X-Mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add <asm-generic/types.h> to fix build errors.
Both ctop.h and <soc/nps/common.h> use u32 types and cause many
errors.

Examples:
../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
    u32 __reserved:20, cluster:4, core:4, thread:4;
../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
   u32 value;
../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
    u32 base:8, cl_x:4, cl_y:4,
../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
   u32 value;

../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
    u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
   u32 value;
../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
    u32 csa:22, dmsid:6, __reserved:3, cs:1;
../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
   u32 value;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
v2: no change

 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180723.orig/arch/arc/plat-eznps/include/plat/ctop.h
+++ linux-next-20180723/arch/arc/plat-eznps/include/plat/ctop.h
@@ -21,6 +21,7 @@
 #error "Incorrect ctop.h include"
 #endif
 
+#include <asm-generic/types.h>
 #include <soc/nps/common.h>
 
 /* core auxiliary registers */


-- 

