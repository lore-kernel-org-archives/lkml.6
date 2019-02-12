Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E2AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD87C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986199;
	bh=Fl6g9cx+KTVtRS/rzj8ZyrdfdE1bg1TwwE1uUnu9KIQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XZ0T1oaKIAT0/cXIT9ssq1oHfh3lqSKVffJTOu8Lp7UmAmUck5Va2bBWmJ5HIdeAG
	 /CLQ0Tt9I7mjY40sgDnwHcHQT5Mp4f36Ipemgx0JW/yR6ZCSyvl9xQNxGWIeSxpxqb
	 UWtW6erSdQCEJB+AxBn7TMsZ+3QbIO6flcV0XsMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfBLPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:43:18 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B6E21773;
        Tue, 12 Feb 2019 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986197;
        bh=Fl6g9cx+KTVtRS/rzj8ZyrdfdE1bg1TwwE1uUnu9KIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=t0hYTQeGGGbEmbH6bWWM75e0pn5rp51r8KgHA5esbPESJLJrPA09YzgA8QLFFfNLl
         uTH2bvblww1t9exvAdOHLcua3zo6XYpqK7SNnn/kl6JPeGnpkfhEgynluJiqN1M6Cn
         YwNA8Cy6ugwBl1gDq1/kV8HW+kkMTxgb8Lclb/M0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 0/4] arm64: kprobes: Update blacklist checking on arm64
Date:   Wed, 13 Feb 2019 00:42:53 +0900
Message-Id: <154998617300.21869.11457765723750331236.stgit@devbox>
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

Here is the v3 series of update of the kprobe blacklist
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

In v3, I rebased on the latest arm64 kernel which includes
James' KVM/HYP fixes for kprobes, and fix a reported bugs
in [4/4].

Changes in v3:
 - [4/4] Fixes to remove redundant blacklist of kprobe_text
   and add blacklist on exception_text.

Thank you,

---

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()


 arch/arm64/kernel/probes/kprobes.c |   52 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 25 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
