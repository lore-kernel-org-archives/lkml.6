Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2220854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB2220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbeKLGKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53508 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbeKLGKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt2-0000oU-F5; Sun, 11 Nov 2018 19:59:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001XH-RK; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Davide Caratti" <dcaratti@redhat.com>,
        "Simon Horman" <simon.horman@netronome.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.236727533@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 129/366] net/sched: act_simple: fix parsing of
 TCA_DEF_DATA
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

commit 8d499533e0bc02d44283dbdab03142b599b8ba16 upstream.

use nla_strlcpy() to avoid copying data beyond the length of TCA_DEF_DATA
netlink attribute, in case it is less than SIMP_MAX_DATA and it does not
end with '\0' character.

v2: fix errors in the commit message, thanks Hangbin Liu

Fixes: fa1b1cff3d06 ("net_cls_act: Make act_simple use of netlink policy.")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -52,22 +52,22 @@ static void tcf_simp_release(struct tc_a
 	kfree(d->tcfd_defdata);
 }
 
-static int alloc_defdata(struct tcf_defact *d, char *defdata)
+static int alloc_defdata(struct tcf_defact *d, const struct nlattr *defdata)
 {
 	d->tcfd_defdata = kzalloc(SIMP_MAX_DATA, GFP_KERNEL);
 	if (unlikely(!d->tcfd_defdata))
 		return -ENOMEM;
-	strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
+	nla_strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	return 0;
 }
 
-static void reset_policy(struct tcf_defact *d, char *defdata,
+static void reset_policy(struct tcf_defact *d, const struct nlattr *defdata,
 			 struct tc_defact *p)
 {
 	spin_lock_bh(&d->tcf_lock);
 	d->tcf_action = p->action;
 	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
-	strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
+	nla_strlcpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	spin_unlock_bh(&d->tcf_lock);
 }
 
@@ -83,7 +83,6 @@ static int tcf_simp_init(struct net *net
 	struct nlattr *tb[TCA_DEF_MAX + 1];
 	struct tc_defact *parm;
 	struct tcf_defact *d;
-	char *defdata;
 	int ret = 0, err;
 
 	if (nla == NULL)
@@ -100,7 +99,6 @@ static int tcf_simp_init(struct net *net
 		return -EINVAL;
 
 	parm = nla_data(tb[TCA_DEF_PARMS]);
-	defdata = nla_data(tb[TCA_DEF_DATA]);
 
 	if (!tcf_hash_check(parm->index, a, bind)) {
 		ret = tcf_hash_create(parm->index, est, a, sizeof(*d), bind);
@@ -108,7 +106,7 @@ static int tcf_simp_init(struct net *net
 			return ret;
 
 		d = to_defact(a);
-		ret = alloc_defdata(d, defdata);
+		ret = alloc_defdata(d, tb[TCA_DEF_DATA]);
 		if (ret < 0) {
 			tcf_hash_cleanup(a, est);
 			return ret;
@@ -124,7 +122,7 @@ static int tcf_simp_init(struct net *net
 		if (!ovr)
 			return -EEXIST;
 
-		reset_policy(d, defdata, parm);
+		reset_policy(d, tb[TCA_DEF_DATA], parm);
 	}
 
 	if (ret == ACT_P_CREATED)

