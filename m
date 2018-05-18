Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrmIEcc1MQZ72KaMW+URE30Zv46qur7Ufm+MdOm1650KZymZry6MBmy/iqYQnunPYwRHNN/
ARC-Seal: i=1; a=rsa-sha256; t=1526631450; cv=none;
        d=google.com; s=arc-20160816;
        b=p3nKfKfQgRBIW+igE0iwq71Oct3R96JZ9Xwf9isZESr2aqm22x+4YpNXXdjlf22rF2
         dlGMDVBeC4COusCQDax4gQWDBqskH2UAVixdPEnsz39m4dmLBfUWD8wIUlI1rmStSKhM
         HVv2RYPjMH3IGM+UmjjHesM7FsfXCtgpkp4w7zDZicv7CcA+sXivpK7y6Lr617bZJwHz
         UpBPL33H0cnu3H5f26800midyqc/0DkMLmkvp6DaLGP0k331zZh5FR3JhfJldIHalCTI
         ULkq/lDGaxlJKGoY6uga764oVHwwuZgj5GVAShMRV9Mkl3R1K8X3Y9yRR65x5nRKkv42
         fTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=T4FTk2cKW8DSPuryTL41JMJns8eso7fNPWsoYz+sqj8=;
        b=Pjv5eCi8LqdVMN47vayqpOtrJAJXZNeVP99+DAERkAp0dioftyTjELp9P8Sic4lVPX
         O0+s3P1f5Z1Ab54ycVZ4i9wFBNQ4/bLrOVgGkpj6VJOmZwbTSSt0dz2Tn38z6ZQDEzAk
         JrBVVi55cXWUvF8au5fW7PEpfnrJJ4PmxYKiQ3N+WP89YaN92tPI0FdTsI5/X6ElMy+I
         bLrcf7eFQ7KD9BmXeNEeh5vol6ZeGUG/Z8lh4d8H7ePybT5PaFN5thILSLuy0rl3jt/u
         IjenI8dvl5Rw7OH2pUEl7P3vfwA5j7vl2Fk14qj1lJGsD4iGh5LoaoU/spRaQlbCzZuw
         WOVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xaJvZzzW;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xaJvZzzW;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 25/55] sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
Date: Fri, 18 May 2018 10:15:21 +0200
Message-Id: <20180518081458.712382412@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789099921166414?=
X-GMAIL-MSGID: =?utf-8?q?1600789099921166414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d625329b06e46bd20baf9ee40847d11982569204 ]

Since sctp ipv6 socket also supports v4 addrs, it's possible to
compare two v4 addrs in pf v6 .cmp_addr, sctp_inet6_cmp_addr.

However after Commit 1071ec9d453a ("sctp: do not check port in
sctp_inet6_cmp_addr"), it no longer calls af1->cmp_addr, which
in this case is sctp_v4_cmp_addr, but calls __sctp_v6_cmp_addr
where it handles them as two v6 addrs. It would cause a out of
bounds crash.

syzbot found this crash when trying to bind two v4 addrs to a
v6 socket.

This patch fixes it by adding the process for two v4 addrs in
sctp_inet6_cmp_addr.

Fixes: 1071ec9d453a ("sctp: do not check port in sctp_inet6_cmp_addr")
Reported-by: syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -866,6 +866,9 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
+	if (addr1->sa.sa_family == AF_INET && addr2->sa.sa_family == AF_INET)
+		return addr1->v4.sin_addr.s_addr == addr2->v4.sin_addr.s_addr;
+
 	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
