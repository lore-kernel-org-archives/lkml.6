Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91892C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA24213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6Od1+H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBYMxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:53:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBYMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5dPdOvbusVr+EyG/9ID51AcWvw5q49yxSYTPP713r5c=; b=U6Od1+H6hpuqGlWV6o0uPdDfi
        UEDKzLodHpTI6WyS6bjfl2iUXKlN586QFAaLdy5tA+nE9TVhfLCzAsemyql4BpJrTh3V5gfoEqzx3
        Q1bZjdERft9qbLz4/gLqGQin5nHzNXr7hxIQ75eKGUbsnUt85bmdM/5ZArXVmUFOmj9MpVJsA6oDU
        N+/L7KwYHGzAhsiUwC9mJzjPxNAn73GWgJn1X3S27b1yI14T/VwaDsE1Yz1+fE5Cw/osXNCUkoFCU
        NPO0jMQc64gs594aSgafM18RiWvV5M1YfuzhKKg+C12jwwF0Aha56ogf/zM/Azm5AX7DyBI6XZptO
        HAkbP/uQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyFkm-0000Eh-P8; Mon, 25 Feb 2019 12:53:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9568E20272A83; Mon, 25 Feb 2019 13:53:02 +0100 (CET)
Message-Id: <20190225124330.613028745@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 25 Feb 2019 13:43:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/6] objtool: UACCESS validation
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Teach objtool to validate the UACCESS (SMAP, PAN) rules which are currently
unenforced and (therefore obviously) violated.

UACCESS sections should be small; we want to limit the amount of code that can
touch userspace. Furthermore, UACCESS state isn't scheduled, this means that
anything that directly calls into the scheduler will result in random code
running with UACCESS enabled and possibly getting back into the UACCESS region
with UACCESS disabled and causing faults.

Forbid any CALL/RET while UACCESS is enabled; but provide an annotation to mark
(a very limited) set of functions as UACCESS-safe (eg. the planned:
unsafe_copy_{to,from}_user()).

---
 arch/x86/ia32/ia32_signal.c     |  29 ++++---
 arch/x86/include/asm/uaccess.h  |   4 +-
 include/linux/frame.h           |  49 ++++++++++-
 tools/objtool/Makefile          |   2 +-
 tools/objtool/arch.h            |   6 +-
 tools/objtool/arch/x86/decode.c |  22 ++++-
 tools/objtool/check.c           | 180 ++++++++++++++++++++++++++++++----------
 tools/objtool/check.h           |   3 +-
 tools/objtool/elf.h             |   1 +
 9 files changed, 234 insertions(+), 62 deletions(-)

