Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr9jXJnT7t2CB82WB4ButAfiC527qX9KMQ3y0ZRWhahO2ZovZWff9f0IizG7MhEzzg0wFUn
ARC-Seal: i=1; a=rsa-sha256; t=1526280964; cv=none;
        d=google.com; s=arc-20160816;
        b=etVbSK+fG7fxh/rCt0mX3MwQn+E8VOAUDltYx/ZTIaNKhvBe5Wab/LuWog+ZdZby1B
         ODzl+fudEUR7VKEslOLk8zcwbmqFDUnktJTRsV5MVSDNaGSd+IoeqSCwxvLjbcb/qF3y
         XFFQLUl3emxX330PZ0jtgKAjmYIbKghe+ctYBeLk3gx++ZeQ+LH+owm4m6RLkdnBFVJv
         HBRhFC/0SSpI635LaWjEihy6oMhbz2Cmmvk75zkA3fQisJeqYZyHu+bMCfnFTcBMT2IY
         UzOd0d5rIzWjf+hzXrmydiDqrkx2dfaHMnlckrwX8Xbe2JRrqVxNR2rBT/kSgcPRBBNk
         3usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=RY6VrC9lzmAjGxBlcrv9ls0oK2+q6n1wK1sFKNFk6FQ=;
        b=b6dvNmn/Laxv/0hwNOW4cGNf6xOGXIPfPJ7TO48g1/5y2KkRhmK5nndtJo7xeIhhJ5
         NXUgMJ7W7NWxnt3WQgnwneGZWnieG6VfgM2teAmcvsiQR9PjZ/ruutTJIaW0m6FGy/I0
         DoJxBL6DOfvSj60EwrlbLv5F8Jh9PKXaiRGq+f06G3weDhvQIIF0fndS8OlmwIYJCefC
         /qfHZGjQzn3ZVciteiFkvgIKj/LyvMZohhltxRDWREvfTjIqgbKOjfMFFAKuz/5HjvDN
         rafdvidC/JkFEBDiW9W5chAu1g6IN1UsezBYyVAxq7uhoFm5tOT98BPfcp8/5lQwGnmc
         ijUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qJ8iXLVq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qJ8iXLVq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/62] netlink: fix uninit-value in netlink_sendmsg
Date: Mon, 14 May 2018 08:48:21 +0200
Message-Id: <20180514064816.742112290@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421231527145500?=
X-GMAIL-MSGID: =?utf-8?q?1600421588414442843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 6091f09c2f79730d895149bcfe3d66140288cd0e upstream.

syzbot reported :

BUG: KMSAN: uninit-value in ffs arch/x86/include/asm/bitops.h:432 [inline]
BUG: KMSAN: uninit-value in netlink_sendmsg+0xb26/0x1310 net/netlink/af_netlink.c:1851

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1813,6 +1813,8 @@ static int netlink_sendmsg(struct socket
 
 	if (msg->msg_namelen) {
 		err = -EINVAL;
+		if (msg->msg_namelen < sizeof(struct sockaddr_nl))
+			goto out;
 		if (addr->nl_family != AF_NETLINK)
 			goto out;
 		dst_portid = addr->nl_pid;
