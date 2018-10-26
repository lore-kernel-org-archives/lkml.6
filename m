Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C53ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9020651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJZXRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJZXRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75B2D30CF544;
        Fri, 26 Oct 2018 14:39:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id A68AA60BD6;
        Fri, 26 Oct 2018 14:39:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 26 Oct 2018 16:39:41 +0200 (CEST)
Date:   Fri, 26 Oct 2018 16:39:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181026143937.GA18848@redhat.com>
References: <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
 <20181025155503.GF3725@redhat.com>
 <3423a470-c152-0dbf-c7a7-2775a9679194@i-love.sakura.ne.jp>
 <20181026130442.GB10581@redhat.com>
 <522c4993-4d98-be98-def2-452ed28098f9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522c4993-4d98-be98-def2-452ed28098f9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 26 Oct 2018 14:39:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26, Tetsuo Handa wrote:
>
> On 2018/10/26 22:04, Oleg Nesterov wrote:
> >> Suppose p1 == p2->real_parent and p2 == p3->real_parent, and p1 exited
> >> when p2 tried to attach on p1, p2->real_parent was pointing to already
> >> (or about to be) freed p1.
> >
> > No, p2->real_parent will be updated. If p1 exits it will re-parent its
> > children including p2.
>
> My error.
>
> Suppose p1 == p2->real_parent and p2 == p3->real_parent, and p1 exited
> when someone tried to attach on p2, p2->real_parent was pointing to already
> (or about to be) freed p1.

I don't see a difference.

If p1 exits it will re-parent p2, p2->real_parent will be updated.

> So, the puzzle part is why p2->real_parent was still pointing p1 even after
> p1 was freed...

I don't understand the question.

Once again. TASK->real_parent can point to the freed mem only if a) TASK exits,
and b) _after_ that its parent TASK->real_parent exits too.

> > Again, did you read my previous email?
>
> Yes. But I still can't be convinced that pid_alive() test helps.

Well, I don't understand which part of my explanations is not clear to you.

OR. Perhaps I am wrong and do not understand your concerns.

Oleg.

