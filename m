Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2FC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2324C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079517;
	bh=o6beDz6+dBB9OIbijO6dxkui/wioAJh0dV1nCeif7Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eBimIPY9t4TwwwwtFHnt/a69r93Zfn9CCvJzKheBZOl11fAFPLyspkesrugvrfMdM
	 AuZnddCDuB9Q0mK328A09nwp6ASAb6haIqP60d7ip9hCGbnhCbLDwfTzmyALG4RXGq
	 lxnPdgDnI0IRL/wgfIvdWMgYcpuJG831X5TLU4SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfAUOB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbfAUOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD60C2089F;
        Mon, 21 Jan 2019 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079281;
        bh=o6beDz6+dBB9OIbijO6dxkui/wioAJh0dV1nCeif7Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlfbIryRfB+lZ5QNfRMJYQ4GDPPPfOTkTaecRlRYvVcuv9kK6b7dN8Vz89N8V4d54
         UEvKUSLvxuVHnBeJWMDtNXXVC1R040gTTa94WajYcWKEnI4NxgU0+4SfG1UC6aRgHk
         Ad5vW0eYN5e59L2gRaFHBmm5LGvKBH+EJEJ9lcHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 69/99] netfilter: ebtables: account ebt_table_info to kmemcg
Date:   Mon, 21 Jan 2019 14:49:01 +0100
Message-Id: <20190121134916.606265438@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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
@@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, c
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


