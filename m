Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58190C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E342146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E342146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK3VmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16297 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeK3VmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6FEF80F7D;
        Fri, 30 Nov 2018 10:33:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 410C15D736;
        Fri, 30 Nov 2018 10:33:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 30 Nov 2018 11:33:32 +0100 (CET)
Date:   Fri, 30 Nov 2018 11:33:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
Message-ID: <20181130103329.GB23670@redhat.com>
References: <20181127225408.7553-1-j@bitron.ch>
 <20181127225408.7553-2-j@bitron.ch>
 <20181128144230.GG30395@redhat.com>
 <87r2f5gr9g.fsf@xmission.com>
 <20181129123409.GA10645@redhat.com>
 <f55261dbc41544363b4348820f67fb01c6d7aaec.camel@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f55261dbc41544363b4348820f67fb01c6d7aaec.camel@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 30 Nov 2018 10:33:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29, Jürg Billeter wrote:
>
> On Thu, 2018-11-29 at 13:34 +0100, Oleg Nesterov wrote:
> > To me it would be more clean to call walk_process_tree(kill_descendant_visitor)
> > unconditionally in find_new_reaper() right before "if (has_child_subreaper)", but
> > then we will need to shift read_lock(tasklist) from walk_process_tree().
>
> Yes, that's the reason why I added the call before the tasklist lock.
> Let me know if you want me to move the read lock from
> walk_process_tree() to PR_SET_CHILD_SUBREAPER (the only caller)
> instead.

I am fine either way. We can do this later, lets keep your patch simple.

> > So I think the patch is mostly fine, the only problem I can see is that
> > PR_SET_KILL_DESCENDANTS_ON_EXIT can race with PR_SET_CHILD_SUBREAPER, they both
> > need to update the bits in the same word.
>
> Good point. I'll make it a regular bool instead of a bitfield for v2,

Agreed,

> unless you have another approach in mind to fix this.

Well, I think that is_child_subreaper/has_child_subreaper and the new
kill_descendants_on_exit should live in signal->flags, but we need some
cleanups to make this possible, so I agree with the boolean.

Oleg.

