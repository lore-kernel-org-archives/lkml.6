Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03C2C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9532820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079257;
	bh=LxAnSu5JQkl2P6hyBMpzA9aKkSNd5wdm9ojqCVl6YvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yENPwo/MVJxMJ1ZrH2hQ9YZ6BFUN5rrV/nvxC3zesa2FQwgx7LmM6UHCLKdO1MO8x
	 nwQLhf4PfhY9h9I5mSBm85e1Dw1AAK/PURmGZAjtRc4ZyUDEq5YGmyAt2b+Uh4O2cD
	 v9k/4bna5BeR+HaRGe1MvW8edsvGFdJwVNGFEozI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbfAUOAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732517AbfAUOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC1320879;
        Mon, 21 Jan 2019 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079252;
        bh=LxAnSu5JQkl2P6hyBMpzA9aKkSNd5wdm9ojqCVl6YvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGY87RW6TvOQt9QFDgQ7xnYiZAjblt7JCxGGz6Yal3DB+JJdDBF2Qb7YRATbi2MmN
         mP0twj6TdonJcyR6m1Mb1g7AFLcvfkdJxWwA0s7fPVrWH+kLzpv2Y0Pp8Id125R6Pn
         mC3+JtNnJpNyj+pugdoKi8hAYcmJAbTcnZfwxIh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florian La Roche <Florian.LaRoche@googlemail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 60/99] fix int_sqrt64() for very large numbers
Date:   Mon, 21 Jan 2019 14:48:52 +0100
Message-Id: <20190121134916.252080272@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian La Roche <florian.laroche@googlemail.com>

commit fbfaf851902cd9293f392f3a1735e0543016d530 upstream.

If an input number x for int_sqrt64() has the highest bit set, then
fls64(x) is 64.  (1UL << 64) is an overflow and breaks the algorithm.

Subtracting 1 is a better guess for the initial value of m anyway and
that's what also done in int_sqrt() implicitly [*].

[*] Note how int_sqrt() uses __fls() with two underscores, which already
    returns the proper raw bit number.

    In contrast, int_sqrt64() used fls64(), and that returns bit numbers
    illogically starting at 1, because of error handling for the "no
    bits set" case. Will points out that he bug probably is due to a
    copy-and-paste error from the regular int_sqrt() case.

Signed-off-by: Florian La Roche <Florian.LaRoche@googlemail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/int_sqrt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << (fls64(x) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;


