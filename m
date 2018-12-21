Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B0B217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="s388RoDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbeLUPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:15:26 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:38484 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbeLUPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:15:25 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1545405322; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=lTRJUL0Yahq7JN1bW0uPxHC2MDoSg3ibls3Avb5GR/M=;
        b=s388RoDaer9X9snNErQYSgRYEE3Cqz6AwiN/eWp1+DF6xTfx/xnavfbF7FiZow/4JIbxNY
        xxzEC7l87k1N3FqTUInpB4eDOQUHBgwGNppm3UBbjD19yJXEgXMZS7Tf/hMwVZUZ9UQQSN
        B2Xq12Qvu5w7bh11BE7+MK0+01eM6+894dE1KaDhm6UMGmxzRTLpIZTK5vXFVVQlCmeJjo
        B+Xqb30fa11POH66OAr8YNztSEYOgM9zXRw24is0SFTXBLkfCHWef95MOK3ymxRuA279gf
        Fiyxwm7f5NYmenxcvjCq5WX/UOEAzBV1iedyBAR2a9oyIlPj9HuEfh2dmDhgsQ==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] bridge: implement Multicast Router Discovery (RFC4286)
Date:   Fri, 21 Dec 2018 16:15:07 +0100
Message-Id: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1545405322; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=lTRJUL0Yahq7JN1bW0uPxHC2MDoSg3ibls3Avb5GR/M=;
        b=jZ8yB4xIk9J17F1YY25e9WUhVljLguSPcudp56TnBfz+5iEmFN44fgB2nmdcu6yQGplhxe
        PgIU2+D4/3O/Srv+hofLvzWhlyLCPJiSTKcCwDPm51TCv2TkaNfOkA0ozMcVmbipB/w4Q9
        7vBpnaTmPyuKZv17G8U68S4ZAOTQ6IAwtg7nW5Soq1G0fbzJ+Mt7QX7LOEGrWzEiLbMSWg
        8Gl8S1E/W9xAYm6mVoANjB2qJRBR7/1UvstR2bW3U9sdnEdyFHo6o3JdIYuAXFy6QDnyLS
        cQsNABn/tJlDedZ8zSByTH9fNES+0jUXG95t246RLYfMBU2sTp55Z3Ze6s9c8w==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1545405322; a=rsa-sha256; cv=none;
        b=a0Ynt6pKn8Dl+j6ISQ6+Bvs5Tl0wbV8Eg0RKYb5H0Z1zwT0jT0pt9lkZMIPpjta9+UQS8U
        QVT8Gn9D4zazyLJciAi6LHCKstUuzquCc8jkRZhBmd4qR3Fc7fHeZwwnyr20SZpy5jPf+S
        mRQwK0rPqocClTWMYC2BC2MyKH7NTrNex4GFqiQg4Qyi39Lw2xmHOYC2dhbOgzgzKekYwB
        AGnmmKKxhA/+sTmE6pWyXv4/0JAMrd39eQmo+HQHHCwesVrtlXmZ18t2Wx+sFYsHRTZf3R
        +AqtBYKt6hedachPP+hv0/L2FfFlfJUv6rTUi06Z9EIPf0/u4nOHD4/gEh/GKA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial Multicast Router Discovery support to
the Linux bridge (RFC4286). With MRD it is possible to detect multicast
routers and mark bridge ports and forward multicast packets to such routers
accordingly.

So far, multicast routers are detected via IGMP/MLD queries and PIM
messages in the Linux bridge. As there is only one active, selected
querier at a time RFC4541 ("Considerations for Internet Group Management
Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
Switches") section 2.1.1.a) recommends snooping Multicast Router
Advertisements as provided by MRD (RFC4286).


The first two patches are refactoring some existing code which is reused
for parsing the Multicast Router Advertisements later in the fourth
patch. The third patch lets the bridge join the all-snoopers multicast
address to be able to reliably receive the Multicast Router
Advertisements.


What is not implemented yet from RFC4286 yet:

* Sending Multicast Router Solicitations:
  -> RFC4286: "[...] may be sent when [...] an interface is
     (re-)initialized [or] MRD is enabled"
* Snooping Multicast Router Terminations:
  -> currently this only relies on our own timeouts
* Adjusting timeouts with the values provided in the announcements


Regards, Linus



