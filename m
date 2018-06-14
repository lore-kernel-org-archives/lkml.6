Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1B5FEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C598E208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XstPJ+7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C598E208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966405AbeFNOPL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965100AbeFNOPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:15:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5EF20864;
        Thu, 14 Jun 2018 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985708;
        bh=C92cKg7r0hYw5SScMgzUz4RIO7l6K0G/igihewdJhTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XstPJ+7eL8c5QvQXle83TPnE7tchYvDXDRbTR32rG5Sd96Y37EGuuTwc/5KZsH7RD
         islNAYXulJz5JyyzaDhILdGM5gD4+/8Tw08I/MQjQLnLOrR5QnZZmNyHcZXrfgRPvB
         r+guDDUAlKnRGBOJ2ISlFFOsDTqREfOnqE9XU9oM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rafael Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.4 16/24] Clarify (and fix) MAX_LFS_FILESIZE macros
Date:   Thu, 14 Jun 2018 16:05:11 +0200
Message-Id: <20180614132725.132674292@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 0cc3b0ec23ce4c69e1e890ed2b8d2fa932b14aad upstream.

We have a MAX_LFS_FILESIZE macro that is meant to be filled in by
filesystems (and other IO targets) that know they are 64-bit clean and
don't have any 32-bit limits in their IO path.

It turns out that our 32-bit value for that limit was bogus.  On 32-bit,
the VM layer is limited by the page cache to only 32-bit index values,
but our logic for that was confusing and actually wrong.  We used to
define that value to

	(((loff_t)PAGE_SIZE << (BITS_PER_LONG-1))-1)

which is actually odd in several ways: it limits the index to 31 bits,
and then it limits files so that they can't have data in that last byte
of a page that has the highest 31-bit index (ie page index 0x7fffffff).

Neither of those limitations make sense.  The index is actually the full
32 bit unsigned value, and we can use that whole full page.  So the
maximum size of the file would logically be "PAGE_SIZE << BITS_PER_LONG".

However, we do wan tto avoid the maximum index, because we have code
that iterates over the page indexes, and we don't want that code to
overflow.  So the maximum size of a file on a 32-bit host should
actually be one page less than the full 32-bit index.

So the actual limit is ULONG_MAX << PAGE_SHIFT.  That means that we will
not actually be using the page of that last index (ULONG_MAX), but we
can grow a file up to that limit.

The wrong value of MAX_LFS_FILESIZE actually caused problems for Doug
Nazar, who was still using a 32-bit host, but with a 9.7TB 2 x RAID5
volume.  It turns out that our old MAX_LFS_FILESIZE was 8TiB (well, one
byte less), but the actual true VM limit is one page less than 16TiB.

This was invisible until commit c2a9737f45e2 ("vfs,mm: fix a dead loop
in truncate_inode_pages_range()"), which started applying that
MAX_LFS_FILESIZE limit to block devices too.

NOTE! On 64-bit, the page index isn't a limiter at all, and the limit is
actually just the offset type itself (loff_t), which is signed.  But for
clarity, on 64-bit, just use the maximum signed value, and don't make
people have to count the number of 'f' characters in the hex constant.

So just use LLONG_MAX for the 64-bit case.  That was what the value had
been before too, just written out as a hex constant.

Fixes: c2a9737f45e2 ("vfs,mm: fix a dead loop in truncate_inode_pages_range()")
Reported-and-tested-by: Doug Nazar <nazard@nazar.ca>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael Tinoco <rafael.tinoco@linaro.org>
[backported to 4.4.y due to requests of failed LTP tests - gregkh]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -926,9 +926,9 @@ static inline struct file *get_file(stru
 /* Page cache limit. The filesystems should put that into their s_maxbytes 
    limits, otherwise bad things can happen in VM. */ 
 #if BITS_PER_LONG==32
-#define MAX_LFS_FILESIZE	(((loff_t)PAGE_CACHE_SIZE << (BITS_PER_LONG-1))-1) 
+#define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
-#define MAX_LFS_FILESIZE 	((loff_t)0x7fffffffffffffffLL)
+#define MAX_LFS_FILESIZE 	((loff_t)LLONG_MAX)
 #endif
 
 #define FL_POSIX	1


