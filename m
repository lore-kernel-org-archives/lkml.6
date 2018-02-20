Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeBTVYG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBTVYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:24:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8C82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Tue, 20 Feb 2018 22:23:59 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Matthew Garrett <mjg59@google.com>
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures
 configurable
Message-ID: <20180220212357.wts5c5c7uqcfguzu@redbean>
References: <20170807195027.13192-1-mjg59@google.com>
 <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
 <20180215152514.rxmh7webdg2i2fct@redbean>
 <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
 <20180220192100.wlrn3c4hnqdmu4zg@redbean>
 <CACdnJuvQHWBaLtPETbmOu=rwT72KGmYQfExRd8788SrYy2hUPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACdnJuvQHWBaLtPETbmOu=rwT72KGmYQfExRd8788SrYy2hUPQ@mail.gmail.com>
X-OS: Linux redbean 4.14.16-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthew Garrett [20/02/18 20:37 +0000]:
>On Tue, Feb 20, 2018 at 11:21 AM Jessica Yu <jeyu@kernel.org> wrote:
>
>> Ah, OK. So if I'm understanding correctly, you want to use the same kernel
>> image/configuration but for two different use cases, one where the module
>> signatures do not matter, and one where they do matter. But the config you
>> want to use in both use cases would have CONFIG_MODULE_SIG=y and
>> CONFIG_MODULE_SIG_TAINT=n (to avoid tainting of unsigned/invalidly signed
>> modules).
>
>Right. Distributions generally have to try to satisfy multiple use cases
>with as few kernel images as possible.
>
>> In any case, I think I'd be willing to merge it as a module_param made
>> available under CONFIG_MODULE_SIG=y (rather than as a new separate config
>> option), while preserving the default behavior of tainting on
>> unsigned/invalidly signed module loads (so let's keep the param parts of
>> your patch). I think it makes sense to consider the turning-off-the-taint
>> param as a behavioral tweak under CONFIG_MODULE_SIG. Then you could turn
>> off the tainting behavior on the kernel command line, would this
>sufficient
>> enough for your use cases?
>
>I think that's probably not practical - distributions often aren't in
>control of the kernel command line after initial installation, so they'd
>end up with different behaviour depending on whether a machine was a clean
>install or not (which is why several things that are module_params have
>defaults controlled by additional kernel config options)

Ah I see.. Fair enough!

>> >Not entirely. There's two cases where the current situation causes
>problems:
>> >
>> >1) Distributions that build out of tree kernel modules and don't have
>> >infrastructure to sign them will end up with kernel taint. That's
>something
>> >that can be resolved by implementing that infrastructure.
>> >2) End-users who build out of tree kernel modules will end up with kernel
>> >taint and will file bugs. This cannot be fixed but will increase
>> >distribution load anyway.
>
>> I thought these two cases (particularly #2) were the very situations
>> where distros might find the unsigned module taint useful (especially
>> in the use case where you do benefit from module signatures). From my
>> understanding, the unsigned module taint is intended to be useful when
>> looking at crashes/OOPses, to provide a clear indication of whether or
>> not a developer could reliably debug the crash, or choose to tread
>> carefully, because the end-user has loaded an unsigned/out-of-tree
>> module that wasn't signed/shipped by the distribution. Is the taint
>> just not useful to distros in this manner anymore?
>
>The module list is usually sufficient for that - users tend not to replace
>individual distribution modules without rebuilding their entire kernel.
