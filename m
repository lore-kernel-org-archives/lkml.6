Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49y6BwOC4YEe9oCUhQ6Tb2GAXOW79d/sZX5y9YcYUoTVPxN62+7KjkeNexlk47ktGjXwJkv
ARC-Seal: i=1; a=rsa-sha256; t=1523981091; cv=none;
        d=google.com; s=arc-20160816;
        b=iLRPAmaRrHcPNRqnQhn3iIiQsbmVBYFG01oxqPzC2TzsX98F5rpYLeuhDLOFsOKo/2
         3oQljDhDp9N1BOoYeiXN/hTC3RRdWOZL9eefccY1eedhhdF3v6eboaik3+BchOxFDroE
         ZqB67oDi4xGUykYxf7dcj8+gaLn3e4pfEaIsaqVUmGEZaOgqtWBihkrLM0hmWnJTJCMI
         VbTsBqULEREFzsSlrwiTZc3z+do3qz2PySwbhPCl4fXBWP2GK+odMyHy8HRP7pw1EOUv
         7DNENtHbAJ3XYy8rcUGptP1R2AREJ5ky7iWa2aZj4QjUeAJxTIG2coTp8fEr4hC/GfeH
         usYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6Hrc4CfXEoCf7tF/wV7eVQ687HXlXwWfKro1CycxtSo=;
        b=Z43imUuNZPVUKfjvScKqLxqWJY3EM1K782ZvNla3ucohns95N+iBTTXm51u5A5BPR7
         gD7p9WVDR43fk7BGomB+NheD//sgDxETZ5m+8U+5pfTjzr/yJAiDIZmV0VdPmsrpQAWu
         3L96OhzXCjoKr3nqJtGje51avV0B9mPXE+4p1wefRNuxhmm+4pkUqzL/V1k60MXOaN/G
         DXtzo2SLgr9JFaR20iPH95MjqE/CSV/s6E3a7qIm3mQO8lgaT4LhZnh4jitjh92SG9TT
         2k+M2Svq+P9BUNpIhAagS/R3sffkoWNuV9hpWiIQHqdTphKaDSs8sEKGu+QPtesNhO+g
         ZXlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 09/53] ip_gre: clear feature flags when incompatible o_flags are set
Date: Tue, 17 Apr 2018 17:58:34 +0200
Message-Id: <20180417155723.471375692@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009748090374289?=
X-GMAIL-MSGID: =?utf-8?q?1598009996399412182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>


[ Upstream commit 1cc5954f44150bb70cac07c3cc5df7cf0dfb61ec ]

Commit dd9d598c6657 ("ip_gre: add the support for i/o_flags update via
netlink") added the ability to change o_flags, but missed that the
GSO/LLTX features are disabled by default, and only enabled some gre
features are unused. Thus we also need to disable the GSO/LLTX features
on the device when the TUNNEL_SEQ or TUNNEL_CSUM flags are set.

These two examples should result in the same features being set:

    ip link add gre_none type gre local 192.168.0.10 remote 192.168.0.20 ttl 255 key 0

    ip link set gre_none type gre seq
    ip link add gre_seq type gre local 192.168.0.10 remote 192.168.0.20 ttl 255 key 1 seq

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -796,8 +796,14 @@ static void ipgre_link_update(struct net
 		    tunnel->encap.type == TUNNEL_ENCAP_NONE) {
 			dev->features |= NETIF_F_GSO_SOFTWARE;
 			dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+		} else {
+			dev->features &= ~NETIF_F_GSO_SOFTWARE;
+			dev->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 		}
 		dev->features |= NETIF_F_LLTX;
+	} else {
+		dev->hw_features &= ~NETIF_F_GSO_SOFTWARE;
+		dev->features &= ~(NETIF_F_LLTX | NETIF_F_GSO_SOFTWARE);
 	}
 }
 
