Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E5AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4202192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406772AbfBNUUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:20:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390579AbfBNUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:20:30 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57FD1B3F;
        Thu, 14 Feb 2019 20:20:29 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:20:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        LKML <linux-kernel@vger.kernel.org>, graham@grahamc.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Userspace regression in LTS and stable kernels
Message-Id: <20190214122027.c0df36282d65dc9979248117@linux-foundation.org>
In-Reply-To: <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
        <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
        <CAHk-=wjtH5ombebghG-SDNGppJF4a5bZAUqndtZ3tauWjgw5_w@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 09:56:46 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Feb 13, 2019 at 3:37 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >
> > Your shebang line exceeds BINPRM_BUF_SIZE.
> > Before the said commit the kernel silently truncated the shebang line
> > (and corrupted it),
> > now it tells the user that the line is too long.
> 
> It doesn't matter if it "corrupted" things by truncating it. All that
> matters is "it used to work, now it doesn't"
> 
> Yes, maybe it never *should* have worked. And yes, it's sad that
> people apparently had cases that depended on this odd behavior, but
> there we are.
> 
> I see that Kees has a patch to fix it up.
> 

Greg, I think we have a problem here.

8099b047ecc431518 ("exec: load_script: don't blindly truncate shebang
string") wasn't marked for backporting.  And, presumably as a
consequence, Kees's fix "exec: load_script: allow interpreter argument
truncation" was not marked for backporting.

8099b047ecc431518 hasn't even appeared in a Linus released kernel, yet
it is now present in 4.9.x, 4.14.x, 4.19.x and 4.20.x.

I don't know if Oleg considered backporting that patch.  I certainly
did (I always do), and I decided against doing so.  Yet there it is.

