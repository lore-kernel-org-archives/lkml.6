Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EQXHIkPzG1t1ZAAAmS7hNA
	; Sat, 09 Jun 2018 15:34:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7CEE1608C9; Sat,  9 Jun 2018 15:34:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhjYOJvt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D47D4606FA;
	Sat,  9 Jun 2018 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D47D4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFIPeM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbeFIPeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:09 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDC5204EC;
        Sat,  9 Jun 2018 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558448;
        bh=U0DY9SVaXcjB5WYRj85Z1UQiNG81oncdN7qbmaE/k9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhjYOJvtL56wrmOVs7fV3tlfkSAj+0sRfBXiKhtMpuhyKQf65gN1fNNuOZQr6S6C+
         zjGTbKrSgis7y5ixzm4WYAwoR1Ow5dyhzf7dG68nLI+8xSeoh0HRh0/vk1pm29Ubvp
         rYSpXWwdFhl5sqOKuY27lkEOGp0oETPLUf9d6vHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 43/48] net : sched: cls_api: deal with egdev path only if needed
Date: Sat,  9 Jun 2018 17:29:55 +0200
Message-Id: <20180609145950.731645550@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit f8f4bef322e4600c5856911c7a632c0e3da920d6 ]

When dealing with ingress rule on a netdev, if we did fine through the
conventional path, there's no need to continue into the egdev route,
and we can stop right there.

Not doing so may cause a 2nd rule to be added by the cls api layer
with the ingress being the egdev.

For example, under sriov switchdev scheme, a user rule of VFR A --> VFR B
will end up with two HW rules (1) VF A --> VF B and (2) uplink --> VF B

Fixes: 208c0f4b5237 ('net: sched: use tc_setup_cb_call to call per-block callbacks')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1587,7 +1587,7 @@ int tc_setup_cb_call(struct tcf_block *b
 		return ret;
 	ok_count = ret;
 
-	if (!exts)
+	if (!exts || ok_count)
 		return ok_count;
 	ret = tc_exts_setup_cb_egdev_call(exts, type, type_data, err_stop);
 	if (ret < 0)
