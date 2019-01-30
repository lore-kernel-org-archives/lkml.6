Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E513C282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rziBfqQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfA3CZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:25:18 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49155 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfA3CZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:25:18 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A104B8448C;
        Wed, 30 Jan 2019 15:25:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1548815115;
        bh=FtGg2mgGSyW+UyijjTus20+D4kntCpDZETnHvxHZYlA=;
        h=From:To:Cc:Subject:Date;
        b=rziBfqQRDfDwA9cqcCJlLfoqaOk9RLWxurKQ5qTaOpyM7kWl2AW8ZojiUrnGrHryn
         ZpOfMHJ/hOfNUktNwdayi7XzyMS+XIM9cieD5yKxnQ1hc9WYs+RnbvwrF/LNZ2e7PY
         Y5NI4iQBvmzY+b61FuDqBoKc9DD2giKxEtW8c3aqYwBFVFF48dYleegzUeSEz1vYKn
         J483hp3T0llOQblHtohFo1dW0itGBN0KoNcEBDgz/t35CP+gvpriKGol6P4LXCEQ7w
         t/pq+otPtTKJCOSifrjbUdivBjc7H3CDTJe3hmAl//tAm1oFvwW/ipbw6VVN6YVzah
         VCsYmukm5FSsg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c510b0b0000>; Wed, 30 Jan 2019 15:25:15 +1300
Received: from callums-dl.ws.atlnz.lc (callums-dl.ws.atlnz.lc [10.33.22.12])
        by smtp (Postfix) with ESMTP id 5D0B313EEFB;
        Wed, 30 Jan 2019 15:25:21 +1300 (NZDT)
Received: by callums-dl.ws.atlnz.lc (Postfix, from userid 1764)
        id 6F6433A041A; Wed, 30 Jan 2019 15:25:15 +1300 (NZDT)
From:   Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Subject: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
Date:   Wed, 30 Jan 2019 15:25:08 +1300
Message-Id: <20190130022509.25303-1-callum.sinclair@alliedtelesis.co.nz>
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

Callum Sinclair (1):
  ipmr: ip6mr: Create new sockopt to clear mfc cache only

 include/uapi/linux/mroute.h  |  3 ++-
 include/uapi/linux/mroute6.h |  3 ++-
 net/ipv4/ipmr.c              | 41 +++++++++++++++++++++-----------
 net/ipv6/ip6mr.c             | 45 +++++++++++++++++++++++-------------
 4 files changed, 60 insertions(+), 32 deletions(-)

--=20
2.20.1

