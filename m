Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvKu/tELWrOqEbIcsbMiJx9zqUyH3yxpc+gtvcU+J+X+wD8IHH58jyQHnx0oc5yXK+TUqga
ARC-Seal: i=1; a=rsa-sha256; t=1520641315; cv=none;
        d=google.com; s=arc-20160816;
        b=CI9COFWMBkj5DPM05QE31WPBrYYN0RgFJVkKV0cX3m1FU94xJZUrtB4l6ON5+Stwtm
         uXkxyVfOLAsCiERBnILNz4NlGz94X2lTho5vvKbQS5o55is8ZQ+jSs/isg7IcG88csz6
         d9z5OcOPNVbLKg2lYGnrreqjrIpHy6L8PiP8H2AY1orruWiAPR3FgDLjRrEBvmbfCEov
         Jw7l8LO0dJW7Tt0Jv4InlglLoNQ1FjWXJinYvVutce1jHyFLLNaWc8GprAa0zwJUOO1M
         TciuPZvUeVyQAmFMc2eoWwgAlth5LNVIhTXTvKg/WKXlaxsuKCXswA51hSSy6Wnt6tyJ
         p5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=848/mO9AnP7tG0iVIExT36HBcv2cBoU0lXRk6VdyA38=;
        b=dFh8WFIKgiF9D3EkvoaKDK777j88kLZVNJncMmPAwUhr8u+ZEHSJxf9w7ccAvQn9dQ
         chQw5fUi+pLOPCutIHUmaGkD+s8YXzVcEYBx6S4HzhrlhZijNtUsr4goooaPXRt3vS1q
         0cZ/GqvQ7QdVRqaf5+II/zP/R5fth/GWYl4p2i09M38a+I886WabN6xbVQ96S54THL1n
         veYA9UMvWxKgqELPNsiQ2f1uEPxf/lPFKu+2p/IT5vH2NOM+gonyoEb+DG5PALZa8Hn9
         5xP14YsvaGZUrBW1BDeuzvIjDxu9pzi4vkArebnvaYzbb8VuW55NQUUjEcce1WXC2L3t
         4rXA==
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
Subject: [PATCH 4.9 36/65] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
Date: Fri,  9 Mar 2018 16:18:36 -0800
Message-Id: <20180310001827.876195875@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507798184824818?=
X-GMAIL-MSGID: =?utf-8?q?1594507987954124707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
