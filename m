Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF910C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6666D2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6666D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeKCEJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:09:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42752 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKCEJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:09:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIehF-00009G-IM; Fri, 02 Nov 2018 19:01:29 +0000
Date:   Fri, 2 Nov 2018 19:01:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mst@redhat.com, mark.rutland@arm.com,
        Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com,
        jasowang@redhat.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181102190129.GY32577@ZenIV.linux.org.uk>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org>
 <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
 <20181102122937-mutt-send-email-mst@kernel.org>
 <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
 <CAHk-=wj5ZnqmpDuXBCcND8nMNitNyRf_4KQSzSUfQvX2-wOYsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5ZnqmpDuXBCcND8nMNitNyRf_4KQSzSUfQvX2-wOYsg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:15:56AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 10:10 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Don't you take over the VM with "use_mm()" when you do the copies? So
> > yes, it's a kernel thread, but it has a user VM, and though that
> > should have the user limits.
> 
> Oooh. *Just* as I sent this, I realized that "use_mm()" doesn't update
> the thread addr_limit.
> 
> That actually looks like a bug to me - although one that you've
> apparently been aware of and worked around.
> 
> Wouldn't it be nicer to just make "use_mm()" do
> 
>         set_fs(USER_DS);
> 
> instead? And undo it on unuse_mm()?
> 
> And, in fact, maybe we should default kernel threads to have a zero
> address limit, so that they can't do any user accesses at all without
> doing this?

Try it and watch it fail to set initramfs up, let alone exec the init...

> Adding Al to the cc, because I think he's been looking at set_fs() in general.

It would be the right thing (with return to KERNEL_DS), but I'm not certain
if GPU users will survive - these two
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:157:                         use_mm(mmptr);                          \
drivers/gpu/drm/i915/gvt/kvmgt.c:1799:          use_mm(kvm->mm);
I don't understand the call chains there (especially for the first one) well
enough to tell.
