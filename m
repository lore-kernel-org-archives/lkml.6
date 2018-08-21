Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1464CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29AF216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDn+OEuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29AF216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeHUM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeHUM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:58:49 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75331216C4;
        Tue, 21 Aug 2018 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534844364;
        bh=Bv+IjdW7rEnDD4X/qdNrL+DbuzzcnjjbUAM8lQcz850=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDn+OEuGI7SINcIsTQZ5w/CfH1NmUDzeSfKmSYDIpRRClbWyfKI/vuC8tl4srTymx
         a/DrBqnUIBknSswzBzPcmJxVfY710adzhSt2l1NO0AfTzMotTNveHhpSdhCq15H59e
         DRkjG7Vd0UC8Y4Hn6i4IG3Mdmm61jNDgDcfi34zg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 3/5] kprobes: Remove meaningless BUG_ON from reuse_unused_kprobe
Date:   Tue, 21 Aug 2018 18:39:01 +0900
Message-Id: <153484434144.5385.1879639244870788384.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153484425558.5385.1484910606397784412.stgit@devbox>
References: <153484425558.5385.1484910606397784412.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since reuse_unused_kprobe is called when the given kprobe
is unused, checking it inside again with BUG_ON is
meaningless. Remove it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 231569e1e2c8..277a6cbe83db 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -704,7 +704,6 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
 
-	BUG_ON(!kprobe_unused(ap));
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
 	 * there is still a relative jump) and disabled.

