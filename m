Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29AFC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CE214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz2hiKsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9CE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeK3Ben (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbeK3Ben (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 249D421479;
        Thu, 29 Nov 2018 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501750;
        bh=o+SLZwRx/MvWf+pex+E/Ad+fOVYSu50M7DkzHdZfuIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fz2hiKsmqWRqblwWzzKyNWIgLBHn9HRQlEGLfbXZ+1zT0623czwMO6aqgSX2hPETW
         01Frv25jQJiAPwQYxOw0srMrFfyRqSpbrQKp+Dw4PJkXiDIkv7Ak1qosLuD6/E6FUM
         wPlF1LoeESAg1SWoRFhFy3Tg7TTlGBZW7IY6tIAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Amit Shah <aams@amazon.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.19 018/110] Documentation/security-bugs: Postpone fix publication in exceptional cases
Date:   Thu, 29 Nov 2018 15:11:49 +0100
Message-Id: <20181129135921.984767872@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 544b03da39e2d7b4961d3163976ed4bfb1fac509 upstream.

At the request of the reporter, the Linux kernel security team offers to
postpone the publishing of a fix for up to 5 business days from the date
of a report.

While it is generally undesirable to keep a fix private after it has
been developed, this short window is intended to allow distributions to
package the fix into their kernel builds and permits early inclusion of
the security team in the case of a co-ordinated disclosure with other
parties. Unfortunately, discussions with major Linux distributions and
cloud providers has revealed that 5 business days is not sufficient to
achieve either of these two goals.

As an example, cloud providers need to roll out KVM security fixes to a
global fleet of hosts with sufficient early ramp-up and monitoring. An
end-to-end timeline of less than two weeks dramatically cuts into the
amount of early validation and increases the chance of guest-visible
regressions.

The consequence of this timeline mismatch is that security issues are
commonly fixed without the involvement of the Linux kernel security team
and are instead analysed and addressed by an ad-hoc group of developers
across companies contributing to Linux. In some cases, mainline (and
therefore the official stable kernels) can be left to languish for
extended periods of time. This undermines the Linux kernel security
process and puts upstream developers in a difficult position should they
find themselves involved with an undisclosed security problem that they
are unable to report due to restrictions from their employer.

To accommodate the needs of these users of the Linux kernel and
encourage them to engage with the Linux security team when security
issues are first uncovered, extend the maximum period for which fixes
may be delayed to 7 calendar days, or 14 calendar days in exceptional
cases, where the logistics of QA and large scale rollouts specifically
need to be accommodated. This brings parity with the linux-distros@
maximum embargo period of 14 calendar days.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Amit Shah <aams@amazon.com>
Cc: Laura Abbott <labbott@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/admin-guide/security-bugs.rst |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -32,16 +32,17 @@ Disclosure and embargoed information
 The security list is not a disclosure channel.  For that, see Coordination
 below.
 
-Once a robust fix has been developed, our preference is to release the
-fix in a timely fashion, treating it no differently than any of the other
-thousands of changes and fixes the Linux kernel project releases every
-month.
+Once a robust fix has been developed, the release process starts.  Fixes
+for publicly known bugs are released immediately.
 
-However, at the request of the reporter, we will postpone releasing the
-fix for up to 5 business days after the date of the report or after the
-embargo has lifted; whichever comes first.  The only exception to that
-rule is if the bug is publicly known, in which case the preference is to
-release the fix as soon as it's available.
+Although our preference is to release fixes for publicly undisclosed bugs
+as soon as they become available, this may be postponed at the request of
+the reporter or an affected party for up to 7 calendar days from the start
+of the release process, with an exceptional extension to 14 calendar days
+if it is agreed that the criticality of the bug requires more time.  The
+only valid reason for deferring the publication of a fix is to accommodate
+the logistics of QA and large scale rollouts which require release
+coordination.
 
 Whilst embargoed information may be shared with trusted individuals in
 order to develop a fix, such information will not be published alongside


