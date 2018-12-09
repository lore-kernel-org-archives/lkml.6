Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFFB20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFFB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLIVzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34874 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbeLIVzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:15 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002ic-7y; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003L3-Ov; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Air Icy" <icytxw@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.397082462@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 098/328] xfrm: Validate address prefix lengths in the
 xfrm selector.
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

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 07bf7908950a8b14e81aa1807e3c667eab39287a upstream.

We don't validate the address prefix lengths in the xfrm
selector we got from userspace. This can lead to undefined
behaviour in the address matching functions if the prefix
is too big for the given address family. Fix this by checking
the prefixes and refuse SA/policy insertation when a prefix
is invalid.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Air Icy <icytxw@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -150,10 +150,16 @@ static int verify_newsa_info(struct xfrm
 	err = -EINVAL;
 	switch (p->family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			goto out;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			goto out;
+
 		break;
 #else
 		err = -EAFNOSUPPORT;
@@ -1227,10 +1233,16 @@ static int verify_newpolicy_info(struct
 
 	switch (p->sel.family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			return -EINVAL;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			return -EINVAL;
+
 		break;
 #else
 		return  -EAFNOSUPPORT;

