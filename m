Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26913C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584C22422
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D584C22422
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHKBjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:39:10 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39406
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbeHKBjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:39:09 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id oGU0f4GV5cdsPoGU0fPzvW; Fri, 10 Aug 2018 16:06:13 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1foGU0-0000Ys-IU; Fri, 10 Aug 2018 16:06:12 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>, stable@vger.kernel.org
Subject: [PATCH 1/5] Tools: hv: Fix a bug in the key delete code
Date:   Fri, 10 Aug 2018 23:06:07 +0000
Message-Id: <20180810230611.2114-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810230520.2055-1-kys@linuxonhyperv.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfNQDujVB5rgfCcStVgpYPifd+qgwkdLeK0LAWyqsSdbAeyOdT7LXQIb/SO/WJuISfAwBsRqgiUFgA8geAURk8Or+PwUM49MAN4Mrh6ytme01QIlbG7lv
 Syr1sWKf7T/VJPdpUMuIAgqnHySSc1nX6mpUn5ZBpvnKSsEN0zM1XqeDFBSoiRUYrsfbFBwbzhPeyfjm88mBdCrEHizdH/B60VUNzY78NxU0H1yQ68kcd+gG
 gD8Zq7qNHkXHTn7MSaioYvEANml/V4L3v8Sc13Q02xc1bQ380c9JYXCXQOwwnGPFoAmSgHQL8iwES1ThG4GwVyqtf8dXlwIBz1U/n8nHCO/1xF453BTY2X/n
 wmmN71vYQGZhq6oaNEmToC2HAnfdZXAU5HHtOum+K6j0yTuPZGLbyel1LI5eo7e7qEFM0VATJCoGnWrNattxPodD9TUcygggp/7RrtMEiSADwAnHyHbcL0Vt
 b6nhqO/KMVLX5juAVzjv+TRdiQVCq22TA/FYTedSFf5exDoHkqqNVzUTJN+OMdZXmQbvG4zv9ywgAw3zWduXtgIFRG60s0MTVA9OeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Fix a bug in the key delete code - the num_records range
from 0 to num_records-1.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reported-by: David Binderman <dcb314@hotmail.com>
Cc: <stable@vger.kernel.org>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index dbf6e8bd98ba..bbb2a8ef367c 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -286,7 +286,7 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
 		 * Found a match; just move the remaining
 		 * entries up.
 		 */
-		if (i == num_records) {
+		if (i == (num_records - 1)) {
 			kvp_file_info[pool].num_records--;
 			kvp_update_file(pool);
 			return 0;
-- 
2.18.0

