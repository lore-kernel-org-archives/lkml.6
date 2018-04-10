Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+HtMqopwWAQT5+nFwCbdh3/HIa06UgRbY3003P5Wx9ee9n6D9NpNSDAYvxaAze4hFttjSP
ARC-Seal: i=1; a=rsa-sha256; t=1523399629; cv=none;
        d=google.com; s=arc-20160816;
        b=ssWrgReW6jbl6A3cBYVHize7UwDtCEKijy+cTB1dJHq3pvn+0ZrmT01ipO3EVW/RW8
         QqMrUKK/dWJsr8Ppm3jC2c4yXnU+L26ZvtFHefE4gp6RCWGLDcLBHmdUVUEb55qXh5Vi
         zC6mJalR1+00snYTBcDSau7vlhwCoH1T5AbXFgkWTdGKFNdG14MoghEOETTDV+UMWw0d
         LOBZm6Z4B3lIrsaLa4JQ0HT/TjvqZ5nmqDPGTYRlIV/X1grLucBqMkb9y6EvribRSptZ
         c/7G+hDM0sJuV7fAOxOUdXEQttFpffiD6DcUjVylembS7FQXkpF8LYcN83B92S5qlWr6
         4I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U9Gx+NZ2Ql2ot7LDsoRYLio5+v+jN+YjFDPvVeSVPqo=;
        b=Z++KvNqSX8oXrlBT1pE8XmgkTkuv6YwU9JazsIDBXtmtnvZLZyMfImDET+YhOlo6QX
         rqfmyO5dCPY34Om0KJ6nsiqOPVpdAZDf9xme/NTW+JkPqaSNIJAlYmSn+VvNviQUIFj7
         y+qbGTQy7vC3uXP3YZJg7P3ClIRWkMT61QKnWUs8S3ptQCgSoYlE/sN5aRQNjk/mHLud
         pwhEPgHCVsXnZswzPWx8OL1/0ZR1ehQKu+vKis13NSVUs2omFuKMiDHq1GbQnUQsHYEf
         8z3aV6tfi/cD44h6acB8xzVEFE2DSuVF37cDAcjPNMF8hbVmJlWUh8sKk4gjChQ0UW7a
         kftw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 154/168] net/sched: fix NULL dereference in the error path of tcf_sample_init()
Date: Wed, 11 Apr 2018 00:24:56 +0200
Message-Id: <20180410212807.622511768@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400290197413139?=
X-GMAIL-MSGID: =?utf-8?q?1597400290197413139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>


[ Upstream commit 1f110e7cae09e6c6a144616480d1a9dd99c5208a ]

when the following command

 # tc action add action sample rate 100 group 100 index 100

is run for the first time, and psample_group_get(100) fails to create a
new group, tcf_sample_cleanup() calls psample_group_put(NULL), thus
causing the following error:

 BUG: unable to handle kernel NULL pointer dereference at 000000000000001c
 IP: psample_group_put+0x15/0x71 [psample]
 PGD 8000000075775067 P4D 8000000075775067 PUD 7453c067 PMD 0
 Oops: 0002 [#1] SMP PTI
 Modules linked in: act_sample(E) psample ip6table_filter ip6_tables iptable_filter binfmt_misc ext4 snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core mbcache jbd2 crct10dif_pclmul snd_hwdep crc32_pclmul snd_seq ghash_clmulni_intel pcbc snd_seq_device snd_pcm aesni_intel crypto_simd snd_timer glue_helper snd cryptd joydev pcspkr i2c_piix4 soundcore virtio_balloon nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm virtio_net ata_piix virtio_console virtio_blk libata serio_raw crc32c_intel virtio_pci i2c_core virtio_ring virtio floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: act_tunnel_key]
 CPU: 2 PID: 5740 Comm: tc Tainted: G            E    4.16.0-rc4.act_vlan.orig+ #403
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:psample_group_put+0x15/0x71 [psample]
 RSP: 0018:ffffb8a80032f7d0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000024
 RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffffc06d93c0
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000044
 R10: 00000000bd003000 R11: ffff979fba04aa59 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff979fbba3f22c
 FS:  00007f7638112740(0000) GS:ffff979fbfd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000001c CR3: 00000000734ea001 CR4: 00000000001606e0
 Call Trace:
  __tcf_idr_release+0x79/0xf0
  tcf_sample_init+0x125/0x1d0 [act_sample]
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
 RIP: 0033:0x7f7637523ba0
 RSP: 002b:00007fff0473ef58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fff0473f080 RCX: 00007f7637523ba0
 RDX: 0000000000000000 RSI: 00007fff0473efd0 RDI: 0000000000000003
 RBP: 000000005aaaac80 R08: 0000000000000002 R09: 0000000000000000
 R10: 00007fff0473e9e0 R11: 0000000000000246 R12: 0000000000000000
 R13: 00007fff0473f094 R14: 0000000000000001 R15: 0000000000669f60
 Code: be 02 00 00 00 48 89 df e8 a9 fe ff ff e9 7c ff ff ff 0f 1f 40 00 0f 1f 44 00 00 53 48 89 fb 48 c7 c7 c0 93 6d c0 e8 db 20 8c ef <83> 6b 1c 01 74 10 48 c7 c7 c0 93 6d c0 ff 14 25 e8 83 83 b0 5b
 RIP: psample_group_put+0x15/0x71 [psample] RSP: ffffb8a80032f7d0
 CR2: 000000000000001c

Fix it in tcf_sample_cleanup(), ensuring that calls to psample_group_put(p)
are done only when p is not NULL.

Fixes: cadb9c9fdbc6 ("net/sched: act_sample: Fix error path in init")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_sample.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -103,7 +103,8 @@ static void tcf_sample_cleanup(struct tc
 
 	psample_group = rtnl_dereference(s->psample_group);
 	RCU_INIT_POINTER(s->psample_group, NULL);
-	psample_group_put(psample_group);
+	if (psample_group)
+		psample_group_put(psample_group);
 }
 
 static bool tcf_sample_dev_ok_push(struct net_device *dev)
