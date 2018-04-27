Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrtRiqYfvpDEl+Q/HfsId/chqotM759rl9ESHpnUvVtDholaTKryo50Rlw9L/BDNBwvheO8
ARC-Seal: i=1; a=rsa-sha256; t=1524837713; cv=none;
        d=google.com; s=arc-20160816;
        b=TqBWIVLe5BZVOWwu7+jbH6dhH68CqkXG96v2BDCmbELVLIb70vqtxZQJUucevMcbuG
         rkKiogwe9o9s8qTyVsnklVFgZ0wIm9bi7n2ELHOESYPIW8g4GZUmtQN50tTYzlklfFXr
         xx9658JWqrBbptxrzWkwXRY2kWMmcdPv06vzHpDBOKWrjEzN+HaDRt4mnL/cEYnZM2ZL
         vfBETIPpYDyUwREzlW5ylg8Yh/zFoNwKzbEihTbwKmGdUrsykSnkAejKtzYjqERCdJca
         WffuZqvRST4kcxGmVH9aThOTETCfPR4qen/Fyf+xKaTBjnP5LrRum3zoAxNaCW/Xc42B
         Lxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=VVFgD7InzZ1YnVMU256TSvHWfbS7bQXz9pcEstwcibs=;
        b=iim32rp5+bWnxRyKxUl4SmDg3hOhGEgoFK+HYVXIA4C8/8w6sVGkeUvWJUyWX8NUH6
         98ndFj8cKMTibH3wsnmxkp5+6uXXgRvq8OOA/jRQOL/5SXqnjktzFUnE7VIY1xsbTX5D
         soRAt2Trfz1hW84hwCV+9nQgQWptSQ8EwLmXGmOCy9/Ei+pHfnvunK5NuB/LKz1b3fxL
         z+K3QPOK+yiKxqWqlVpBs/4VWgpdOI2+aGg5cPK5w/obsl9Gr5aMKJ/5kR776RzAOnC7
         yKmbRJHmkzECJdP0SzZSW6gaMeD+HFb7UaD6oJ2xK9GXBaZNhIbJa57OZSInxwcw6DgI
         rfnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116E2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 37/50] pppoe: check sockaddr length in pppoe_connect()
Date: Fri, 27 Apr 2018 15:58:39 +0200
Message-Id: <20180427135657.874662228@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908020087873199?=
X-GMAIL-MSGID: =?utf-8?q?1598908229936936875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit a49e2f5d5fb141884452ddb428f551b123d436b5 ]

We must validate sockaddr_len, otherwise userspace can pass fewer data
than we expect and we end up accessing invalid data.

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Reported-by: syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pppoe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -638,6 +638,10 @@ static int pppoe_connect(struct socket *
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppox))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OE)
 		goto end;
 
