Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB82C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C062086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C062086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeIJWjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:39:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbeIJWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A4E9DFF3;
        Mon, 10 Sep 2018 17:43:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 99C751049499;
        Mon, 10 Sep 2018 17:43:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Sep 2018 19:43:58 +0200 (CEST)
Date:   Mon, 10 Sep 2018 19:43:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: get_arg_page() && ptr_size accounting
Message-ID: <20180910174355.GA27312@redhat.com>
References: <20180910122907.GA23963@redhat.com>
 <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
 <CAGXu5jJ+aiJWL0G0Zpq2Df4ADEmpSBZHSTaUkzJiNbgg+B6x2Q@mail.gmail.com>
 <20180910172109.GB27005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910172109.GB27005@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 17:43:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 17:43:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Oleg Nesterov wrote:
>
> On 09/10, Kees Cook wrote:
> >
> > On Mon, Sep 10, 2018 at 9:41 AM, Kees Cook <keescook@chromium.org> wrote:
> > > On Mon, Sep 10, 2018 at 5:29 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> > >> Hi Kees,
> > >>
> > >> I was thinking about backporting the commit 98da7d08850fb8bde
> > >> ("fs/exec.c: account for argv/envp pointers"), but I am not sure
> > >> I understand it...
> >
> > BTW, if you backport that, please get the rest associated with the
> > various Stack Clash related weaknesses:
>
> may be...
>
> > da029c11e6b1 exec: Limit arg stack to at most 75% of _STK_LIM
>
> and I have to admit that I do not understand this patch at all, the
> changelog explains nothing.
>
> Could you explain what this patch actually prevents from? Especially
> now that we have stack_guard_gap?

forgot to mention...

with this patch

	#define MAX_ARG_STRINGS 0x7FFFFFFF

doesn't match the reality. perhaps something like below makes sense just
to make it clear, but this is cosmetic.

Oleg.

--- x/fs/exec.c
+++ x/fs/exec.c
@@ -1789,11 +1789,13 @@ static int __do_execve_file(int fd, stru
 	if (retval)
 		goto out_unmark;
 
-	bprm->argc = count(argv, MAX_ARG_STRINGS);
+	int max_arg_strings = _STK_LIM / 4 * 3 / 2; // actually even less than
+
+	bprm->argc = count(argv, max_arg_strings);
 	if ((retval = bprm->argc) < 0)
 		goto out;
 
-	bprm->envc = count(envp, MAX_ARG_STRINGS);
+	bprm->envc = count(envp, max_arg_strings - bprm->argc);
 	if ((retval = bprm->envc) < 0)
 		goto out;
 

