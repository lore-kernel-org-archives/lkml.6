Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE24214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE24214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbeHPMBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:01:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbeHPMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9F8F406E81C;
        Thu, 16 Aug 2018 09:03:57 +0000 (UTC)
Received: from ming.t460p (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 982B02166BA0;
        Thu, 16 Aug 2018 09:03:45 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:03:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: sync the update nr_hw_queues with
 part_in_flight
Message-ID: <20180816090334.GA7144@ming.t460p>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-3-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+g2ACx9XYx4XtwRkpSC9bCYeSFEj07Z==6r7nT-HxkQ@mail.gmail.com>
 <8cd103e6-0986-2c45-00f2-8a2a540a2eb5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd103e6-0986-2c45-00f2-8a2a540a2eb5@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 09:03:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 09:03:57 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 04:29:33PM +0800, jianchao.wang wrote:
> 
> 
> On 08/16/2018 12:50 PM, Ming Lei wrote:
> > On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
> > <jianchao.w.wang@oracle.com> wrote:
> >> For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
> >> account the inflight requests. It will access the queue_hw_ctx and
> >> nr_hw_queues w/o any protection. When updating nr_hw_queues and
> >> blk_mq_in_flight/rw occur concurrently, panic comes up.
> > 
> > When updating nr_hw_queues, all queues are frozen, and there shouldn't
> > be any inflight requests, so there shouldn't be such issue.
> > 
> 
> I get following crash when do updating nr_hw_queues test.
> 
> [  112.643189] BUG: unable to handle kernel NULL pointer dereference at 0000000000000174
> [  112.643275] PGD 40baf8067 P4D 40baf8067 PUD 40bb38067 PMD 0 
> [  112.643334] Oops: 0000 [#1] PREEMPT SMP
> [  112.643372] CPU: 7 PID: 1526 Comm: fio Kdump: loaded Not tainted 4.18.0-rc6+ #250
> [  112.643434] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
> [  112.643499] RIP: 0010:blk_mq_queue_tag_busy_iter+0x4d/0x250
> [  112.643548] Code: 48 89 54 24 20 c7 44 24 0c 00 00 00 00 85 c9 0f 84 25 01 00 00 48 8b 7c 24 10 48 63 44 24 0c 48 8b 97 88 01 00 00 4c 8b 34 c2 <41> 8b 96 74 01 00 00 4d 8b a6 e8 01 00 00 85 d2 0f 84 e0 00 00 00 
> [  112.643791] RSP: 0018:ffff95708284fc70 EFLAGS: 00010202
> [  112.643840] RAX: 0000000000000002 RBX: ffff895b49570e18 RCX: 00000000000000ff
> [  112.643899] RDX: ffff895b4fc1d6c0 RSI: ffffffff8b6a94b0 RDI: ffff895b49570e18
> [  112.643961] RBP: 000000000000001f R08: 0000000000000000 R09: 0000000000000000
> [  112.644021] R10: ffff95708284fcd8 R11: ffffffff8b6b547d R12: ffff895b4fc30b40
> [  112.644081] R13: 0000000000000000 R14: 0000000000000000 R15: ffff895b48c96c40
> [  112.644144] FS:  00007fa79fd4c700(0000) GS:ffff895b62dc0000(0000) knlGS:0000000000000000
> [  112.644212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  112.644270] CR2: 0000000000000174 CR3: 000000040b9ae001 CR4: 00000000003606e0
> [  112.644357] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  112.644459] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  112.644552] Call Trace:
> [  112.644603]  ? blk_mq_stop_hw_queues+0x50/0x50
> [  112.644675]  ? blk_mq_stop_hw_queues+0x50/0x50
> [  112.644748]  blk_mq_in_flight+0x2e/0x40
> [  112.644792]  part_round_stats+0x158/0x160
> [  112.644835]  part_stat_show+0x9c/0x530
> [  112.644873]  ? lock_acquire+0xab/0x200
> [  112.644913]  ? kernfs_seq_start+0x32/0x90
> [  112.644959]  dev_attr_show+0x19/0x50
> [  112.644996]  sysfs_kf_seq_show+0xad/0x100
> [  112.645039]  seq_read+0xa5/0x410
> [  112.645075]  ? __mutex_lock+0x20e/0x990
> [  112.645117]  __vfs_read+0x23/0x160
> [  112.645158]  vfs_read+0xa0/0x140
> [  112.645193]  ksys_read+0x45/0xa0
> [  112.645230]  do_syscall_64+0x5a/0x1a0
> [  112.645267]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> 
> The blk_mq_in_flight will access the queue_hw_ctx and nr_hw_queues when updating nr_hw_queues is ongoing.
> 

Sorry for missing this use case, then what do you think of the following fix?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b42a2c9ba00e..fbc5534f8178 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -113,6 +113,10 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
+	if (percpu_ref_is_dying(&q->q_usage_counter))
+		return;
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 

Thanks,
Ming
