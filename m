Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56797C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B630521908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vogybaas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBHELI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:11:08 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35980 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHELI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:11:08 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CE8268011F;
        Fri,  8 Feb 2019 17:11:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549599065;
        bh=2FDO7rFqOhl7jNSFnZeec+aX+BB3ND308jRm/H6fc9A=;
        h=From:To:Cc:Subject:Date;
        b=vogybaasJhM/xTsSh/PES7yw6PVyRQQPGyoWeizmN5+T3XgKrjDmQOPKdFNdUCWuB
         Kaa1mjuYL98+apZHGtLydqKTUQPb3fCkx9B3qxOrSui0KJbjaFCwfGWppVm/xYhzej
         z2VSuC4uhnPraGXTvpPiqtyX2weWeg3H18rQuvl9HUM7EUJGcKO4MpGnsByxd7R0v2
         qzAn5zjzuQ5Fl3Hezi/u0qXUpoDwjOewtZev95JLIVr0GmQ5g3yorKMPI7IhpuB+62
         ciMPGZMADGVYJZTQUxTmZ4PcaV6SfoTlzJnrJMHmQNOBRt1aOXhQn3bK0iBBMxxtX6
         m3u5m4ZTylMHA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c5d015a0000>; Fri, 08 Feb 2019 17:11:06 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id 9A7A713EECA;
        Fri,  8 Feb 2019 17:11:11 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 94C943AA350; Fri,  8 Feb 2019 17:11:05 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs
Date:   Fri,  8 Feb 2019 17:11:02 +1300
Message-Id: <20190208041103.31299-1-callum.sinclair@alliedtelesis.co.nz>
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

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache or vifs

 include/uapi/linux/mroute.h  |  7 +++-
 include/uapi/linux/mroute6.h |  7 +++-
 net/ipv4/ipmr.c              | 69 ++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 74 ++++++++++++++++++++++--------------
 4 files changed, 100 insertions(+), 57 deletions(-)

--=20
2.20.1

