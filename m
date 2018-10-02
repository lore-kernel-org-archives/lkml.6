Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0DC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11E52083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11E52083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJCEwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:52:05 -0400
Received: from namei.org ([65.99.196.166]:35266 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbeJCEwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:52:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w92M6Ca3027182;
        Tue, 2 Oct 2018 22:06:12 GMT
Date:   Wed, 3 Oct 2018 08:06:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
In-Reply-To: <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810030758460.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org> <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com> <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
 <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com> <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Kees Cook wrote:

> On Tue, Oct 2, 2018 at 11:57 AM, John Johansen
> <john.johansen@canonical.com> wrote:
> > Under the current scheme
> >
> > lsm.enabled=selinux
> >
> > could actually mean selinux,yama,loadpin,something_else are
> > enabled. If we extend this behavior to when full stacking lands
> >
> > lsm.enabled=selinux,yama
> >
> > might mean selinux,yama,apparmor,loadpin,something_else
> >
> > and what that list is will vary from kernel to kernel, which I think
> > is harder for the user than the lsm.enabled list being what is
> > actually enabled at boot
> 
> Ah, I think I missed this in your earlier emails. What you don't like
> here is that "lsm.enable=" is additive. You want it to be explicit.
> 

This is a path to madness.

How about enable flags set ONLY per LSM:

lsm.selinux.enable=x
lsm.apparmor.enable=x

With no lsm.enable, and removing selinux=x and apparmor=x.

Yes this will break existing docs, but they can be updated for newer 
kernel versions to say "replace selinux=0 with lsm.selinux.enable=0" from 
kernel X onwards.

Surely distro packages and bootloaders are able to cope with changes to 
kernel parameters?

We can either take a one-time hit now, or build new usability debt, which 
will confuse people forever.


-- 
James Morris
<jmorris@namei.org>

