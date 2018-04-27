Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDfNUdyH2Qw5ikR1zwCHiPWx+t44d0Dw4GIWLwUGEET/CJKXxcGZZkU1DoiDWGBY+frnbU
ARC-Seal: i=1; a=rsa-sha256; t=1524837969; cv=none;
        d=google.com; s=arc-20160816;
        b=XkCcE/JLIy53KG0Q8HtC/5KLgKiJWGzCr/knbkZoG/AaH81JUY/tNBpY93XMW6GqWi
         +mklsmSjtkzLs60Tx9r/sYLjsYOfRTfGQkwyolCAE50ycU4lrh1FyKDEc2+PTV8h3MXw
         W9vGp+AZo4EELDFJ0g0/0Csj4mVNk+5e7TB8zsp5in54ZIDUniSdmkRHv/ThxKO+3OEw
         Gt0tTVj8C4dShfL8AhICgOiOXtDAephTF4rGstZDb3eZS2/Yzh6HDA/btkzaXXh1c3S4
         FtROG+1gNwXEeFtlpOsFy/MptxGd8x6kG3Dnn777Y5kXrexrBq8KVjJyEOh6HMa9U5oY
         vgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=DLU1G+OT2w0tnmfZiUXZZHQLo9xzJmR2qgReVvX1ROg=;
        b=dWKwdIN6x+9aTgeEknZgiCWPpX7/xcpcARt+eKtDxS1hES7rgULnG87AZ8e5KA8wSR
         wd4NMqkA1vzHYdDp6ATuYo4jSHiSb97nwWXGZbsOFV0L2zyif6eRHK/tMJYEh2DTkjQe
         KHcaE1/2adq8xPzajeHnuxLYPnSXDen3WoU+5MSwPnU+3PPIu4GXNUSry2a+lXvmQGeb
         wvvOM/dsau9USok1zySyNrCBJr8yAVmVyqaLMd01pskoEK1hN3W9Rbz/aNaFKkyjZq4e
         7gdmxaszIKBnqaV50KoSCVr7S4CHN8Yes8M4rSkoNfFaOWcaxov0NPvsqSeUXAnTYAGU
         HvHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B51321864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/80] l2tp: check sockaddr length in pppol2tp_connect()
Date: Fri, 27 Apr 2018 15:58:05 +0200
Message-Id: <20180427135733.561313445@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908009181656382?=
X-GMAIL-MSGID: =?utf-8?q?1598908498883141968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -591,6 +591,13 @@ static int pppol2tp_connect(struct socke
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
 
