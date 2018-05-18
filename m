Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrarySq+cyltAroZn5yh/AQ1UXDU37mzxP/b/4SX6nyXeMVbivH+YPoxAlJ0b8eAxN3FPm5
ARC-Seal: i=1; a=rsa-sha256; t=1526631675; cv=none;
        d=google.com; s=arc-20160816;
        b=jW/8QXSMSyTz/aPZ7XGlnVQsbR27/Uj0Lk088qgFEbKzVP2fBeGJoaTGSbiRQIUbwZ
         3A9+RWxpySirTcli5Om0lWAbaiDP35ZAqbk7/60PCQkynAWe+Z7epHbtYIbr6LY4c8ql
         VhuyCnGOCty4euN8NRm1dilfDGhMgGSOaOka0Rwu4sziEZlVLwoUrYZJgOfHKMleGfWK
         vQXpideWDR634XAj9SPIHbGPel3NjTUiKDlWmz9wTZHOd1jwt685qbBNRbNDYq4KUw82
         j9gkFuZ+f14iTwbGcUYRn5PUeKExmZL309krTbYgGE9Ce4ZasWsGAgn5Y941XukjwON1
         79Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=boiRFdFVh6UdPVn3g+IrdYZqzopcSLqTgse4HQVbp00=;
        b=vpboTHz5lR+KunqGKADBnPGKTLD1ZNFZFk7ZIcn/DgpZtOSoUjhnuK1eJ4FkWE6Rk1
         Fvdm3EYqWvyKeZrmuXdcD2UHLCFNm5Z9xgcwMPLyYc0I2ilX79Dpr74evznXcGS4vEoX
         aVpWm5etLmyuLm1PuWi5INAjqb5K99yd47Jmlv5daHtg/cV8xY4nvq+GL4pNvP4pZGew
         cxDvy1dubgNtJEtQW8jMWB9GBREU0TJvk3fdRNJTK+hGMDQ78fmVjqLijxDdkNag9Jax
         XsHZrWlveSXQwNA9C7/2Nrzjtq5R9lOSvDid4mdsLK5bFGDr6zd8TUUVgtEOdagqKk/2
         oegg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HtvV5RDz;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HtvV5RDz;
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
Subject: [PATCH 4.14 27/45] tcp_bbr: fix to zero idle_restart only upon S/ACKed data
Date: Fri, 18 May 2018 10:15:44 +0200
Message-Id: <20180518081531.712221697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789108162066793?=
X-GMAIL-MSGID: =?utf-8?q?1600789336023730531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -802,7 +802,9 @@ static void bbr_update_min_rtt(struct so
 			}
 		}
 	}
-	bbr->idle_restart = 0;
+	/* Restart after idle ends only once we process a new S/ACK for data */
+	if (rs->delivered > 0)
+		bbr->idle_restart = 0;
 }
 
 static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
