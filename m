Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EE6C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF93E20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJtZJZJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF93E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbeKCD4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbeKCD4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92FA20843;
        Fri,  2 Nov 2018 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184516;
        bh=TmjvhyDvTQL1UV0RUTgS/OYL5bv9YF99S+yK0oR8f8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJtZJZJmkoPtslct6GHkBq7xdVAmG/zSuuoifXfvN6yWWNhAHP79L0s8BKo8UeV+x
         JTRlS89Uf7rDqv3gfaLxOvBHW7/YIArywY+XlZi0yKD0rbJ0CeDtqaEN0g6T8LCf1o
         c/JUn/1ogXXau2oYPydx9M8aqrB5fhDwbfJwReFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 026/143] qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
Date:   Fri,  2 Nov 2018 19:33:31 +0100
Message-Id: <20181102182859.173342957@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index fb7c2d1562ae..bedbf840fd7d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -129,23 +129,16 @@ static void qed_rdma_copy_gids(struct qed_rdma_qp *qp, __le32 *src_gid,
 
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
 
 void qed_roce_free_cid_pair(struct qed_hwfn *p_hwfn, u16 cid)
-- 
2.17.1



