Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq/CGrKK8Ij+SI1i/ONoqaGHu2cBPMEU6PGyJBLWGKn0OJ2En3JzhFQLp942dWygd7qFvVC
ARC-Seal: i=1; a=rsa-sha256; t=1524837692; cv=none;
        d=google.com; s=arc-20160816;
        b=N8oy/snLfg4RPIIqMXNOUYbhDIWUFHrTOid1b967uS2nDgSElhVZlDejOiZSRY9Evq
         gMX3sdXcD7wWj9RCue6uWOBNk6j0Kvh5Is/ZmWHamCbUrnq3r+SYbgtkkdoqE1MSQSYe
         gJaF2sm/oB9ZDZeRZJnYFue35H40QRGintW5nHaQmdByvmY7jRtuIbwoad0ad3wi8gEq
         rvhLr+zyQO6SuecZC6Sox3g+1SKQQfIZeMALhXHNzQ4gunBo6kYT3y/Ig/FKiKcqM0uQ
         FxajPLn2JV6CRQw7E3a/0Eb79WeYSiEGeRPTN8OmCA/17wbVjnUo6a7lDo2swbvPkRv9
         hF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4Gre5QBH/mxIBI5UduMWaL6y1/y4Bx6Pa2ueqoxi4yU=;
        b=CX02dPa/LMFNPFMBYq+Nl/vY/hTGkDusPSX3qPQ10HDDGmwQCwotmxuC/lw/z8YAq/
         7/t4zuU47tYLcPJ9IMw4dudRMt8RpcYOEcI0GPVNhkAAddhYWheBAsa0jCW9Nckmzt6A
         tHdCfSaDsRL6ARfK/fd5cy6ed1PJCzOxzvkVAO25kwuMGOvkcdo9YqqgmhKn/CZxTnTS
         RH0/n6fvko+kBQbxxZRHhfr3TDGr3TseOG9Y385TnIIjxy2aN/8RiimG9SZKc6qI1Llc
         aBlarSfnmaXV+aTPrkj74vBA0yifrQhxF5X9Hfx6CaDryJoXDDYWlDeRjkf5UuA7Myj7
         jjgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C322185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 30/50] l2tp: check sockaddr length in pppol2tp_connect()
Date: Fri, 27 Apr 2018 15:58:32 +0200
Message-Id: <20180427135657.477574230@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908009181656382?=
X-GMAIL-MSGID: =?utf-8?q?1598908208612969919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -606,6 +606,13 @@ static int pppol2tp_connect(struct socke
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
 
