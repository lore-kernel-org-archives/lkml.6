Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A282C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D43D20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXIK2TOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D43D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeKIIEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:04:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeKIHko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:44 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6302120892;
        Thu,  8 Nov 2018 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714594;
        bh=POCkLxyMovQ/ZYSlv5w1K2rUgKxnbcbcr7VWEq7pnvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXIK2TOthxhGc4N64/EWmv0pWeZRiSCJdXs/KEg6O2i2Vj8SV8Kyrj/ecsNULVOZ9
         4NFuXDOiUlj7vJrLHI6aroE2Xwy0MddChin38WaMXl8cUT+tD0noTKywKFHoalVs8S
         PMQXTC0mF6WbObP8qO/c9Pcy8NUAv0/DaQxcuPQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 019/171] qed: Avoid constant logical operation warning in qed_vf_pf_acquire
Date:   Thu,  8 Nov 2018 13:49:49 -0800
Message-Id: <20181108215128.650516042@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



