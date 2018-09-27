Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9325D216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XOMZme7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9325D216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeI1AT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38991 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbeI1ATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so5850450edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//4teGx2aqB1iUXfxLOI165v5hE2Bibr4eSEPlWj71c=;
        b=XOMZme7/dlhYD9c/JGgN8lf+xDfuBQg4hBTpysq0HK9md5iUCSwkbdg/GapnQXjuVp
         3xouYNlX7OclL0IW2gj9EUYWaMQp27c/9+5QrsyRGLxdPm1j75X2WWWGlHSToWdRAZAf
         Cjr26NjtTerlXq/Dabkxxj4YfyWsY2Q/BXpKrgDu28zscavCfBmfXJsdLYeQk0yma2I9
         p7ujkZHLUucmOmK6DDsrKTWPOmFQrt4ebS/SxT333kUk9f4t4uSW83vi18+O24X0WlUY
         PQX6eUkqrklF2nyoAE7XrboSUaw3vWP8yLD1mYHMExzV2vSGz+7uC8q5RTs/DVjt2xGE
         8jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//4teGx2aqB1iUXfxLOI165v5hE2Bibr4eSEPlWj71c=;
        b=YEiP20pdFnjTd726JDFsOfQ1rsEWqqbOJzDVuJ2JUzGMh+wSneYYCxoBhdD/esEA8X
         NqlQcIZRZlkC0VxuK3GdCznScSBM0s3fkhdNtxqW0Xzn/Ut3+jhxu1xgQJF/NWHk45VB
         POFjkL/KrPlQXFo9jULNPQ69UO4CRLA9sSHHg6S76iDilVddnqbgwRy5viuvx+GhDef5
         V7gxIcqyT6ewvo+61izjI4SDqxBqAIwS0VnHSXL6iMeAMBTrKVE29kBOPt6aqpV2ll20
         5wHz9uxwENqIeB43fmXqUFjroow31xE6jGRzUopXGYb+SOt0gXI5y0pLCfol3KY/qcoY
         2Uyw==
X-Gm-Message-State: ABuFfohJBMlIDUzf0C5dpCZ3eCY4bpMv5fc9VNnyH6zn/fTHzrbJJImR
        Nr51C/iUH8klbhfc3xBM+QHt2Q==
X-Google-Smtp-Source: ACcGV62CBa6SJDpxAssNKPxLwsEU/SaMug/DJvUnAkKu/ojW5sDCWnmkyB/6psBY2qSEKYy76F++DQ==
X-Received: by 2002:a50:c2c9:: with SMTP id u9-v6mr9852227edf.15.1538071180843;
        Thu, 27 Sep 2018 10:59:40 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:39 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 6/7] selinux: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:56 +0200
Message-Id: <20180927175857.3511-7-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927175857.3511-1-christian@brauner.io>
References: <20180927175857.3511-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various userspace programs (e.g. iproute2) have sent RTM_GETADDR
requests with struct ifinfomsg. This is wrong and should have been
struct ifaddrmsg all along as mandated by the manpages. However, dump
requests so far didn't parse the netlink message that was sent and
succeeded even when a wrong struct was passed along.

Currently, the message is parsed under the assumption that the correct
struct ifaddrmsg is sent down. If the parsing fails the kernel will
still fulfill the request to preserve backwards compatability but a
rate-limited message that there were leftover bytes after parsing the
message is recorded in dmesg. It has been argued that this is
unacceptable [1].

But various new features that got and will get added to RTM_GETADDR make
it necessary to definitely know what header was passed along.
This is currently not possible without resorting to (likely unreliable)
hacks such as introducing a nested attribute that ensures that
RTM_GETADDR which pass along properties such as IFA_TARGET_NETNSID
always exceed RTM_GETADDR requests that send down the wrong struct
ifinfomsg [2]. Basically, multiple approaches to solve this have been
shut down. Furthermore, the API expressed via RTM_GETADDR is apparently
frozen [3] so the wiggle room at this point seems very much zero.

The correct solution at this point seems to me to introduce a new
RTM_GETADDR2 request. This way we can parse the message and fail hard if
the struct is not struct ifaddrmsg and can safely extend it in the
future. Userspace tools that rely on the buggy RTM_GETADDR API will
still keep working without even having to see any log messages and new
userspace tools that want to make user of new features can make use of
the new RTM_GETADDR2 requests.

[1]: https://lists.openwall.net/netdev/2018/09/25/59
[2]: https://lists.openwall.net/netdev/2018/09/25/75
[3]: https://lists.openwall.net/netdev/2018/09/26/166

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
---
 security/selinux/nlmsgtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 74b951f55608..3c45f50e987d 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -80,6 +80,7 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_NEWSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_GETSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 	{ RTM_NEWCACHEREPORT,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_GETADDR2,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
@@ -159,7 +160,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 	switch (sclass) {
 	case SECCLASS_NETLINK_ROUTE_SOCKET:
 		/* RTM_MAX always point to RTM_SETxxxx, ie RTM_NEWxxx + 3 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_NEWCHAIN + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_GETADDR2 + 1));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.17.1

