Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0uJ5CfBBGVsxdwAAmS7hNA
	; Thu, 07 Jun 2018 14:33:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 26915607E7; Thu,  7 Jun 2018 14:33:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 74562601D2;
	Thu,  7 Jun 2018 14:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74562601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeFGOdJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:33:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40308 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933880AbeFGOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:33:05 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zn-Go; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-000315-CU; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Randy Dunlap" <rdunlap@infradead.org>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.522642950@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 209/410] sysctl: check for UINT_MAX before unsigned
 int min/max
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Lawrence <joe.lawrence@redhat.com>

commit fb910c42ccebf853c29296185c45c11164a56098 upstream.

Mikulas noticed in the existing do_proc_douintvec_minmax_conv() and
do_proc_dopipe_max_size_conv() introduced in this patchset, that they
inconsistently handle overflow and min/max range inputs:

For example:

  0 ... param->min - 1 ---> ERANGE
  param->min ... param->max ---> the value is accepted
  param->max + 1 ... 0x100000000L + param->min - 1 ---> ERANGE
  0x100000000L + param->min ... 0x100000000L + param->max ---> EINVAL
  0x100000000L + param->max + 1, 0x200000000L + param->min - 1 ---> ERANGE
  0x200000000L + param->min ... 0x200000000L + param->max ---> EINVAL
  0x200000000L + param->max + 1, 0x300000000L + param->min - 1 ---> ERANGE

In do_proc_do*() routines which store values into unsigned int variables
(4 bytes wide for 64-bit builds), first validate that the input unsigned
long value (8 bytes wide for 64-bit builds) will fit inside the smaller
unsigned int variable.  Then check that the unsigned int value falls
inside the specified parameter min, max range.  Otherwise the unsigned
long -> unsigned int conversion drops leading bits from the input value,
leading to the inconsistent pattern Mikulas documented above.

Link: http://lkml.kernel.org/r/1507658689-11669-5-git-send-email-joe.lawrence@redhat.com
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Drop changes in do_proc_douintvec_minmax_conv()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2233,17 +2233,18 @@ static int do_proc_dopipe_max_size_conv(
 	struct do_proc_dopipe_max_size_conv_param *param = data;
 
 	if (write) {
-		unsigned int val = round_pipe_size(*lvalp);
+		unsigned int val;
 
+		if (*lvalp > UINT_MAX)
+			return -EINVAL;
+
+		val = round_pipe_size(*lvalp);
 		if (*negp || val == 0)
 			return -EINVAL;
 
 		if (param->min && *param->min > val)
 			return -ERANGE;
 
-		if (*lvalp > UINT_MAX)
-			return -EINVAL;
-
 		*valp = val;
 	} else {
 		unsigned int val = *valp;
