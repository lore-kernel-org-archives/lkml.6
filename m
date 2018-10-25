Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB5ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784620856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHGog/Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeJYWtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbeJYWtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:23 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121E22085B;
        Thu, 25 Oct 2018 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476986;
        bh=P/CyCQkzeYp1oAP9dVbNskLtqUYlFIJU2zfEXqwsLWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHGog/CeZuOs1dHF8oKf70/sW3O6HpvZ13kT8DrKmEcOptA4j9ZJCrZn35kjZF8zx
         FdcPycDvlLnjqdbmoRAohDDjwDWaiB90v4itrVeinRLoMyz+oPbxUlhspcZtZGRSRQ
         chNdMj2Ra1PXKwn/GOL4Ihq+BBju6/CbsZYWtxaI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 83/98] futex: futex_wake_op, do not fail on invalid op
Date:   Thu, 25 Oct 2018 10:14:08 -0400
Message-Id: <20181025141423.213774-83-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

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

