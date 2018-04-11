Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49UIes3A3R+pUa/XozkvgALsCa+f8CixM9XU+OW6BlxuIwYY+3IqLBEcgNzNm18jJ2pf0Ne
ARC-Seal: i=1; a=rsa-sha256; t=1523472148; cv=none;
        d=google.com; s=arc-20160816;
        b=HviFMKXIEKlizWt0aBYih7TQ16pyGpgIeOvuiXmyTFy2Cw8qPnh8GacxRYGvXrKZB2
         DnCuTTEwJMVTGRKlBGvasfqY3YEE53xpN+ckhe6o4vtyXRYSYiVw7FWX/vXoC8JnwxvK
         oq+l7a943db39DQJV2bk7PY5EpCWm3aSjXwXYmHjWM/2eiHwj8tywVwiLDv6eV9na52+
         NbUIxyaRoEPUeMjucIwCjNKBeNZi9ZR2+Hv8b22JxzJY83qONanCir9VDNx0Qa2snMAJ
         cMTxzw+O8dMGwCia/zaKdOB92GMN/VXnDoVaSszJiWck+cmk8SG5/GwGgcmxivRXo7N5
         uVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=msO1KasEFZJnGg7cN91XcEEMvRVaDgdiZ11qbcgdI1c=;
        b=DtHm+DXvtwvSanHCi/169NB3O9kU3+W/4PgmCaRTiCICg1+4rUTubWm4xwv0EvWpVI
         W8ltKnYeQYCAt9d3M9rAv0TJe3LmHHm8jwF4vazprmtbxUX2uqSOakIdKXN1p5ypI01g
         UGRpCDr6UpTVFEm0TN5qGLNh7wffR7V+gMGqqoabdlMdmFEKd6Dg04vRDfRNDAL4uwd1
         O1cKimVoj6YNUHkQPSatVUBzgez8H2VAazuCWPyqWey6r22jhhc8hHgDmYZqTp2ROU6a
         fy+6K7xNnYsh1f4SSMuFqNHKIVFiOGqREFSyDzENmcOee5NIC0ukCgRTAM8lkrF1mo6f
         ncCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 104/121] netlink: make sure nladdr has correct size in netlink_connect()
Date: Wed, 11 Apr 2018 20:36:47 +0200
Message-Id: <20180411183503.135035009@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476332058088557?=
X-GMAIL-MSGID: =?utf-8?q?1597476332058088557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>


[ Upstream commit 7880287981b60a6808f39f297bb66936e8bdf57a ]

KMSAN reports use of uninitialized memory in the case when |alen| is
smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
fully copied from the userspace.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -977,6 +977,9 @@ static int netlink_connect(struct socket
 	if (addr->sa_family != AF_NETLINK)
 		return -EINVAL;
 
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	if ((nladdr->nl_groups || nladdr->nl_pid) &&
 	    !netlink_allowed(sock, NL_CFG_F_NONROOT_SEND))
 		return -EPERM;
