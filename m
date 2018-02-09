Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nuLl75QjjRTx+LtXNvFdPqI9Enzqr3+9GNEkoRj/vGTgj3+TMn/Jv54Da9vaUQYcTv4gj
ARC-Seal: i=1; a=rsa-sha256; t=1518183996; cv=none;
        d=google.com; s=arc-20160816;
        b=UItd9NLm5Bcde7gR5ObHFfHUb1/IiejR0wedFzX9lvfVURDeZz0SidnrfEz2qssYK3
         BHwKMeD0l8x5OpURRT9jVdps+knTtWAiyWmGiUPfAQeOgo0gYNLVg9RL03NpGrqhiOru
         nyaR7q7z3oNa+QBwIKDPFhRg0PTWWBPBhNr9dFOEGb+p3o8BAqNjxKYndeB3XPA7120D
         4emvUVmbO6u/p60NdJfZNDWrviKgOu4FJ9/bHge6oCY1TxC8fTRSJwUBy1wTjP3DWvAA
         gNUtgisYF5MTm4OmGoYc/gB0/97yOQlWMH31WFLfGIC3FGIiPoxa7ZD715T8QcrQ8yje
         bn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x8o5i7OrcIrOQoiygLrvTFnlQKj0qZ7qHfFPJvqhmJI=;
        b=OUvH7ZhlXvY5Tyo8kUOJyiKibwPea+YURFPVQRKzK9gG5yiCz40KE1u/6T/7dbNsvo
         EqHZn2bm8EFroT06wvcQXFp5nqwd7J9A2kwf4V9f7+vzwrdPBX+1v+5/odI8VzDucbXw
         8k6gUPA9YxAmXAOlW0L0i4cZE29+2zklJ2EMslzYVCvI6ILRXfsaiEkvpy9qTH4QtqjK
         cUIR+RLRBkEGajSXGNoo8xSmN6H2Q359uNt6Qon2HkyQBr1toz/+IRCTjjWmUT3Wp/Gt
         Hy1cCU5rjTSPg3hbAScsR4UBVXWO0vmvpD5PZblsVovKrWWosHaDUWimeE73VaZErNce
         Y8JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 18/23] net: sched: fix use-after-free in tcf_block_put_ext
Date: Fri,  9 Feb 2018 14:40:16 +0100
Message-Id: <20180209133939.222647136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931302497150824?=
X-GMAIL-MSGID: =?utf-8?q?1591931302497150824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Pirko <jiri@mellanox.com>


[ Upstream commit df45bf84e4f5a48f23d4b1a07d21d566e8b587b2 ]

Since the block is freed with last chain being put, once we reach the
end of iteration of list_for_each_entry_safe, the block may be
already freed. I'm hitting this only by creating and deleting clsact:

[  202.171952] ==================================================================
[  202.180182] BUG: KASAN: use-after-free in tcf_block_put_ext+0x240/0x390
[  202.187590] Read of size 8 at addr ffff880225539a80 by task tc/796
[  202.194508]
[  202.196185] CPU: 0 PID: 796 Comm: tc Not tainted 4.15.0-rc2jiri+ #5
[  202.203200] Hardware name: Mellanox Technologies Ltd. "MSN2100-CB2F"/"SA001017", BIOS 5.6.5 06/07/2016
[  202.213613] Call Trace:
[  202.216369]  dump_stack+0xda/0x169
[  202.220192]  ? dma_virt_map_sg+0x147/0x147
[  202.224790]  ? show_regs_print_info+0x54/0x54
[  202.229691]  ? tcf_chain_destroy+0x1dc/0x250
[  202.234494]  print_address_description+0x83/0x3d0
[  202.239781]  ? tcf_block_put_ext+0x240/0x390
[  202.244575]  kasan_report+0x1ba/0x460
[  202.248707]  ? tcf_block_put_ext+0x240/0x390
[  202.253518]  tcf_block_put_ext+0x240/0x390
[  202.258117]  ? tcf_chain_flush+0x290/0x290
[  202.262708]  ? qdisc_hash_del+0x82/0x1a0
[  202.267111]  ? qdisc_hash_add+0x50/0x50
[  202.271411]  ? __lock_is_held+0x5f/0x1a0
[  202.275843]  clsact_destroy+0x3d/0x80 [sch_ingress]
[  202.281323]  qdisc_destroy+0xcb/0x240
[  202.285445]  qdisc_graft+0x216/0x7b0
[  202.289497]  tc_get_qdisc+0x260/0x560

Fix this by holding the block also by chain 0 and put chain 0
explicitly, out of the list_for_each_entry_safe loop at the very
end of tcf_block_put_ext.

Fixes: efbf78973978 ("net_sched: get rid of rcu_barrier() in tcf_block_put_ext()")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -343,23 +343,24 @@ void tcf_block_put_ext(struct tcf_block
 
 	if (!block)
 		return;
-	/* Hold a refcnt for all chains, except 0, so that they don't disappear
+	/* Hold a refcnt for all chains, so that they don't disappear
 	 * while we are iterating.
 	 */
 	list_for_each_entry(chain, &block->chain_list, list)
-		if (chain->index)
-			tcf_chain_hold(chain);
+		tcf_chain_hold(chain);
 
 	list_for_each_entry(chain, &block->chain_list, list)
 		tcf_chain_flush(chain);
 
 	tcf_block_offload_unbind(block, q, ei);
 
-	/* At this point, all the chains should have refcnt >= 1. Block will be
-	 * freed after all chains are gone.
-	 */
+	/* At this point, all the chains should have refcnt >= 1. */
 	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
 		tcf_chain_put(chain);
+
+	/* Finally, put chain 0 and allow block to be freed. */
+	chain = list_first_entry(&block->chain_list, struct tcf_chain, list);
+	tcf_chain_put(chain);
 }
 EXPORT_SYMBOL(tcf_block_put_ext);
 
