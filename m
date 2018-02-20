Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBTUhr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:37:47 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35873 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBTUhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:37:46 -0500
X-Google-Smtp-Source: AG47ELtctBU7kAqcO82jcqMJOlExPteTkNpnhTuTFf8voxnAEiKcFVrEY8ZCpQ+B4kvOGgML7djI/WTFDSVz1NlppxA=
MIME-Version: 1.0
References: <20170807195027.13192-1-mjg59@google.com> <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
 <20180215152514.rxmh7webdg2i2fct@redbean> <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
 <20180220192100.wlrn3c4hnqdmu4zg@redbean>
In-Reply-To: <20180220192100.wlrn3c4hnqdmu4zg@redbean>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 20 Feb 2018 20:37:34 +0000
Message-ID: <CACdnJuvQHWBaLtPETbmOu=rwT72KGmYQfExRd8788SrYy2hUPQ@mail.gmail.com>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures configurable
To: Jessica Yu <jeyu@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 11:21 AM Jessica Yu <jeyu@kernel.org> wrote:

> Ah, OK. So if I'm understanding correctly, you want to use the same kernel
> image/configuration but for two different use cases, one where the module
> signatures do not matter, and one where they do matter. But the config you
> want to use in both use cases would have CONFIG_MODULE_SIG=y and
> CONFIG_MODULE_SIG_TAINT=n (to avoid tainting of unsigned/invalidly signed
> modules).

Right. Distributions generally have to try to satisfy multiple use cases
with as few kernel images as possible.

> In any case, I think I'd be willing to merge it as a module_param made
> available under CONFIG_MODULE_SIG=y (rather than as a new separate config
> option), while preserving the default behavior of tainting on
> unsigned/invalidly signed module loads (so let's keep the param parts of
> your patch). I think it makes sense to consider the turning-off-the-taint
> param as a behavioral tweak under CONFIG_MODULE_SIG. Then you could turn
> off the tainting behavior on the kernel command line, would this
sufficient
> enough for your use cases?

I think that's probably not practical - distributions often aren't in
control of the kernel command line after initial installation, so they'd
end up with different behaviour depending on whether a machine was a clean
install or not (which is why several things that are module_params have
defaults controlled by additional kernel config options)

> >Not entirely. There's two cases where the current situation causes
problems:
> >
> >1) Distributions that build out of tree kernel modules and don't have
> >infrastructure to sign them will end up with kernel taint. That's
something
> >that can be resolved by implementing that infrastructure.
> >2) End-users who build out of tree kernel modules will end up with kernel
> >taint and will file bugs. This cannot be fixed but will increase
> >distribution load anyway.

> I thought these two cases (particularly #2) were the very situations
> where distros might find the unsigned module taint useful (especially
> in the use case where you do benefit from module signatures). From my
> understanding, the unsigned module taint is intended to be useful when
> looking at crashes/OOPses, to provide a clear indication of whether or
> not a developer could reliably debug the crash, or choose to tread
> carefully, because the end-user has loaded an unsigned/out-of-tree
> module that wasn't signed/shipped by the distribution. Is the taint
> just not useful to distros in this manner anymore?

The module list is usually sufficient for that - users tend not to replace
individual distribution modules without rebuilding their entire kernel.
