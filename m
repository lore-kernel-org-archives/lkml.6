Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F923C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0205321736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Z4kmjHsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBJWMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:12:38 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38058 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:12:37 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 069C7806A8;
        Mon, 11 Feb 2019 11:12:34 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549836754;
        bh=tXVqB/VOZq86uvfy6dkXjVHR4xFAHuv/5YrZ26dfmZs=;
        h=From:To:Cc:Subject:Date;
        b=Z4kmjHshuip3OTrlYgLhnf1F5IcC1aHSbBGJCw8uWeBxnIUBmFeS0hwRPHNFGgH1w
         VQYdFZSiwA9C0cwtdBPrfPbQHcIsCR8TEVtaCJYekrl7IJmXePjsRG7UYpiK754qxd
         x9qFjA7Uf1eaPlMv7Hiwia147nDq11q5qikeIr2IC2K32+OKPyh+nUisZv89L1QYmC
         F9DA87yh00SlZcO1ci+siYrYv7iDL4wssIOtiFJi0fVqXaGhMnGGl9YdvFK2EhcvE/
         lzbgWrRGxyBenh466w4W8aFNHNMby1r5sC8+Tqw0DPE6uAfRh5g0GR9i31haYFLtgZ
         vuK7nB4BmPomg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c60a1c60000>; Mon, 11 Feb 2019 11:12:24 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id D2E6B13EECA;
        Mon, 11 Feb 2019 11:12:29 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id C65763A09E6; Mon, 11 Feb 2019 11:12:23 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs
Date:   Mon, 11 Feb 2019 11:12:21 +1300
Message-Id: <20190210221222.28215-1-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created a way to clear the multicast forwarding cache on a socket
without having to either remove the entries manually using the delete
entry socket option or destroy and recreate the multicast socket.

Using the flags MRT_FLUSH_ENTRIES and MRT_FLUSH_VIFS, all multicast
entries can be cleared, all multicast interfaces can be closed or both
can be cleared using one sockopt call.

Patch Set 2:
  - Created new flags to flush static entries or vifs

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs

 include/uapi/linux/mroute.h  |  9 ++++-
 include/uapi/linux/mroute6.h |  9 ++++-
 net/ipv4/ipmr.c              | 71 ++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 76 +++++++++++++++++++++++-------------
 4 files changed, 108 insertions(+), 57 deletions(-)

--=20
2.20.1

