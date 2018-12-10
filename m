Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB969C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26542084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26542084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeLJLbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:31:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59201 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:31:55 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d4144038bcab2e97; Mon, 10 Dec 2018 12:31:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date:   Mon, 10 Dec 2018 12:31:37 +0100
Message-ID: <3143453.Hr4lRPQaf4@aspire.rjw.lan>
In-Reply-To: <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
References: <20181120161451.21149-1-tiny.windzz@gmail.com> <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, December 9, 2018 7:20:26 AM CET Frank Lee wrote:
> On Wed, Nov 21, 2018 at 12:14 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v3:
> > -update changelog
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index db2ede565f1a..650f063ef809 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
> >         /*
> >          * Initialize the driver just for a compliant set of machines
> >          */
> > -       if (!of_match_node(compatible_machine_match, root))
> > +       if (!of_match_node(compatible_machine_match, root)){
> > +               of_node_put(root);
> >                 return -ENODEV;
> > +       }
> > +
> > +       of_node_put(root);
> >
> >         if (!mcpm_is_available())
> >                 return -EUNATCH;
> > --
> > 2.17.0
> >
> ping......

I've been waiting for the maintainers of this driver to speak up.

I'll pick up the patch later today or tomorrow unless there are objections.

Thanks,
Rafael

