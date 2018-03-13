Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuF/+RuUAiLuH5LNtj94ViVWaUdOtZbXLpqCDce0plxx+UFzjKXpR3O/LynrL9gA+CL1Zm6
ARC-Seal: i=1; a=rsa-sha256; t=1520955326; cv=none;
        d=google.com; s=arc-20160816;
        b=DyhLlCSrCLsIFk7CzhOtZ6EeFY7lfi/yfwMeJaSVy1GC3VJcjIUeHionmxX+h6Jnlh
         UdcCiyf+a8giGNoX1Y+d0Zicg9+XMi50RkNgbi/RjatGESgWom3fRdfobvd5qOewO0Td
         JTyfBfW7KgD0SsOtURuCHctufft02dc+FG3PLdWwrC7SW9CcX4m5UerIx+x8DooAAvYR
         bdp8cHCz0liEjgerfqWkH9UKKPYHevBbCwrTeUHlWK6WNb45q7ZCrXmZfUbm9JwM+jtq
         AkBz4zzKzmeKi3Q8S+XTtRQkdBt6a93Z0/p1n9FmQuce+PJ4IXk1y7ZYKHnJaY+N5H7f
         8Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tcyzTHtWfaspblRfQoz9R/oIiDYcSubRPAqcIC2F/68=;
        b=VZEv1d97yqjHLe3G5rUxBIfVOd8E8GioZ2hlwcgNWp6uVQWs+IMY/gLcyogHFfWHda
         5wG05xWjY/vJV+ca3HENUHr8Lx32ygWG3JaCjpDDlNSKQ43OWvT7+2q3mdlSJhzxWc9g
         mnTfvsRQzM5s1dk9uTIiE/2KpD9AQ7o0wzXOgDdhaT+0BIcqR6MzHer1csuO1vm0X4LH
         7WkYqwE7EVluntRtyWs/XnDmiu8H2A2nXjWayGkwjNnDz+XkZAwVSX41QLdYx1uTiv8G
         OA5I+R0onX6ZHsTL+x2XFgEboMbdCClT/9DppyH/ZguSyMRlHFKnBby0klgCE043ozL4
         1pFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 011/140] netfilter: xt_hashlimit: fix lock imbalance
Date: Tue, 13 Mar 2018 16:23:34 +0100
Message-Id: <20180313152458.875947864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837079823728325?=
X-GMAIL-MSGID: =?utf-8?q?1594837252234186370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit de526f401284e1638d4c97cb5a4c292ac3f37655 upstream.

syszkaller found that rcu was not held in hashlimit_mt_common()

We only need to enable BH at this point.

Fixes: bea74641e378 ("netfilter: xt_hashlimit: add rate match mode")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_hashlimit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -774,7 +774,7 @@ hashlimit_mt_common(const struct sk_buff
 		if (!dh->rateinfo.prev_window &&
 		    (dh->rateinfo.current_rate <= dh->rateinfo.burst)) {
 			spin_unlock(&dh->lock);
-			rcu_read_unlock_bh();
+			local_bh_enable();
 			return !(cfg->mode & XT_HASHLIMIT_INVERT);
 		} else {
 			goto overlimit;
