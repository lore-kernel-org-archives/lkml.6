Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOyN5LXmbFfntk/Mai9a60NP67aHv3fER4zKVFG7cePA+4AWQlZLpidEEAPMhZHmEuPvbF
ARC-Seal: i=1; a=rsa-sha256; t=1521214683; cv=none;
        d=google.com; s=arc-20160816;
        b=dYAxvNUKisGaoHDMriyica7fc5k5pxT0oI358+dh1yeEIxrkK3+8ZpAFTLfmsTXbrO
         qR7OJoQLq+0um9TfDgYDLFNlSjs7JCr9PJ4p1aXUIqLkMhwZuJSOJK1eypqBjU8bA4Re
         sCGX7mJA5w3TwPiC1ADuxVhgrYskjBN28i9bBM32WALBPLqCBZeITIhTIx3xpirEFY1j
         0WCq27GlDuGHvIjHhsaG9XaOEnVNzHlOEvXqGYJYfcIU+6g+7lVXWdj/FCQ2EvPn5b76
         0QJB5DxcDAeHWmNXukxyzSAXuoR+/EgxlCLXNHIbFUW3tUGiE+3j3XT8y/QoFWmJZhSM
         0JeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5PEtK9Uj8hiBeM64O6TtgfPSVdQdNAnRVNoLdQb1F1Y=;
        b=QOgi3LYjNbsmgq9Yk4BCAU0InGsrozOzAno3Ppp8qbmluSlOAGMur6WLJSm6x/Gi6V
         TRSc5iTX+VKY0AzlgXRj0bDH/iCZjOrcSc50910lem+SoyAAicYO5JCO9rruR9zuslK/
         WrfZtmNhtUo4GQbvnMiAqMZ3x4cx8BwuXPeN0uUDlS+7aGrmnSVKLYZaDm4kuwZY84gu
         yzTxXJF3NiboY8BRcgKhsF9evoSzaJe8D4px5wrNqgNivjMLIzr9XJ9Aplo1SEyD5DUP
         daojO+yWgusHQ8V7DiwSF0yAohHmXM5VQjCuKO7PfZm2YblpV2dctmeJTLeRyVH7dmsb
         Cbdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 090/109] net: sched: drop qdisc_reset from dev_graft_qdisc
Date: Fri, 16 Mar 2018 16:23:59 +0100
Message-Id: <20180316152334.821254067@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109207660390965?=
X-GMAIL-MSGID: =?utf-8?q?1595109207660390965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>


[ Upstream commit 7bbde83b1860c28a1cc35516352c4e7e5172c29a ]

In qdisc_graft_qdisc a "new" qdisc is attached and the 'qdisc_destroy'
operation is called on the old qdisc. The destroy operation will wait
a rcu grace period and call qdisc_rcu_free(). At which point
gso_cpu_skb is free'd along with all stats so no need to zero stats
and gso_cpu_skb from the graft operation itself.

Further after dropping the qdisc locks we can not continue to call
qdisc_reset before waiting an rcu grace period so that the qdisc is
detached from all cpus. By removing the qdisc_reset() here we get
the correct property of waiting an rcu grace period and letting the
qdisc_destroy operation clean up the qdisc correctly.

Note, a refcnt greater than 1 would cause the destroy operation to
be aborted however if this ever happened the reference to the qdisc
would be lost and we would have a memory leak.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_generic.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -743,10 +743,6 @@ struct Qdisc *dev_graft_qdisc(struct net
 	root_lock = qdisc_lock(oqdisc);
 	spin_lock_bh(root_lock);
 
-	/* Prune old scheduler */
-	if (oqdisc && refcount_read(&oqdisc->refcnt) <= 1)
-		qdisc_reset(oqdisc);
-
 	/* ... and graft new one */
 	if (qdisc == NULL)
 		qdisc = &noop_qdisc;
@@ -897,6 +893,16 @@ static bool some_qdisc_is_busy(struct ne
 	return false;
 }
 
+static void dev_qdisc_reset(struct net_device *dev,
+			    struct netdev_queue *dev_queue,
+			    void *none)
+{
+	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+
+	if (qdisc)
+		qdisc_reset(qdisc);
+}
+
 /**
  * 	dev_deactivate_many - deactivate transmissions on several devices
  * 	@head: list of devices to deactivate
@@ -907,7 +913,6 @@ static bool some_qdisc_is_busy(struct ne
 void dev_deactivate_many(struct list_head *head)
 {
 	struct net_device *dev;
-	bool sync_needed = false;
 
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_deactivate_queue,
@@ -917,20 +922,25 @@ void dev_deactivate_many(struct list_hea
 					     &noop_qdisc);
 
 		dev_watchdog_down(dev);
-		sync_needed |= !dev->dismantle;
 	}
 
 	/* Wait for outstanding qdisc-less dev_queue_xmit calls.
 	 * This is avoided if all devices are in dismantle phase :
 	 * Caller will call synchronize_net() for us
 	 */
-	if (sync_needed)
-		synchronize_net();
+	synchronize_net();
 
 	/* Wait for outstanding qdisc_run calls. */
-	list_for_each_entry(dev, head, close_list)
+	list_for_each_entry(dev, head, close_list) {
 		while (some_qdisc_is_busy(dev))
 			yield();
+		/* The new qdisc is assigned at this point so we can safely
+		 * unwind stale skb lists and qdisc statistics
+		 */
+		netdev_for_each_tx_queue(dev, dev_qdisc_reset, NULL);
+		if (dev_ingress_queue(dev))
+			dev_qdisc_reset(dev, dev_ingress_queue(dev), NULL);
+	}
 }
 
 void dev_deactivate(struct net_device *dev)
