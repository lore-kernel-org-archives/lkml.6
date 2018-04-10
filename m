Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ik3LfiaJQn3lcmrRGwef0DzyZKWTN3PlGonR2sbhDOfjXka1LALiKwqt4OubpZd3q8FtX
ARC-Seal: i=1; a=rsa-sha256; t=1523399051; cv=none;
        d=google.com; s=arc-20160816;
        b=YhyTkI0idIgDIe4RxmqcyttxTmg2ZtQJNJxVJuEeMNWxnRoiDJ0F5h9nzzerCP3+vb
         zgi21qhkQFKmw8kryz2aBVHjNODL1iNUGYpYP+Gi9BKVVXqoj4lcdu/pWgOs6Y8ejOsE
         Mgkd5vWF7iZlevuJ0tfbQTmfDxOG6X4p/dmsCGEKEHc9iToUufbDxvJxA+fDJ/iCqg1L
         GS1qsgLx/KuRjBKmQCMrnAxO6cPUnO2oHXK5VojyfEif8TfsLpv7EX84nRH+R7yVeSix
         3EzgECxtNyK98zSZmbP5o4bPPxcHZVDDoyYArwPpVQvq8I+L4QZjfElomihhG4KwVLPV
         HkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sheMDRUd2M1jjG9jzerDVUMSlUNX+DXQTRlJ0BVzHks=;
        b=PSLpVVj4l4Ukqb8Qg6MT+f+9eeMyYrgmLc2r7IleqieCrXlB25GKMl9o9Gn8qW+Hf5
         zCjKf5mMJer5hhLJNCXvMaZQaK+RWmsmvR6QWp6ZiSlKpOgSRjpTbYwJ/ymPJOp8sznu
         5lyrK+26beakzJ7j/UAfJtf+tcKcGZ+xSyVy+Yj4t2IhuFo094OFQLEhGGQVmnnFh3Wp
         lwsWox/ogn97DHTze48reQWxGYI9addFC4JiGRao+sz7hodqFQ62qrNo7HjzBKE3rFSE
         y30kwBNNJPDeJfZypECrCR0QATcKbDDrvxwyDyZRTsbGx1A0QoCyZ7/2s4i8yofX5Uch
         F8Rw==
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
Subject: [PATCH 4.16 02/18] arp: fix arp_filter on l3slave devices
Date: Wed, 11 Apr 2018 00:23:37 +0200
Message-Id: <20180410212758.678446275@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399683900973342?=
X-GMAIL-MSGID: =?utf-8?q?1597399683900973342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
