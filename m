Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68425C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372A820836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mj4j3LJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfBLDNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:13:09 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40505 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfBLDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:13:09 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4A232806A8;
        Tue, 12 Feb 2019 16:13:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549941185;
        bh=nlIUaIN7SSb56zKhDUggf/vi13Ji6xlM/Rl46p5GXUQ=;
        h=From:To:Cc:Subject:Date;
        b=mj4j3LJrvHRYur01tNhYuCbTMOVGgN2xjAhW25Ke5o4XS3IKg3Cm+Zui/ygt+Wpkg
         Ld96sqiUL4BLzqfcyvkxVRuDgdqZeuTlzVgZxtW4B4laWTraB6q1mMSPJnD5zcgUk3
         DtbYT5coVKm8K6hpZ0eBGRrsv+k9H1RgudtQWYS7YcYTpZHkaxuq98i98ZhR1W1eh6
         ux1e1dxjPqDyi1shlxeGUoMAlTjzHg9k2AccT2EgnKjzyZ8o/2fmaDzXmAyCMkGaSo
         +mPYVnPyGHlVWaz7fLW+szMR4bKSdPT5FhP2Kn2jHg/M2PP4iar9tVPcfBcND7K6a+
         /EZIv42SflO4w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c6239b90000>; Tue, 12 Feb 2019 16:12:57 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id B5CB613EF01;
        Tue, 12 Feb 2019 16:12:56 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id AB8723AA212; Tue, 12 Feb 2019 16:12:56 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nicolas.dichtel@6wind.com,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH net-next v4] ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs
Date:   Tue, 12 Feb 2019 16:12:54 +1300
Message-Id: <20190212031255.16121-1-callum.sinclair@alliedtelesis.co.nz>
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

MRT_FLUSH_MFC will clear all non static mfc entries
MRT_FLUSH_MFC_STATIC will clear all static mfc entries
MRT_FLUSH_VIFS will clear all non static interfaces
MRT_FLUSH_VIFS_STATIC will clear all static interfaces.

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs

 include/uapi/linux/mroute.h  |  9 ++++-
 include/uapi/linux/mroute6.h |  9 ++++-
 net/ipv4/ipmr.c              | 73 ++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 78 +++++++++++++++++++++++-------------
 4 files changed, 112 insertions(+), 57 deletions(-)

--=20
2.20.1

