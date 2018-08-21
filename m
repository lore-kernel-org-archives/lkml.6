Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E479C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33031216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEqG4RGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33031216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHUM5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeHUM5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:57:52 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D990B216C4;
        Tue, 21 Aug 2018 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534844307;
        bh=2K8zx1LvUK3dhmnDRXEX3SIUJpS8tKzEPjXXwtbarG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEqG4RGvAmS6LPzcxH7TGw19RTct1thBQtKrcBaYD7gMzgV8mdDRrF7+sY6rNYedx
         WoNi/+dPsBSjOymqKtZZEuAQSTM6Q3ANu6sWagxV0ftQge2xZB518+Zo1xlkx1UVc5
         gtpPvx4Sp2hki6a6pb+QCmQHmatPkge4KKv7sClQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 1/5] kprobes: Remove meaningless BUG_ON from disarming process
Date:   Tue, 21 Aug 2018 18:38:05 +0900
Message-Id: <153484428494.5385.7721941049086272054.stgit@devbox>
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

All aggr_probe at this line are already disarmed by
disable_kprobe() or checked by kprobe_disarmed().
So this BUG_ON() does meaningless check. Remove it.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab257be4d924..d1edd8d5641e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1704,7 +1704,6 @@ static int __unregister_kprobe_top(struct kprobe *p)
 	return 0;
 
 disarmed:
-	BUG_ON(!kprobe_disarmed(ap));
 	hlist_del_rcu(&ap->hlist);
 	return 0;
 }

