Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A765C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E69420818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qen99xgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E69420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeKIHko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbeKIHkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:43 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10AF20883;
        Thu,  8 Nov 2018 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714593;
        bh=stoz+FCVHPNoI1Kz7kTPrir9Wu6DGJIZGdbcfYRGYBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qen99xgrWOR5mnv6NHyyH8paWL6Y71cL1IzyRnItcXB+HqHfo5DqAmz7NrvcR+fMZ
         bNQROfFwIh7Hj2YPyO8cbtL7jh+k4pb37OWBrCXttjViFejcNumZbe1UidJAukXMej
         FvJq2uN1wTrvPjMH2kPXcLmXd/lpWF44VV0Ga14g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 018/171] qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
Date:   Thu,  8 Nov 2018 13:49:48 -0800
Message-Id: <20181108215128.586309990@linuxfoundation.org>
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

[ Upstream commit d3a315795b4ce8b105a64a90699103121bde04a8 ]

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
the value directly from the switch statement.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_roce.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index d9dcb0d1714c..07783d13df71 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -1059,23 +1059,16 @@ static void qed_rdma_copy_gids(struct qed_rdma_qp *qp, __le32 *src_gid,
 
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
 
 static int qed_roce_alloc_cid(struct qed_hwfn *p_hwfn, u16 *cid)
-- 
2.17.1



