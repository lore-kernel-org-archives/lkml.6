Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92D2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90F02084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj5cv97Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbeKCDxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeKCDxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:19 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0EF20847;
        Fri,  2 Nov 2018 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184306;
        bh=erG/1a0vWBV+4W/H37C9ZJ+idoOveP8AgGP4vgwwcu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gj5cv97QL/tmDRvUqodts6nU68pmjqif+n14borMAFmUhL/N2BN5VVEgel3Bj6pcs
         qv0LzMmIdu1ke0fD2JHQj+WGacbnLmth5W69w1sRSTY7+cgC5EV2NPc+T6SH2MfV1m
         kyrTidRF4K3oWJU7esfTBnxRcrBjODgq5yg2mN8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 130/150] net/sched: cls_api: add missing validation of netlink attributes
Date:   Fri,  2 Nov 2018 19:34:52 +0100
Message-Id: <20181102182911.832588717@linuxfoundation.org>
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
 net/sched/cls_api.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -31,6 +31,8 @@
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -1083,7 +1085,7 @@ static int tc_new_tfilter(struct sk_buff
 replay:
 	tp_created = 0;
 
-	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, rtm_tca_policy, extack);
 	if (err < 0)
 		return err;
 
@@ -1226,7 +1228,7 @@ static int tc_del_tfilter(struct sk_buff
 	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
-	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, rtm_tca_policy, extack);
 	if (err < 0)
 		return err;
 
@@ -1334,7 +1336,7 @@ static int tc_get_tfilter(struct sk_buff
 	void *fh = NULL;
 	int err;
 
-	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, NULL, extack);
+	err = nlmsg_parse(n, sizeof(*t), tca, TCA_MAX, rtm_tca_policy, extack);
 	if (err < 0)
 		return err;
 
@@ -1488,7 +1490,8 @@ static int tc_dump_tfilter(struct sk_buf
 	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
 		return skb->len;
 
-	err = nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, NULL, NULL);
+	err = nlmsg_parse(cb->nlh, sizeof(*tcm), tca, TCA_MAX, rtm_tca_policy,
+			  NULL);
 	if (err)
 		return err;
 


