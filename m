Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5202AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF54420894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF54420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeG0LWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbeG0LWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:19 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1F3FCB8;
        Fri, 27 Jul 2018 10:01:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/48] multicast: do not restore deleted record source filter mode to new one
Date:   Fri, 27 Jul 2018 12:00:02 +0200
Message-Id: <20180727095920.323747701@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

There are two scenarios that we will restore deleted records. The first is
when device down and up(or unmap/remap). In this scenario the new filter
mode is same with previous one. Because we get it from in_dev->mc_list and
we do not touch it during device down and up.

The other scenario is when a new socket join a group which was just delete
and not finish sending status reports. In this scenario, we should use the
current filter mode instead of restore old one. Here are 4 cases in total.

old_socket        new_socket       before_fix       after_fix
  IN(A)             IN(A)           ALLOW(A)         ALLOW(A)
  IN(A)             EX( )           TO_IN( )         TO_EX( )
  EX( )             IN(A)           TO_EX( )         ALLOW(A)
  EX( )             EX( )           TO_EX( )         TO_EX( )

Fixes: 24803f38a5c0b (igmp: do not remove igmp souce list info when set link down)
Fixes: 1666d49e1d416 (mld: do not remove mld souce list info when set link down)
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/igmp.c  |    3 +--
 net/ipv6/mcast.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1201,8 +1201,7 @@ static void igmpv3_del_delrec(struct in_
 	if (pmc) {
 		im->interface = pmc->interface;
 		im->crcount = in_dev->mr_qrv ?: net->ipv4.sysctl_igmp_qrv;
-		im->sfmode = pmc->sfmode;
-		if (pmc->sfmode == MCAST_INCLUDE) {
+		if (im->sfmode == MCAST_INCLUDE) {
 			im->tomb = pmc->tomb;
 			im->sources = pmc->sources;
 			for (psf = im->sources; psf; psf = psf->sf_next)
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -771,8 +771,7 @@ static void mld_del_delrec(struct inet6_
 	if (pmc) {
 		im->idev = pmc->idev;
 		im->mca_crcount = idev->mc_qrv;
-		im->mca_sfmode = pmc->mca_sfmode;
-		if (pmc->mca_sfmode == MCAST_INCLUDE) {
+		if (im->mca_sfmode == MCAST_INCLUDE) {
 			im->mca_tomb = pmc->mca_tomb;
 			im->mca_sources = pmc->mca_sources;
 			for (psf = im->mca_sources; psf; psf = psf->sf_next)


