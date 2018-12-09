Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6745C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A707D20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A707D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeLIWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:10:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37580 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbeLIWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:10:36 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002iY-Pk; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003HK-Dc; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "YueHaibing" <yuehaibing@huawei.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.865669722@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 065/328] xfrm: fix 'passing zero to ERR_PTR()' warning
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit 934ffce1343f22ed5e2d0bd6da4440f4848074de upstream.

Fix a static code checker warning:

  net/xfrm/xfrm_policy.c:1836 xfrm_resolve_and_create_bundle() warn: passing zero to 'ERR_PTR'

xfrm_tmpl_resolve return 0 just means no xdst found, return NULL
instead of passing zero to ERR_PTR.

Fixes: d809ec895505 ("xfrm: do not assume that template resolving always returns xfrms")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1692,7 +1692,10 @@ xfrm_resolve_and_create_bundle(struct xf
 	/* Try to instantiate a bundle */
 	err = xfrm_tmpl_resolve(pols, num_pols, fl, xfrm, family);
 	if (err <= 0) {
-		if (err != 0 && err != -EAGAIN)
+		if (err == 0)
+			return NULL;
+
+		if (err != -EAGAIN)
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTPOLERROR);
 		return ERR_PTR(err);
 	}

