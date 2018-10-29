Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74A920657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74A920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJ2Xyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4619 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJ2Xyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 708B730C6D54;
        Mon, 29 Oct 2018 15:05:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1AEA5D780;
        Mon, 29 Oct 2018 15:05:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 29 Oct 2018 16:05:49 +0100 (CET)
Date:   Mon, 29 Oct 2018 16:05:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: yama: unsafe usage of ptrace_relation->tracer
Message-ID: <20181029150546.GA30959@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <20181025130129.GE3725@redhat.com>
 <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
 <20181029122356.GA29883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029122356.GA29883@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Oct 2018 15:05:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

let me change the subject to avoid the confusion with the already confusing
disccussion about task_is_descendant().

On 10/29, Oleg Nesterov wrote:
>
> I still think we need a single pid_alive() check and I even sent the patch.
> Attached again at the end.
>
> To clarify, let me repeat that ptracer_exception_found() may need some fixes
> too, right now I am only talking about task_is_descendant().

so yes, the ptracer_relations code looks very broken to me, but perhaps I
misread this code, please correct me.

RCU can only protect the ptracer_relations list itself, you can do nothing
with (say) relation->tracer. relation->tracer can be already freed when
ptracer_exception_found() checks relation->tracee == tracee.

Not only pid_alive(parent) can not help in this case, pid_alive(parent) is
equally unsafe because, again, this memory can be freed.

security_task_free(tsk) is called right before free_task(tsk), there is no
a gp pass in between, and of course we can't rely on the ->invalid check.

_At first glance_ we can fix this if we simply turn both ->tracer/tracee
pointers into "signal_struct *", then we can turn all same_thread_group()'s
into walker->signal == parent which doesn't need to dereference the possibly-
freed parent. This also allows to remove all thread_group_leader() checks.
We need to ensure that false-positive is not possible (if, say, ->tracer
was already re-allocated and points to another task->signal), but this
doesn't look difficult.

Oleg.

