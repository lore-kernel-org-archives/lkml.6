Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNsgyBMKCneFkcPB64YHFt/txkSpZqEpXK/XhGLI52ooklEXZYgDQI6XGVOMrp/LbHwt8P
ARC-Seal: i=1; a=rsa-sha256; t=1520955164; cv=none;
        d=google.com; s=arc-20160816;
        b=ime+4CFLdfNoYiAxpCmzt1lYWaNk6jf3gDkl91i7a8aB5yUs+cQLqyjfLpsAad8iLj
         Q7XliIdDfXWYhtLURAcMnfKjm+Qhnwzl3Gjgx+xAUcwSzD3UaYEu7KgzwOg8mKxCuXee
         g11In3sFLDVho5mhp5oINyGw2PT4mzVbK2vl6Nn1LqF8JXXkIznKQxx+Vv+TgKf7TLsq
         RdP4o2ZLJwl6SEVqDj1AC709SeVFs4llb48ictad6xn68aJZH0jA5207ssRlzYRoGyxE
         /QeVGiVNAMf+BppaQnZ3tV9QvrucXBKHbgJXOwktdTqbpdVQ0rZP/ywszzLW+Lf+8mCW
         7jBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a7z6OXlyFm5GyMdPt4L0r+E2QQo48Ylhgt26VW7msKg=;
        b=0DMTaz4FHPDPTpmUVl7rZPxQA8DAiNAJGyDkUV2IzxdyMsTt7deR/sST/4D40tu8w2
         1d4yK+n+jDCdw2SFQihLCkrhD9LANBYwWfRZs24yGMuyUGs1LKFpfR4o0N+FcusKe8Bv
         yBIAR83QUm86vAeYARqeYm7PbUhFujkDLR7sGEEADtON7WOTXHs0lPg/1pCZ/fexlGD1
         Mpv/5hrZRqhiXt9Tjk5haxYKVzne2j8wsHomMBLM7hzUyctgTvd90YiY3+ViNGdp2b06
         f4j7CJY67pnUx7qzbLgIgp4MSxNinhl///fSua6Uidajj64Eo3xIOZEBAtAOAedov4Fi
         ivdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+10c98dc5725c6c8fc7fb@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 111/146] netfilter: x_tables: fix missing timer initialization in xt_LED
Date: Tue, 13 Mar 2018 16:24:38 +0100
Message-Id: <20180313152328.983597937@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837082696506724?=
X-GMAIL-MSGID: =?utf-8?q?1594837082696506724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 10414014bc085aac9f787a5890b33b5605fbcfc4 upstream.

syzbot reported that xt_LED may try to use the ledinternal->timer
without previously initializing it:

------------[ cut here ]------------
kernel BUG at kernel/time/timer.c:958!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 1826 Comm: kworker/1:2 Not tainted 4.15.0+ #306
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__mod_timer kernel/time/timer.c:958 [inline]
RIP: 0010:mod_timer+0x7d6/0x13c0 kernel/time/timer.c:1102
RSP: 0018:ffff8801d24fe9f8 EFLAGS: 00010293
RAX: ffff8801d25246c0 RBX: ffff8801aec6cb50 RCX: ffffffff816052c6
RDX: 0000000000000000 RSI: 00000000fffbd14b RDI: ffff8801aec6cb68
RBP: ffff8801d24fec98 R08: 0000000000000000 R09: 1ffff1003a49fd6c
R10: ffff8801d24feb28 R11: 0000000000000005 R12: dffffc0000000000
R13: ffff8801d24fec70 R14: 00000000fffbd14b R15: ffff8801af608f90
FS:  0000000000000000(0000) GS:ffff8801db500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000206d6fd0 CR3: 0000000006a22001 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  led_tg+0x1db/0x2e0 net/netfilter/xt_LED.c:75
  ip6t_do_table+0xc2a/0x1a30 net/ipv6/netfilter/ip6_tables.c:365
  ip6table_raw_hook+0x65/0x80 net/ipv6/netfilter/ip6table_raw.c:42
  nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
  nf_hook_slow+0xba/0x1a0 net/netfilter/core.c:483
  nf_hook.constprop.27+0x3f6/0x830 include/linux/netfilter.h:243
  NF_HOOK include/linux/netfilter.h:286 [inline]
  ndisc_send_skb+0xa51/0x1370 net/ipv6/ndisc.c:491
  ndisc_send_ns+0x38a/0x870 net/ipv6/ndisc.c:633
  addrconf_dad_work+0xb9e/0x1320 net/ipv6/addrconf.c:4008
  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
Code: 85 2a 0b 00 00 4d 8b 3c 24 4d 85 ff 75 9f 4c 8b bd 60 fd ff ff e8 bb
57 10 00 65 ff 0d 94 9a a1 7e e9 d9 fc ff ff e8 aa 57 10 00 <0f> 0b e8 a3
57 10 00 e9 14 fb ff ff e8 99 57 10 00 4c 89 bd 70
RIP: __mod_timer kernel/time/timer.c:958 [inline] RSP: ffff8801d24fe9f8
RIP: mod_timer+0x7d6/0x13c0 kernel/time/timer.c:1102 RSP: ffff8801d24fe9f8
---[ end trace f661ab06f5dd8b3d ]---

The ledinternal struct can be shared between several different
xt_LED targets, but the related timer is currently initialized only
if the first target requires it. Fix it by unconditionally
initializing the timer struct.

v1 -> v2: call del_timer_sync() unconditionally, too.

Fixes: 268cb38e1802 ("netfilter: x_tables: add LED trigger target")
Reported-by: syzbot+10c98dc5725c6c8fc7fb@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_LED.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -142,9 +142,10 @@ static int led_tg_check(const struct xt_
 		goto exit_alloc;
 	}
 
-	/* See if we need to set up a timer */
-	if (ledinfo->delay > 0)
-		timer_setup(&ledinternal->timer, led_timeout_callback, 0);
+	/* Since the letinternal timer can be shared between multiple targets,
+	 * always set it up, even if the current target does not need it
+	 */
+	timer_setup(&ledinternal->timer, led_timeout_callback, 0);
 
 	list_add_tail(&ledinternal->list, &xt_led_triggers);
 
@@ -181,8 +182,7 @@ static void led_tg_destroy(const struct
 
 	list_del(&ledinternal->list);
 
-	if (ledinfo->delay > 0)
-		del_timer_sync(&ledinternal->timer);
+	del_timer_sync(&ledinternal->timer);
 
 	led_trigger_unregister(&ledinternal->netfilter_led_trigger);
 
