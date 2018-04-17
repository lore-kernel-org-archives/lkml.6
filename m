Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cC4CLjOnMuqvK3hZIt1AoehuffLfbVvnuye0TUDy3AUmNXD7vDxVfVJTkCMo7bWqJFgkm
ARC-Seal: i=1; a=rsa-sha256; t=1523981100; cv=none;
        d=google.com; s=arc-20160816;
        b=UvDjAhnqSUIqceJ1ckmGY/jCKvso4oIDMxA85ikAhge0x7YK73mWTFPHPnt768Ue6i
         Qt+xzFmqrY4yZ3Xv0XZM0TQmtkyRR/dhjQFdRefKXVx0g47I03Y7OEZCHtfsSwAki0ER
         lb6uX3C89OuPL7fIiG4uGqUdiF7emjrDdzOv06c5Rm2wuEMbhSqrni3cWVugoEy8jQlS
         UYSpPdOLnPm+pZgkf0wt6h0Vf/DHzC+HKRCgzEWFCc9F6FrhTP10vs466IFwuSXnujdV
         KNHZIX7xw99S4BI81LlyLthJGc7qP8ee3bRXmr4gSuWAF9s1+sUvT1y0gfn1MvVAEf0i
         CL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q5a7jCvws31bSNQFuDqwYTPRLmIowFAbkt7+sTNESjw=;
        b=ReCSMLspjJ7XXxpuJEbFilZoubVPNPmtNywaglz4vuj8wa7I+NscPJxyAhet/hgzXC
         PWjF7GY2lzrj+o1QbdQRLGYg+TJ3CgaHJlFqChE6Ca3sBTq3vqCfXdeOYnxoBmVHwCAp
         bux/Mvs2CpHQ1qGPbwr7FmeaRePofQaqKdglOAS10AuBW+KQBkAW0A5m2/bdM4RpyHh4
         Ssk/7QeZgzT05PfdmQKMxO9eCcrj0liC+k5gGqAkuuQkpmh6J8fJN8SbvJoHxkVssif/
         Qrf4bgm4vnKPFT2GsztOuTKm+YhGblFUZK7RXXelhByYvludhVHFmT0IBqK9Yo/H2DIj
         IvVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	syzbot+36b06f219f2439fe62e1@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 02/53] netfilter: ipset: Missing nfnl_lock()/nfnl_unlock() is added to ip_set_net_exit()
Date: Tue, 17 Apr 2018 17:58:27 +0200
Message-Id: <20180417155723.188401861@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010006841981086?=
X-GMAIL-MSGID: =?utf-8?q?1598010006841981086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

commit f998b6b10144cd9809da6af02758615f789e8aa1 upstream.

Patch "netfilter: ipset: use nfnl_mutex_is_locked" is added the real
mutex locking check, which revealed the missing locking in ip_set_net_exit().

Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Reported-by: syzbot+36b06f219f2439fe62e1@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipset/ip_set_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -2055,6 +2055,7 @@ ip_set_net_exit(struct net *net)
 
 	inst->is_deleted = true; /* flag for ip_set_nfnl_put */
 
+	nfnl_lock(NFNL_SUBSYS_IPSET);
 	for (i = 0; i < inst->ip_set_max; i++) {
 		set = ip_set(inst, i);
 		if (set) {
@@ -2062,6 +2063,7 @@ ip_set_net_exit(struct net *net)
 			ip_set_destroy_set(set);
 		}
 	}
+	nfnl_unlock(NFNL_SUBSYS_IPSET);
 	kfree(rcu_dereference_protected(inst->ip_set_list, 1));
 }
 
