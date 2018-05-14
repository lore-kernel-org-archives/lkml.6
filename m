Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpcwaEm7Yej7HbLQdsPhZv9KiRJOG0DnKVohglsgk/20DOFzZHUt4IbjFFAAV9CSSJLSjKq
ARC-Seal: i=1; a=rsa-sha256; t=1526280797; cv=none;
        d=google.com; s=arc-20160816;
        b=SsxPVFnRzoF7k1fqaP6ILdW+auLXn6dws1p8+WOrP1gCMfddvrwcWhtylCB3yJjO1/
         142N074Zyk0unZJsX/biq1XXhTaiUfAW7H/S+rfXKb3efetr2cKSMbeuySVUSXUYoyoG
         L1w2O7qGJZHT3OGNgaU+d8+Fpj5T3ASClqlPV3KutNYNoTjqzCcMvrobXBnAgldTn2kT
         qVIQ+xpOLoWaEqis1bVFDVRJ65SzpXYp4i616cMXp6UZLCtdUdKPxNGWc70UoDECG15t
         4BUv6HzFQtb/vXdrMeZaUgvMDqCz2MCagWG+273Vvjb3EVNXLI2YF0VuwEl4gwI4Ryn9
         2o6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MaEKMbvtvgh6HsoSBb++yqVdqpVmSDhiTXXLv33Wy3c=;
        b=tuXUskmI6g9yTWyEZ4Ns/kICp+L1RUi7t/byXaBMBH8DzfdIy9yOQfmmQuUZuqDjX+
         ujU8O7wDQsz6G5/5/JVRslG0ZQXXefUqs23ry0wEn6kaKZXdOVCaAa32KdDJvDK0IQ83
         fi7NHkEnONWVHGs3tJqmhcUfQsF5MidksnqCRI606VR1aaEMg478mFqZZEOg6Vtd5I2Q
         m27W5JyIy+Zuvl32TgQToaiflISrQGw90ardX/COkeZ7mPUStvc80S4d112KkMGxZVZ4
         0Lk316axZIGGdYy8r8XcXLlbbsoicYmAzCcabqeIHoWZ20u+c2bvuNleKbFj4JIyuVu4
         e6tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jYTgAz2i;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jYTgAz2i;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 35/56] net: initialize skb->peeked when cloning
Date: Mon, 14 May 2018 08:48:40 +0200
Message-Id: <20180514064758.157135743@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421244637782425?=
X-GMAIL-MSGID: =?utf-8?q?1600421412849603816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -827,6 +827,7 @@ static struct sk_buff *__skb_clone(struc
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned = 1;
 	n->nohdr = 0;
+	n->peeked = 0;
 	n->destructor = NULL;
 	C(tail);
 	C(end);
