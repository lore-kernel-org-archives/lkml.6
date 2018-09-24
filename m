Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104AC004D2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58355214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzbI7ZCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58355214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeIYDfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:35:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYDfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:35:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so11486101wmq.4;
        Mon, 24 Sep 2018 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVI5RGRmIIppj50hOlIob796Ek5C8SVoACA40gxpVMc=;
        b=SzbI7ZCPpoHlFA6RV9Hbrd7euZAnWAXFQpyblAoKp715dLFFUHWEifn5d7duSTP3jq
         /Se5mP+h8bPZrjXgHqgfehilVySfxXuvBLM/keblxNVkxzOM3nyvognBRXvlQc6fMdWk
         00WuqcgjceNKI8xVTRznSbFtqbQoTi5AKFYHbIABm85lAG82CYTHuAFvaUA3mTy8F069
         YAWvCIB1IWEogovjUKdQNZvdG1zxk/Cm22iz/8Ioh9e5ucgEFiv+tTdOtcpH5mHJ6JOu
         6/JBdQPmHo7V7cWxCMCN8yyDTMeWmdcABr93Oik5bki2mBV40QW9cq5ISLknHXjPIPbH
         rASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVI5RGRmIIppj50hOlIob796Ek5C8SVoACA40gxpVMc=;
        b=LBjIzlvHdMaEksKRkW5kgMhct3avpa6i6NUh63cLvBxJrDwgTzTBgmgeYlcRjnbyGI
         v6fVweI3LAaaZFz8iTFTCuuKofeh5flg8UsEFgdcFFehjsmT7LoFFVVp8IAPu6OpRl1B
         Ktm7Mk/MJ/0xW2c1B3Mws1YzB7gdGoBQbXI12ZNP+ioPsoaLqmm7i5BkjQe2u9ivkSyr
         9cWaSmP3e9TgOnYbazVrzcLrtyvAD9fz+5RLha11UU1f8tVP1UkgsKKatXdMAh8N8qc6
         H2SI5PEqn76vAldysRIf/spmVOk/WAQKGmyq/R6RFhk7iyXNarZ5Wo2ZoBGuWzgGCTPJ
         OEUA==
X-Gm-Message-State: ABuFfohOjRaTJx9r3zbVICTTG+4wdS9SJqz+8UAkafsgEM0jVsiZsBNI
        3P5Z4ODTMxjKUT1Dux7Ipag=
X-Google-Smtp-Source: ACcGV60VLC0XhT1wlm4r3j7rN8ZT9RDDp4hw3n/jN22zStfX0e05PhcwJAKMs0SYcixWXFIvQbrEcg==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr142714wmz.79.1537824688389;
        Mon, 24 Sep 2018 14:31:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j27-v6sm139815wmc.17.2018.09.24.14.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:31:27 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
Date:   Mon, 24 Sep 2018 14:31:20 -0700
Message-Id: <20180924213120.18979-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_roce.c:153:12: warning: implicit
conversion from enumeration type 'enum roce_mode' to different
enumeration type 'enum roce_flavor' [-Wenum-conversion]
                flavor = ROCE_V2_IPV6;
                       ~ ^~~~~~~~~~~~
drivers/net/ethernet/qlogic/qed/qed_roce.c:156:12: warning: implicit
conversion from enumeration type 'enum roce_mode' to different
enumeration type 'enum roce_flavor' [-Wenum-conversion]
                flavor = MAX_ROCE_MODE;
                       ~ ^~~~~~~~~~~~~
2 warnings generated.

Use the appropriate values from the expected type, roce_flavor:

ROCE_V2_IPV6 = RROCE_IPV6 = 2
MAX_ROCE_MODE = MAX_ROCE_FLAVOR = 3

While we're add it, ditch the local variable flavor, we can just return
the value directly from the if statement.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_roce.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index 7d7a64c55ff1..f9167d1354bb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -140,23 +140,16 @@ static void qed_rdma_copy_gids(struct qed_rdma_qp *qp, __le32 *src_gid,
 
 static enum roce_flavor qed_roce_mode_to_flavor(enum roce_mode roce_mode)
 {
-	enum roce_flavor flavor;
-
 	switch (roce_mode) {
 	case ROCE_V1:
-		flavor = PLAIN_ROCE;
-		break;
+		return PLAIN_ROCE;
 	case ROCE_V2_IPV4:
-		flavor = RROCE_IPV4;
-		break;
+		return RROCE_IPV4;
 	case ROCE_V2_IPV6:
-		flavor = ROCE_V2_IPV6;
-		break;
+		return RROCE_IPV6;
 	default:
-		flavor = MAX_ROCE_MODE;
-		break;
+		return MAX_ROCE_FLAVOR;
 	}
-	return flavor;
 }
 
 static void qed_roce_free_cid_pair(struct qed_hwfn *p_hwfn, u16 cid)
-- 
2.19.0

