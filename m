Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZohVrTXm2IKHS+s59+fcvebWBVkav+CoO99U/VqjYciv7rdlyNAsrj3QmqFsyYHDaUeY4WL
ARC-Seal: i=1; a=rsa-sha256; t=1526280636; cv=none;
        d=google.com; s=arc-20160816;
        b=UzyDcdRV5QS/OISVFnd/+VJ97AeiOrUcAb4yQmLIX+yDEu8QbwjNTrBcorR+wXwEbz
         fByPb+HFxUDpmkLvUl0b0+Du+yi7J3MxgUwfTjjnepv1xJLlcuISsdS+Fac73WJ9jv8x
         6MODyFRAgwSkGC6QESaaV650Krzn7uYBq4hCfUsUYFt9CyHPCUl3fdu9pWmqerkuDw09
         YKNlqnbljdlUCQzMBneoAhkeCgWZiykBi8DjRQ3VdNGFwOJxlgtviF8z1rdvCMtR7ycV
         3jBFyFOKvhSfuDAQ8+l1lRCqZCaDbr0aAtOYkV5AmMKqsoxYfsCNkyNknoIRbDniG1LI
         B6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9U6DQ5OfVD4Yi87ysk4PbDYyrltKqliSuYv8tXT/Myc=;
        b=LNos0swO/adFlWbS5NuhzdO8JPRc3cyZLIWblgSvlHOmLrYR89T8IIVI4ZokVJy/1g
         R1JNDckjKeDmrxrF01jrUXM2xD4Hy8qxpUN9v/yCBY5vmiFoIYXZIfOHc50ehr0F89UE
         6YX8xgm6X94WEQoNy7Y6QeG5Dvh2sEwTS8ZH0vG4tev4eyg/Z/dtWso3gg24Rd+kRkZT
         GW6CydJl2PQf9UnaEOYxLDlpo1mj8HU+KzChBPUPjisESS4mXPav53FTlomTo6ahl8Q6
         mjE77qcOdQVm3W3vJr/Mf/RWpnyZFaMTpvCF0Pp19opughomDk4cRed85kjwBzsGspzW
         C2bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kZHfCiAg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kZHfCiAg;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 14/23] net: initialize skb->peeked when cloning
Date: Mon, 14 May 2018 08:48:43 +0200
Message-Id: <20180514064704.662614756@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421244637782425?=
X-GMAIL-MSGID: =?utf-8?q?1600421244637782425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -779,6 +779,7 @@ static struct sk_buff *__skb_clone(struc
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned = 1;
 	n->nohdr = 0;
+	n->peeked = 0;
 	n->destructor = NULL;
 	C(tail);
 	C(end);
