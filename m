Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897EDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D47F20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="dUmkFV5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfBKHVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:21:21 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:13362 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549869677;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2+Wj7m7ySIuMfGlN7asIXsR+ghoPH8tIEa6cdB4icBU=;
        b=dUmkFV5rSIJebTEL7agFsmT8sWXeA5VIskO2jwVZjoWXDolGR7SZo28pmJ49ujIBfN
        O0XVly3OX6GQlnR2AERXTHuiujneC5Yqj61G6RLV8NCDtJ4aN6DEWQGq8IVC2MX30RMM
        O7e/rlE6KoWYsMp5hRoAZ1Hl+sM1PHCAa7D8vEuC19ok2iMWizCH2ABfT3uDa+ciQsQL
        0VyTXGkqkloAIDCpUva8uMmXbBWy1V3AQmb31/SOYDJzXw2Kjy7tlGxCacJtJFs+vLeT
        VgkBAmWHxNrbz/eAwJv1c02fnzkFmyBxFcK9W0KMWKtD30N/kmK4XHWJjqc557yFsUE0
        atSg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWZ5grpnxnRrZcnSnXxCNGtcwUruZsoM1Hh3rrCw"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8189:222c:8934:2abd:8ff5:5de2]
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id t0203dv1B7LBGUZ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Feb 2019 08:21:11 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
Date:   Mon, 11 Feb 2019 08:21:11 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0807B9CE-69E6-45A6-A029-1AAE5615CC8E@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de> <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de> <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Mario successfully tested a kernel from your Git [1] on his T2080rdb today.

Link to the log:=20
https://gitlab.com/oshw-powerpc-notebook/T2080customizations/blob/master/ker=
nel/dma_fix/kernel_dma_fix_log.txt

He wrote:

Please, note that all of the above kernel runs just fine with the T2080rdb, h=
owever did not had the time to test extensively (tested: login into MATE gra=
phical desktop environment, used ArctiFox for opening couple of websites, th=
en played Neverball).

=E2=80=94=E2=80=94

Cheers,
Christian

[1] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6=
