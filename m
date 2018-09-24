Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3315C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5107120685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5107120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeIXRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbeIXRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B84F61070;
        Mon, 24 Sep 2018 11:40:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 060/105] netfilter: x_tables: avoid stack-out-of-bounds read in xt_copy_counters_from_user
Date:   Mon, 24 Sep 2018 13:33:46 +0200
Message-Id: <20180924113119.562763240@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit e466af75c074e76107ae1cd5a2823e9c61894ffb upstream.

syzkaller reports an out of bound read in strlcpy(), triggered
by xt_copy_counters_from_user()

Fix this by using memcpy(), then forcing a zero byte at the last position
of the destination, as Florian did for the non COMPAT code.

Fixes: d7591f0c41ce ("netfilter: x_tables: introduce and use xt_copy_counters_from_user")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -877,7 +877,7 @@ void *xt_copy_counters_from_user(const v
 		if (copy_from_user(&compat_tmp, user, sizeof(compat_tmp)) != 0)
 			return ERR_PTR(-EFAULT);
 
-		strlcpy(info->name, compat_tmp.name, sizeof(info->name));
+		memcpy(info->name, compat_tmp.name, sizeof(info->name) - 1);
 		info->num_counters = compat_tmp.num_counters;
 		user += sizeof(compat_tmp);
 	} else
@@ -890,9 +890,9 @@ void *xt_copy_counters_from_user(const v
 		if (copy_from_user(info, user, sizeof(*info)) != 0)
 			return ERR_PTR(-EFAULT);
 
-		info->name[sizeof(info->name) - 1] = '\0';
 		user += sizeof(*info);
 	}
+	info->name[sizeof(info->name) - 1] = '\0';
 
 	size = sizeof(struct xt_counters);
 	size *= info->num_counters;


