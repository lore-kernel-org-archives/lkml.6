Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo0iZpKmoNbleNag3xZ71dBt23gz3Uk2LvfawCqUOIVqrRfd4rox5/AGToYGko6CFzxxuN/
ARC-Seal: i=1; a=rsa-sha256; t=1526281156; cv=none;
        d=google.com; s=arc-20160816;
        b=QjcvJFuW2vg4ZXVMihiYjT+WFQ8pcZtI/yRM7Vm2Pj+HN+TZ9Eted5oFicQ9b93/v3
         /Sissnl6ez4zX8xt8mp8xq5vZiH2TNMRXPsAoVk8sfAGlk7CexoNdVBk9Pl72NG604Is
         e0kdhMtY5pEEWpe7SEytU7a3WYZhkA2/gFqB5F/TwdEHke3lSj6t/QNPn7HC9fUoN0bF
         jDlN4bGBrdNFyFQIwN8IzXnilMZG5pp8wSxTjEPHS2TDKTlLDpgM75QUjp6RmpIg8kPq
         Foue+Cvp6xZlVAdSefLMzdXxt15Qj470U9t55T5haz7qUd4yPk4j/KI4r13Oh6V/3ZDw
         JfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QJFTJ6mluCZ/tEmX5aASwXP8swxIAGuXKmKgWjsW3Dg=;
        b=nf5rn14FA0/v1muBkEGeohgVpp1/dvuNCLkxD7+76mC20+kmSdIkkpMjuBVvN0nxur
         e27w5D8bVGrJEMMeqxhT9yU+QVYz7Ycob5f3gYQo3OT8VrCQUH7raE3U8KejKVQGMCzv
         EzpMMssiPW5cC75K6MjQeHXHkUw7t3lkHzDdlX6kT5glGtnt9J37CCKsdKjtw89YxYun
         V8iDIzMGOcIMo1T//1jom9anXsp+uU6oTOqvA1Meafjhqqa7macZGts9JM47b5QBJ50E
         cBbwJuO5rXuVy0jr7XFNHB7rMcI9vyymZxVn6kXuCQh4r7I9dZ+k1F/10YySyY1eswNe
         8d1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0e2P1wQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V0e2P1wQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 09/72] net: initialize skb->peeked when cloning
Date: Mon, 14 May 2018 08:48:26 +0200
Message-Id: <20180514064823.444208327@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421244637782425?=
X-GMAIL-MSGID: =?utf-8?q?1600421789197657761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b13dda9f9aa7caceeee61c080c2e544d5f5d85e5 upstream.

syzbot reported __skb_try_recv_from_queue() was using skb->peeked
while it was potentially unitialized.

We need to clear it in __skb_clone()

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/skbuff.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -857,6 +857,7 @@ static struct sk_buff *__skb_clone(struc
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned = 1;
 	n->nohdr = 0;
+	n->peeked = 0;
 	n->destructor = NULL;
 	C(tail);
 	C(end);
