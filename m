Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+mHbhHREK/AyndPKWO4WmZmbW3t9dGlbm5w31Mf4eI+C0SaCMU9N4CXVxiBJtf+DOMLgL
ARC-Seal: i=1; a=rsa-sha256; t=1519981507; cv=none;
        d=google.com; s=arc-20160816;
        b=LYpZ3OQ1rL1Kh6Xy/lfvJ5PRuy8/MbyHT/z3E5ltpzWF4+9cE1bpH7OGMbkdUDmrIr
         /IHc9CYO1BBo8O1m1nZYNfUJADY992lOpm4Yu4CukA6D9RQVgF5DbCZnHYsaOoCNddAF
         49h5r6FVc0TJvZmJq0cgv1lxdNWKUVZz6wn5qEHLFzPC2rygwkJEH1V7e3MRWY2ofyiU
         KnLqTpQABx1loe7g9bzP8un/+8nB0SccgLICTrj7CW7DVMRs2p1iX2FAcevqUtNC6v6x
         pwCrrB3FtAR8FD81ldTaBHPcr4XdZKk56b52xJ5eDuaCXh3COOynt1iQCCc6RgUzxxpN
         CtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iphriPUKeAUCsdaXckCHUsMqlv85mRvh9DYDiE2ASt4=;
        b=jGFm7xLxb7rtMsu7v634eBPW4p45aHtf0RLJx15NMzEzBO0zxYHEJgnOyQuaB6gIZn
         0+WYgOx2yDvNcKjZ4nNYJlurs+xO6uEA3NQ7p/vgRa9LdBi70uspgmIeXQU7Gd/xDmiq
         jpb+kqqDfqt944PEeTqQ6s6WZ/mjH5itAVTujWoV8eBCDKX4/rcXbtl3VZJYT4/HX/6K
         f/gw6rOc04b3mZj4O1GN8DvvTSFHTtdmBJYJJTWKKkhQ9XPwQv22W9K0YNBOf57ek9h6
         CZif7d5sDvEyPZCbuT5YmV0RyzWdKtC0KPRCuCiNVGm6NogMsKhX63uEiQVzLFpPFUD6
         at8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Kapl <code@rkapl.cz>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.14 113/115] net: sched: crash on blocks with goto chain action
Date: Fri,  2 Mar 2018 09:51:56 +0100
Message-Id: <20180302084508.410381673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816128926878592?=
X-GMAIL-MSGID: =?utf-8?q?1593816128926878592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <code@rkapl.cz>

commit a60b3f515d30d0fe8537c64671926879a3548103 upstream.

tcf_block_put_ext has assumed that all filters (and thus their goto
actions) are destroyed in RCU callback and thus can not race with our
list iteration. However, that is not true during netns cleanup (see
tcf_exts_get_net comment).

Prevent the user after free by holding all chains (except 0, that one is
already held). foreach_safe is not enough in this case.

To reproduce, run the following in a netns and then delete the ns:
    ip link add dtest type dummy
    tc qdisc add dev dtest ingress
    tc filter add dev dtest chain 1 parent ffff: handle 1 prio 1 flower action goto chain 2

Fixes: 822e86d997 ("net_sched: remove tcf_block_put_deferred()")
Signed-off-by: Roman Kapl <code@rkapl.cz>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sched/cls_api.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -282,7 +282,8 @@ static void tcf_block_put_final(struct w
 	struct tcf_chain *chain, *tmp;
 
 	rtnl_lock();
-	/* Only chain 0 should be still here. */
+
+	/* At this point, all the chains should have refcnt == 1. */
 	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
 		tcf_chain_put(chain);
 	rtnl_unlock();
@@ -290,17 +291,23 @@ static void tcf_block_put_final(struct w
 }
 
 /* XXX: Standalone actions are not allowed to jump to any chain, and bound
- * actions should be all removed after flushing. However, filters are now
- * destroyed in tc filter workqueue with RTNL lock, they can not race here.
+ * actions should be all removed after flushing.
  */
 void tcf_block_put(struct tcf_block *block)
 {
-	struct tcf_chain *chain, *tmp;
+	struct tcf_chain *chain;
 
 	if (!block)
 		return;
 
-	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
+	/* Hold a refcnt for all chains, except 0, so that they don't disappear
+	 * while we are iterating.
+	 */
+	list_for_each_entry(chain, &block->chain_list, list)
+		if (chain->index)
+			tcf_chain_hold(chain);
+
+	list_for_each_entry(chain, &block->chain_list, list)
 		tcf_chain_flush(chain);
 
 	INIT_WORK(&block->work, tcf_block_put_final);
