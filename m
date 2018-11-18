Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE31A20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YJp57uAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE31A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeKSITr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:19:47 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52468 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeKSITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FaOxu9IScWZqehadeckdK2vcOxjvMUEdwR766hP5WRM=; b=YJp57uAlv/MxPh6xn92oML3Dzd
        +VgJd48ag+OCHh7Z1sOcBEsMMklPVGr03vu6SHv8ZJEcRD6dIWP0vKqPxidjevUhOXpQz/z4gG6ED
        ygRnvb0B6Ap/0CoM2k4XD/6V7BZ1eXoOKIAhpsTu7bLpLLVgjfLi/PgvpiuK/xpdoi2s=;
Received: from p200300ccfbe8ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbe8:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV52-00077d-Rr; Sun, 18 Nov 2018 22:58:12 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV52-0003D5-FD; Sun, 18 Nov 2018 22:58:12 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/5] gnss: sirf: add support for w2sg0004 + lna
Date:   Sun, 18 Nov 2018 22:57:56 +0100
Message-Id: <20181118215801.12280-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another chapter of the story to get gta04 gnss power
management into the mainline kernel.
There is a w2sg0004 without wakeup line in there, so power state
can only be determined indirectly by looking at the serial data lines.
Then there as also an lna which needs to be powered for real gps
reception. That part needs probably more discussion, since it might
be an idea to have it more generalized since it has nothing todo
with the chip itself.
I marked the corresponding patches as RFC. The support for
the w2sg0004 without wakeup can imho go in without the lna first
because users of that chip without an additional lna power supply
can already benefit from it if we should do more discussion first.
I just kept them together so that the full picture can be seen.

Andreas Kemnade (5):
  gnss: sirf: write data to gnss only when the gnss device is open
  gnss: sirf: power on logic for devices without wakeup signal
  dt-bindings: gnss: add w2sg0004 compatible string
  gnss: sirf: add a separate supply for a lna
  dt-bindings: gnss: add lna-supply property

 .../devicetree/bindings/gnss/sirfstar.txt          |   2 +
 drivers/gnss/sirf.c                                | 126 +++++++++++++++------
 2 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.11.0

