Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EE521B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfBKQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:48:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfBKQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:47:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2E9885362;
        Mon, 11 Feb 2019 16:47:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id EC4E062468;
        Mon, 11 Feb 2019 16:47:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Feb 2019 17:47:58 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:47:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Jack Andersen <jackoalan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] signal fixes for v5.0-rc6
Message-ID: <20190211164755.GD21430@redhat.com>
References: <87mun6nuql.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mun6nuql.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 11 Feb 2019 16:47:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08, Eric W. Biederman wrote:
>
>       signal: Always notice exiting tasks

Sorry, I could not look at these patches before...

So I think this one should be reverted, it makes PTRACE_EVENT_EXIT even more broken.

Once again, why we can't do something like

	--- x/kernel/signal.c
	+++ x/kernel/signal.c
	@@ -209,6 +209,8 @@ int next_signal(struct sigpending *pendi
		 */
		x = *s &~ *m;
		if (x) {
	+		if (x & sigmask(SIGKILL))
	+			return SIGKILL;
			if (x & SYNCHRONOUS_MASK)
				x &= SYNCHRONOUS_MASK;
			sig = ffz(~x) + 1;

instead? at least for the start.

Oleg.

