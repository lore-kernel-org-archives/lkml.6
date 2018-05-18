Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpe7KkKwsXYqWKVkNaOkyf/KX+2eCOQRJahBywrpqCaMxgoy2dOCDXKkGqVdAOX3LmqSRjy
ARC-Seal: i=1; a=rsa-sha256; t=1526631458; cv=none;
        d=google.com; s=arc-20160816;
        b=Yl/Ax+2Z0BfNZdDU+2RXg+cSi74mGwlhqnLvTXHY0b11ds939H9O029Ta0FJFZ48gn
         uszRKQkBmlCIlWVGWlWs/9oF8LszdWxWtpwo9RDv+gWsUYyzFdtGB88t/AOqvtbknsSt
         MiIreecxxzB/+N8Vda0Itm4Mwp5iOAYB98Vm7edMyxqa1h/AO2obgn6H3uYtiFzy4jMF
         lrsEZTe23GAmhXBI0gOGhmYbJmQUmlxSg1R755eXR0dq/QWh5BSpWex2uoRRd4J84U5M
         x/mbvEh1Xl/I2/nMzmPNfmJtkFavJPFZxxq/8opwI5VSkQXpXQDIw/MBmML7Ahf1cvRe
         If2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=M8tR6EvtGC9k4jFNSWR4X5kjQfToLqmfBgreiPfTliI=;
        b=0MQ010uDsVzqCvSDivlKtnyPUSUiSQmOYMZuynupcoUcK1z/r5kJexIct2IrNUG+lI
         sCd9pLi5e4+QWWYCZvwqP+q54CBDmSBaknduibePwvxGYpuBqoobqUhbqA0R5BEcqcO7
         rMyjhAfS+6LCEJ1SzjNYZCAjHrwrQmUd9agnqWU9k77LLdf4wgOQoYXnsN/FdP1KJJMD
         7LBnZH9ibXWyTjrURS6VP8Gcm08fwCj+B7DkuN18LTnk2OiTUqHW9LmKnbmI845rpPgX
         kLI9Szbomk7XIpncJJ+vIdwsZulTrv4a1P6icp4F5RdUKKCBzgAGwXchQKcDUwfOZUV3
         xjVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0nPkr0y1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0nPkr0y1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Priyaranjan Jha <priyarjha@google.com>,
	Yousuk Seung <ysseung@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 28/55] tcp_bbr: fix to zero idle_restart only upon S/ACKed data
Date: Fri, 18 May 2018 10:15:24 +0200
Message-Id: <20180518081458.838032366@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789108162066793?=
X-GMAIL-MSGID: =?utf-8?q?1600789108162066793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit e6e6a278b1eaffa19d42186bfacd1ffc15a50b3f ]

Previously the bbr->idle_restart tracking was zeroing out the
bbr->idle_restart bit upon ACKs that did not SACK or ACK anything,
e.g. receiving incoming data or receiver window updates. In such
situations BBR would forget that this was a restart-from-idle
situation, and if the min_rtt had expired it would unnecessarily enter
PROBE_RTT (even though we were actually restarting from idle but had
merely forgotten that fact).

The fix is simple: we need to remember we are restarting from idle
until we receive a S/ACK for some data (a S/ACK for the first flight
of data we send as we are restarting).

This commit is a stable candidate for kernels back as far as 4.9.

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: Priyaranjan Jha <priyarjha@google.com>
Signed-off-by: Yousuk Seung <ysseung@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_bbr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -803,7 +803,9 @@ static void bbr_update_min_rtt(struct so
 			}
 		}
 	}
-	bbr->idle_restart = 0;
+	/* Restart after idle ends only once we process a new S/ACK for data */
+	if (rs->delivered > 0)
+		bbr->idle_restart = 0;
 }
 
 static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
