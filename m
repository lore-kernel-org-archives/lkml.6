Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx481YmtQOcAf5GeG9GaSJ4SIFD8gMNFmPLgPBzUP0sEY5y3t+PwCf10q1eCb/m6fqvGtn0EY
ARC-Seal: i=1; a=rsa-sha256; t=1523399523; cv=none;
        d=google.com; s=arc-20160816;
        b=TJqLXcSe+Ld52P0CVz9TGcjE0ojt9rVw1ukC8mxRKXZc1zygijhhep8Rg7mRap7DuE
         lCdFM7dY0xSnuOoVsRfu8yhFXTiqxKKAIHM/KgpNSpM/s/OKPAxuTpP5C5Tvj6Hx1r8w
         MOF+9M6iJxqQH8wM+iO2iqFL6Mg5m8XEWxE2W6FvuKeKNQNuPUy/SNf996LvfUBxbqJI
         SeGw8OuCOeaORKIXszFXu3VjYQomh3owms5ame8N6o2CCmedVrbm+41vNXJmml2yHRJf
         xEn+fDuYMkmLt3469WTh5SFkPaD/u7OVNDckV0LW1PDy8OdyL2zDZKGZtz0j9vo4JOka
         FxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KhCvgzBvwswP0ub4eHfCb7cbkmt8CWKolP2CDmoTBek=;
        b=xCCTddyJJCK6TnHiakOs59X/YHI5Ik3UbdGrXEAdPj/HX8wewuPXkL8WFygGcPPhws
         4ySbP7sw6jylMz4513U7lwXnsKILHATj4JvUjsLNJPCoZFOWmnkVbIGY2PgdiwzwGrKc
         dXYhNvTmcf17ddB1H2JY5auUfcYxEcmlMYpl89pDMyLtbz+zimE1zgTHMULF7+c0zsT3
         H+zeuK4mNhLJ0xCiJi7+xXbcQZg2axAR0DCx+D6DTSHJSbxipQW/FO/gx3lBfqp95qVf
         zV2Y7mH22wIVdSHeG6S78VZ0dXo2goPtVGEcKPQneDXAHbokWd+3A1XUiCEbMbLp9mah
         2zXw==
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
Subject: [PATCH 4.15 121/168] arp: fix arp_filter on l3slave devices
Date: Wed, 11 Apr 2018 00:24:23 +0200
Message-Id: <20180410212805.710092323@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399683900973342?=
X-GMAIL-MSGID: =?utf-8?q?1597400179442984979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
