Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78759C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBE120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967457AbeFRIdR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:33:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967430AbeFRIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:33:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ACF93BBE;
        Mon, 18 Jun 2018 08:33:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/189] <linux/stringhash.h>: fix end_name_hash() for 64bit long
Date:   Mon, 18 Jun 2018 10:13:05 +0200
Message-Id: <20180618081212.816961840@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 19b9ad67310ed2f685062a00aec602bec33835f0 ]

The comment claims that this helper will try not to loose bits, but for
64bit long it looses the high bits before hashing 64bit long into 32bit
int.  Use the helper hash_long() to do the right thing for 64bit long.
For 32bit long, there is no change.

All the callers of end_name_hash() either assign the result to
qstr->hash, which is u32 or return the result as an int value (e.g.
full_name_hash()).  Change the helper return type to int to conform to
its users.

[ It took me a while to apply this, because my initial reaction to it
  was - incorrectly - that it could make for slower code.

  After having looked more at it, I take back all my complaints about
  the patch, Amir was right and I was mis-reading things or just being
  stupid.

  I also don't worry too much about the possible performance impact of
  this on 64-bit, since most architectures that actually care about
  performance end up not using this very much (the dcache code is the
  most performance-critical, but the word-at-a-time case uses its own
  hashing anyway).

  So this ends up being mostly used for filesystems that do their own
  degraded hashing (usually because they want a case-insensitive
  comparison function).

  A _tiny_ worry remains, in that not everybody uses DCACHE_WORD_ACCESS,
  and then this potentially makes things more expensive on 64-bit
  architectures with slow or lacking multipliers even for the normal
  case.

  That said, realistically the only such architecture I can think of is
  PA-RISC. Nobody really cares about performance on that, it's more of a
  "look ma, I've got warts^W an odd machine" platform.

  So the patch is fine, and all my initial worries were just misplaced
  from not looking at this properly.   - Linus ]

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/stringhash.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/stringhash.h
+++ b/include/linux/stringhash.h
@@ -50,9 +50,9 @@ partial_name_hash(unsigned long c, unsig
  * losing bits).  This also has the property (wanted by the dcache)
  * that the msbits make a good hash table index.
  */
-static inline unsigned long end_name_hash(unsigned long hash)
+static inline unsigned int end_name_hash(unsigned long hash)
 {
-	return __hash_32((unsigned int)hash);
+	return hash_long(hash, 32);
 }
 
 /*


