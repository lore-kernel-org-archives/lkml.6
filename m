Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EDFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B90E21774
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B90E21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeHCQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:38:27 -0400
Received: from nov-007-i646.relay.mailchannels.net ([46.232.183.200]:56721
        "EHLO nov-007-i646.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbeHCQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:38:26 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E6F081B6036E;
        Fri,  3 Aug 2018 14:41:43 +0000 (UTC)
Received: from srv17.tophost.ch (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTPA id 46B1D1B602A1;
        Fri,  3 Aug 2018 14:41:40 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Fri, 03 Aug 2018 14:41:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Abiding-Versed: 10acd7ff3ce039e5_1533307303669_1964353658
X-MC-Loop-Signature: 1533307303669:3983243402
X-MC-Ingress-Time: 1533307303668
Received: from [80.219.231.201] (port=55868 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1flbGq-004ETW-Ka; Fri, 03 Aug 2018 16:41:36 +0200
From:   =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH v3 1/2] fork: do not rely on SIGNAL_UNKILLABLE for init check
Date:   Fri,  3 Aug 2018 16:40:20 +0200
Message-Id: <20180803144021.56920-1-j@bitron.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730075241.24002-1-j@bitron.ch>
References: <20180730075241.24002-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_process() currently checks the SIGNAL_UNKILLABLE flag to determine
whether to accept CLONE_PARENT. In preparation for allowing init
processes to opt out of SIGNAL_UNKILLABLE, directly check whether the
process is an init process with is_child_reaper().

Signed-off-by: Jürg Billeter <j@bitron.ch>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1b27babc4c78..c019ce461556 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1646,7 +1646,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * from creating siblings.
 	 */
 	if ((clone_flags & CLONE_PARENT) &&
-				current->signal->flags & SIGNAL_UNKILLABLE)
+				is_child_reaper(task_tgid(current)))
 		return ERR_PTR(-EINVAL);
 
 	/*
-- 
2.18.0

