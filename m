Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF01C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977821924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfBOQS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:18:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfBOQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:18:55 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 083DA7AEAF;
        Fri, 15 Feb 2019 16:18:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D7F3101E84C;
        Fri, 15 Feb 2019 16:18:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Feb 2019 17:18:53 +0100 (CET)
Date:   Fri, 15 Feb 2019 17:18:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter
 path
Message-ID: <20190215161851.GA8804@redhat.com>
References: <20190215031758.GA18776@beast>
 <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 15 Feb 2019 16:18:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14, Kees Cook wrote:
>
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -42,9 +42,18 @@ static int load_script(struct linux_binprm *bprm)
>         fput(bprm->file);
>         bprm->file = NULL;
>
> -       bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
> -       if ((cp = strchr(bprm->buf, '\n')) == NULL)
> -               cp = bprm->buf+BINPRM_BUF_SIZE-1;
> +       if ((cp = strnchr(bprm->buf, BINPRM_BUF_SIZE, '\n')) == NULL) {
> +               bool truncated = true;
> +
> +               for (cp = bprm->buf+2; cp < bprm->buf+BINPRM_BUF_SIZE-1 &&
> +                                      ((*cp == ' ') || (*cp == '\t')); cp++);
> +               for (; cp < bprm->buf+BINPRM_BUF_SIZE-1; cp++) {
> +                       if ((*cp == ' ') || (*cp == '\t'))
> +                               truncated = false;
> +               }
> +               if (truncated)
> +                       return -ENOEXEC; /* Interpreter truncated */

Not sure. Consider a script file which has a single line

	#!/path/to/interpreter

WITHOUT '\n' at the end. If I read load_script() correctly it should work,
so I think the 2nd for() loop should also reset "truncated" if *cp == '\0'.

Hmm. And cp < bprm->buf+BINPRM_BUF_SIZE-1 is off-by-one again...

Well. Probably nobody does this... but after regression caused by my patch
I am not 100% sure ;)

Oleg.

