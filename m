Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25138C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D052083E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2iHog6XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D052083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZKgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:36:47 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48127 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeJZKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:36:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E55108364D;
        Fri, 26 Oct 2018 15:01:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540519299;
        bh=InN8OegVbtOBG7yAY7yXNMRyHMNyI04HisGDicfMqOc=;
        h=From:To:Cc:Subject:Date;
        b=2iHog6XOboLyftjkHM0Os1qgXDswLzu5Xy+tesdByrU5V1uAQ9J6I7Oq+jb2UrXb6
         3+72v78rck5iGFQOWxbeMuuXefgbRxnraQl3cYCEER8FtTvYfX0X4gLRdh23kvkhwW
         5eUviXyz/C3kTZLVkMBb7Tg59Lh8lfqtdkKVTFZaOggYE+8sN7sC8UpJH5om69rAus
         C2/5eiCwU7WWtCPD8+1ur78A4mvBUea+xcvdsMMEHlBXIQxhnBgUsVdw/zbKeZhvoA
         WextQ+FjAol9hqT0R75HU7Sa2++bLs+bW09u+WCw9NYRChdPlisAZFncV6KD2UWa7f
         K1m0m7TpYjBew==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd275820000>; Fri, 26 Oct 2018 15:01:40 +1300
Received: from brodieg-dl.ws.atlnz.lc (brodieg-dl.ws.atlnz.lc [10.33.22.16])
        by smtp (Postfix) with ESMTP id 03E7A13ECD5;
        Fri, 26 Oct 2018 15:01:42 +1300 (NZDT)
Received: by brodieg-dl.ws.atlnz.lc (Postfix, from userid 1718)
        id 32B6B500471; Fri, 26 Oct 2018 15:01:37 +1300 (NZDT)
From:   Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz,
        Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Subject: [PATCH 0/1] Make ipmr queue length configurable
Date:   Fri, 26 Oct 2018 15:01:21 +1300
Message-Id: <20181026020122.22210-1-brodie.greenfield@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to have some more space in our queue for processing incoming
multicast packets, so we can process more of them without dropping
them prematurely. It is useful to be able to increase this limit on
higher-spec platforms that can handle more items.

For the particular use case here at Allied Telesis, we have linux
running on our switches and routers, with support for the number of
multicast groups being increased. Basically, this queue length affects
the time taken to fully learn all of the multicast streams.=20

Brodie Greenfield (1):
=20 ipmr: Make cache queue length configurable

=20Documentation/networking/ip-sysctl.txt | 7 +++++++
=20include/net/netns/ipv4.h               | 1 +
=20include/uapi/linux/sysctl.h            | 1 +
=20kernel/sysctl_binary.c                 | 1 +
=20net/ipv4/af_inet.c                     | 2 ++
=20net/ipv4/ipmr.c                        | 4 +++-
=20net/ipv4/sysctl_net_ipv4.c             | 7 +++++++
=207 files changed, 22 insertions(+), 1 deletion(-)

--=20
2.19.1
