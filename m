Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtqVJcJWsHTwz19gt22XKL0/7AYMMe4xNywDP3akhUjmH5ETXDqAgSOPUl4h5hN+7R++7Sr
ARC-Seal: i=1; a=rsa-sha256; t=1519981325; cv=none;
        d=google.com; s=arc-20160816;
        b=ianHVKulwBt9APTOoL5UI0J6dF351CxaQTQ6vy8htLVfCoBcNSpw1/8fXfdL70tXLy
         M26OXKDt7AclU3lbRyv25+9638imifM69UwO1lfn6xUge/tuKAOLfVsihzcO0hSeQ3M5
         khAA8Kb0FHFnxFNbNrZlHLA86ebps+EltSQ9ryByYATxnEUMrL3JMYy/edLc2wayxkIF
         xVFvFPGrQ+A2V+/lpanIHVMxuGhWr2fXOyuBYVMvTB6Bf8O/jMfIDyX+gjhs5ZDn+d/M
         2m5voSzvGi8IqlaOeHmFo6+4pUWKBJ7qCkUZvjThD0KOUhzN70BNo0Y84jQe9eAfBEDf
         FZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WsrLbzVJZQ/j6K2oF+uAsev9corBk8q/YkiEjfldPl0=;
        b=rmB9DNJSSt8oy2e7OFA6nJ5sjXbgnqvJoPfXzqyxqZEJpWxWyERmhnRIUqGrDbqW5o
         xRY+XWxmjvq5VnWW8WPh4spwOEOaXyIF5awDWBJAzQq0BmD4u1Q4uTY8fN0ML22FnsGB
         r0dO5SR51ybG2Wor+FgJjzBvioytL4VhvPYbz1Qb/2V3B0ggg/V5zwAOMFQsPl693SMv
         j9KesZ4zyWIfCeA657JXz4bPY3+c3MFixbFmVuVYZyDgzxLLudJGDTwxpl/sLucTjcVI
         bcfvNGNal8gMbmHu8UEOqg+2kvmmhmpo5hR8uoo/KEDlrq/7t2mZ3LJiMp8LeBtNgmjw
         VQqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 057/115] tipc: fix tipc_mon_delete() oops in tipc_enable_bearer() error path
Date: Fri,  2 Mar 2018 09:51:00 +0100
Message-Id: <20180302084506.194074233@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815615517653649?=
X-GMAIL-MSGID: =?utf-8?q?1593815938556045725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>


[ Upstream commit 642a8439ddd8423b92f2e71960afe21ee1f66bb6 ]

Calling tipc_mon_delete() before the monitor has been created will oops.
This can happen in tipc_enable_bearer() error path if tipc_disc_create()
fails.

[   48.589074] BUG: unable to handle kernel paging request at 0000000000001008
[   48.590266] IP: tipc_mon_delete+0xea/0x270 [tipc]
[   48.591223] PGD 1e60c5067 P4D 1e60c5067 PUD 1eb0cf067 PMD 0
[   48.592230] Oops: 0000 [#1] SMP KASAN
[   48.595610] CPU: 5 PID: 1199 Comm: tipc Tainted: G    B            4.15.0-rc4-pc64-dirty #5
[   48.597176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
[   48.598489] RIP: 0010:tipc_mon_delete+0xea/0x270 [tipc]
[   48.599347] RSP: 0018:ffff8801d827f668 EFLAGS: 00010282
[   48.600705] RAX: ffff8801ee813f00 RBX: 0000000000000204 RCX: 0000000000000000
[   48.602183] RDX: 1ffffffff1de6a75 RSI: 0000000000000297 RDI: 0000000000000297
[   48.604373] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1dd1533
[   48.605607] R10: ffffffff8eafbb05 R11: fffffbfff1dd1534 R12: 0000000000000050
[   48.607082] R13: dead000000000200 R14: ffffffff8e73f310 R15: 0000000000001020
[   48.608228] FS:  00007fc686484800(0000) GS:ffff8801f5540000(0000) knlGS:0000000000000000
[   48.610189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.611459] CR2: 0000000000001008 CR3: 00000001dda70002 CR4: 00000000003606e0
[   48.612759] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   48.613831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   48.615038] Call Trace:
[   48.615635]  tipc_enable_bearer+0x415/0x5e0 [tipc]
[   48.620623]  tipc_nl_bearer_enable+0x1ab/0x200 [tipc]
[   48.625118]  genl_family_rcv_msg+0x36b/0x570
[   48.631233]  genl_rcv_msg+0x5a/0xa0
[   48.631867]  netlink_rcv_skb+0x1cc/0x220
[   48.636373]  genl_rcv+0x24/0x40
[   48.637306]  netlink_unicast+0x29c/0x350
[   48.639664]  netlink_sendmsg+0x439/0x590
[   48.642014]  SYSC_sendto+0x199/0x250
[   48.649912]  do_syscall_64+0xfd/0x2c0
[   48.650651]  entry_SYSCALL64_slow_path+0x25/0x25
[   48.651843] RIP: 0033:0x7fc6859848e3
[   48.652539] RSP: 002b:00007ffd25dff938 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   48.654003] RAX: ffffffffffffffda RBX: 00007ffd25dff990 RCX: 00007fc6859848e3
[   48.655303] RDX: 0000000000000054 RSI: 00007ffd25dff990 RDI: 0000000000000003
[   48.656512] RBP: 00007ffd25dff980 R08: 00007fc685c35fc0 R09: 000000000000000c
[   48.657697] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000d13010
[   48.658840] R13: 00007ffd25e009c0 R14: 0000000000000000 R15: 0000000000000000
[   48.662972] RIP: tipc_mon_delete+0xea/0x270 [tipc] RSP: ffff8801d827f668
[   48.664073] CR2: 0000000000001008
[   48.664576] ---[ end trace e811818d54d5ce88 ]---

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/monitor.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -633,9 +633,13 @@ void tipc_mon_delete(struct net *net, in
 {
 	struct tipc_net *tn = tipc_net(net);
 	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
-	struct tipc_peer *self = get_self(net, bearer_id);
+	struct tipc_peer *self;
 	struct tipc_peer *peer, *tmp;
 
+	if (!mon)
+		return;
+
+	self = get_self(net, bearer_id);
 	write_lock_bh(&mon->lock);
 	tn->monitors[bearer_id] = NULL;
 	list_for_each_entry_safe(peer, tmp, &self->list, list) {
