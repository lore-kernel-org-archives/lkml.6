Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B834420651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547533460;
	bh=M5ZDJU8js+RTgGe66Ho1fUpZuVQo2/Q9RHdHmc4kBdg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1EU2gQgfq154GNqvRnZ8tkjTWH+XH8Yk49ZvIwb5h6qOLQmPiEjsop7C/eO1hYP5D
	 6iaWqh9wG6ziQzRBZamO3g2jlXsAWpYWP17W1ATt9y1uGn3pnMP6raPmCBshSpWFg5
	 vVLnxLRkn87W7tV+YiS/6qN6Sa5Xh/7o9n1s3lV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfAOGYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOGYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:24:03 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9446220651;
        Tue, 15 Jan 2019 06:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547533442;
        bh=M5ZDJU8js+RTgGe66Ho1fUpZuVQo2/Q9RHdHmc4kBdg=;
        h=From:To:Cc:Subject:Date:From;
        b=a36Hwwf3r5f2yM6YQmasuIow5Q2TUHgI6O8oiI/KnDXyNfz6j+fkwyLWEqfQwNp8v
         reJogmLtN64oGutxeve6OJd7zI+TrQqifZ/Owp49O9bHCBR6R0mZvMIWnpRXT2L27L
         whlC6Fxg9O8JhadwR9jvFEOQ3tQC+GAn+Cj7o3i0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on arm64
Date:   Tue, 15 Jan 2019 15:23:39 +0900
Message-Id: <154753341900.31541.8135985235882849464.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the v2 series of update of the kprobe blacklist
checking on arm64.

I found that some blacklist checking code were mis-placed in
arch_prepare_kprobe() and arch_within_kprobe_blacklist().
Since the blacklist just filters by symbol, smaller than the
symbol, like extable must be checked in arch_prepare_kprobe().
Also, all function (symbol) level check must be done by blacklist.

For arm64, it checks the extable entry address in blacklist
and exception/irqentry function in arch_prepare_kprobe().
And, RODATA check is unneeded since kernel/kprobes.c
already ensures the probe address is in kernel-text area.

In v2, I updated [1/4]'s description and added James'
Reviewed-by. Also, in this version, I added a patch which
uses arch_populate_kprobe_blacklist() instead of
arch_within_kprobe_blacklist() so that user can see the full
list of blacklisted symbols under the debugfs.

Changes in v2:
 - [1/4] change description so that it make clear and add
         James' Reviewed-by.
 - [4/4] new patch.

Thank you,

---

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()


 arch/arm64/kernel/probes/kprobes.c |   49 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
