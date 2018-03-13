Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIaddx+r8toXwLixmJhlcJJtwr9jzb2ZUVXRJ20ZYAHWqj2+syUJ1gw+XBgHKgI6rRYkYi
ARC-Seal: i=1; a=rsa-sha256; t=1520955161; cv=none;
        d=google.com; s=arc-20160816;
        b=N50oldfrcpSee5/9O4e75ylh8IWyPIh+MEn5OYXnYFpZiP8MivdtxtbsqkBBJjLckL
         mxcYQFHLu1k6FwDJ3ZIAA6bFhOdc2gtJusA5YhtfEbcDotlAbjf+hqaM6DRN+W7W8jT8
         rolzOaaIroj62gHDopOIHjGeo9tysZLu6/aSzWUqmoh0SNXZC9gU3R56LBreqox8ILu3
         VscyNsxF4BG+PR3JdYvbh+QKQ6cdBMEtGIIZESpaDOeHTDy4LhTl3116i8CxNGp9vTrZ
         ZVsSgk1bF6QZLnRKaSD/nhsbtFy72PQnaUdfzTDvltE45aolvxl11SElhmyJp69vceDx
         aYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wNqKVGIFzb4umxjek83Cr8D1ip49slBsRzk2xxs1Dos=;
        b=Pe5Ns4HWKFcACFRMN3Hccno1kPPi4T3WdqyUdKIxym+vHOz5C1b0at4dyAPkdZeuGR
         EvRb55oWQ03cl9fMqDXAKZ827MqAeDul7+LtlQIwp121unibYe2M9hZfe87lWjRNIKxv
         KqVcOWWVj4c7bOPFZG5wSjqojRyQYXfEZ626oMjidDkDhrzV9EdKN+H+sAvzeVUyI6Dt
         4Ie07DJJV6cTlJnIvAWRfpLoBz+h+ojcbd66wRt8AVK6GNyGWduCGFV/whbnI7YhP2NX
         EZJH8tBLl3P4uBndFE/TkULbPaA4V1SzT76n4ysguPw+p9Swts2usc41VbFOdpA/pmvO
         1bFw==
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
Subject: [PATCH 4.15 110/146] netfilter: xt_hashlimit: fix lock imbalance
Date: Tue, 13 Mar 2018 16:24:37 +0100
Message-Id: <20180313152328.902424893@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837079823728325?=
X-GMAIL-MSGID: =?utf-8?q?1594837079823728325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
