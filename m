Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B810C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8DE21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mJTExgCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfAXGe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:34:56 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:48656 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAXGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ut/6aP9u8OlLyU1dfKG5iXCRfy1XO4eymr3CvcWW0DE=; b=mJTExgCrQJLX4g5/u3BpXPwYuH
        20rmdH9V7nwNV0be4lQ6qOJhDrmt4tfyDoykoNNcmFWXnQpj7tTBgHZeJdtQqTFKz1gEUmpq3ZNre
        hvwMshtrpjH8ZSt/pc3qvZhDH0vA78J1VbGg4XP1YDbwPnI6LxMCnS1ULKeKoSA0ZifI=;
Received: from [77.247.85.78] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYbA-0000vG-MC; Thu, 24 Jan 2019 07:34:48 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb4-0007rL-EX; Thu, 24 Jan 2019 07:34:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 0/5] gnss: sirf: add support for w2sg0004 + lna
Date:   Thu, 24 Jan 2019 07:34:34 +0100
Message-Id: <20190124063439.29897-1-andreas@kemnade.info>
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
reception.

Changes in v2:
  - do not change behavior of devices with wakeup line
    - do not keep serdev open if runtime is active and device is not used
  - style cleanup
  - locking of sirf_close() vs. gnss_insert_raw()
  - name reordering

Changes in v3:
  - more style cleanup
  - more locking
  - better regulator error handling
  - timeout logic cleaned up and problems documented
  - initial power off sorted out as a separate patch
  - renamed patch gnss: sirf: power on logic for devices without wakeup signal

Changes in v4:
  - rebased on top of "gnss: sirf: fixes and cleanups"
    so the initial powerdown patch is unneeded
  - cleanups

Andreas Kemnade (5):
  gnss: sirf: write data to gnss only when the gnss device is open
  gnss: sirf: add support for configurations without wakeup signal
  dt-bindings: gnss: add w2sg0004 compatible string
  gnss: sirf: add a separate supply for a lna
  dt-bindings: gnss: add lna-supply property

 Documentation/devicetree/bindings/gnss/gnss.txt    |   1 +
 .../devicetree/bindings/gnss/sirfstar.txt          |   1 +
 drivers/gnss/sirf.c                                | 212 ++++++++++++++++++---
 3 files changed, 188 insertions(+), 26 deletions(-)

-- 
2.11.0

