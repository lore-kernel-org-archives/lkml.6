Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A8D222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083686;
	bh=YaLgMlk5ulSiJtjiRMII83+nVG+KDv2bpWqVRxluOBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D+XesHyC+Q90LIAGDwZR4UlefoAeYDagGpJ1V7QedXCzBVd6FwlB84hSt0LcKRQL4
	 +n6gM8bZ7d6eUW8r2Q4KoFip2r/5x1S4G3tUSC10gaV+t7HIOBYGuILFhHFlbZLakM
	 XIS6RYXP4YJ5Q7w4xPD9swMgctSefh1qJrCeG8sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbfBMSsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406523AbfBMSqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB73B20811;
        Wed, 13 Feb 2019 18:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083608;
        bh=YaLgMlk5ulSiJtjiRMII83+nVG+KDv2bpWqVRxluOBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Se0ny6J3tkNO37W1eg+7pSZ1rYc60YhADwu81+Xv0k3vGdOmZLPa0wc/fUO+NOLSq
         /uxWwbyfrxsnpu/d2Y9c4cREvkKB6ioFjvgp4IZF2DjR+9QaIPe52EnE/UoDuF9ygJ
         3y432GKrV3V33JKCbieQqtybpx0VZZCqvnJIkxP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, 3ntr0py1337@gmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.20 48/50] xfrm: refine validation of template and selector families
Date:   Wed, 13 Feb 2019 19:38:53 +0100
Message-Id: <20190213183659.456889702@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 35e6103861a3a970de6c84688c6e7a1f65b164ca upstream.

The check assumes that in transport mode, the first templates family
must match the address family of the policy selector.

Syzkaller managed to build a template using MODE_ROUTEOPTIMIZATION,
with ipv4-in-ipv6 chain, leading to following splat:

BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x1db/0x1854
Read of size 4 at addr ffff888063e57aa0 by task a.out/2050
 xfrm_state_find+0x1db/0x1854
 xfrm_tmpl_resolve+0x100/0x1d0
 xfrm_resolve_and_create_bundle+0x108/0x1000 [..]

Problem is that addresses point into flowi4 struct, but xfrm_state_find
treats them as being ipv6 because it uses templ->encap_family is used
(AF_INET6 in case of reproducer) rather than family (AF_INET).

This patch inverts the logic: Enforce 'template family must match
selector' EXCEPT for tunnel and BEET mode.

In BEET and Tunnel mode, xfrm_tmpl_resolve_one will have remote/local
address pointers changed to point at the addresses found in the template,
rather than the flowi ones, so no oob read will occur.

Reported-by: 3ntr0py1337@gmail.com
Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1488,10 +1488,15 @@ static int validate_tmpl(int nr, struct
 		if (!ut[i].family)
 			ut[i].family = family;
 
-		if ((ut[i].mode == XFRM_MODE_TRANSPORT) &&
-		    (ut[i].family != prev_family))
-			return -EINVAL;
-
+		switch (ut[i].mode) {
+		case XFRM_MODE_TUNNEL:
+		case XFRM_MODE_BEET:
+			break;
+		default:
+			if (ut[i].family != prev_family)
+				return -EINVAL;
+			break;
+		}
 		if (ut[i].mode >= XFRM_MODE_MAX)
 			return -EINVAL;
 


