Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uzCQCCwlHltceAAAmS7hNA
	; Mon, 11 Jun 2018 07:30:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 097F1607A4; Mon, 11 Jun 2018 07:30:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ca1X1hVw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8796C60791;
	Mon, 11 Jun 2018 07:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8796C60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeFKHat (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:30:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeFKHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p2m7SGTa1jCUMvnQ3uC5ngNpS34viKso9DqC0IMYuY4=; b=ca1X1hVwxjfgTvdst7WZWcbsv
        PWLOBpBhWlp4Ytsbuvc9ESDuCycfgpQrqdy4jm8CLwmBqAeO4VQ2dSwj3C6mQOYZ8FIqrhzIp63yh
        TpqiZy4/J98kA9pBqXnBMKmSq34bdJtU5UfNZ4u+CQdzYs2do9HPvEnnDRMTkJ+rFpKQBB+7hlvUZ
        +8Fxgjaq9kWqnR4QG1I692jVHXT9fdOl+Xg12eOhHQccsmDxKxSaRLdtZscMJXQNbnF1x+Zz3sfhu
        UzQgrKSls7cSBK5Ii+zV0Ik1RYYGj40teou9ocVlclqNYcyW+lwN3BeYnK8S+4Z/r+t2Ty9ePIhb+
        m05OiXxig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSHHl-0001gy-3U; Mon, 11 Jun 2018 07:30:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BCA1201EA7A6; Mon, 11 Jun 2018 09:30:38 +0200 (CEST)
Date: Mon, 11 Jun 2018 09:30:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in __sb_start_write
Message-ID: <20180611073038.GK12217@hirez.programming.kicks-ass.net>
References: <000000000000283c37056b4a81a5@google.com>
 <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 11:47:56PM +0900, Tetsuo Handa wrote:

> This looks quite strange that nobody is holding percpu_rw_semaphore for
> write but everybody is stuck trying to hold it for read. (Since there
> is no "X locks held by ..." line without followup "#0:" line, there is
> no possibility that somebody is in TASK_RUNNING state while holding
> percpu_rw_semaphore for write.)
> 
> I feel that either API has a bug or API usage is wrong.
> Any idea for debugging this?

Look at percpu_rwsem_release() and usage. The whole fs freezer thing is
magic.
