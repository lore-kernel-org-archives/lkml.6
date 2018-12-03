Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1FC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA1A20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lm6uPTw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA1A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLCHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:59 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:60611 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:58 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB37p4O1009296;
        Mon, 3 Dec 2018 16:51:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB37p4O1009296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543823465;
        bh=c2KWmbyD/iAnOI30KUeYe3usJKSD0OWJ1yYAuzzhrno=;
        h=From:To:Cc:Subject:Date:From;
        b=lm6uPTw4qWzTmrTmXGTg7wxyYHUBA+RQ9KNZNBt4tVEoS+RsD2vBG9//YFz9VL3G5
         pYICs3BpCtvvCNs2ddffwB/IOB4chCxE1uQYIVFeuev0C8dbWYwxm404hoy2KbN1QU
         7uVMO7j8KGXKyV+t7WL+TrLEf8uhR3DXsJtGvuIPcmMH09bbPpIIafjdZb/7Hw6Muk
         Lj3vXnSURgf3LLekQeXwmkT2mC5IISO+T0Wt8aDTlknRXnvaG7X5pKjGE2tqZ4Gq3A
         CpkgNK8KWkdyNh6+J3nIXPVJz8rrXPlhj3sOyHm8J/Hy/FP3IleHxn1RP0Sx2rHJsB
         pTwnUmtnkHLlw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/7] microblaze: fix various problems in building boot images
Date:   Mon,  3 Dec 2018 16:50:50 +0900
Message-Id: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes various issues in microblaze Makefiles.

BTW, "simpleImage.<dt>" works like a phony target to generate the
following four images, where the first three are just aliases.

 - arch/microblaze/boot/simpleImage.<dt>:
         identical to arch/microblaze/boot/linux.bin

 - arch/microblaze/boot/simpleImage.<dt>.unstrip:
         identical to vmlinux

 - arch/microblaze/boot/simpleImage.<dt>.ub:
         identical to arch/microblaze/boot/linux.bin.ub

 - arch/microblaze/boot/simpleImage.<dt>.strip:
         stripped vmlinux

I am not sure how much useful those copies are,
but, I tried my best to keep the same behavior.

IMHO, I guess DTB=<dt> would be more sensible,
but it is up to Michal.



Masahiro Yamada (7):
  microblaze: fix cleaning of boot images
  microblaze: adjust the help to the real behavior
  microblaze: move "... is ready" message to arch/microblaze/Makefile
  microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
  microblaze: add linux.bin* and simpleImage.* to PHONY
  microblaze: fix race condition in building boot images
  microblaze: remove the unneeded code just in case file copy fails

 arch/microblaze/Makefile          | 14 +++++++++-----
 arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
 arch/microblaze/boot/dts/Makefile |  5 +----
 3 files changed, 27 insertions(+), 25 deletions(-)

-- 
2.7.4

