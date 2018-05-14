Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp1ryFh5D4foIAEUH8dRnmwPVoN5spn9npd2HBpY+Zs2BBXfB+vKrbg8hCvkXfYXzcxtFnP
ARC-Seal: i=1; a=rsa-sha256; t=1526280791; cv=none;
        d=google.com; s=arc-20160816;
        b=frLmtSSx9X6QX+ybSP+aVLOtw6zl+Jj0DC//zUVD2qxEiqyL4NuL0yRGjl3Aw4VcGp
         gpiX+HcUj+xzcEzHiZOnaJBFd/qEvIEBmfU3dsizhTfrapn1ykzC7jvzim4nK2iMHs4y
         qarKAte43PaCneaJw2R0zcduZf+1oVHFO/bh3GwPxi8AV177/G6iWhJjomRXXIjYGlVJ
         wxZh8Y4Tx9AbhrVHkKgwICIfy3t+LapMGv6yLEX/xBQ5nnNtQQnZ+HQqNtjkePewJdj9
         sBmRHRGbVqKW6P38wOnsVS8IvtDuTciJilVjKXzLGLIw7tF4v8lm+NSCcqvVyDx8RIke
         5ryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XPCMSWzFwBTc8M2SqALypNqn0Eu/MqrPq+PzLoXH59c=;
        b=H4aVdY+z2x1Ci2wvMYAvIynHG6aS8Zc6tzUxlSkOIQT0tIvkruYOztSrknhvURa9xD
         iKi2jpdQjTX+sMOS8dT67G3j2oTDXiXJF0fKZCDTxPK9jgpWnpRtthnT5VG2IwMisf4A
         t7KA/mYmEMSDAw/AMZmT0V1z6B8z0U6/w3ogfjcLfPkD0IwsMaCxyJbAJqZVq/YwyvDA
         qbqdCfn9TiACXi/d+t3AtPaMCcVONMw4+XFNeU00j/ZvbZy/YfnLN7YY1QHBOAaK6pKH
         uNxmN2FVB2tPAhkI+oQWyGxYC7Qr+bNayFAoOETpt/oTfAa4nWpK7RQE+O03Yc479QT3
         RcBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UdxGkaxh;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UdxGkaxh;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 33/56] netlink: fix uninit-value in netlink_sendmsg
Date: Mon, 14 May 2018 08:48:38 +0200
Message-Id: <20180514064758.013163764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421231527145500?=
X-GMAIL-MSGID: =?utf-8?q?1600421406841446218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1795,6 +1795,8 @@ static int netlink_sendmsg(struct socket
 
 	if (msg->msg_namelen) {
 		err = -EINVAL;
+		if (msg->msg_namelen < sizeof(struct sockaddr_nl))
+			goto out;
 		if (addr->nl_family != AF_NETLINK)
 			goto out;
 		dst_portid = addr->nl_pid;
