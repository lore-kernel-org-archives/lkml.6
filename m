Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C8EC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E4420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080013;
	bh=1+BFqj1sSDBTArY6qFPtlJvloXZ/7/X1lLWe8fzCtpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CerXK1IXfavlcUV2Oot7egITUE2O2l8Ddmg5VpT9vNG+VNs/huAIjwrNpkAfWmm4B
	 tyZ7QQsVC1osYUDUDybgP3d3iUUavvcXmm29Q/ptQcwWY5y2JO2p3fRMYigbsgarMQ
	 hSWtQvsv5ocEQQZh6G0Lgz9i9uUh1WiSuHcgkgdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfAUONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbfAUNxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A832084C;
        Mon, 21 Jan 2019 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078788;
        bh=1+BFqj1sSDBTArY6qFPtlJvloXZ/7/X1lLWe8fzCtpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YD1I2xs7/ARN764o+qOznQprWzqoA94RKT2lwmzWQOHSVo2w9TOTmeZT2XBkeARD2
         VONWTb0K2FrSm38nKJrKp1fsp8rd4Sh12762VCLPR660v3J1tIU7Y86BTeDO1RBJP8
         kU+NOn/fcf6ogc30rDQkEfvqvroxygm5xoGHJ89E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 44/59] netfilter: ebtables: account ebt_table_info to kmemcg
Date:   Mon, 21 Jan 2019 14:44:09 +0100
Message-Id: <20190121122501.692716433@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1134,14 +1134,16 @@ static int do_replace(struct net *net, c
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


