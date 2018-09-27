Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2164F2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJnKHun8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2164F2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeI0HeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:34:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0HeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:34:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so772465wrx.1;
        Wed, 26 Sep 2018 18:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gprILtFW4iRcCQHlr8VUKU1MMDfbOAr3oA4iDgJ0DqE=;
        b=jJnKHun8vUVt7ygD9k7utmnh/v+tRH7v2FfEi6tmWPwdOJTL6v/d+WNFFAT2L9+v8q
         sCyJUDLCkz9y4l9H083czFiRYHAc6mQ94pjVnCaIzV47RMt7VLjKE3mWddM785O/26yJ
         S4wLoKY0yybvfIu1t14LInI7zbcHkorz5TPO4X3CnZ3CdReVtZCQ0FwxQGMKaCWinSJF
         GOUHHOnbwqVEKH0fTdpAdja/Sc8GDojvSXD98CNnWRBb0lfI8bMUin198h2mn8gdCojS
         IOH6oPEmXwYcVoqr8oYSraptUREvSt/SU1JIFSZ+0O3uBx/A4ZqXWsp7PIpx5fbPcqmh
         jeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gprILtFW4iRcCQHlr8VUKU1MMDfbOAr3oA4iDgJ0DqE=;
        b=I70Qxn/WiWJ0b0MXVxkEkXjXOZtj7bcedHcwlnTAlU99I+8DDpHZ5rn6yC25sUvpA4
         HveiZRhs38tObqZokXTIyMshH5/QLd3L6PCNtjelZrJZOTfmMVshXymp78vfCamCMB28
         QaQGTQo0Kg+zgEpLAJjpuyLnLrbYWVMl13qgE6IPxOXubpJlVyVlP5IqHEfr2JIZZJpP
         4w7pVL7ySMG5hedYy7LUqqVwn/3WPo3PCcQLz3U2CmDJ6dwSpBrPKjNrtiau6fsrO5oO
         PJNm4Zrv8gLuGBG4jshz6BxVgADeFf23odIkY2JhSX4rIPxD1f5R/2MQJ42uMa0C/gH7
         iJVg==
X-Gm-Message-State: ABuFfoi1id321rPLgh19AiVOhCvbncJOHlFQy3Ec9xL1kccU5LmDmMAG
        KEQg8pHAP/+zepR4MT7fBIg=
X-Google-Smtp-Source: ACcGV60OJQxFUVkhmkj5XMdhyM5X+vEX0A0V1k5+/tH2XNySj7P4uhF+kEo9BdwfdtVlyLsNwTfh6A==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr6602960wrg.24.1538011105720;
        Wed, 26 Sep 2018 18:18:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a105-v6sm1571788wrc.23.2018.09.26.18.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 18:18:25 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] RDMA/qedr: Explicitly cast pkt->tx_dest to qed_ll2_tx_dest
Date:   Wed, 26 Sep 2018 18:18:20 -0700
Message-Id: <20180927011820.13608-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is explicitly converted to another.

drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
        ll2_tx_pkt.tx_dest = pkt->tx_dest;
                           ~ ~~~~~^~~~~~~
1 warning generated.

Avoid this warning by explicitly casting pkt->tx_dest to
qed_112_tx_dest, which has the expected values from the
type qed_roce_ll2_tx_dest.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index 85578887421b..147e0d69003d 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -195,7 +195,7 @@ static int qedr_ll2_post_tx(struct qedr_dev *dev,
 
 	ll2_tx_pkt.num_of_bds = 1 /* hdr */  + pkt->n_seg;
 	ll2_tx_pkt.vlan = 0;
-	ll2_tx_pkt.tx_dest = pkt->tx_dest;
+	ll2_tx_pkt.tx_dest = (enum qed_ll2_tx_dest)pkt->tx_dest;
 	ll2_tx_pkt.qed_roce_flavor = roce_flavor;
 	ll2_tx_pkt.first_frag = pkt->header.baddr;
 	ll2_tx_pkt.first_frag_len = pkt->header.len;
-- 
2.19.0

