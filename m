Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MYLvacmJEFpI/qvQ2/1l/F5eG6ExIqCP/860FNrmiy5L8C8522WU1JyLjc6j9PelnicQz
ARC-Seal: i=1; a=rsa-sha256; t=1523473516; cv=none;
        d=google.com; s=arc-20160816;
        b=jP0wPyCZCRu09mWQsqmtGQVHyJmaGQq7yltLa3+F4FzgubAjUKwBFRRzyJJDNp39tj
         57+CS/NyOK4GcYH5F2jQsxpAzt0pqYtVLAtLbGqmRadDWUmrWldhnKNXzYvr/8JjQHyb
         Z3szw+9qbHYwE2vdr9kTROTO5SbqfHbkKxxVO54IKB0vMI8SG2wCWP1HQgoCrc0XqGgh
         epB0PBGZQUmM/SO04z7kFnu+Oe2Emzdb2V2dkpEjiC/9k9tgC+dfpTiFxCEx8jIjQhOz
         1UWVJ5XaV28pE1uG9VOpr0uAUVqs06loOR9YJgErod/PklomWFxl1YpROtK8aoEOZUgZ
         4Vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uBYldfdjNjfxP+wqgwGc5RkEmG6c5svM7vMPMTag/Lo=;
        b=ruy8wLl7lRnzPTm2NuEgVHABbe355PXIs5QL4zm/mjiDiybhUwQsCTrEmhVdmn79Sz
         hbOAm6yGqbgZd4Sy52Hq5DNSiFseqhwMYyGzW4Dr3WyLVFdc/0u8XEQ53Ll9qagmWWcA
         KHLZi8tKGn8De8UTVPCtSS+h1kRVfZsJ32jY7+SWBbGvOFrGTm8ip7TBX2VOIS1X1vr+
         FiNfuX0OWeoLQoDqdb9286rUJEnUzFTw6Xji/DBuEwc4xUhawNawd08x9zIMbzkxzcLA
         mXRfU4+E3YhWrDNAXODVqXrhElHF/9GwUSNRVkOPefYHddKfuqhuZpDeF7SIgAmKu2jl
         ZSFw==
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
Subject: [PATCH 4.9 276/310] arp: fix arp_filter on l3slave devices
Date: Wed, 11 Apr 2018 20:36:55 +0200
Message-Id: <20180411183634.497130430@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476873404359288?=
X-GMAIL-MSGID: =?utf-8?q?1597477765994561929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
