Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+335Y+7KRikt52gyJcjrjw/EUa3BA/J8BZdpKQEv/gLB/ZOVfHTXEdnubmeteuv3xT2PUL
ARC-Seal: i=1; a=rsa-sha256; t=1523472629; cv=none;
        d=google.com; s=arc-20160816;
        b=Hwrdylam6gkhurWXRn/Ge4/vI8o+UcPKP9acLgbjNfEohHFInN3fggUmcCDyL+28+9
         gQdVq8JVgXpeiQVFg4Qi8wL7ENuhTJ9EkC2Bjly+NxixfNiCATGoWEDqKlNY4pMhJAyn
         sivyF6fpocaotni4wFXInVoBc3mA330LxC7KKTvmWCsAtqZwbVjRzDI0AbwI4HAX8Lyb
         7OoO9qkUpD1srZyxskMxpG4XeM23OQ5VytzgUKEVqdgJNNZEC/bG3vRCwX21StNRWfD5
         TlusM6WVfxkZfqHuuMomZ91wHklLPrak42VZy+zAo3goeP71YxzFTunb66FoleQyYaXE
         mvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/aF5SyWMJj3DQgrK4rBKV0dkB7jHcTuhOf9EltaHki4=;
        b=hWepMne/y10alMZg9TGLxi169RwlIkGrMHqReLRpF1rNQ4DOXWmzokRIFNSItTep7i
         Wsho66i89/gAt72SMaawRIS2+L3A8di5Gjyp0MUtl5NAuzuyL4hf6yRbqyjUJqBN+q8z
         n08HcrLM8SofE9Ug81VgVxgqJs/jSNSLYSgGcsITPZ00ni86Iu4tgVCh7m+2ZtOiSNL1
         2x/mrPXz5FgSBYRURhqhy+1RU1AWL0SqCCeHLxE/KnAxve+gbfwYt2Y6ZAacv+Grdtzc
         Fn96jY4O2/EM29xmJANKbjPtwh/rnGZZTyJfpbrWPYDJGtzi0vUWjZV2k9GH+tDmW1sw
         0ecA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhang Yi <yizhan@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 154/190] blk-mq: fix kernel oops in blk_mq_tag_idle()
Date: Wed, 11 Apr 2018 20:36:40 +0200
Message-Id: <20180411183601.604910031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476836239327035?=
X-GMAIL-MSGID: =?utf-8?q?1597476836239327035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 8ab0b7dc73e1b3e2987d42554b2bff503f692772 ]

HW queues may be unmapped in some cases, such as blk_mq_update_nr_hw_queues(),
then we need to check it before calling blk_mq_tag_idle(), otherwise
the following kernel oops can be triggered, so fix it by checking if
the hw queue is unmapped since it doesn't make sense to idle the tags
any more after hw queues are unmapped.

[  440.771298] Workqueue: nvme-wq nvme_rdma_del_ctrl_work [nvme_rdma]
[  440.779104] task: ffff894bae755ee0 ti: ffff893bf9bc8000 task.ti: ffff893bf9bc8000
[  440.788359] RIP: 0010:[<ffffffffb730e2b4>]  [<ffffffffb730e2b4>] __blk_mq_tag_idle+0x24/0x40
[  440.798697] RSP: 0018:ffff893bf9bcbd10  EFLAGS: 00010286
[  440.805538] RAX: 0000000000000000 RBX: ffff895bb131dc00 RCX: 000000000000011f
[  440.814426] RDX: 00000000ffffffff RSI: 0000000000000120 RDI: ffff895bb131dc00
[  440.823301] RBP: ffff893bf9bcbd10 R08: 000000000001b860 R09: 4a51d361c00c0000
[  440.832193] R10: b5907f32b4cc7003 R11: ffffd6cabfb57000 R12: ffff894bafd1e008
[  440.841091] R13: 0000000000000001 R14: ffff895baf770000 R15: 0000000000000080
[  440.849988] FS:  0000000000000000(0000) GS:ffff894bbdcc0000(0000) knlGS:0000000000000000
[  440.859955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  440.867274] CR2: 0000000000000008 CR3: 000000103d098000 CR4: 00000000001407e0
[  440.876169] Call Trace:
[  440.879818]  [<ffffffffb7309d68>] blk_mq_exit_hctx+0xd8/0xe0
[  440.887051]  [<ffffffffb730dc40>] blk_mq_free_queue+0xf0/0x160
[  440.894465]  [<ffffffffb72ff679>] blk_cleanup_queue+0xd9/0x150
[  440.901881]  [<ffffffffc08a802b>] nvme_ns_remove+0x5b/0xb0 [nvme_core]
[  440.910068]  [<ffffffffc08a811b>] nvme_remove_namespaces+0x3b/0x60 [nvme_core]
[  440.919026]  [<ffffffffc08b817b>] __nvme_rdma_remove_ctrl+0x2b/0xb0 [nvme_rdma]
[  440.928079]  [<ffffffffc08b8237>] nvme_rdma_del_ctrl_work+0x17/0x20 [nvme_rdma]
[  440.937126]  [<ffffffffb70ab58a>] process_one_work+0x17a/0x440
[  440.944517]  [<ffffffffb70ac3a8>] worker_thread+0x278/0x3c0
[  440.951607]  [<ffffffffb70ac130>] ? manage_workers.isra.24+0x2a0/0x2a0
[  440.959760]  [<ffffffffb70b352f>] kthread+0xcf/0xe0
[  440.966055]  [<ffffffffb70b3460>] ? insert_kthread_work+0x40/0x40
[  440.973715]  [<ffffffffb76d8658>] ret_from_fork+0x58/0x90
[  440.980586]  [<ffffffffb70b3460>] ? insert_kthread_work+0x40/0x40
[  440.988229] Code: 5b 41 5c 5d c3 66 90 0f 1f 44 00 00 48 8b 87 20 01 00 00 f0 0f ba 77 40 01 19 d2 85 d2 75 08 c3 0f 1f 80 00 00 00 00 55 48 89 e5 <f0> ff 48 08 48 8d 78 10 e8 7f 0f 05 00 5d c3 0f 1f 00 66 2e 0f
[  441.011620] RIP  [<ffffffffb730e2b4>] __blk_mq_tag_idle+0x24/0x40
[  441.019301]  RSP <ffff893bf9bcbd10>
[  441.024052] CR2: 0000000000000008

Reported-by: Zhang Yi <yizhan@redhat.com>
Tested-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1634,7 +1634,8 @@ static void blk_mq_exit_hctx(struct requ
 {
 	unsigned flush_start_tag = set->queue_depth;
 
-	blk_mq_tag_idle(hctx);
+	if (blk_mq_hw_queue_mapped(hctx))
+		blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
 		set->ops->exit_request(set->driver_data,
