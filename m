Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E4FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962BD2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545034851;
	bh=ZTNQXw9mjqaDhnbOX2ukZ2znjixQTWuBC6q6DSC/nDw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0iXeM4S685t2kpWp3hxOLAyunvOLWrfPGoVW5XNf5isvGtEZgU0Oa6Z0esWbLY5hp
	 M7PFeUOaZRWk4330BIUyNpu8bcUtxfkvF2N5AXHOgO7tYRIjm3CKnkFvrn9NFHDH51
	 mDjdyE7XeAFduarcfi6i//sXisupRuumrOGsOWXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbeLQIUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731637AbeLQIUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:20:50 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFABA20672;
        Mon, 17 Dec 2018 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545034849;
        bh=ZTNQXw9mjqaDhnbOX2ukZ2znjixQTWuBC6q6DSC/nDw=;
        h=From:To:Cc:Subject:Date:From;
        b=aTe6NpUwnJWV51lW3mk8zRT9YJ8dQ/xqRbzy9qbgITVESP2OEavsaJgLWK33qMPLM
         OrpgFE1ZedTP/PUbi9Wbg3R6LNhakVEudxqNw2BWnpNVUIHiMXYSJiD6WKizktftKm
         xf/JCwxMO5strp0mhqts0j5GL4Wg41M0LEvmGLmc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86: kprobes: Show correct blaclkist in debugfs
Date:   Mon, 17 Dec 2018 17:20:25 +0900
Message-Id: <154503482486.26176.6224515860220847638.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 series for showing correct kprobe blacklist in
debugfs.

v1 is here:

 https://lkml.org/lkml/2018/12/7/517

I splitted the RFC v1 patch into x86 and generic parts,
also added a patch to remove unneeded arch-specific
blacklist check function (because those have been added
to the generic blacklist.)

If this style is good, I will make another series for the
archs which have own arch_within_kprobe_blacklist(), and
eventually replace that with arch_populate_kprobe_blacklist()
so that user can get the correct kprobe blacklist in debugfs.

Thank you,

---

Masami Hiramatsu (3):
      kprobes: Blacklist symbols in arch-defined prohibited area
      x86/kprobes: Show x86-64 specific blacklisted symbols correctly
      x86/kprobes: Remove unneeded arch_within_kprobe_blacklist from x86


 arch/x86/kernel/kprobes/core.c |    8 ++---
 include/linux/kprobes.h        |    3 ++
 kernel/kprobes.c               |   67 ++++++++++++++++++++++++++++++++--------
 3 files changed, 59 insertions(+), 19 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
