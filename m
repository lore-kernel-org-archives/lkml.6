Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0296DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75B820848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zKKl3gKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75B820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbeKCEEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:47 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7A1A2082D;
        Fri,  2 Nov 2018 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184990;
        bh=+cXBUs+VUOr/Z/abfWc35BaUWSjGUpShTP7X4hzyjkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKKl3gKAtew265KGTRnh7rZj6o31UB97Db5pUsZOCps6nVbeTOjFq/tmTBN2WGrab
         jePkQ+j9mjjiwpJ33aVJHxGtp/ABWcvjHBdj7uyeij/dRMeGSDKoc7rx/oKZZzAWTe
         k4ZX6so3OuVyJfI1UupauJh8GgokeF3hmQSv/R+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 143/143] net/sched: cls_api: add missing validation of netlink attributes
Date:   Fri,  2 Nov 2018 19:35:28 +0100
Message-Id: <20181102182909.092603972@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit e331473fee3d500bb0d2582a1fe598df3326d8cd ]

Similarly to what has been done in 8b4c3cdd9dd8 ("net: sched: Add policy
validation for tc attributes"), fix classifier code to add validation of
TCA_CHAIN and TCA_KIND netlink attributes.

tested with:
 # ./tdc.py -c filter

v2: Let sch_api and cls_api share nla_policy they have in common, thanks
    to David Ahern.
v3: Avoid EXPORT_SYMBOL(), as validation of those attributes is not done
    by TC modules, thanks to Cong Wang.
    While at it, restore the 'Delete / get qdisc' comment to its orginal
    position, just above tc_get_qdisc() function prototype.

Fixes: 5bc1701881e39 ("net: sched: introduce multichain support for filters")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -31,6 +31,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -559,7 +561,7 @@ static int tc_ctl_tfilter(struct sk_buff
 replay:
 	tp_created = 0;
 
-	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, rtm_tca_policy, extack);
 	if (err < 0)
 		return err;
 
@@ -836,7 +838,8 @@ static int tc_dump_tfilter(struct sk_buf
 	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
 		return skb->len;
 
-	err = nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, NULL, NULL);
+	err = nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
+			  NULL);
 	if (err)
 		return err;
 


