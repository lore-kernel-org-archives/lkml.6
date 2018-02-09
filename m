Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184332-2-14855750902922151742
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184331; b=IBI1DbHQz+l8Tj2IxVCz93pU7PG/pbmiiMbHO5gMNjegngO
    BO/qtHZMk2JbYTFlUsPqcs3C2TdwUsPJeITIfTjRzW1OfpyGfy04RDkzHuXu5m6o
    MArBTme3nZQRfB4XojMKkgDXkjB+Y425gOC+0G/qd0eqx1tDVtiwGpDSk6xx/z8j
    zMC6dXXLebdmXZTfIBlR6m5Iwd4+YtumNr9NRUPvZaaYG2xbHjoG096hq0Lky8OT
    JTp/Ak9m2b9NbX+BjPo1WOaiTODgvkrx2bpcw0HDgUeSGqoRPHzytpUJizSR0ihF
    3Osftnh8Z5dwjqEM3rdKPTyx7WgiWhp0awHm4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184331; bh=tfhqt+cJ+N65P3Q4Bmtv0E/wto
    y25Q8A8Ho8Qo55wzk=; b=Qxye62XsRYVx7FwDX3e2lcq66JKfP5UY795PlL1ulH
    77955hXuLexXZDlUdCdM+K2wAzkz0DOILbmxaY00d0Fa+hcVaIv8fjMTaqJAMPNN
    H0qjVOBHvOPFPl2yrbPzqoLf4omTp8BWPEzeCe1ePT8YEXUKTIyRdBIJgiiI3KRA
    FO9XvhdP0RtVIpExchVeVTUxTw1XKNrBiE4dNeE8Kla11Vm2RgoHJZAYQ1SVtXa9
    ZVlKmi6nUoioZAt3Y/U8MfhlC+s8PBunobGkNp/K3eY8tAFwF99yw1/LjjIrBMmP
    +5r1UVH7xL5E/2qPrvIWcTA26kM+Zm6uUs4gCAfYw8QA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeBINqQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbeBINqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vivek Venkatraman <vivek@cumulusnetworks.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 11/23] net: ipv6: send unsolicited NA after DAD
Date: Fri,  9 Feb 2018 14:40:09 +0100
Message-Id: <20180209133938.946399194@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>


[ Upstream commit c76fe2d98c726224a975a0d0198c3fb50406d325 ]

Unsolicited IPv6 neighbor advertisements should be sent after DAD
completes. Update ndisc_send_unsol_na to skip tentative, non-optimistic
addresses and have those sent by addrconf_dad_completed after DAD.

Fixes: 4a6e3c5def13c ("net: ipv6: send unsolicited NA on admin up")
Reported-by: Vivek Venkatraman <vivek@cumulusnetworks.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |   30 ++++++++++++++++++++++++++----
 net/ipv6/ndisc.c    |    5 +++++
 2 files changed, 31 insertions(+), 4 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -186,7 +186,8 @@ static struct rt6_info *addrconf_get_pre
 
 static void addrconf_dad_start(struct inet6_ifaddr *ifp);
 static void addrconf_dad_work(struct work_struct *w);
-static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id);
+static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
+				   bool send_na);
 static void addrconf_dad_run(struct inet6_dev *idev);
 static void addrconf_rs_timer(struct timer_list *t);
 static void __ipv6_ifa_notify(int event, struct inet6_ifaddr *ifa);
@@ -3833,12 +3834,17 @@ static void addrconf_dad_begin(struct in
 	     idev->cnf.accept_dad < 1) ||
 	    !(ifp->flags&IFA_F_TENTATIVE) ||
 	    ifp->flags & IFA_F_NODAD) {
+		bool send_na = false;
+
+		if (ifp->flags & IFA_F_TENTATIVE &&
+		    !(ifp->flags & IFA_F_OPTIMISTIC))
+			send_na = true;
 		bump_id = ifp->flags & IFA_F_TENTATIVE;
 		ifp->flags &= ~(IFA_F_TENTATIVE|IFA_F_OPTIMISTIC|IFA_F_DADFAILED);
 		spin_unlock(&ifp->lock);
 		read_unlock_bh(&idev->lock);
 
-		addrconf_dad_completed(ifp, bump_id);
+		addrconf_dad_completed(ifp, bump_id, send_na);
 		return;
 	}
 
@@ -3967,16 +3973,21 @@ static void addrconf_dad_work(struct wor
 	}
 
 	if (ifp->dad_probes == 0) {
+		bool send_na = false;
+
 		/*
 		 * DAD was successful
 		 */
 
+		if (ifp->flags & IFA_F_TENTATIVE &&
+		    !(ifp->flags & IFA_F_OPTIMISTIC))
+			send_na = true;
 		bump_id = ifp->flags & IFA_F_TENTATIVE;
 		ifp->flags &= ~(IFA_F_TENTATIVE|IFA_F_OPTIMISTIC|IFA_F_DADFAILED);
 		spin_unlock(&ifp->lock);
 		write_unlock_bh(&idev->lock);
 
-		addrconf_dad_completed(ifp, bump_id);
+		addrconf_dad_completed(ifp, bump_id, send_na);
 
 		goto out;
 	}
@@ -4014,7 +4025,8 @@ static bool ipv6_lonely_lladdr(struct in
 	return true;
 }
 
-static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id)
+static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
+				   bool send_na)
 {
 	struct net_device *dev = ifp->idev->dev;
 	struct in6_addr lladdr;
@@ -4046,6 +4058,16 @@ static void addrconf_dad_completed(struc
 	if (send_mld)
 		ipv6_mc_dad_complete(ifp->idev);
 
+	/* send unsolicited NA if enabled */
+	if (send_na &&
+	    (ifp->idev->cnf.ndisc_notify ||
+	     dev_net(dev)->ipv6.devconf_all->ndisc_notify)) {
+		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifp->addr,
+			      /*router=*/ !!ifp->idev->cnf.forwarding,
+			      /*solicited=*/ false, /*override=*/ true,
+			      /*inc_opt=*/ true);
+	}
+
 	if (send_rs) {
 		/*
 		 *	If a host as already performed a random delay
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -566,6 +566,11 @@ static void ndisc_send_unsol_na(struct n
 
 	read_lock_bh(&idev->lock);
 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		/* skip tentative addresses until dad completes */
+		if (ifa->flags & IFA_F_TENTATIVE &&
+		    !(ifa->flags & IFA_F_OPTIMISTIC))
+			continue;
+
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifa->addr,
 			      /*router=*/ !!idev->cnf.forwarding,
 			      /*solicited=*/ false, /*override=*/ true,
