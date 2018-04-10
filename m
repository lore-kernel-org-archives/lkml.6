Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4960g3frqtJm70K8+lnj4nUGqWohagNr1jCm7Z+9dZnwoBYUo3Ca3TW8CSG0fauJWEgujdE
ARC-Seal: i=1; a=rsa-sha256; t=1523399556; cv=none;
        d=google.com; s=arc-20160816;
        b=fUuGHqmu70ICLT70J30uL9Xf/KhvILyjYAirHhhGA8WYWd2JwvL88fYi8mNlK//Sxc
         pZCvo37KAinh8x4XL86HxjyXggVMIpaXpbWC+gBOMlXRBUkLyYuE0YOk5eTDgS/qKI79
         7shPoF9Wodxh+f7ncnZF4MgDMNGkV1XjIki6HdYfIkq8y9dTPvNFZTZoY1VRxo3+WRss
         q+EVhee2fr5fB9hhx4hhmOx8o+ZSVxYWyA07yR5wfBXdnIzdgYpd53IYjau6L1+PZDAU
         41tjAfO4zWz1CsmA+TeXo5HTvSx5PgrIGtWCXh00pF5lwGTeWedfSGG/i631y8qUTCpK
         Gtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DWrCb97UBSLktHPCkxlFyRUO8zKbl9qN6sO9ey7pE2g=;
        b=QajC6R7qkM9dYgbDfSo1/G+Jf8f7YqY8vTRXO0M2B2RdgaOyiW5HmW0eU34hcJRiqj
         w4WuLCLZsI15msrP3bs++r2D9rEafk7dyRD+tm4YZKsj2gsD6+MDblX0JiUuKbISnvgb
         Rre4kyjex6MqOREZcBaGMPD6PN7Rwbz8Tr/QoAQcBXix+FhDmhyJMQixTIc1MziOnUMu
         8Gkb5eXBXzYxj5jeKE4LN04PNyDERWpby3GYgltHlyVFSha4KatWOVbKO8OHpqmvMW4r
         nsuXU+JSFmLVeklOoeoD9rxTbkWeCv8lcjYUNrejCnzLY8bTvv0Plovpojs1oSd9cS0j
         DeHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@mellanox.com>,
	Manish Kurup <manish.kurup@verizon.com>,
	Davide Caratti <dcaratti@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 151/168] net/sched: fix NULL dereference in the error path of tcf_vlan_init()
Date: Wed, 11 Apr 2018 00:24:53 +0200
Message-Id: <20180410212807.501749852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400213089958699?=
X-GMAIL-MSGID: =?utf-8?q?1597400213089958699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>


[ Upstream commit 1edf8abe04090c4f41a85e42c66638be1ee69156 ]

when the following command

 # tc actions replace action vlan pop index 100

is run for the first time, and tcf_vlan_init() fails allocating struct
tcf_vlan_params, tcf_vlan_cleanup() calls kfree_rcu(NULL, ...). This causes
the following error:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
 IP: __call_rcu+0x23/0x2b0
 PGD 80000000760a2067 P4D 80000000760a2067 PUD 742c1067 PMD 0
 Oops: 0002 [#1] SMP PTI
 Modules linked in: act_vlan(E) ip6table_filter ip6_tables iptable_filter binfmt_misc ext4 snd_hda_codec_generic snd_hda_intel mbcache snd_hda_codec jbd2 snd_hda_core crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc snd_hwdep snd_seq snd_seq_device snd_pcm aesni_intel crypto_simd snd_timer glue_helper snd cryptd joydev soundcore virtio_balloon pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm virtio_console virtio_blk virtio_net ata_piix crc32c_intel libata virtio_pci i2c_core virtio_ring serio_raw virtio floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: act_vlan]
 CPU: 3 PID: 3119 Comm: tc Tainted: G            E    4.16.0-rc4.act_vlan.orig+ #403
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:__call_rcu+0x23/0x2b0
 RSP: 0018:ffffaac3005fb798 EFLAGS: 00010246
 RAX: ffffffffc0704080 RBX: ffff97f2b4bbe900 RCX: 00000000ffffffff
 RDX: ffffffffabca5f00 RSI: 0000000000000010 RDI: 0000000000000010
 RBP: 0000000000000010 R08: 0000000000000001 R09: 0000000000000044
 R10: 00000000fd003000 R11: ffff97f2faab5b91 R12: 0000000000000000
 R13: ffffffffabca5f00 R14: ffff97f2fb80202c R15: 00000000fffffff4
 FS:  00007f68f75b4740(0000) GS:ffff97f2ffd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000018 CR3: 0000000072b52001 CR4: 00000000001606e0
 Call Trace:
  __tcf_idr_release+0x79/0xf0
  tcf_vlan_init+0x168/0x270 [act_vlan]
  tcf_action_init_1+0x2cc/0x430
  tcf_action_init+0xd3/0x1b0
  tc_ctl_action+0x18b/0x240
  rtnetlink_rcv_msg+0x29c/0x310
  ? _cond_resched+0x15/0x30
  ? __kmalloc_node_track_caller+0x1b9/0x270
  ? rtnl_calcit.isra.28+0x100/0x100
  netlink_rcv_skb+0xd2/0x110
  netlink_unicast+0x17c/0x230
  netlink_sendmsg+0x2cd/0x3c0
  sock_sendmsg+0x30/0x40
  ___sys_sendmsg+0x27a/0x290
  ? filemap_map_pages+0x34a/0x3a0
  ? __handle_mm_fault+0xbfd/0xe20
  __sys_sendmsg+0x51/0x90
  do_syscall_64+0x6e/0x1a0
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
 RIP: 0033:0x7f68f69c5ba0
 RSP: 002b:00007fffd79c1118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fffd79c1240 RCX: 00007f68f69c5ba0
 RDX: 0000000000000000 RSI: 00007fffd79c1190 RDI: 0000000000000003
 RBP: 000000005aaa708e R08: 0000000000000002 R09: 0000000000000000
 R10: 00007fffd79c0ba0 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007fffd79c1254 R14: 0000000000000001 R15: 0000000000669f60
 Code: 5d e9 42 da ff ff 66 90 0f 1f 44 00 00 41 57 41 56 41 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec 08 40 f6 c7 07 0f 85 19 02 00 00 <48> 89 75 08 48 c7 45 00 00 00 00 00 9c 58 0f 1f 44 00 00 49 89
 RIP: __call_rcu+0x23/0x2b0 RSP: ffffaac3005fb798
 CR2: 0000000000000018

fix this in tcf_vlan_cleanup(), ensuring that kfree_rcu(p, ...) is called
only when p is not NULL.

Fixes: 4c5b9d9642c8 ("act_vlan: VLAN action rewrite to use RCU lock/unlock and update")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Manish Kurup <manish.kurup@verizon.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_vlan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -225,7 +225,8 @@ static void tcf_vlan_cleanup(struct tc_a
 	struct tcf_vlan_params *p;
 
 	p = rcu_dereference_protected(v->vlan_p, 1);
-	kfree_rcu(p, rcu);
+	if (p)
+		kfree_rcu(p, rcu);
 }
 
 static int tcf_vlan_dump(struct sk_buff *skb, struct tc_action *a,
