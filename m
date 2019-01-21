Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C13C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079037;
	bh=J5wa0eo8jZ3fDNPOuQHfeV+0kXIhSQIOwXO2hfxwPH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bYUKKhWBCecNwWUD0q7LEB/BK1UMqn8kZxjA7cQM91qNkYnvHo0tq49+Ce2G0oFZ7
	 ZkvRAO4Ul7wLEHzt0++nlYAHWVe/hZ+MpFY2x0K7MxOR0znqnhgGbZoj8XrBvqETaL
	 xbcDAyHPegxc2Y8WKJYEygSi687Q6Ki/K4CyL8Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfAUN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731939AbfAUN4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6403D2084C;
        Mon, 21 Jan 2019 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078989;
        bh=J5wa0eo8jZ3fDNPOuQHfeV+0kXIhSQIOwXO2hfxwPH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBh4HnQxJKnYUJmWd0j776AilBXlgXi5Bny4SSh/QGIK2xP2U9YN28tofmLYv+QIo
         GkD0y+i40Egv4PebIzjfrbFbcS5twinbGim/JHXE5sWbV1N3ivI5bzpI7IEuCblJrF
         rd4NZdQVNmI2aV+8FHp82tEcsP0+PLtcvzm2EkiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 37/51] netfilter: ebtables: account ebt_table_info to kmemcg
Date:   Mon, 21 Jan 2019 14:44:33 +0100
Message-Id: <20190121122457.271400912@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeelb@google.com>

commit e2c8d550a973bb34fc28bc8d0ec996f84562fb8a upstream.

The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
memory is already accounted to kmemcg. Do the same for ebtables. The
syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
whole system from a restricted memcg, a potential DoS.

By accounting the ebt_table_info, the memory used for ebt_table_info can
be contained within the memcg of the allocating process. However the
lifetime of ebt_table_info is independent of the allocating process and
is tied to the network namespace. So, the oom-killer will not be able to
relieve the memory pressure due to ebt_table_info memory. The memory for
ebt_table_info is allocated through vmalloc. Currently vmalloc does not
handle the oom-killed allocating process correctly and one large
allocation can bypass memcg limit enforcement. So, with this patch,
at least the small allocations will be contained. For large allocations,
we need to fix vmalloc.

Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1147,14 +1147,16 @@ static int do_replace(struct net *net, c
 	tmp.name[sizeof(tmp.name) - 1] = 0;
 
 	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
-	newinfo = vmalloc(sizeof(*newinfo) + countersize);
+	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
+			    PAGE_KERNEL);
 	if (!newinfo)
 		return -ENOMEM;
 
 	if (countersize)
 		memset(newinfo->counters, 0, countersize);
 
-	newinfo->entries = vmalloc(tmp.entries_size);
+	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
+				     PAGE_KERNEL);
 	if (!newinfo->entries) {
 		ret = -ENOMEM;
 		goto free_newinfo;


