Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeERI60 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:58:26 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42809 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeERI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:58:21 -0400
X-Google-Smtp-Source: AB8JxZretzJBrNQswgfOdesza5mnWYTGWkEnoOJKeEhUexQPpr5LkZInhRhcuczxORvK3fHYFHJ30+I5qNu8VrqngX8=
MIME-Version: 1.0
In-Reply-To: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org>
References: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 10:58:20 +0200
X-Google-Sender-Auth: PWfq_n3GRb0tQplHLn9wqSnbPps
Message-ID: <CAJZ5v0ikXsWdXq-h8rWLd-vfzi-gFmxyHmOGvRvDUoJHC3L2XA@mail.gmail.com>
Subject: Re: [PATCH] PM / runtime: Fixup reference counting of device link
 suppliers at probe
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In the driver core, before it invokes really_probe() it runtime resumes the
> suppliers for the device via calling pm_runtime_get_suppliers(), which also
> increases the runtime PM usage count for each of the available supplier.
>
> This makes sense, as to be able to allow the consumer device to be probed
> by its driver. However, if the driver decides to add a new supplier link
> during ->probe(), hence updating the list of suppliers,

Do any of the existing drivers do that?

> the following call to pm_runtime_put_suppliers(), invoked after really_probe()
> in the driver core, we get into trouble.
