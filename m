Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMw9Wj1ybQh3zx5OROu+LcHmJ6reyaLgVrbOxvGHJRXeMJzKstvllt0JZFwzY+FTxYh+Qw
ARC-Seal: i=1; a=rsa-sha256; t=1520451659; cv=none;
        d=google.com; s=arc-20160816;
        b=VBZlZ+Gmh0AOzqWY6ckAThdWHdGEMIh7KD2zgMn7D2snsZFcKNQA/PTV155IwDgbDc
         qdGKNRkWduZgsZYKelqpCWeQ3q1qU7w3UI+JVcf9zoi53wrG4jZ7XGfyS9hmq7TITavW
         E1LzPQiLayaDzoKOCT2Xmh0VUovBJsB81pGMQBXRvzSSEBQgXwhmdWyd/LyT9PiWdKpP
         oZjdI07cxRVE79kdxR/jn5vy37A4vatt3ymrXa0WKPdEFnfRLaRz+rob/LDqlKs/Wna5
         tYRKo8kyXHNa2HEdVi9GHCQ9X44G1pZYjJvu2JesDWsukEC6153M0i5BgnLGw8776Y0V
         jDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GUFrXlj4tFdc8cg9YSikBrZ9YRAfGJExrMOv/HHvFmA=;
        b=UAe24gJ+1NKQSGxcNwSoKK9uooVY1/+59U3ByCMxZD7sJ3RYVsY60PStTOYh+aB85K
         nbyXuO0pFG8J5yMmuX19hlFgCP3r7eiyVLhkynbfhzgPA033amNAXWN13Upo7ipp1Og2
         9Tgbxqk4SWPeT2Wfa3mZArGn7TV4CFMptEVQPZgJKiYD/XBpy+HWAxIVPjGMcZkwVATc
         /B1YS+Y/iBd2Gggnx9CYxTbQSHVgSYO/OVTUKDx8iEzuXhTM6xqgLo4gEDSea0EGtT1V
         sbZZqOZPRXOyjYTdHL/3GawNbAnuOnHZXGxhKXilwGrarpsjGS9cNmM4PpvTbOoVvN2k
         ovdg==
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
Subject: [PATCH 4.15 042/122] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Wed,  7 Mar 2018 11:37:34 -0800
Message-Id: <20180307191735.112949252@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309119767792971?=
X-GMAIL-MSGID: =?utf-8?q?1594309119767792971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -182,7 +182,7 @@ static void ipip6_tunnel_clone_6rd(struc
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel *t = netdev_priv(dev);
 
-	if (t->dev == sitn->fb_tunnel_dev) {
+	if (dev == sitn->fb_tunnel_dev) {
 		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
 		t->ip6rd.relay_prefix = 0;
 		t->ip6rd.prefixlen = 16;
