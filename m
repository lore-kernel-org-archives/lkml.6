Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8048C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807D021934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfBOA6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:58:02 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:17638 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfBOA6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:58:02 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1F0vxYI076972;
        Fri, 15 Feb 2019 09:57:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Fri, 15 Feb 2019 09:57:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1F0vxME076967;
        Fri, 15 Feb 2019 09:57:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1F0vxHb076966;
        Fri, 15 Feb 2019 09:57:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902150057.x1F0vxHb076966@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 =?ISO-2022-JP?B?b29tX3Njb3JlX2Fkag==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date:   Fri, 15 Feb 2019 09:57:59 +0900
References: <201902130124.x1D1OGg3070046@www262.sakura.ne.jp> <20190213114733.GB4525@dhcp22.suse.cz>
In-Reply-To: <20190213114733.GB4525@dhcp22.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh, you are again misunderstanding...

I'm not opposing to forbid CLONE_VM without CLONE_SIGHAND threading model.
I'm asserting that we had better revert the iteration for now, even if we will
strive towards forbidding CLONE_VM without CLONE_SIGHAND threading model.

You say "And that is a correctness issue." but your patch is broken because
your patch does not close the race. Since nobody seems to be using CLONE_VM
without CLONE_SIGHAND threading, we can both avoid hungtask problem and close
the race by eliminating this broken iteration. We don't need to worry about
"This could easily lead to breaking the OOM_SCORE_ADJ_MIN protection." case
because setting OOM_SCORE_ADJ_MIN needs administrator's privilege. And it is
YOUR PATCH that still allows leading to breaking the OOM_SCORE_ADJ_MIN
protection. My patch is more simpler and accurate than your patch.
