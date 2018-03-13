Return-Path: <jelsasser@appneta.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520919295; cv=none;
        d=google.com; s=arc-20160816;
        b=bssYcG/0ryQ9Njv54Fjc/wCNy8KgdMDIo4fUcaByQMiJsrda/qQ8ztTCh/QgtBTXVb
         5/VrWYdBPVzBcEIoGmqs3SMqepw94ywdmCOLixRvx+eQiF4od6pIfkQiwH5iALSzv71m
         VhV+VBQDHDanvQ4paJrX+xRjJhz8mCU987L0TwJvo/28twK/9deUILwXYJD+QCDAXeV4
         ropJoxWrDHAF4jVpx07ppQZkeO8hVTSvz++oZTwdC8noMtM5QSUc9wc3FWjtoBAOjXEl
         80bDP8dA1jy7uZsc10PiyBgkLLDQKloOkbD445eR3gjgtE7m94La2IyXYcPwhbemptGB
         TXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+C9QRfiazf9HUsqnEssuj2nDukPSST/RcV5959A9/EA=;
        b=aLGOkA/56LgMU2Vo1b7C0qMY93YCiUhYkh4zmKnhFvqmCF1L2u3wEVM3vfwO8Tjh95
         S+qFm7Ts/qLYaXkC1JZejf/E4gFSaqS8ocIMfBscs6VtYvRZ5hmS+MBiDVnSZ7g73u7I
         Jza/XNh4UJGEPpflBgpGMOpbsPbm8xx3fy/q5JnWU0LouLhokwPrm+YN2wD9+U14Wq0B
         6tGqszzopVEYuiR2ArAWmfJv5gXv7B5r+YoG1XstcLooGj5trH+BzXU8tzLY9rwubu/W
         1XUUUaC+wH+NSdGur24R8/2J5uglrhy4xSpKiFuSyEJgcseC/iFNjiHpWrKAzGPvwEmJ
         41Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=GioQIY8O;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=GioQIY8O;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
X-Google-Smtp-Source: AG47ELtT093xv1ThQRSy0Rybp7n1ExksUEpSO6CX0TnaDWCEMgzgx++af/w3YxxrpKAOZSbqHgA6iA==
From: Josh Elsasser <jelsasser@appneta.com>
To: davem@davemloft.net
Cc: Josh Elsasser <jelsasser@appneta.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Potapenko <glider@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	=?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] net: check before dereferencing netdev_ops during busy poll
Date: Mon, 12 Mar 2018 22:32:00 -0700
Message-Id: <20180313053248.13654-2-jelsasser@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180313053248.13654-1-jelsasser@appneta.com>
References: <20180313053248.13654-1-jelsasser@appneta.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594799470799291475?=
X-GMAIL-MSGID: =?utf-8?q?1594799470799291475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

init_dummy_netdev() leaves its netdev_ops pointer zeroed. This leads
to a NULL pointer dereference when sk_busy_loop fires against an iwlwifi
wireless adapter and checks napi->dev->netdev_ops->ndo_busy_poll.

Avoid this by ensuring napi->dev->netdev_ops is valid before following
the pointer, avoiding the following panic when busy polling on a dummy
netdev:

  BUG: unable to handle kernel NULL pointer dereference at 00000000000000c8
  IP: [<ffffffff817b4b72>] sk_busy_loop+0x92/0x2f0
  Call Trace:
   [<ffffffff815a3134>] ? uart_write_room+0x74/0xf0
   [<ffffffff817964a9>] sock_poll+0x99/0xa0
   [<ffffffff81223142>] do_sys_poll+0x2e2/0x520
   [<ffffffff8118d3fc>] ? get_page_from_freelist+0x3bc/0xa30
   [<ffffffff810ada22>] ? update_curr+0x62/0x140
   [<ffffffff811ea671>] ? __slab_free+0xa1/0x2a0
   [<ffffffff811ea671>] ? __slab_free+0xa1/0x2a0
   [<ffffffff8179dbb1>] ? skb_free_head+0x21/0x30
   [<ffffffff81221bd0>] ? poll_initwait+0x50/0x50
   [<ffffffff811eaa36>] ? kmem_cache_free+0x1c6/0x1e0
   [<ffffffff815a4884>] ? uart_write+0x124/0x1d0
   [<ffffffff810bd1cd>] ? remove_wait_queue+0x4d/0x60
   [<ffffffff810bd224>] ? __wake_up+0x44/0x50
   [<ffffffff81582731>] ? tty_write_unlock+0x31/0x40
   [<ffffffff8158c5c6>] ? tty_ldisc_deref+0x16/0x20
   [<ffffffff81584820>] ? tty_write+0x1e0/0x2f0
   [<ffffffff81587e50>] ? process_echoes+0x80/0x80
   [<ffffffff8120c17b>] ? __vfs_write+0x2b/0x130
   [<ffffffff8120d09a>] ? vfs_write+0x15a/0x1a0
   [<ffffffff81223455>] SyS_poll+0x75/0x100
   [<ffffffff819a6524>] entry_SYSCALL_64_fastpath+0x24/0xcf

Commit 79e7fff47b7b ("net: remove support for per driver ndo_busy_poll()")
indirectly fixed this upstream in linux-4.11 by removing the offending
pointer usage. No other users of napi->dev touch its netdev_ops.

Fixes: 060212928670 ("net: add low latency socket poll")
Fixes: ce6aea93f751 ("net: network drivers no longer need to implement ndo_busy_poll()") - 4.9.y
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8898618bf341..1f50c131ed15 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5042,7 +5042,10 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
 		goto out;
 
 	/* Note: ndo_busy_poll method is optional in linux-4.5 */
-	busy_poll = napi->dev->netdev_ops->ndo_busy_poll;
+	if (napi->dev->netdev_ops)
+		busy_poll = napi->dev->netdev_ops->ndo_busy_poll;
+	else
+		busy_poll = NULL;
 
 	do {
 		rc = 0;
-- 
2.11.0
