Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+mYBuIBwmS+3iyKi+I/SpacS7pDlo22RJD4ify7qF21I3xvG8VZDX7zfbaxmU2Uh5uqNS
ARC-Seal: i=1; a=rsa-sha256; t=1519981510; cv=none;
        d=google.com; s=arc-20160816;
        b=CihBKwCrCsuxI18j+HUz7cETVM0L7IQRt09E50PKJ+IubAeBDncbjDCsyqzUlM+Knm
         1IC0bg3i5xBSl9vkuKAN5WA9rwZ1WN5sPCuv4p/CV6z2WrzjvQtnc2Jbtv34bkZ3Kh3O
         jWmu6HazcFAS2X9UajTo0s55iRRhn09tl5O3sz7vY6TJgGnNW6kUpmTNOJmDhlmS+AxC
         aJ6W1OFb1MZg6dQoKFOOMYaN497QKo+PsZU3oor/wqD7t1dr1nJbeptPr15LFEREUztM
         UDCTx1mO94T6KQmI/LVvQtVDOVwxxCaX6iGNGGyhmDqAoQlQ2O2PNYkuA/i7lwJr6IMj
         6pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yd3N0SGm2bBB2TF450ckDm+b2zMAlN1R/Vfg6L2AI8Q=;
        b=rNwBAOmiQAm5OneC2XVNxFRouotz6HiTDgN5/Dvel7XQDxWO3rI6pN2VxUmeQyNMo+
         IxoIxpLbavUIOHrQUjwCnO6azECE9U+N2XB14wLacZ7W8aEnnJ4foo6SPVnTJJ0tYDrz
         eOSEq55ftuWSp3WME6hfdeWcssC+kL2mXTpDAmSY3THfc98Nu0BfNOWBnscpvbhJliAD
         2yyPIAr5Qcug/R10LAq/rhCHwm4bhxkI/vohltMiLZBaIHd+OHFRrvIcV1BeEzaNp2Ya
         hGjR+oyhneRKjvt5BneBqtm/H8aRTFBN/zKlXcx/mR2qo33kor4nBLXmXiWcXkQJQ3kL
         93GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 114/115] net_sched: get rid of rcu_barrier() in tcf_block_put_ext()
Date: Fri,  2 Mar 2018 09:51:57 +0100
Message-Id: <20180302084508.453780017@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816132024733622?=
X-GMAIL-MSGID: =?utf-8?q?1593816132024733622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit efbf78973978b0d25af59bc26c8013a942af6e64 upstream.

Both Eric and Paolo noticed the rcu_barrier() we use in
tcf_block_put_ext() could be a performance bottleneck when
we have a lot of tc classes.

Paolo provided the following to demonstrate the issue:

tc qdisc add dev lo root htb
for I in `seq 1 1000`; do
        tc class add dev lo parent 1: classid 1:$I htb rate 100kbit
        tc qdisc add dev lo parent 1:$I handle $((I + 1)): htb
        for J in `seq 1 10`; do
                tc filter add dev lo parent $((I + 1)): u32 match ip src 1.1.1.$J
        done
done
time tc qdisc del dev root

real    0m54.764s
user    0m0.023s
sys     0m0.000s

The rcu_barrier() there is to ensure we free the block after all chains
are gone, that is, to queue tcf_block_put_final() at the tail of workqueue.
We can achieve this ordering requirement by refcnt'ing tcf block instead,
that is, the tcf block is freed only when the last chain in this block is
gone. This also simplifies the code.

Paolo reported after this patch we get:

real    0m0.017s
user    0m0.000s
sys     0m0.017s

Tested-by: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 include/net/sch_generic.h |    1 -
 net/sched/cls_api.c       |   29 +++++++++--------------------
 2 files changed, 9 insertions(+), 21 deletions(-)

--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -273,7 +273,6 @@ struct tcf_chain {
 
 struct tcf_block {
 	struct list_head chain_list;
-	struct work_struct work;
 };
 
 static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -211,8 +211,12 @@ static void tcf_chain_flush(struct tcf_c
 
 static void tcf_chain_destroy(struct tcf_chain *chain)
 {
+	struct tcf_block *block = chain->block;
+
 	list_del(&chain->list);
 	kfree(chain);
+	if (list_empty(&block->chain_list))
+		kfree(block);
 }
 
 static void tcf_chain_hold(struct tcf_chain *chain)
@@ -276,26 +280,12 @@ err_chain_create:
 }
 EXPORT_SYMBOL(tcf_block_get);
 
-static void tcf_block_put_final(struct work_struct *work)
-{
-	struct tcf_block *block = container_of(work, struct tcf_block, work);
-	struct tcf_chain *chain, *tmp;
-
-	rtnl_lock();
-
-	/* At this point, all the chains should have refcnt == 1. */
-	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
-		tcf_chain_put(chain);
-	rtnl_unlock();
-	kfree(block);
-}
-
 /* XXX: Standalone actions are not allowed to jump to any chain, and bound
  * actions should be all removed after flushing.
  */
 void tcf_block_put(struct tcf_block *block)
 {
-	struct tcf_chain *chain;
+	struct tcf_chain *chain, *tmp;
 
 	if (!block)
 		return;
@@ -310,12 +300,11 @@ void tcf_block_put(struct tcf_block *blo
 	list_for_each_entry(chain, &block->chain_list, list)
 		tcf_chain_flush(chain);
 
-	INIT_WORK(&block->work, tcf_block_put_final);
-	/* Wait for RCU callbacks to release the reference count and make
-	 * sure their works have been queued before this.
+	/* At this point, all the chains should have refcnt >= 1. Block will be
+	 * freed after all chains are gone.
 	 */
-	rcu_barrier();
-	tcf_queue_work(&block->work);
+	list_for_each_entry_safe(chain, tmp, &block->chain_list, list)
+		tcf_chain_put(chain);
 }
 EXPORT_SYMBOL(tcf_block_put);
 
