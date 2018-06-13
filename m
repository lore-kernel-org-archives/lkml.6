Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B90E0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C820693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792C820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeFMF2I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:28:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:55117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeFMF2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:28:06 -0400
Received: from juanniu018037.ss.mogujie.org ([122.225.81.134]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MEo4s-1fRIIV3ptq-00G2aY; Wed, 13 Jun 2018 07:28:02 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     nab@linux-iscsi.org
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [RESEND PATCH] target: fix potential memory leak in option parsing
Date:   Wed, 13 Jun 2018 13:27:26 +0800
Message-Id: <1528867646-138322-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:hhFkXKB5Tn7ZcqvC5gl0clmvEyCmJr4KIRqWlLvbuf0jslWdlpX
 tvQLhQbbkS3zcws5/9nXaOheD0eyZwg9Un0KCM057qoL8WL++RnOjxsfp9nJeKR//Y6EdY+
 15zQaNth/woB3LqEkJEgoPQ/r7IGjyOAGJyDbDPdKoi4UtUb54zNDSTJBRkRhy1+P0TO3nc
 u6YN7z4dcjPsR9UgvWC8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UD3YdJwDfGs=:NgqFWqllkokeCGWlgY+0IH
 2ahvL4dwHcAoQGU76vZ6N+30iHSFRTnJedh7PjIci0cA+fARZFd7iakm/igD6CHPYYdA71m1Z
 AQ/85PHahBjKMBuKwmvsmzVJUbmsiBJb4rJMrLmo3xUrrOyjdcCHIR8C5EZ0fVihs+FP+16BR
 K+sP8+pz1UsgszMo96jAb4n26rL+SHMZKmN0ajPd7FoKuDuWAFMLSpVkjQkCGO+qlECmrFKe2
 DQDkQvluRIyV7qGJkC9bidR/rVukpXjdl0QLdyBTmCW8iVeRUXXgvEJ9wPANN50AFDDS4/RUC
 DoERAG/qbI1d6OXWPOwfQplrqhmMuRGIwrdPCkHba+J/b7/LvYN16e6ueN7cXeAGegnFblxiU
 /0+NPTxbfTKw9uYy8n05B4tZrARnWOrIHbhvOqYYzDNl/lEEVHi4pS1XxZTrFlJFvDIBSwMCi
 0RGlxJgmfh15DkKuInWr90BWrVcqPWISVuKKslWP1x0/k3+t3WdVyQo4KUS2az9qei5JoFuqI
 3RRlmO+dhCWPnDodA5XvLc6Y+Iarty0Q7jeoW14dMEiKhWWYtEnAOjCBFl5W/v+3rey56DjfH
 GiUGzKhYmBd2BwMaqr/b/otT6JpU581alDf78MmhI3vAFEb3cbeAaDxNfrgqYbPeyJgErelKl
 HqV3a5EJ7I0TyhLU3Qgmqm6DuusJs4QsYwCDEk8xrBaq3nxQixoqwYY2N0X3sv4y6DSa4EOjN
 xKYFBFkOv+bPKpwYBdiF5ZrfYx4ZK4UEBoo7cRlt0qRS17BVQ8hWCM849LQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying same string type option several times,
current option parsing will cause memory leak. Hence,
call kfree for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/target/target_core_configfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 5ccef7d..5512432 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1661,6 +1661,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 		token = match_token(ptr, tokens, args);
 		switch (token) {
 		case Opt_initiator_fabric:
+			kfree(i_fabric);
 			i_fabric = match_strdup(args);
 			if (!i_fabric) {
 				ret = -ENOMEM;
@@ -1668,6 +1669,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 			}
 			break;
 		case Opt_initiator_node:
+			kfree(i_port);
 			i_port = match_strdup(args);
 			if (!i_port) {
 				ret = -ENOMEM;
@@ -1682,6 +1684,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 			}
 			break;
 		case Opt_initiator_sid:
+			kfree(isid);
 			isid = match_strdup(args);
 			if (!isid) {
 				ret = -ENOMEM;
@@ -1739,6 +1742,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 		 * PR APTPL Metadata for Target Port
 		 */
 		case Opt_target_fabric:
+			kfree(t_fabric);
 			t_fabric = match_strdup(args);
 			if (!t_fabric) {
 				ret = -ENOMEM;
@@ -1746,6 +1750,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 			}
 			break;
 		case Opt_target_node:
+			kfree(t_port);
 			t_port = match_strdup(args);
 			if (!t_port) {
 				ret = -ENOMEM;
-- 
1.8.3.1

