Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49EzAMoryHj/IO4GlYNbEwAChldOh8j4GEOfihbzlPjgPnsWWyCyFlZ5Pt01DeDP8h3qNtD
ARC-Seal: i=1; a=rsa-sha256; t=1523981143; cv=none;
        d=google.com; s=arc-20160816;
        b=AXLP8H4qosvxnXfFlwmNKpIaoR1YN+VGZJEyd7mRX0qbLFOEGOfa+GA4y35euPmJCI
         gPwa1HtOBekGTfzA7WCIVBIqH68tuHCLoNlYMz8bJuF6iI1WCJtxp7dt+04rQUrrdI+f
         8PC/AJAF0ckAAN2OyOYdDrBnZ/cU1J/Yq0lMg5lA/tVbSs7TTFXd9qkxY0DdSOKNuVnH
         sXKd7khOU5ZvCen711W0oobFDKIHA9pT0JK8TA4gaNMPYGwuY6rsBIs47YlmBhaMSQH5
         SVJ3MFPeRxfSwGAOuDpKG64aspJUHAY3BQhZTSrzDzUPmlbTTwZWR+e3EohKkwcQE1DX
         fQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HNmDiLV3pQtl4G4Fgjuc1DObfoPrT07/+5KXD6qDihE=;
        b=VejC4fblEAWEH3WBf/pWQ7Pz6pM/l4OODGL60rfzlHEFa1XAddahIwEdBzcm/DxQ6e
         vEOUDvmgZnWtJnoRixy2QkIkTKLYzOfSEUT8ZliEWHXNNhxkjscAgOWYKoO/OawwPgMT
         KC35zeX3QE/7/PGX/xMzqqMnM+6fc+M4ePmjtIyWo3eCZzoK8a7Xt9Wza4okJkjjDHB8
         SViuoUnhFD0WFAv8jyFEMlF4LHwmwb9eZDSfWCzLUvIz9dGEjAAp03WRksKeDoTa5Ylg
         CcHc7JAyiqhzhKJGKgTmy1ZuIw1tjmOV557ABGUtzvKicGlTSRZeQeofyZg1b3M8iG1a
         Ue+A==
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
Subject: [PATCH 4.14 01/49] netfilter: ipset: Missing nfnl_lock()/nfnl_unlock() is added to ip_set_net_exit()
Date: Tue, 17 Apr 2018 17:58:40 +0200
Message-Id: <20180417155715.098569524@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010006841981086?=
X-GMAIL-MSGID: =?utf-8?q?1598010051909512816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
