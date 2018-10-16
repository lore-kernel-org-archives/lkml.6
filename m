Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30747C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz4oByVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24F020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeJPMEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbeJPMEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110C1214C3;
        Tue, 16 Oct 2018 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663343;
        bh=nTg5CTeDmKTs5gF6cDU1w9G0DtBl7UnSx8ETYBSKIEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tz4oByVY6nBD6aMy/VOaWdD1BmRt7HBzH9VWIb4sxTKUXEUSTVuIrHcdQGclSYmsN
         mELQ2chSdgd4dEfn9STEJk7sKboU3tyyu4yR/Xsp2a+jDuu5Ofki8osfbjecj3U8Zh
         8mRcexGrfYXjToDLiEWzmv3OROcRejHO7mLWq4ck=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 21/38] qed: Avoid constant logical operation warning in qed_vf_pf_acquire
Date:   Tue, 16 Oct 2018 00:15:05 -0400
Message-Id: <20181016041522.135789-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 1c492a9d55ba99079210ed901dd8a5423f980487 ]

Clang warns when a constant is used in a boolean context as it thinks a
bitwise operation may have been intended.

drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: warning: use of logical
'&&' with constant operand [-Wconstant-logical-operand]
        if (!p_iov->b_pre_fp_hsi &&
                                 ^
drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: use '&' for a
bitwise operation
        if (!p_iov->b_pre_fp_hsi &&
                                 ^~
                                 &
drivers/net/ethernet/qlogic/qed/qed_vf.c:415:27: note: remove constant
to silence this warning
        if (!p_iov->b_pre_fp_hsi &&
                                ~^~
1 warning generated.

This has been here since commit 1fe614d10f45 ("qed: Relax VF firmware
requirements") and I am not entirely sure why since 0 isn't a special
case. Just remove the statement causing Clang to warn since it isn't
required.

Link: https://github.com/ClangBuiltLinux/linux/issues/126
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index faf8215872de..9cc02b94328a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -295,7 +295,6 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	}
 
 	if (!p_iov->b_pre_fp_hsi &&
-	    ETH_HSI_VER_MINOR &&
 	    (resp->pfdev_info.minor_fp_hsi < ETH_HSI_VER_MINOR)) {
 		DP_INFO(p_hwfn,
 			"PF is using older fastpath HSI; %02x.%02x is configured\n",
-- 
2.17.1

