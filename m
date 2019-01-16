Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE2C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfAPUDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:03:21 -0500
Received: from namei.org ([65.99.196.166]:56360 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbfAPUDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:03:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0GK2pdP003316;
        Wed, 16 Jan 2019 20:02:51 GMT
Date:   Thu, 17 Jan 2019 07:02:51 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Yama: Check for pid death before checking ancestry
In-Reply-To: <alpine.LRH.2.21.1901170702280.2986@namei.org>
Message-ID: <alpine.LRH.2.21.1901170702420.2986@namei.org>
References: <20190116183109.GA21722@beast> <alpine.LRH.2.21.1901170702280.2986@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, James Morris wrote:

> On Wed, 16 Jan 2019, Kees Cook wrote:
> 
> > It's possible that a pid has died before we take the rcu lock, in which
> > case we can't walk the ancestry list as it may be detached. Instead, check
> > for death first before doing the walk.
> > 
> > Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com
> > Fixes: 2d514487faf1 ("security: Yama LSM")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > James, can you please send this to Linus in your -fixes tree?
> 
> Done.

I mean, queued in that tree.

> 
> > ---
> >  security/yama/yama_lsm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > index ffda91a4a1aa..02514fe558b4 100644
> > --- a/security/yama/yama_lsm.c
> > +++ b/security/yama/yama_lsm.c
> > @@ -368,7 +368,9 @@ static int yama_ptrace_access_check(struct task_struct *child,
> >  			break;
> >  		case YAMA_SCOPE_RELATIONAL:
> >  			rcu_read_lock();
> > -			if (!task_is_descendant(current, child) &&
> > +			if (!pid_alive(child))
> > +				rc = -EPERM;
> > +			if (!rc && !task_is_descendant(current, child) &&
> >  			    !ptracer_exception_found(current, child) &&
> >  			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
> >  				rc = -EPERM;
> > 
> 
> 

-- 
James Morris
<jmorris@namei.org>

