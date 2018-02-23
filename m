Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519418718-2-15074945325529016090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418717; b=W1HUT5fWguxRHV1lfngcZbxw1WM4juXoXmvhciTuofi7oyA
    t77dUw1qPXuUaD+ayCArlHhfDjfCx+JeiT+PlC/SD0Gpr05ZZlCJd7vIsqdc6sh5
    9vMOzqM93PDgxPBJrqhdhnwCgQCZQJs9/4JHHK2DzF2pU3ioM/lPQZg5etvgrjnP
    24iKAGnOqNoB3WaV9iasIqpU53reQFlC+Cbh8URD8EKy92m9ppS/OMa46RQv4JHt
    +5T/FiYTITzR1hrNZo2KdS41VMfJv/kx/u3SN2sGa7+E7LMnGqYjOuxFXYd92tNr
    OTigtRWAEz0cRvuIKEnjZWikZaFQMOmW+XZ/4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418717; bh=Ip5ORBFeUyE6y7TBFhQb6PWOw9
    GF8R23KZ4+pflnla4=; b=nki/tK8bSTTwafXD9WvqSY+Tg1pIghH2DJ7Fywwlc6
    aB+xxveEQTYSUSSw0QfS4kIOdPjZXPEmfwo7VvqMBaS8YdZcNdFT+YcpNBUvL/nC
    NkrfKKuAwbObsOVruPyAqsSjieu/o/+xBLFmGFQOGQeljPdsCWsKNbsN9rlbzhlN
    wnS8+V9HcpD1TTtUcg9Gsaa0+5touEl3vEdemF1tE7NTbU2xRZ/ZX3Ybdye7M0Tu
    Xnaw90oulrQa/uDDDWb0juGIcF6lsIsjd+RXwC3XeDQVih2f1FWw8lMfcPvl82C1
    gNleNOHqev6zgnMH8PuX5tEXD1mUn2GxIQQV2d6/Ovtw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeBWSck (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeBWScj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nogah Frankel <nogahf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 47/58] net_sched: red: Avoid illegal values
Date: Fri, 23 Feb 2018 19:26:46 +0100
Message-Id: <20180223170214.168605838@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 8afa10cbe281b10371fee5a87ab266e48d71a7f9 ]

Check the qmin & qmax values doesn't overflow for the given Wlog value.
Check that qmin <= qmax.

Fixes: a783474591f2 ("[PKT_SCHED]: Generic RED layer")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h     |   11 +++++++++++
 net/sched/sch_choke.c |    3 +++
 net/sched/sch_gred.c  |    3 +++
 net/sched/sch_red.c   |    2 ++
 net/sched/sch_sfq.c   |    3 +++
 5 files changed, 22 insertions(+)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -167,6 +167,17 @@ static inline void red_set_vars(struct r
 	v->qcount	= -1;
 }
 
+static inline bool red_check_params(u32 qth_min, u32 qth_max, u8 Wlog)
+{
+	if (fls(qth_min) + Wlog > 32)
+		return false;
+	if (fls(qth_max) + Wlog > 32)
+		return false;
+	if (qth_max < qth_min)
+		return false;
+	return true;
+}
+
 static inline void red_set_parms(struct red_parms *p,
 				 u32 qth_min, u32 qth_max, u8 Wlog, u8 Plog,
 				 u8 Scell_log, u8 *stab, u32 max_P)
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -431,6 +431,9 @@ static int choke_change(struct Qdisc *sc
 
 	ctl = nla_data(tb[TCA_CHOKE_PARMS]);
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (ctl->limit > CHOKE_MAX_QUEUE)
 		return -EINVAL;
 
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -388,6 +388,9 @@ static inline int gred_change_vq(struct
 	struct gred_sched *table = qdisc_priv(sch);
 	struct gred_sched_data *q = table->tab[dp];
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (!q) {
 		table->tab[dp] = q = *prealloc;
 		*prealloc = NULL;
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -199,6 +199,8 @@ static int red_change(struct Qdisc *sch,
 	max_P = tb[TCA_RED_MAX_P] ? nla_get_u32(tb[TCA_RED_MAX_P]) : 0;
 
 	ctl = nla_data(tb[TCA_RED_PARMS]);
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
 
 	if (ctl->limit > 0) {
 		child = fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -653,6 +653,9 @@ static int sfq_change(struct Qdisc *sch,
 	if (ctl->divisor &&
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
+	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
+					ctl_v1->Wlog))
+		return -EINVAL;
 	if (ctl_v1 && ctl_v1->qth_min) {
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
