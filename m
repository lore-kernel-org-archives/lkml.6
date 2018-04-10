Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qzA1JSwOiM3IKgwvIeHNoZXwTg9c4OXvR6OFgVU04KB6yRAcAobhSqaNUJRpDG/QmCh/8
ARC-Seal: i=1; a=rsa-sha256; t=1523399881; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0YxEKckcqnsN73h52M0lGE2cWE5JTpPiHeK5zL7H//J4rJKcrVh0AeJQx0BtSJmb7
         NPtta4ryDHVGmp2uuXmsUwSfejbxlur7FfalaIE4selsGPVlnsJ9iwxAkSZOyotonPNk
         429viP6OPR0t+V7llpwDvDHjmJ/V8zx9+RPeC7es8a2VgKoYpOW4f2wcF7FBF2AFZhTS
         J48mlWdAb+U14IUfDPAdmefieYnqb/62SUJQnMldrBucHTgKJccq/J0gDWpQdT1Y+/jZ
         /sm/BObgH2GHhxSe3XkbMW20X7UZUjgcDAeVRbWHTPXqUFe2gbK5RlHiTvd79wjhM4eI
         HGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aI15aRaKVNlFEQxNrvI4f4DCc/CKcGmEUS5bbqdSViU=;
        b=sl/FxL9bpSAyRYk+JmRvf8GrUY3PZbSN393hbpi+hrZU49iqsPPu0nLSpx+IWIKeG7
         MdmNrLVpsVz69XhYDyA6tzA0THluJu40b4di7ttuKhLevbCoM3a7LMJuQ/4YLyvuZYaU
         1MnOHgN0vhlMVl3RHvMl0fu1NDh7XmZ/niRKHQ8DEc/ffNOvo3tzQ7zzXCDNBkUWkc6Y
         923f1hNKqbd9149z2gDEVbFm7iu9qsIvJq8eyUun2o4rVAXLMRqMUWvMXqTJY+S2318M
         QLH8WrH2f6yc7RTPi0xMeqymenP0rVcs06WgEctXU2eQQAd163uwEDvvohmqUXckEqfE
         h8ew==
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
Subject: [PATCH 4.14 097/138] arp: fix arp_filter on l3slave devices
Date: Wed, 11 Apr 2018 00:24:47 +0200
Message-Id: <20180410212913.454809972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399683900973342?=
X-GMAIL-MSGID: =?utf-8?q?1597400553875468317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
