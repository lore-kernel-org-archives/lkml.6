Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+39en9maLFchs+sFRGgz0jElnmtu7KfVmVJyDxJt5nASlzFxY0H4ZM4rhGPfvU8wB5LRIE
ARC-Seal: i=1; a=rsa-sha256; t=1523472665; cv=none;
        d=google.com; s=arc-20160816;
        b=QfrvFUzQcywfsXBj/FUj6dvp6xQeH79AD3pqcP5CCfQRMfKlk8Qg90vFAXhGM+BBae
         CujSUBaNLIYy+USYscgMwWtCGiEdg04d9jFzP4JE4sESVNgc9Mcx168obmVrRux/0M13
         TEZBMsnQP5TlO/jbuef6a4ewzx3OYSu4P9MpeBE0jjfwFZ82/XO70ZOaVSc0KZ36w2tw
         wIiX6c4WV7EgJjNNn3i2VLuEQYavdo/QZjwku+5btrXfxGRAyPST0oLWTnwDutGK/0Oj
         BKbFQ6uRIbl5iMU1RRpKqw78BYHFbpd7epHVeCsotwbgbpdmJWuabQUT86sMXRA3MPhc
         gfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=btAEFvqf9l98yVOlIiJau3kpQQqNNcnukQWlSUmATPI=;
        b=Xno7G3YmpHLlDKO//qQadbdk59uDDGFr7vNjXFc5IVZ79i0rChUC4np1IAR5bsuY+7
         +wVM8fG8x7FZ8mD5x0r6zLpcQKa5oORRDIQl07pwDls006T1qmm9HGq8cLBpqaBaRJbp
         uQkLcI53g9Ue0oi3wjocjRzibRxEWx1qJBffwEMBiCDYMGYz5w/NitPMY3ktPEF5THnN
         /nguLGswRFB0/TyHOku7DPCKX7sw4Q9aaYSlRgvye1KGxiEx6dkHmHzgsNmNB+4r8f91
         RyPzL06skSai4jI+DP3K+afOo3kHUFJFl1Lj+kGsEaVpDFVy4Lwn29Y/ks2dhIa0nBv3
         pD1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miguel Fadon Perlines <mfadon@teldat.com>,
	David Ahern <dsa@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 166/190] arp: fix arp_filter on l3slave devices
Date: Wed, 11 Apr 2018 20:36:52 +0200
Message-Id: <20180411183602.214845800@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476873404359288?=
X-GMAIL-MSGID: =?utf-8?q?1597476873404359288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Fadon Perlines <mfadon@teldat.com>


[ Upstream commit 58b35f27689b5eb514fc293c332966c226b1b6e4 ]

arp_filter performs an ip_route_output search for arp source address and
checks if output device is the same where the arp request was received,
if it is not, the arp request is not answered.

This route lookup is always done on main route table so l3slave devices
never find the proper route and arp is not answered.

Passing l3mdev_master_ifindex_rcu(dev) return value as oif fixes the
lookup for l3slave devices while maintaining same behavior for non
l3slave devices as this function returns 0 in that case.

Fixes: 613d09b30f8b ("net: Use VRF device index for lookups on TX")
Signed-off-by: Miguel Fadon Perlines <mfadon@teldat.com>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/arp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -437,7 +437,7 @@ static int arp_filter(__be32 sip, __be32
 	/*unsigned long now; */
 	struct net *net = dev_net(dev);
 
-	rt = ip_route_output(net, sip, tip, 0, 0);
+	rt = ip_route_output(net, sip, tip, 0, l3mdev_master_ifindex_rcu(dev));
 	if (IS_ERR(rt))
 		return 1;
 	if (rt->dst.dev != dev) {
