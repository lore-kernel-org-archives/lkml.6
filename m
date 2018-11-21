Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C578206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCN3QC79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C578206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeKVFyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387583AbeKVFmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF57214F1;
        Wed, 21 Nov 2018 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827212;
        bh=8ic/CydjPLeuiQSGHVxVQYsziXxzhwMYHDz5jBnlRh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCN3QC793gE4LvXU+B3XRHYEwUTeuP+pf4twpFeb6dX3Tjb9mWv5xjm8waWQSK8Pr
         TMjkkpC/Xm0TL6tvYvWtDC/l30/OwgmqRwI35lg4QNNE3wBqTiSmiqtadlZjcXEhsn
         dQtj7e8GYGY5b6gw3hrm/bDGPN+Xua/K8yC+BTPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/42] net: sched: cls_flower: validate nested enc_opts_policy to avoid warning
Date:   Wed, 21 Nov 2018 20:05:52 +0100
Message-Id: <20181121183148.735870933@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 63c82997f5c0f3e1b914af43d82f712a86bc5f3a ]

TCA_FLOWER_KEY_ENC_OPTS and TCA_FLOWER_KEY_ENC_OPTS_MASK can only
currently contain further nested attributes, which are parsed by
hand, so the policy is never actually used resulting in a W=1
build warning:

net/sched/cls_flower.c:492:1: warning: ‘enc_opts_policy’ defined but not used [-Wunused-const-variable=]
 enc_opts_policy[TCA_FLOWER_KEY_ENC_OPTS_MAX + 1] = {

Add the validation anyway to avoid potential bugs when other
attributes are added and to make the attribute structure slightly
more clear.  Validation will also set extact to point to bad
attribute on error.

Fixes: 0a6e77784f49 ("net/sched: allow flower to match tunnel options")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Simon Horman <simon.horman@netronome.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -709,11 +709,23 @@ static int fl_set_enc_opt(struct nlattr
 			  struct netlink_ext_ack *extack)
 {
 	const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk = NULL;
-	int option_len, key_depth, msk_depth = 0;
+	int err, option_len, key_depth, msk_depth = 0;
+
+	err = nla_validate_nested(tb[TCA_FLOWER_KEY_ENC_OPTS],
+				  TCA_FLOWER_KEY_ENC_OPTS_MAX,
+				  enc_opts_policy, extack);
+	if (err)
+		return err;
 
 	nla_enc_key = nla_data(tb[TCA_FLOWER_KEY_ENC_OPTS]);
 
 	if (tb[TCA_FLOWER_KEY_ENC_OPTS_MASK]) {
+		err = nla_validate_nested(tb[TCA_FLOWER_KEY_ENC_OPTS_MASK],
+					  TCA_FLOWER_KEY_ENC_OPTS_MAX,
+					  enc_opts_policy, extack);
+		if (err)
+			return err;
+
 		nla_opt_msk = nla_data(tb[TCA_FLOWER_KEY_ENC_OPTS_MASK]);
 		msk_depth = nla_len(tb[TCA_FLOWER_KEY_ENC_OPTS_MASK]);
 	}


