Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvImedBNHmpMl/trhz4LsDC4il92+1pb+0ekKjnlUqAuUjpiq4TQSNSbAIOTJkrmTDRJDFy
ARC-Seal: i=1; a=rsa-sha256; t=1520641134; cv=none;
        d=google.com; s=arc-20160816;
        b=QXmQwaFS9DTNvnXQOOdL/NEr9bzTc0sAvrUwl096OoAfbTExBvpGy6ybl7WIUU4b4C
         /LnuPZk482ao2350ElTqgRP+mGKY4kEi9b1uePyn+2MvhHDQOEFZw+q3qK0kHsfqeVED
         nDeuP3dUFFTkmMoujC+UtfGyS96BEzvrYo1pX0S0TgQHLUoE69J0wlBHESm8gCQZsBM3
         AJEYgWGQFbabyScQgyHqlqLB4oZnWxrgLNy0BFsYr2a7sTu43Ds5c53f2v3wbO97V41f
         IJ8vewZtn6R+aLKO3ItLb9BO66wYTHsTQqYTPBP3hutafOb73eYydXVAH1RJSks+z1+c
         GhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nu3Kx167gPe1KKRKku2bplvrsedp5LxUGfXXtzm76rk=;
        b=g5aBOaG/0Dp0pfkop9lEb6sbLvZKcfvUACQAEMH2JYzW4xoz1bNZQv1TCXeufZ2OAb
         rWMmpAwLwWMNT3ZsS5nMBgGFv7CfBCLyHqaYPilow+09n6zfIU1CjHCOifUsdAs8f343
         sWpb+qPXbTXES/KBWPio8LQZEYvxoiaOms7V98IskI2lGgfT7d3JcYTzIW+T6Mz/cm0b
         6IeMohATpOidzNZCNX68xTr3D+cbQ8eyQYsMMGGNpZJo+RuuFB2Mc/CXk/7HI4utzcKO
         +VtAt2VdHmQJL/UvGfpugM0dFT9igq139sDfQKa8IxV408fhLizT5rVjU0u8/+JMuTDG
         e1XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Sebor <msebor@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 10/21] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Fri,  9 Mar 2018 16:18:32 -0800
Message-Id: <20180310001801.631686321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507798184824818?=
X-GMAIL-MSGID: =?utf-8?q?1594507798184824818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit ca79bec237f5809a7c3c59bd41cd0880aa889966 ]

gcc-8 has a new warning that detects overlapping input and output arguments
in memcpy(). It triggers for sit_init_net() calling ipip6_tunnel_clone_6rd(),
which is actually correct:

net/ipv6/sit.c: In function 'sit_init_net':
net/ipv6/sit.c:192:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

The problem here is that the logic detecting the memcpy() arguments finds them
to be the same, but the conditional that tests for the input and output of
ipip6_tunnel_clone_6rd() to be identical is not a compile-time constant.

We know that netdev_priv(t->dev) is the same as t for a tunnel device,
and comparing "dev" directly here lets the compiler figure out as well
that 'dev == sitn->fb_tunnel_dev' when called from sit_init_net(), so
it no longer warns.

This code is old, so Cc stable to make sure that we don't get the warning
for older kernels built with new gcc.

Cc: Martin Sebor <msebor@gmail.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83456
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -176,7 +176,7 @@ static void ipip6_tunnel_clone_6rd(struc
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
 
-	if (t->dev == sitn->fb_tunnel_dev) {
+	if (dev == sitn->fb_tunnel_dev) {
 		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
 		t->ip6rd.relay_prefix = 0;
 		t->ip6rd.prefixlen = 16;
