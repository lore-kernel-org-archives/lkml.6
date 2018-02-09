Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227AqWp1TsrXP5pwaAI0mRQ3xmZzK3rBBfjBINmOazkMmk7uneRRT0FjikpisA9ZZzfzLWg5
ARC-Seal: i=1; a=rsa-sha256; t=1518183919; cv=none;
        d=google.com; s=arc-20160816;
        b=JNhF0+8JRT3LtFVPjtW6OyimhC3l0n/ZL7y5SQf5n6I25FxIn/YvzzJbNahWTc0lP8
         7yimgstmwcZSqe74RoAWXtjqB9uEyNmJUwMaDtmxt8txe48Nu+fKDfcAoPXUNWHK/ZPi
         5ngW7qs1qfxEjAdpXwe0P1VA6x6AUGK6W3IyHVuZLzb65MRAcst2RalJZK1C8NeBzonV
         8oj4QZ8/b71IWOO52MaijR5aYKzGlkc3RiAUMXVqv7JLwEYDxIVRg4y9Y7P6GSinW1dS
         P1EP7VZSJqz9h/icTC/pxj94GjxiQPx3SQ1b0YXsFkpg7ggmaPwB21LrhqErdVGLIbmX
         jdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x9H2cezgBEN8e0mDqHwZzd9wrP0K/nVR9qaLmJ5dgoc=;
        b=VJhsotWFFnGyESNjS+hxE7dN46GZxn1iqR5UFJyCBtbHRUnNLECYdd2d7RpjkPeyy/
         qqDtd263ZGuVXfjV1guxw/dmZ8hLzBI7i/0XCWWj+B7BrXU7dUp2e2/lBlHbUmltG+UL
         q+K584VC0rywhd0adB040v7uV44q3tYhdXBerN4daL1P58XVlrEumxhHEOE0FLHNyzeo
         TqoNcg3FdsJeYBX52ZuNML1276Tdh0SSDnbzixtMEPJc54gsVFt2rLCtXvaRIW9LZ8UB
         phJNvZFDL9mRx5Ecbs2iQm+IabI2FstNynRSMzRB/iF+lh88DLYaZNompHpJpQMCPKIS
         Ol4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com,
	Craig Gallek <kraig@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/22] soreuseport: fix mem leak in reuseport_add_sock()
Date: Fri,  9 Feb 2018 14:40:05 +0100
Message-Id: <20180209133935.296314284@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930985749093640?=
X-GMAIL-MSGID: =?utf-8?q?1591931221972893742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 4db428a7c9ab07e08783e0fcdc4ca0f555da0567 ]

reuseport_add_sock() needs to deal with attaching a socket having
its own sk_reuseport_cb, after a prior
setsockopt(SO_ATTACH_REUSEPORT_?BPF)

Without this fix, not only a WARN_ONCE() was issued, but we were also
leaking memory.

Thanks to sysbot and Eric Biggers for providing us nice C repros.

------------[ cut here ]------------
socket already in reuseport group
WARNING: CPU: 0 PID: 3496 at net/core/sock_reuseport.c:119  
reuseport_add_sock+0x742/0x9b0 net/core/sock_reuseport.c:117
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 3496 Comm: syzkaller869503 Not tainted 4.15.0-rc6+ #245
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x211/0x2d0 lib/bug.c:184
  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079

Fixes: ef456144da8e ("soreuseport: define reuseport groups")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com
Acked-by: Craig Gallek <kraig@google.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock_reuseport.c |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -94,6 +94,16 @@ static struct sock_reuseport *reuseport_
 	return more_reuse;
 }
 
+static void reuseport_free_rcu(struct rcu_head *head)
+{
+	struct sock_reuseport *reuse;
+
+	reuse = container_of(head, struct sock_reuseport, rcu);
+	if (reuse->prog)
+		bpf_prog_destroy(reuse->prog);
+	kfree(reuse);
+}
+
 /**
  *  reuseport_add_sock - Add a socket to the reuseport group of another.
  *  @sk:  New socket to add to the group.
@@ -102,7 +112,7 @@ static struct sock_reuseport *reuseport_
  */
 int reuseport_add_sock(struct sock *sk, struct sock *sk2)
 {
-	struct sock_reuseport *reuse;
+	struct sock_reuseport *old_reuse, *reuse;
 
 	if (!rcu_access_pointer(sk2->sk_reuseport_cb)) {
 		int err = reuseport_alloc(sk2);
@@ -113,10 +123,13 @@ int reuseport_add_sock(struct sock *sk,
 
 	spin_lock_bh(&reuseport_lock);
 	reuse = rcu_dereference_protected(sk2->sk_reuseport_cb,
-					  lockdep_is_held(&reuseport_lock)),
-	WARN_ONCE(rcu_dereference_protected(sk->sk_reuseport_cb,
-					    lockdep_is_held(&reuseport_lock)),
-		  "socket already in reuseport group");
+					  lockdep_is_held(&reuseport_lock));
+	old_reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
+					     lockdep_is_held(&reuseport_lock));
+	if (old_reuse && old_reuse->num_socks != 1) {
+		spin_unlock_bh(&reuseport_lock);
+		return -EBUSY;
+	}
 
 	if (reuse->num_socks == reuse->max_socks) {
 		reuse = reuseport_grow(reuse);
@@ -134,19 +147,11 @@ int reuseport_add_sock(struct sock *sk,
 
 	spin_unlock_bh(&reuseport_lock);
 
+	if (old_reuse)
+		call_rcu(&old_reuse->rcu, reuseport_free_rcu);
 	return 0;
 }
 
-static void reuseport_free_rcu(struct rcu_head *head)
-{
-	struct sock_reuseport *reuse;
-
-	reuse = container_of(head, struct sock_reuseport, rcu);
-	if (reuse->prog)
-		bpf_prog_destroy(reuse->prog);
-	kfree(reuse);
-}
-
 void reuseport_detach_sock(struct sock *sk)
 {
 	struct sock_reuseport *reuse;
