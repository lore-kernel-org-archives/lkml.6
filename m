Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeE2Ill (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:41:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64333 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeE2Ilj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:41:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PM / runtime: Drop usage count for suppliers at device link removal
Date: Tue, 29 May 2018 10:40:51 +0200
Message-ID: <2305835.OJaHNvgZnB@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0gGLvKS6yDuBokJzm2gAhM=VMSaz5frvWq=eRPkAD-z6g@mail.gmail.com>
References: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0gGLvKS6yDuBokJzm2gAhM=VMSaz5frvWq=eRPkAD-z6g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 27, 2018 12:18:05 PM CEST Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 10:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > In the case consumer device is runtime resumed, while the link to the
> > supplier is removed, the earlier call to pm_runtime_get_sync() made from
> > rpm_get_suppliers() does not get properly balanced with a corresponding
> > call to pm_runtime_put(). This leads to that suppliers remains to be
> > runtime resumed forever, while they don't need to.
> >
> > Let's fix the behaviour by calling rpm_put_suppliers() when dropping a
> > device link. Not that, since rpm_put_suppliers() checks the
> > link->rpm_active flag, we can correctly avoid to call pm_runtime_put() in
> > cases when we shouldn't.
> >
> > Reported-by: Todor Tomov <todor.tomov@linaro.org>
> > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Rafael, I am not sure if this is safe from locking point of view. The device
> > link write lock has been taken when pm_runtime_drop_link() is called, hence I
> > assume calling rpm_put_suppliers() should be fine!? If not, can you please
> > advise how to change?
> 
> Holding the lock should be sufficient for the list to be stable, so
> AFAICS it is OK.

So the patch has been applied, thanks!
