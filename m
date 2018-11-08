Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB3C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F4D20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQXv42RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F4D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeKIH6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731810AbeKIHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D43D21486;
        Thu,  8 Nov 2018 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714758;
        bh=jDON1sgSOcYrYzARQpO+bZvm86jldaAIlVL84cMwr78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQXv42RZ/iS5SL+ET2+cz24ZMAML1f68WOuSs6kCmULIRFr+Em5A/xxLRTjiI4Cx1
         /pmWqHiqOc7r9mJGUKh7RgCqfjjYQRYZNYebegOdDSQib9Z+7jcSrx8qOtt7F63wsh
         yCIoItTvzD8DgDKFEifpkcjQP3yj/ow/SlYlfKYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 111/171] futex: futex_wake_op, do not fail on invalid op
Date:   Thu,  8 Nov 2018 13:51:21 -0800
Message-Id: <20181108215135.344756191@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e78c38f6bdd900b2ad9ac9df8eff58b745dc5b3c ]

In commit 30d6e0a4190d ("futex: Remove duplicated code and fix undefined
behaviour"), I let FUTEX_WAKE_OP to fail on invalid op.  Namely when op
should be considered as shift and the shift is out of range (< 0 or > 31).

But strace's test suite does this madness:

  futex(0x7fabd78bcffc, 0x5, 0xfacefeed, 0xb, 0x7fabd78bcffc, 0xa0caffee);
  futex(0x7fabd78bcffc, 0x5, 0xfacefeed, 0xb, 0x7fabd78bcffc, 0xbadfaced);
  futex(0x7fabd78bcffc, 0x5, 0xfacefeed, 0xb, 0x7fabd78bcffc, 0xffffffff);

When I pick the first 0xa0caffee, it decodes as:

  0x80000000 & 0xa0caffee: oparg is shift
  0x70000000 & 0xa0caffee: op is FUTEX_OP_OR
  0x0f000000 & 0xa0caffee: cmp is FUTEX_OP_CMP_EQ
  0x00fff000 & 0xa0caffee: oparg is sign-extended 0xcaf = -849
  0x00000fff & 0xa0caffee: cmparg is sign-extended 0xfee = -18

That means the op tries to do this:

  (futex |= (1 << (-849))) == -18

which is completely bogus. The new check of op in the code is:

        if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
                if (oparg < 0 || oparg > 31)
                        return -EINVAL;
                oparg = 1 << oparg;
        }

which results obviously in the "Invalid argument" errno:

  FAIL: futex
  ===========

  futex(0x7fabd78bcffc, 0x5, 0xfacefeed, 0xb, 0x7fabd78bcffc, 0xa0caffee) = -1: Invalid argument
  futex.test: failed test: ../futex failed with code 1

So let us soften the failure to print only a (ratelimited) message, crop
the value and continue as if it were right.  When userspace keeps up, we
can switch this to return -EINVAL again.

[v2] Do not return 0 immediatelly, proceed with the cropped value.

Fixes: 30d6e0a4190d ("futex: Remove duplicated code and fix undefined behaviour")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c3ea6f2a6997..053d7be08be5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1467,8 +1467,16 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 	int oldval, ret;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
-		if (oparg < 0 || oparg > 31)
-			return -EINVAL;
+		if (oparg < 0 || oparg > 31) {
+			char comm[sizeof(current->comm)];
+			/*
+			 * kill this print and return -EINVAL when userspace
+			 * is sane again
+			 */
+			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
+					get_task_comm(comm, current), oparg);
+			oparg &= 31;
+		}
 		oparg = 1 << oparg;
 	}
 
-- 
2.17.1



