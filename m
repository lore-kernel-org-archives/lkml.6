Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2022133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2022133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIMQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:20:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbeIMQUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2466AFF3;
        Thu, 13 Sep 2018 11:11:36 +0000 (UTC)
Date:   Thu, 13 Sep 2018 13:11:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
Message-ID: <20180913111135.GA21006@dhcp22.suse.cz>
References: <000000000000038dab0575476b73@google.com>
 <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
 <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-09-18 09:12:04, peter enderborg wrote:
> On 09/13/2018 08:26 AM, Tetsuo Handa wrote:
> > On 2018/09/13 12:02, Paul Moore wrote:
> >> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>> syzbot is hitting warning at str_read() [1] because len parameter can
> >>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> >>> this case.
> >>>
> >>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
> >>>
> >>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> >>> ---
> >>>  security/selinux/ss/policydb.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >>> index e9394e7..f4eadd3 100644
> >>> --- a/security/selinux/ss/policydb.c
> >>> +++ b/security/selinux/ss/policydb.c
> >>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> >>>         if ((len == 0) || (len == (u32)-1))
> >>>                 return -EINVAL;
> >>>
> >>> -       str = kmalloc(len + 1, flags);
> >>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
> >>>         if (!str)
> >>>                 return -ENOMEM;
> >> Thanks for the patch.
> >>
> >> My eyes are starting to glaze over a bit chasing down all of the
> >> different kmalloc() code paths trying to ensure that this always does
> >> the right thing based on size of the allocation and the different slab
> >> allocators ... are we sure that this will always return NULL when (len
> >> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> >> configurations?
> >>
> > Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
> > ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
> >
> > The only concern would be whether you want allocation failure messages.
> > I assumed you don't need it because we are returning -ENOMEM to the caller.
> >
> Would it not be better with
> 
>     char *str;
> 
>     if ((len == 0) || (len == (u32)-1) || (len >= KMALLOC_MAX_SIZE))
>         return -EINVAL;
> 
>     str = kmalloc(len + 1, flags);
>     if (!str)
>         return -ENOMEM;

I strongly suspect that you want kvmalloc rather than kmalloc here. The
larger the request the more likely is the allocation to fail.

I am not familiar with the code but I assume this is a root only
interface so we don't have to worry about nasty users scenario.

-- 
Michal Hocko
SUSE Labs
