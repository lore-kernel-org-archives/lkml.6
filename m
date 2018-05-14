Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbY+MG0o8dnM5kbYIy3dxTaP5dr5n0sXKuzJMFQcfKo3/WuOEpjdDQV6IqmsxXu78N2Iws
ARC-Seal: i=1; a=rsa-sha256; t=1526280969; cv=none;
        d=google.com; s=arc-20160816;
        b=B74UegJt/zWJiEn1XBwg69rxdXQX1ugnvM1iO0T4U5SYKlaXRrba/RIf83z+0S1UCA
         4qTo8WjnglStpKkgOxfvoOv2rluTjN8T/EJiAS+vg1peeUb/dvz4kXvke65ZgmbVK+BL
         V898Ai134NM2kifqdVFgY2TNe6FSrJrVzZMDTFO65QPAddU9nOBV6zarKEe7AfgssgxB
         gCz3kthZQLaWUoE84Jp1LcOHurFRfLjZPBVvFlGz+ek8cifT0Viq+vGe53/bzNugDMT6
         T6V/P/HVQ8IVhPzd0FwuStF/8zwZ2AYHHxLLnDj0EirLHi0Q0/W0ymDbjKXdnq7dcTxu
         LtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XoxIZ5hq5uS3IEjL9AkGkg9GbTsMQo8xqFcuJ7Nytkg=;
        b=dUCGdZ9R7ga8My472TjxM7Ts6npPGczZ5d9VjrhRz0ify+iBjf0eu3yVUvgnz7VGCB
         Rvg5q7EXX9P+j4caJws34+n+p/UgorIkmC+BMKr6ujl4Tk6oDN/BjU+i+pjRd9TRUuIF
         nSeCwGJVSf8HvBxNyjNRQt+QDTDyGW092znXdzbNIqRiyucoVDXH5MI+HSqp5izMLIEk
         WkvnQBo7Yqp0WxVDC4wW1Mk6ZXLSQf6TTEp6CbZr94LK1Zvd2TejPRRodFLLG6iYYlDg
         zJOcuXPeSxot35ZNIjajMxyYu0MfSHianAsdha1eHVi5h5+BoG8FAB+EvcHC71pWCXX1
         0cGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TJevej8E;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TJevej8E;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/62] net: initialize skb->peeked when cloning
Date: Mon, 14 May 2018 08:48:23 +0200
Message-Id: <20180514064816.866161575@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421244637782425?=
X-GMAIL-MSGID: =?utf-8?q?1600421593947032627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
