Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A22204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="m0MgJGGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A22204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeGYRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:00:33 -0400
Received: from 8bytes.org ([81.169.241.247]:40038 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYRAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:00:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C280F29B; Wed, 25 Jul 2018 17:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532533696; bh=nN29WtP51d8nkZ63nhGchAFE+Rs95z0ByOm5HC0RsXE=;
        h=From:To:Cc:Subject:Date:From;
        b=m0MgJGGL6xMKXbiElMDb43YLnhwXzKIa36SQSiAKOZK6Ct8dYK6HdqI1RA8Xpe+dJ
         96mWLdTtKczvYowi9y94JMyecqlyqX984eUlhLEj3DdFhkJ0zKc+t6mTQSuIx6jqJl
         52mr/cIoVDbXeQKZrvAKn43gmI03ifGsVIBJWrRWb/xosL3kl1/vvSv8RlA4DZd3Sv
         1CkjR1f++ocfcYP5IbcSKq0uHaKFfrrgaqRE9FCEfryIlNiCeCVlRcnHnnFvtTPuxj
         5H6Dq2URlKJp1uzq2kb2XlTY8dejPi3oMER4iKO13XpkeYjfLoFykuiWCpVoIwp50o
         PLlzlu7bXGLTA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 0/3] PTI x86-32 Updates and Fixes
Date:   Wed, 25 Jul 2018 17:48:00 +0200
Message-Id: <1532533683-5988-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are three patches on-top of tip/x86/pti to update the
vmallo_fault() fix and also with another important fix.

The first two patches remove the WARN_ON_ONCE(in_nmi) from
the vmalloc_fault() function and revert the previous fix, as
discussed at the last patch-set.

The third patch is an important fix for a silent memory
corruption issue found by the trinity fuzzer, which did take
a while to track down. But I found it and with the fix the
fuzzer already runs for couple of hours now and the VM is
still alive.

Regards,

	Joerg

Joerg Roedel (3):
  x86/mm: Remove in_nmi() warning from vmalloc_fault()
  Revert "perf/core: Make sure the ring-buffer is mapped in all
    page-tables"
  x86/kexec: Allocate 8k PGDs for PTI

 arch/x86/kernel/machine_kexec_32.c |  5 +++--
 arch/x86/mm/fault.c                |  2 --
 kernel/events/ring_buffer.c        | 16 ----------------
 3 files changed, 3 insertions(+), 20 deletions(-)

-- 
2.7.4

