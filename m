Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqBRQUoJudbUH1GI99037CXBt7uybu6kSOhq8WW8u52PzlKxb1vz6ONTXoI9AlzhJn1QfDx
ARC-Seal: i=1; a=rsa-sha256; t=1524838183; cv=none;
        d=google.com; s=arc-20160816;
        b=Bmt4Jc8h8xP45QoQ4zYJoZ9UFgckPAqfeQwH8dY/hZHdKLifLRMGiAgKo3loB+BFcL
         EpUwNfZ0CP2/Mih9iBi93BrV1YfhvmOBiFAKkH0UjkrO1Gj99We97+eeJtcV4BBKzXBn
         0ieNakx4PXp2S3Yn8nXu+nlzrKqVcnfogfV++cF3c4X/Z+aTp4+T6nR7gnvKAcQLuonZ
         r+Sr6UZ0pMcideCAYjvGTxQqijkU2Iu77S5WFf+brtHnVF1j2coN0ZA2uwlN+dJUBrXX
         u5wZUWX1iCxpfry5Ir2v/8wYSdwwLEr5a4ezLeNMKbtXn6Sy02X9jjSLJSlnsdht37Po
         bMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qqUtIPv9LuACxoLC2IPVWo2XUYbnpn9D7oVqXXOcZVM=;
        b=l1J+oPnoW3ffMdyJb5Ky4/NmcNQS6RmhaGLRiC0cWWD2W064gucUnLJ1YjIPpAXg1d
         PHaR2jK6knm7GHlu5+jcXxa00zS6tpuCCYIZdVbM5YUbK8aQOYPPWDVKa6QinEZ8gznw
         jSgxUqI8/LpHTR4Q/8i+yFsUwhX5lVmfsSlHI0tN6nag7siBMz6li1PUbdM+Z/kfwfbf
         G9lZo5rFhgFtcyKW3aGLKbODJKqiLrAXo9BvAgokwZFTbJeVo3h8W7uEKU9RaASgez6m
         F5vrxeV0YeVRXnfprg8204iepHzTaL131g3qIRX1cSs7hx46ChgUINQbNvB9/a15JQEv
         e5Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD710218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 13/81] l2tp: check sockaddr length in pppol2tp_connect()
Date: Fri, 27 Apr 2018 15:58:15 +0200
Message-Id: <20180427135744.015355719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908009181656382?=
X-GMAIL-MSGID: =?utf-8?q?1598908723065095524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit eb1c28c05894a4b1f6b56c5bf072205e64cfa280 ]

Check sockaddr_len before dereferencing sp->sa_protocol, to ensure that
it actually points to valid data.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Reported-by: syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -619,6 +619,13 @@ static int pppol2tp_connect(struct socke
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppol2tp) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpv3) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpin6) &&
+	    sockaddr_len != sizeof(struct sockaddr_pppol2tpv3in6))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OL2TP)
 		goto end;
 
