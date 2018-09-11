Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D01C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60B320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ya3/yIao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60B320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIKPSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbeIKPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:18:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC7020839;
        Tue, 11 Sep 2018 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536661206;
        bh=BZnybgoQurcAhQgQ2tU8EQCWlruyYc7E5NPDiv3CWKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ya3/yIaofgqw3N5krGtGx6OZu+24ON73N08K+rwhvsdLdQCWJUOjPM4FT5zihQUhu
         MZHPq/CRyt6UQ5zonrK3nFa15g4og0jIF8p12zC1+0u0XrZo0WHSWaLYbsOOCFvq1P
         k7tz8rdn2hoeiNymVK3dRQkKbKFg/DjF3QWH4Ulk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v2 2/5] kprobes: Remove meaningless BUG_ON from add_new_kprobe
Date:   Tue, 11 Sep 2018 19:19:43 +0900
Message-Id: <153666118298.21306.4915366706875652652.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153666112297.21306.4621579144717171778.stgit@devbox>
References: <153666112297.21306.4621579144717171778.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling add_new_kprobe(), aggr_probe's GONE
flag and kprobe GONE flag are cleared. We don't need
to worry about that flag at this point.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d1edd8d5641e..231569e1e2c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1259,8 +1259,6 @@ NOKPROBE_SYMBOL(cleanup_rp_inst);
 /* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
-	BUG_ON(kprobe_gone(ap) || kprobe_gone(p));
-
 	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 

