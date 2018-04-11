Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/iZhb4MgIQr5NfvQvoT6TdfNs/977+PKzf9R2WKC8Zdntu3b1E8IRXFL9xySeLURhEcDWo
ARC-Seal: i=1; a=rsa-sha256; t=1523473161; cv=none;
        d=google.com; s=arc-20160816;
        b=zolv/owlME0E2mYlgKbqNbfCNE5+Nw7r3Zv+ZcgXRL7wW8LIu4h/M0tHrOebCCs3fX
         5/n1hCj4YcTl5cGjyFAVtLRJp1xng7P4+n/PCZO9JFD9cIOKBMRXVUaOxXwiZFYXpUIa
         bzENiAbLgAr0ypoRAvt31ROSHv7b3sESDqKO69LXf9PNvR9bHhir9/1AddXYOEUwvIRu
         scaYH2vS3/LmIOCrWmg3Iu7d8xBXJwFAaYHSzSL3yo5vJoIue+JzEQLlJH260+GIdZVp
         8iU/gbXoOFpMs8teP/nViAqF8lP20WZkj3dfpWRgNn0Q7EEfFXtgZeC5sX1UAJ6O4Eq4
         I1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qo3cu2rfCELd7oi76+9W+UJao3nnHCNvBF/n8xBynis=;
        b=MQc2+6KwgkJU/iZ2r/j9Odi8fXIiJHP8ST5vEtlfAXnVwIqLzSLPPDzxIUbylH9YRK
         Lf7916P9ogh/aNxaUR065SbVB9MzNSvurNUoOOWreg6bvZlHZE3PxyPSayDdE0dLYVnp
         Thsp8/QHQ75BNGsBs53W561Efi0OOBH0eZcAb/mRUyHro/9qFEamNYids0EvvnrR9zt9
         +DaXLUpYSTh9GkZdMrXhOW7rFyeNF72FnipEo0L5FiJTS4+9n/WbuiHe45yUYQjDpOw5
         eQRoWaQ0Ksxhs0+WTrdDrNT5816dA9W073tgn6XNza/+hDtUqD/VZ+jifyXEwzEA0VNs
         e3sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 150/310] netfilter: conntrack: dont call iter for non-confirmed conntracks
Date: Wed, 11 Apr 2018 20:34:49 +0200
Message-Id: <20180411183628.890879702@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477393665205876?=
X-GMAIL-MSGID: =?utf-8?q?1597477393665205876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>


[ Upstream commit b0feacaad13a0aa9657c37ed80991575981e2e3b ]

nf_ct_iterate_cleanup_net currently calls iter() callback also for
conntracks on the unconfirmed list, but this is unsafe.

Acesses to nf_conn are fine, but some users access the extension area
in the iter() callback, but that does only work reliably for confirmed
conntracks (ct->ext can be reallocated at any time for unconfirmed
conntrack).

The seond issue is that there is a short window where a conntrack entry
is neither on the list nor in the table: To confirm an entry, it is first
removed from the unconfirmed list, then insert into the table.

Fix this by iterating the unconfirmed list first and marking all entries
as dying, then wait for rcu grace period.

This makes sure all entries that were about to be confirmed either are
in the main table, or will be dropped soon.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_core.c |   39 ++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1542,7 +1542,6 @@ get_next_corpse(struct net *net, int (*i
 	struct nf_conntrack_tuple_hash *h;
 	struct nf_conn *ct;
 	struct hlist_nulls_node *n;
-	int cpu;
 	spinlock_t *lockp;
 
 	for (; *bucket < nf_conntrack_htable_size; (*bucket)++) {
@@ -1564,24 +1563,40 @@ get_next_corpse(struct net *net, int (*i
 		cond_resched();
 	}
 
+	return NULL;
+found:
+	atomic_inc(&ct->ct_general.use);
+	spin_unlock(lockp);
+	local_bh_enable();
+	return ct;
+}
+
+static void
+__nf_ct_unconfirmed_destroy(struct net *net)
+{
+	int cpu;
+
 	for_each_possible_cpu(cpu) {
-		struct ct_pcpu *pcpu = per_cpu_ptr(net->ct.pcpu_lists, cpu);
+		struct nf_conntrack_tuple_hash *h;
+		struct hlist_nulls_node *n;
+		struct ct_pcpu *pcpu;
+
+		pcpu = per_cpu_ptr(net->ct.pcpu_lists, cpu);
 
 		spin_lock_bh(&pcpu->lock);
 		hlist_nulls_for_each_entry(h, n, &pcpu->unconfirmed, hnnode) {
+			struct nf_conn *ct;
+
 			ct = nf_ct_tuplehash_to_ctrack(h);
-			if (iter(ct, data))
-				set_bit(IPS_DYING_BIT, &ct->status);
+
+			/* we cannot call iter() on unconfirmed list, the
+			 * owning cpu can reallocate ct->ext at any time.
+			 */
+			set_bit(IPS_DYING_BIT, &ct->status);
 		}
 		spin_unlock_bh(&pcpu->lock);
 		cond_resched();
 	}
-	return NULL;
-found:
-	atomic_inc(&ct->ct_general.use);
-	spin_unlock(lockp);
-	local_bh_enable();
-	return ct;
 }
 
 void nf_ct_iterate_cleanup(struct net *net,
@@ -1596,6 +1611,10 @@ void nf_ct_iterate_cleanup(struct net *n
 	if (atomic_read(&net->ct.count) == 0)
 		return;
 
+	__nf_ct_unconfirmed_destroy(net);
+
+	synchronize_net();
+
 	while ((ct = get_next_corpse(net, iter, data, &bucket)) != NULL) {
 		/* Time to push up daises... */
 
