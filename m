Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B342C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBA620854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBA620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJEDwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:52:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeJEDwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:52:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so8685000oic.3;
        Thu, 04 Oct 2018 13:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yyPNgY+RMm9FXmfdTd9Ctuy+o5f7dgQgyt2oV3Jn8Q=;
        b=RWwB1RIy8IcroGVyZdKM0rpcrf8RBMYVX9UPwpdUiJEepWBEg4h8k8SCtuU1KYbCQQ
         vpmvGFNoXx7jTahYkuinfKSAjYzs6J5TLzaDPOfn6Xxqm0P4zvlSfF0P0pjEJ+Zb9dDR
         7ZSnURhAauD/I8a8MpJ4/mO5mkFDlmybJ2e0B5Xdhc74BVQyrtv3nqt/AyR+7pTTfup/
         13YJjL1ko19FWtUoGpsjS53Im3T/tOfRS4y3QtJkYoofssezED3/nCq4l/RdrA0kaDBX
         CbqVaClOsuk95A1BodcLxe843qVUnMCxEqUiHbdJNUAONzHxpb4WwMM42SxoDCI8jJQV
         g7AQ==
X-Gm-Message-State: ABuFfohmS5HFhZc6f3OovH0w7POHA43q9Y5PEAadknBTEknQ7UQe/uEV
        l4MRFUHhc2OFZzMrL4kMTeXzwRK9io0qNjsvqoI/2A==
X-Google-Smtp-Source: ACcGV63umOnSGtIntLSvuIgr2IXfVc9GRbpJmuA1WBy7fBUVzxnYoFAQ203h9aNdjZE/P9FNOvhzgm6KQskPCbkVrZQ=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr4067711oif.8.1538686639727;
 Thu, 04 Oct 2018 13:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com> <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com>
In-Reply-To: <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 22:57:08 +0200
Message-ID: <CAJZ5v0jqb1iScje5PajN7F5EL4SQ0oMd4gFhss+=vYRHnogVhA@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, alcooperx@gmail.com,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 8:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 19:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > If __device_suspend() returns early on an error or pending wakeup
> >> > and the power.direct_complete flag has been set for the device
> >> > already, the subsequent device_resume() will be confused by it
> >> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> >> > has not been disabled for the device by __device_suspend().
> >>
> >> I think it would be fair to mention that is related to the async
> >> suspend path, in dpm_suspend().
> >
> > OK, fair enough.
> >
> >> >
> >> > To avoid that, clear power.direct_complete if __device_suspend()
> >> > is not going to disable runtime PM for the device before returning.
> >>
> >> Overall, by looking at the behavior in dpm_suspend() of async
> >> suspended devices, it does look a bit fragile to me.
> >>
> >> My worries is that we put asynced suspended devices in the
> >> dpm_suspended_list, no matter if the device was successfully suspended
> >> or not. This differs from the no-async path.
> >
> > That's because this was the most straightforward way to organize that
> > (otherwise you need to worry about the list locking with respect to
> > the async suspends etc and you really need to preserve the ordering
> > there).
>
> I understand about the lock, but not sure if that is something to
> worry about, at least from contention point of view, if that is what
> you mean?

The contention may not be a problem, but there would be some extra
overhead related to the dragging of the lock cache line between CPUs.

> In regards to the order, is that really problem for async enabled devices?

You may be underestimating the problem somewhat.

For example, say you have 4 devices, A which is the parent of B and C,
and D which is a child of C.  Say that D depends on B too, but it
cannot be a child of it and there's no device link between B and D.
[For instance, the driver of A has registered both B and C, and the
driver of C has registered D, but it doesn't know about the dependency
between D and B.]  Also say that A, B and C are all async, but D is
sync and all A, B, C are before D in the original list order.

dpm_suspend() will get to A, B and C only after dealing with D.  It
will then start to suspend B and C almost at the same time and A will
wait for both of them.  So far so good.

Next, A will resume first, B and C after it, and D after C.  Say that
B is somewhat faster to resume, but it actually adds itself back to
the list after C and D (as they don't wait for it).  The resume of C
and D succeeds (because B is already there physically), but the
ordering of the list is now A->C->D->B and there will be trouble
during the next suspend, because B will be suspending in parallel with
D which depends on it.

In this case you have to guarantee that D and B will not be reordered,
but it generally is hard without an explicit "link" between them -
unless the original ordering of the list is preserved entirely.

> >
> >> In the long run, maybe we should change that instead?
> >
> > Is there anything wrong with it really?
>
> No, besides complexity. :-)

And how exactly are you measuring the "complexity" here?

> My, point was that we could potentially simplify the code in
> device_resume() and in __device_suspend(), as the behavior would them
> becomes more deterministic.

No, it wouldn't be more deterministic.  In fact, it would then become
less deterministic and provably so if you take consecutive
suspend-resume cycles into account.  In principle, the order in which
devices are handled might be different every time then and sorry, but
I'm failing to see how that can be regarded as "more deterministic".

> device_resume() will never be called unless __device_suspend() has succeeded for the device.

Which doesn't matter.  What matters is that (and which is the case
already) the resume callbacks will not be invoked without invoking the
suspend callbacks for the device beforehand.
