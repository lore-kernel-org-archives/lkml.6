Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414804-2-1659503279789963885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414804; b=MUDYhKh6FpvpYagXF+zhwh5n7jgLk+7h/wD9F0ejAMoecKh
    oucoa4HQxzHjlECIpOB35IJJJl7CgqlalnI0Ji4KiMJIcAmEbLERbbqP2zTqvP0g
    gGuuBkLq0J4yX3vwCp9ERljZVSy+Doz4zI7yqF5OVDuDaMvSFS1ZtWdwvgqnSpBd
    7NsD6BvBIWCSXsWTVcFWjB6rZbWgzurDJ7aS/zB4xS/bZQleM1hGCfh1VyLStrjJ
    L6em/tFrSUtjwwJmO3ewe3J1lOP3WKHNmlEuSzAe3V0dibey5ZigOgJwH45AgYRq
    MmNEAvdLtL25JeYsxOxfHh6G5qeHPqsNjMHD77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414804; bh=r5j4rBl/FIf8MbeziS+r86qVGy
    7AfVNtFCObx1VTbPA=; b=SFOwcckE0R2QCJJoKKVno68eRNWyxKeLSCVJA2RmGQ
    j2PR/+MXHoOyirL3+PXyHjUBURQntOlpMhHsbdhWd/kSPihOhHkpvxPaRK2lNqEs
    j4YmY78SM6O6HnTLHEWqvsVS6AM7iY9FWfZbMdDdLzEBVZoK04LeJE6yfCcv0RV2
    o5NIKn87JabbCoKLjCffJpK9stVXI79jlb8x2WjM847mToC6Eo47GrltBXsLo+Jr
    rxNZPrbO8WSOAhLFI8Jt0myU/CtoJWPZDW0sEp92+qpP5MBceUgm8xxy3va/k35F
    hQCGnplzXeoo8uCHETdufS2p6bKU2Vhef3kXU4pxzbMg==
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
        id S1754621AbeBWTjs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:39:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934296AbeBWSth (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 015/159] xfrm: Fix stack-out-of-bounds read on socket policy lookup.
Date: Fri, 23 Feb 2018 19:25:23 +0100
Message-Id: <20180223170745.075446285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit ddc47e4404b58f03e98345398fb12d38fe291512 upstream.

When we do tunnel or beet mode, we pass saddr and daddr from the
template to xfrm_state_find(), this is ok. On transport mode,
we pass the addresses from the flowi, assuming that the IP
addresses (and address family) don't change during transformation.
This assumption is wrong in the IPv4 mapped IPv6 case, packet
is IPv4 and template is IPv6.

Fix this by catching address family missmatches of the policy
and the flow already before we do the lookup.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1168,9 +1168,15 @@ static struct xfrm_policy *xfrm_sk_polic
  again:
 	pol = rcu_dereference(sk->sk_policy[dir]);
 	if (pol != NULL) {
-		bool match = xfrm_selector_match(&pol->selector, fl, family);
+		bool match;
 		int err = 0;
 
+		if (pol->family != family) {
+			pol = NULL;
+			goto out;
+		}
+
+		match = xfrm_selector_match(&pol->selector, fl, family);
 		if (match) {
 			if ((sk->sk_mark & pol->mark.m) != pol->mark.v) {
 				pol = NULL;
