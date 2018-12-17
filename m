Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C067C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1745E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545028843;
	bh=UmiQsNgEMM6zxKlasX/6ZUpXyg006ccYbXxMb3MykwI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0yDfeM+7mPJAHwgdwBw7fYMatzSmwcfw+FaGsQN7qFdLY0jDMrWtUxRueurpAzYOL
	 rW2N/iEeNMp7ZvQKn9b1RQZ61n9UgDtWH5mUIMuUMD5VAFsh8uPyo70xC+ODEK5sIs
	 biHXQpDwW0bCw5vaso4dVapLJB4v5WD+tj/eE1vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbeLQGkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbeLQGkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:40:41 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2023E20675;
        Mon, 17 Dec 2018 06:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545028841;
        bh=UmiQsNgEMM6zxKlasX/6ZUpXyg006ccYbXxMb3MykwI=;
        h=From:To:Cc:Subject:Date:From;
        b=klSJzvWekAgM1fHQG9ZMQkPWga6Jpzltj5XWzvhpyn8boj68f4oL2C3mrRWds6UsS
         yPF+iH6h4reiRTTrCZb8c3zJ1y+FOihm+z4WCnl8mfK8PU58Ij9Xs27R0J3Kcx0Swu
         1ZlngzOwntLuVmW0NhTPMOhhhZFTPoUd/xyxQJWM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: kprobes: Fix blacklist checking on arm64
Date:   Mon, 17 Dec 2018 15:40:17 +0900
Message-Id: <154502881646.30629.9938335052821665530.stgit@devbox>
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

Here is a short series about fixing kprobe blacklist checking on
arm64.

I found that some blacklist checking code were mis-placed in
arch_prepare_kprobe() and arch_within_kprobe_blacklist().
Some sub-function (instruction-level) accept/decline check
should be done in arch_prepare_kprobe() and that should not
be in the blacklist. Also, all function (symbol) level check
must be done by blacklist.

For arm64, it checks the extable entry address in blacklist
and exception/irqentry function in arch_prepare_kprobe().
Moreover, RODATA check is unneeded since kernel/kprobes.c
already ensures the probe address is in kernel-text area.

Thank you,

---

Masami Hiramatsu (3):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist


 arch/arm64/kernel/probes/kprobes.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--
Signature
