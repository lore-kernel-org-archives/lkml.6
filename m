Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2720837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYhA+nEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeKCDrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeKCDrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:23 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914282082E;
        Fri,  2 Nov 2018 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183952;
        bh=/+GnNQuiPzJT7F31plplVNo/CDxa4Y7tExdieqDhY1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYhA+nEGJeMwMF/OjSYCnDyE/xFWoiNpoWHApkB3/NfP9VxrmYQUUEFKZa/0DtGB2
         xos/44hGp84nIqyX+97zT38O7m4DUY4cnfKOXpkjYMhsCQtrFjaaZlYb+aSPiZWvbc
         meFt6xib6OuToKebcLMv+GnYJoDM14mgNeJMlG6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 032/150] qed: Avoid constant logical operation warning in qed_vf_pf_acquire
Date:   Fri,  2 Nov 2018 19:33:14 +0100
Message-Id: <20181102182905.579618976@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
index ac3f54bbe9b9..c4766e4ac485 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -413,7 +413,6 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	}
 
 	if (!p_iov->b_pre_fp_hsi &&
-	    ETH_HSI_VER_MINOR &&
 	    (resp->pfdev_info.minor_fp_hsi < ETH_HSI_VER_MINOR)) {
 		DP_INFO(p_hwfn,
 			"PF is using older fastpath HSI; %02x.%02x is configured\n",
-- 
2.17.1



