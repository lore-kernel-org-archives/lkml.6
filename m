Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56981C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19446218D9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="u8Y/8JDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBGCIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:08:37 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33503 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:08:36 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 66D4C8011F;
        Thu,  7 Feb 2019 15:08:33 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1549505313;
        bh=HUPdAc1UiiQKjDWdriLRf09KwNiMNt6G6AG8cVyDJys=;
        h=From:To:Cc:Subject:Date;
        b=u8Y/8JDvKdvQQ8ephlzUVZ5as0CZvHLd8fbWqweN3qte854O9IV0al72h34IiXVVw
         Mcbwno801ikVd0s3lff+4FtY6Yyryq7o389LR8cM3RiyWuCXLqSPdcjKhG9IJYJn3r
         mLM4bfEPhIQ+ZG+T29xANc6MU9S9iJlOzMFvthzrl/95RzQ4q0g8R8VF9ixQjDVWIm
         3YkXhBbgVMpF1fFtRLD1T0zNqa1qEVtrGp8iI40M7SKLr9bdF+17Strx07f1+hE/Yb
         9qEoSj+qicp3dxtR4Hxvpo87QO20ebgbb7OhmUNZlukvG0io0s7J+k+ZHFlXk8R7MK
         66IC0wWsbC+CA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c5b931f0000>; Thu, 07 Feb 2019 15:08:34 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id AA2F813EF01;
        Thu,  7 Feb 2019 15:08:36 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id ABD6B3A9BF1; Thu,  7 Feb 2019 15:08:30 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: ipmr: ip6mr: Create new sockopt to clear mfc cache only
Date:   Thu,  7 Feb 2019 15:08:27 +1300
Message-Id: <20190207020828.21854-1-callum.sinclair@alliedtelesis.co.nz>
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
  - Fix Compile Errors

Patch Set 3:
  - Fix Style Errors

Patch Set 4:
  - Implemented a way to clear the entries or vifs based off an input fla=
g.


Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache only

 include/uapi/linux/mroute.h  |  7 +++-
 include/uapi/linux/mroute6.h |  7 +++-
 net/ipv4/ipmr.c              | 69 +++++++++++++++++++++-------------
 net/ipv6/ip6mr.c             | 73 ++++++++++++++++++++++--------------
 4 files changed, 99 insertions(+), 57 deletions(-)

--=20
2.20.1

