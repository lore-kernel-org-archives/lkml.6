Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548CEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D1D2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RrorpSx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D1D2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeHGMiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:38:13 -0400
Received: from 8bytes.org ([81.169.241.247]:60788 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeHGMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:38:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 27D75220; Tue,  7 Aug 2018 12:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533637473; bh=E/cO6UwIuvwTfAr9UjHcfZD3F2tB/lHW3z78HEvDf70=;
        h=From:To:Cc:Subject:Date:From;
        b=RrorpSx6B1Zy9kXFlomHm94g1qgP6nZ8OOCGDVg9YUiwpX21qX9OnZJfpReQ1WIlO
         tivzmZx5NuuOdOZ9qSqGbrjrpgnw7cOFqs1UfG/kQXZp6IZW9yFWKwtXRUoeWpxC8I
         /9IdNq1wgojwxtZc/RDmoEhQjabZI4MvBUc4DCGLVe22fw5qvxInU0uxqntMkQGrhl
         +tBtC2OvolYsDdW7lO2dHQ3zw/wsEY/kJgbaHIgVCZL9rey8WBj57aUrN9JRvFsh2X
         0RFkgny58TukGXvS6bJb4ojgEdUXelunoRh9tPNIrqxiPDulnjfNPvC/XiWWE28SuO
         rtXsvetG2ukIg==
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
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 0/3] PTI for x86-32 Fixes
Date:   Tue,  7 Aug 2018 12:24:28 +0200
Message-Id: <1533637471-30953-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to fix two small issues in the
PTI implementation for 32 bit x86. The issues are:

	1) Fix the 32 bit PCID check. I used the wrong
	   operator there and this caused false-positive
	   warnings.

	2) The other two patches make sure the init-hole is
	   not mapped into the user page-table. It is the
	   32 bit counterpart to commit

	   c40a56a7818c ('x86/mm/init: Remove freed kernel image areas from alias mapping')

	   for the 64 bit PTI implementation.

I tested that no-PAE, PAE and 64 bit kernel all boot and
have correct user page-tables with identical global mappings
between user and kernel.

Regards,

	Joerg

Joerg Roedel (3):
  x86/mm/pti: Fix 32 bit PCID check
  x86/mm/pti: Don't clear permissions in pti_clone_pmd()
  x86/mm/pti: Clone kernel-image on PTE level for 32 bit

 arch/x86/mm/pti.c | 143 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 43 deletions(-)

-- 
2.7.4

