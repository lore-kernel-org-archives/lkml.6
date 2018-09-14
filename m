Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5372FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB6B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeINN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:27:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbeINN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:27:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 972032C74FFF0;
        Fri, 14 Sep 2018 16:14:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 16:14:21 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <gregkh@linux-foundation.org>,
        <dwmw2@infradead.org>, <eric.dumazet@gmail.com>,
        <davem@davemloft.net>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH stable 4.4 V2 0/6] fix SegmentSmack in stable branch (CVE-2018-5390)
Date:   Fri, 14 Sep 2018 16:24:04 +0800
Message-ID: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five patches to fix CVE-2018-5390 in latest mainline 
branch, but only two patches exist in stable 4.4 and 3.18: 
dc6ae4d tcp: detect malicious patterns in tcp_collapse_ofo_queue()
5fbec48 tcp: avoid collapses in tcp_prune_queue() if possible
I have tested with stable 4.4 kernel, and found the cpu usage was very high.
So I think only two patches can't fix the CVE-2018-5390.
test results:
with fix patch：     78.2%   ksoftirqd
withoutfix patch：   90%     ksoftirqd

Then I try to imitate 72cd43ba(tcp: free batches of packets in tcp_prune_ofo_queue())
to drop at least 12.5 % of sk_rcvbuf to avoid malicious attacks with simple queue 
instead of RB tree. The result is not very well.
 
After analysing the codes of stable 4.4, and debuging the 
system, shows that search of ofo_queue(tcp ofo using a simple queue) cost more cycles.

So I try to backport "tcp: use an RB tree for ooo receive queue" using RB tree 
instead of simple queue, then backport Eric Dumazet 5 fixed patches in mainline,
good news is that ksoftirqd is turn to about 20%, which is the same with mainline now.

Stable 4.4 have already back port two patches, 
f4a3313d(tcp: avoid collapses in tcp_prune_queue() if possible)
3d4bf93a(tcp: detect malicious patterns in tcp_collapse_ofo_queue())
If we want to change simple queue to RB tree to finally resolve, we should apply previous 
patch 9f5afeae(tcp: use an RB tree for ooo receive queue.) firstly, but 9f5afeae have many 
conflicts with 3d4bf93a and f4a3313d, which are part of patch series from Eric in 
mainline to fix CVE-2018-5390, so I need revert part of patches in stable 4.4 firstly, 
then apply 9f5afeae, and reapply five patches from Eric.

V1->V2:
1) Don't revert 3d4bf93a and f4a3313d firstly, all of 6 patches based on 4.4.155. 
2) Add one bug fix patch for RB tree:76f0dcbb5ae1a7c3dbeec13dd98233b8e6b0b32a tcp: fix a stale ooo_last_skb

Eric Dumazet (5):
  tcp: increment sk_drops for dropped rx packets
  tcp: fix a stale ooo_last_skb after a replace
  tcp: free batches of packets in tcp_prune_ofo_queue()
  tcp: call tcp_drop() from tcp_data_queue_ofo()
  tcp: add tcp_ooo_try_coalesce() helper

Yaogong Wang (1):
  tcp: use an RB tree for ooo receive queue

 include/linux/skbuff.h   |   8 +
 include/linux/tcp.h      |   7 +-
 include/net/sock.h       |   7 +
 include/net/tcp.h        |   2 +-
 net/core/skbuff.c        |  19 +++
 net/ipv4/tcp.c           |   4 +-
 net/ipv4/tcp_input.c     | 417 +++++++++++++++++++++++++++++------------------
 net/ipv4/tcp_ipv4.c      |   3 +-
 net/ipv4/tcp_minisocks.c |   1 -
 net/ipv6/tcp_ipv6.c      |   1 +
 10 files changed, 297 insertions(+), 172 deletions(-)

-- 
1.8.3.1

