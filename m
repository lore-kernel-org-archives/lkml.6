Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56C420870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56C420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3NeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:34:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeG3NeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:34:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UBvsYe2294506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 04:57:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UBvqvb2294503;
        Mon, 30 Jul 2018 04:57:52 -0700
Date:   Mon, 30 Jul 2018 04:57:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-6863ea0cda8725072522cd78bda332d9a0b73150@git.kernel.org>
Cc:     will.deacon@arm.com, tglx@linutronix.de, jroedel@suse.de,
        gregkh@linuxfoundation.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, namhyung@kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, dave.hansen@intel.com, dhgutteridge@sympatico.ca,
        eduval@amazon.com, dvlasenk@redhat.com,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        jgross@suse.com, llong@redhat.com, mingo@kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, aarcange@redhat.com,
        pavel@ucw.cz, jolsa@redhat.com, David.Laight@aculab.com,
        brgerst@gmail.com, luto@kernel.org
Reply-To: torvalds@linux-foundation.org, namhyung@kernel.org,
          dhgutteridge@sympatico.ca, eduval@amazon.com,
          dvlasenk@redhat.com, dave.hansen@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jkosina@suse.cz, jroedel@suse.de,
          gregkh@linuxfoundation.org, will.deacon@arm.com,
          tglx@linutronix.de, bp@alien8.de, boris.ostrovsky@oracle.com,
          David.Laight@aculab.com, jolsa@redhat.com, pavel@ucw.cz,
          jpoimboe@redhat.com, aarcange@redhat.com, luto@kernel.org,
          brgerst@gmail.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, mingo@kernel.org, llong@redhat.com,
          jgross@suse.com, acme@kernel.org
In-Reply-To: <1532533683-5988-2-git-send-email-joro@8bytes.org>
References: <1532533683-5988-2-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Remove in_nmi() warning from vmalloc_fault()
Git-Commit-ID: 6863ea0cda8725072522cd78bda332d9a0b73150
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6863ea0cda8725072522cd78bda332d9a0b73150
Gitweb:     https://git.kernel.org/tip/6863ea0cda8725072522cd78bda332d9a0b73150
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 25 Jul 2018 17:48:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 13:53:48 +0200

x86/mm: Remove in_nmi() warning from vmalloc_fault()

It is perfectly okay to take page-faults, especially on the
vmalloc area while executing an NMI handler. Remove the
warning.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532533683-5988-2-git-send-email-joro@8bytes.org

---
 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2aafa6ab6103..db1c042e9853 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -317,8 +317,6 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (!(address >= VMALLOC_START && address < VMALLOC_END))
 		return -1;
 
-	WARN_ON_ONCE(in_nmi());
-
 	/*
 	 * Synchronize this task's top level page-table
 	 * with the 'reference' page table.
