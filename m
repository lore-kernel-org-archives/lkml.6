Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591523-2-2993091634698725375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591522; b=aU3YSsxC6f170h2K4jx8jm4R62gk3kNruRszOgtFoNgG/xJ
    i7BfIHNJH8SBzAJhikDBWqsrPJIvk46GJy9Zp+Pov4D4YyQrmWfCyryHVQwzmoea
    Ssj4jNVuXkK6Pd468daWiidg2zS/UW+C7ACtAPe9ZipcgvnnhIYYCJsS6AMFLscD
    5Cofk5dsw4Mg7IBfozxCaUhTQv2/SewSbPoqdtEXXTFkY/eKXDTJraYXCjTUpY2w
    r26PsqYX+kSSduDTCPU8xJKGicu8PY9zCdvMWKC7mpXO22MO2BFdU5KWTNnRE0Rk
    fCWVtOl+GlqR22MMcG6V77gpQ5kphw/VP8ZpXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591522; bh=Jl+qC5b4m7mjdkvXMkb/AQ45Fv
    hSxi7dnPxBTOHMD/4=; b=VW0Ryy4KEdW+iGyEn/ZZdCHToli831lKKy1fr7/rKN
    ZOZe4fXsUoK5+elIcch7MoaKFhB9eU28RCtBh6wjd0xZQQYRysntfCds0y0mY4fb
    GncupeJYtQGw7qldVfJ7BKmQy7urHbEYIP9iUkRfaXBWgUXQN8xRmXBiNQgvXRxy
    ZVuE4exdEzEK1BQ857Uh+0mGK1jfHIBND08ks1hSsig9WdYT+dqEwoCk/HBC7svw
    TbMEKB956Mi+GIdX15YzHqcJqKAEFhepa+0Qh1R8ZAJXGG6ZuLWuxArLCMNuk6mx
    5lO39Zk0KkQAtVw0jjUVMFxoxppufDw3CVrbYfKs7mAg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeBBRMA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:12:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeBBRLz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhangliping <zhangliping02@baidu.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 067/156] openvswitch: fix the incorrect flow action alloc size
Date: Fri,  2 Feb 2018 17:57:28 +0100
Message-Id: <20180202140843.335166031@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangliping <zhangliping02@baidu.com>


[ Upstream commit 67c8d22a73128ff910e2287567132530abcf5b71 ]

If we want to add a datapath flow, which has more than 500 vxlan outputs'
action, we will get the following error reports:
  openvswitch: netlink: Flow action size 32832 bytes exceeds max
  openvswitch: netlink: Flow action size 32832 bytes exceeds max
  openvswitch: netlink: Actions may not be safe on all matching packets
  ... ...

It seems that we can simply enlarge the MAX_ACTIONS_BUFSIZE to fix it, but
this is not the root cause. For example, for a vxlan output action, we need
about 60 bytes for the nlattr, but after it is converted to the flow
action, it only occupies 24 bytes. This means that we can still support
more than 1000 vxlan output actions for a single datapath flow under the
the current 32k max limitation.

So even if the nla_len(attr) is larger than MAX_ACTIONS_BUFSIZE, we
shouldn't report EINVAL and keep it move on, as the judgement can be
done by the reserve_sfa_size.

Signed-off-by: zhangliping <zhangliping02@baidu.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1903,14 +1903,11 @@ int ovs_nla_put_mask(const struct sw_flo
 
 #define MAX_ACTIONS_BUFSIZE	(32 * 1024)
 
-static struct sw_flow_actions *nla_alloc_flow_actions(int size, bool log)
+static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 {
 	struct sw_flow_actions *sfa;
 
-	if (size > MAX_ACTIONS_BUFSIZE) {
-		OVS_NLERR(log, "Flow action size %u bytes exceeds max", size);
-		return ERR_PTR(-EINVAL);
-	}
+	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
 
 	sfa = kmalloc(sizeof(*sfa) + size, GFP_KERNEL);
 	if (!sfa)
@@ -1983,12 +1980,15 @@ static struct nlattr *reserve_sfa_size(s
 	new_acts_size = ksize(*sfa) * 2;
 
 	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size)
+		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
+			OVS_NLERR(log, "Flow action size exceeds max %u",
+				  MAX_ACTIONS_BUFSIZE);
 			return ERR_PTR(-EMSGSIZE);
+		}
 		new_acts_size = MAX_ACTIONS_BUFSIZE;
 	}
 
-	acts = nla_alloc_flow_actions(new_acts_size, log);
+	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
 		return (void *)acts;
 
@@ -2660,7 +2660,7 @@ int ovs_nla_copy_actions(struct net *net
 {
 	int err;
 
-	*sfa = nla_alloc_flow_actions(nla_len(attr), log);
+	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
