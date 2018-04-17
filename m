Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+q6M6VMBIXnVr8ZSVd44wkeB1RdA7OCbusQvzc1k4facTLOnlo0Bo6DiYRHWYxBiWnMz2D
ARC-Seal: i=1; a=rsa-sha256; t=1523980853; cv=none;
        d=google.com; s=arc-20160816;
        b=vJ6xkJGH4ERUkrWokjLl153fcNsxqVvWWfIyeUU1D8bYI8ylZElMOSm9ECqXwsZERf
         RMgBADL6KKMMk0iLJneqwkcw+ZUr4a85hZUMKgkZW/06hB+fR3x0s56X6QqV08NRz5Z6
         HA3Mj12MZrL+T68M+5DrJO0Dq0yF5q8rmZCz94lBa5NW9WtxS5BlXtQID5MLAc/kaNHH
         vuytnYyMU6Gu4ygAvKr199nc1J0XRvr1RIFBXaDBsvgE34RaD3OCFJnlFHI9XpzTalNa
         DMkGQgvR8+CYYPlWRKtkjdiH2UvzBoUPfnr+Xg2jDCjxUADAXzoJuzNEe4VLZnpInjov
         4TnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K6wifGSUsCzPuxuwjB6vZYsnjY8DC2nL31L8ILA7lIA=;
        b=Becn5J5To2bTE5idKmhRrjvmst63tk+95jXzpihJ66lQH+2z9ZctaZXUF49tVYqhgf
         K1U0w5ZUipb584ordF2uAX60wHUx7d9okHNSQCF8wQVM1qu3l35iN/2EJx7/RPMHRQiF
         bIZYQwnvyqPcBXgS9M8Fyq7b3b7ElNQM/NH6Y8XWi12mDWiumlvUc0X7iz2TF6SgkX+R
         I1OqlJtj5epg9kLq71qAcZ5Q928qVGFVOFgOexUSAO66JLMv81BTZU6upwcbEp8GeOXW
         bd+VPc3nvwM3x3CgsBak5mpOD9HlGzOShbFn6oheYtvKdnthVqfBrW4rj2bt29k8Z6Gm
         Kelg==
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
Subject: [PATCH 4.16 07/68] ip_gre: clear feature flags when incompatible o_flags are set
Date: Tue, 17 Apr 2018 17:57:20 +0200
Message-Id: <20180417155749.638564160@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009748090374289?=
X-GMAIL-MSGID: =?utf-8?q?1598009748090374289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -778,8 +778,14 @@ static void ipgre_link_update(struct net
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
 
