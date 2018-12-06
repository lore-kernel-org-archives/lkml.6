Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35870C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A420672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107246;
	bh=si6XuCE9NJkXMbu0tDVPm77TtJeDzxoJkvlqqiVZBMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXIZOWi2ItnUzcxmOWa0fKxG2RMBukESMRfo9bb72gnDioj5jrPOV9aSGgUEU+1tf
	 RyZEC9AsPTUKObDvmz2DbGlSBJyNJXL2wYMZdJ2fTy29uriy6Of795NBIG5N0DxGYs
	 l8LWJKREwfLy9aho9F01UoOy7Ulcuddj1+UL7VHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19A420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeLFOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbeLFOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5EB20672;
        Thu,  6 Dec 2018 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107241;
        bh=si6XuCE9NJkXMbu0tDVPm77TtJeDzxoJkvlqqiVZBMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDaexsNcwdBexRXOVp7JtYLLYoE3KI5la9uRlAGZdMv9qsny7aKFFPq2oi7OLbw5/
         nTttU0QAFPEalt0TZ0JodsCLeRkBpsCPpDx5GZl9Q7R7Z0+JEQWVtMgIXMWqkplV/I
         atg2iJeXP+Z9fftPyKuWw3J5v67eKnOu5H6y9IV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 28/41] selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN
Date:   Thu,  6 Dec 2018 15:39:08 +0100
Message-Id: <20181206142952.159625701@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 598e1a42e9626213565d3b22ea948ce78556512a upstream.

Commit 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
added new RTM_* definitions without properly updating SELinux, this
patch adds the necessary SELinux support.

While there was a BUILD_BUG_ON() in the SELinux code to protect from
exactly this case, it was bypassed in the broken commit.  In order to
hopefully prevent this from happening in the future, add additional
comments which provide some instructions on how to resolve the
BUILD_BUG_ON() failures.

Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Cc: <stable@vger.kernel.org> # 4.19
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/nlmsgtab.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -80,6 +80,9 @@ static const struct nlmsg_perm nlmsg_rou
 	{ RTM_NEWSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_GETSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 	{ RTM_NEWCACHEREPORT,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_NEWCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
@@ -158,7 +161,11 @@ int selinux_nlmsg_lookup(u16 sclass, u16
 
 	switch (sclass) {
 	case SECCLASS_NETLINK_ROUTE_SOCKET:
-		/* RTM_MAX always point to RTM_SETxxxx, ie RTM_NEWxxx + 3 */
+		/* RTM_MAX always points to RTM_SETxxxx, ie RTM_NEWxxx + 3.
+		 * If the BUILD_BUG_ON() below fails you must update the
+		 * structures at the top of this file with the new mappings
+		 * before updating the BUILD_BUG_ON() macro!
+		 */
 		BUILD_BUG_ON(RTM_MAX != (RTM_NEWCHAIN + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
@@ -170,6 +177,10 @@ int selinux_nlmsg_lookup(u16 sclass, u16
 		break;
 
 	case SECCLASS_NETLINK_XFRM_SOCKET:
+		/* If the BUILD_BUG_ON() below fails you must update the
+		 * structures at the top of this file with the new mappings
+		 * before updating the BUILD_BUG_ON() macro!
+		 */
 		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_MAPPING);
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
 				 sizeof(nlmsg_xfrm_perms));


