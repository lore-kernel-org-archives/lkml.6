Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZosOFbrYQeJFp8oliVdbhNego4XRsfvPW0AN1Dw1bfH/HHPzloHUs0hoOTz34PBcDm6Kdba
ARC-Seal: i=1; a=rsa-sha256; t=1526280623; cv=none;
        d=google.com; s=arc-20160816;
        b=rQtfTrbTmVBd9jpK8y89mUYboz/NYLVTdP6b1v1vzoAc+Ulbk0Q9RdnPRMqc0RTp5f
         awY4Q6FhT5oLcMkotFfyq/+DIxFOECljzzlxqTQ9uxQg4VS5WPhUfBrml2xEcGrfJv+R
         7esY5NjxXZnH+2kYFFDQYe58E5kYFX576pXFJVNm9t7hR+tFQqVGsh1AoZujGfeK3rws
         aM7S2O0cd6QWk8cM1OLrh/9KSHZltEr8c/mb/f9jol2q9pClKwR37mSULuk3pJ41GkTy
         b5Gl1UV7KeVMk4/5RlF00QAfxzeA3EjIoT0dRePiVLrO3XeYKGiDC/k9hE5iuw9Qf7VX
         gUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eaVbnodZCVZJWfFHyAfhlZBoDb4+DhtxP6DB3l+tBYU=;
        b=VqN7R3A7VWM8eqiTG76Epau0QEn0SHXTj8aEEmB9Hv1YW/clE4MzDU4i3vpqb0H1OE
         S2QVpr2sgNfDH2Ynn40MrHDFd2Qa8rPQwxkDFwrk33FAYq0lN7ZY3deaAnfUWy3hkFDH
         n/UF9KL6aEyzjMR9lPQiV0csgS82/gjM99+sSE+3Y+u744/zsBh0HV6C6F0VwBPApvEg
         uYylh6xGC//ZORApwGgzjBA5ru184WkbZnkp/L7LSjOBoXpCC5ctNxZFlzlRYrfN7tGV
         1IpqsBalznqHS4pSP0NY3tlUnvmlXtWcUghoTaUoJycbc91bAYux7mU1vXNIqBkq0RQd
         gFMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oOSP6cwZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oOSP6cwZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 12/23] netlink: fix uninit-value in netlink_sendmsg
Date: Mon, 14 May 2018 08:48:41 +0200
Message-Id: <20180514064704.577027752@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421231527145500?=
X-GMAIL-MSGID: =?utf-8?q?1600421231527145500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1641,6 +1641,8 @@ static int netlink_sendmsg(struct kiocb
 
 	if (msg->msg_namelen) {
 		err = -EINVAL;
+		if (msg->msg_namelen < sizeof(struct sockaddr_nl))
+			goto out;
 		if (addr->nl_family != AF_NETLINK)
 			goto out;
 		dst_portid = addr->nl_pid;
