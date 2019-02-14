Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD39C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F201B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zfLUdDQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394131AbfBNCoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:44:25 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45916 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfBNCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:44:24 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C8CD3806A8;
        Thu, 14 Feb 2019 15:44:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1550112261;
        bh=impbUH9nV+toQTY7M/OP/YMGwFlXyj2IM63BNKJzDAE=;
        h=From:To:Cc:Subject:Date;
        b=zfLUdDQxNQmPP/JNIsOLlznlMQLrZ4SsrUdvoLr6hZOjz56seUKrmKDJEBdeOYvLf
         CPoDHaW6yJy5d2/kcgUFjVS0xEBN8JAHssrtzLEo8SJLa8BIDfm4fyf2jY6bRbzAFM
         hcMRKs0DtLBijH4hpfrFiwJhgV7VPyn8yL4kRUymOx5z8Ki7+P98fJI48r1UPSIaNy
         /LGngz+mXPhc7DQWn2tg3newdRnows0o51X/ILblYMx5f7iKr5owsBaGEkurwCpDI1
         djMrd4vm3TRC1VRhtWfqfrmpOayo65RF2r/kN4NUvHOWByIr6rc37XQF0QGsaWNsJB
         DcenED29HMa3g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c64d6030000>; Thu, 14 Feb 2019 15:44:20 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id D9C8A13ED33;
        Thu, 14 Feb 2019 15:44:20 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id CBF6F3A0176; Thu, 14 Feb 2019 15:44:20 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nicolas.dichtel@6wind.com,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH net-next v5] ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs
Date:   Thu, 14 Feb 2019 15:44:17 +1300
Message-Id: <20190214024418.21490-1-callum.sinclair@alliedtelesis.co.nz>
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

Calling the socket option MRT_FLUSH will allow any combination of the
four flag options to be cleared.

MRT_FLUSH_MFC will clear all non static mfc entries and clear the unresol=
ved cache
MRT_FLUSH_MFC_STATIC will clear all static mfc entries
MRT_FLUSH_VIFS will clear all non static interfaces
MRT_FLUSH_VIFS_STATIC will clear all static interfaces.

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs

 include/uapi/linux/mroute.h  |  9 ++++-
 include/uapi/linux/mroute6.h |  9 ++++-
 net/ipv4/ipmr.c              | 75 +++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 78 +++++++++++++++++++++++-------------
 4 files changed, 115 insertions(+), 56 deletions(-)

--=20
2.20.1

