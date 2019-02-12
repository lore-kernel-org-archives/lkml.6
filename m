Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB1BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BC12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfBLJqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:46:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:59762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfBLJqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:46:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E042B016;
        Tue, 12 Feb 2019 09:46:09 +0000 (UTC)
Date:   Tue, 12 Feb 2019 10:46:08 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
Message-ID: <20190212094608.bzwc26j67daqnx6x@pathway.suse.cz>
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com>
 <20190211140813.z7kap634gz3gp6a4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211140813.z7kap634gz3gp6a4@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-02-11 08:08:13, Josh Poimboeuf wrote:
> Anyway, I'm not sure about this approach.  This patch makes the s390
> livepatch code no longer compilable, turning it into completely dead
> code.  So if something changes in the s390 code which causes it to stop
> compiling, nobody will notice.

Good point. Well, it is only small win when a code is buildable
but it could not get really used. Also the amount of arch-specific
code is really minimal.

> I think I'd rather go in the opposite direction: allow the patches to be
> loaded.  Then they can be forced, if needed.  That enables both compile
> and runtime testing.  That way we don't make any backward progress,
> until such arches get reliable stacktraces.

Do you mean to convert the error into warning?

For example, the change below. Note that I did not mention
the possibility to force the transition by intention. It is risky
and people should not get used to it.

Heh, I think that this was the main reason why it was the error.
We did not want to get people used to forcing livepatches.


diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index d1af69e9f0e3..8d9bce251516 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1035,11 +1035,10 @@ int klp_enable_patch(struct klp_patch *patch)
 		return -ENODEV;
 
 	if (!klp_have_reliable_stack()) {
-		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -EOPNOTSUPP;
+		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
+		pr_warn("Only one livepatch can be installed.\n");
 	}
 
-
 	mutex_lock(&klp_mutex);
 
 	ret = klp_init_patch_early(patch);


Best Regards,
Petr
