Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E6BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7E20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPBk22Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD7E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeIKPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbeIKPSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:18:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB6820839;
        Tue, 11 Sep 2018 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536661177;
        bh=2K8zx1LvUK3dhmnDRXEX3SIUJpS8tKzEPjXXwtbarG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPBk22GtuenrOaQY2+h5JB9AK9WJ3teKILqKezp/sxQk+lLo336CGYFw5L37Joop4
         V3lW5azcpx/KHewIIYd+CMMHfk+ZxyLbeRcKv3LZTBeQp8EjOTpmXTk0T+6kv+t6nM
         8sIAt02BKHt/OMmDfhUOazKvc2TXHg4B1z3XfbFE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v2 1/5] kprobes: Remove meaningless BUG_ON from disarming process
Date:   Tue, 11 Sep 2018 19:19:14 +0900
Message-Id: <153666115463.21306.8799008438116029806.stgit@devbox>
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

