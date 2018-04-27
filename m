Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq5QKZQX/PkxoprMiSbZVKjyoyOyyM/TjTYl6D38+awbppICCdBU+QXXO+xcCWnjGfu673k
ARC-Seal: i=1; a=rsa-sha256; t=1524837959; cv=none;
        d=google.com; s=arc-20160816;
        b=JI4tikbrJMZDyuYM44Cb6rtLSqcUrZ9tm35jpOdh3WPSjW8tPUtLy2YCBrPWVi0+wn
         Up9HfIDBBvOj+aEMlS4dNiJNiGdjNVmHZ5mtEeRJY/Pi+SxE1lLBpYm0bcaYefJUhU/D
         hcHoD8GoZbvuymW07yLLBAWAEJ/UkAqJZQElkTNqdId/QcVF0WoUnQM/TFO/t555cJkI
         REaL7Y8lf3mEL71JMbfAIv2XG516E1BeHLIEi0GwFBynjHiUw3R48fIQDhIYEFol7run
         6aOCCJPIZp7PtsEj6kkzT6p5/+aX+Cq/QYreLdFyFSQbYUTfd01AEvUjXUM1LmwstTKr
         X0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UPhhgpzCrlL21s4l+vk6esf3/e0vyQoCpKhhB4oj9IM=;
        b=M4P1BSpih4Hu065ndDtdUuBYhsGOt0A6D8lpPhC2vRQPFZ2fcRYxgoYuu5j9NgB7HZ
         W6YZp5R9uC6j+W9fks68veMMVgkEg1LFKgG0/zxNzSwQFfNSypogBMlWLuakMYpUSIou
         vtXQVWB3SRpYiAQ1ZpAbW6Ofen3YxKJ5gTqWCu6bJBHLkXxegT5XhPpxmDLt4h/Jmbn7
         50vhHWXcYnBOLV3nID+sbJ9a7KP/r9SOpzHJIKW+S4yhAL6lDgyPJnEvvoBTS4yAPRJE
         TRUtWmIDq7ZicEWFSrpKE5hLnEQVhw43UUViD2NI960EuoKGl4r7l/NdAhFwbLMJ88ma
         iqeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC2B21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a70ac890b23b1bf29f5c@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 49/74] l2tp: check sockaddr length in pppol2tp_connect()
Date: Fri, 27 Apr 2018 15:58:39 +0200
Message-Id: <20180427135711.964602787@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908009181656382?=
X-GMAIL-MSGID: =?utf-8?q?1598908487817677486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -590,6 +590,13 @@ static int pppol2tp_connect(struct socke
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
 
