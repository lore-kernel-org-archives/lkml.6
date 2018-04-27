Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpEeK4yvZO9tfopKLjOytLcpqMYg0hotaqRUQZU/VFUMjPdAbNSMz09YPAv2y8Ba++DNNY
ARC-Seal: i=1; a=rsa-sha256; t=1524837954; cv=none;
        d=google.com; s=arc-20160816;
        b=KXpDydPKkqbpCSDMe3oRRZQrSOAoqKbp8C+zLhpPaT9B1o8mN1VAFVJjqfZ2mh1M66
         NPWrsqstAQ1B/7B1Z7aOiBZznaBlfJOGi369ERAMVHsX052m5ehW+egA6RYN7mxxzCe8
         Ub2F7XpjesaOGTIL0eVJZW5u+sNsp1sllSroLF7xUVN//s++Fmp8tN+IpQ4ydBccQ1QW
         uWuDclykzmv8Cx6Gc4pfAaT0mNbjXuyAugEjX+0LqH1P5sPVQZidR10hk5iYCYfFjMC9
         IouGwBSnRskPjCihjB1bimTYe0MilGa8qmyUUCBI1TKuM4vqXIhiv9ihiRWeZi8w+0gc
         eFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=eQ2Y17DFAYL/Rm0eZCs1QSvYgJV7Cu5fF4n6cb3EYgI=;
        b=SNzD7U366T0aHi0BpMDUIeZYXDwl8TVmp3h8iIXf9bQGcDo92f8Fo7fkozRv7vjUTz
         /9iBmdSqW9vEMTXMouHuXbpFsyC5EBXM1EpiLUrpvL2961FrKtSwEW226Gz2JBXxAPF6
         qankNNDf/58llOBkvNjz7l9C0XmtXmUaKojq6NzdVVCKuYjDnboXlIpqXeRT8Wj0FmoJ
         Svuc1etAGFDaB2hhyhLFR4BgT01Bl4ApcP8bB8ldHhAyCfaNpzvx3LfSqNi174qfw2ab
         r20OmS6Iwu1NZdHsK5Kt384eo2K6PpY7P8WEtaTLGK8nTr7nU13FBa/yb9O+3RuAOViE
         sP8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2593721892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+4f03bdf92fdf9ef5ddab@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 57/74] pppoe: check sockaddr length in pppoe_connect()
Date: Fri, 27 Apr 2018 15:58:47 +0200
Message-Id: <20180427135712.294877621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908020087873199?=
X-GMAIL-MSGID: =?utf-8?q?1598908483164825298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -620,6 +620,10 @@ static int pppoe_connect(struct socket *
 	lock_sock(sk);
 
 	error = -EINVAL;
+
+	if (sockaddr_len != sizeof(struct sockaddr_pppox))
+		goto end;
+
 	if (sp->sa_protocol != PX_PROTO_OE)
 		goto end;
 
