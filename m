Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37017C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1152214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1152214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJEALD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:11:03 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:36619 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727530AbeJEALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:11:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 53BD3181D341E;
        Thu,  4 Oct 2018 17:16:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hill62_3b4e9038c9d19
X-Filterd-Recvd-Size: 3467
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Oct 2018 17:16:47 +0000 (UTC)
Message-ID: <dba47f670a8aab2ff68e664b3a138ca456fbfd74.camel@perches.com>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
From:   Joe Perches <joe@perches.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Oct 2018 10:16:46 -0700
In-Reply-To: <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
         <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
         <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
         <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 10:40 +0200, Daniel Lezcano wrote:
> On 04/10/2018 10:22, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > > The function get_loadavg() returns almost always zero. To be more
> > > precise, statistically speaking for a total of 1023379 times passing
> > > in the function, the load is equal to zero 1020728 times, greater than
> > > 100, 610 times, the remaining is between 0 and 5.
[]
> > > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
[]
> > > @@ -359,7 +346,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >                  * Use the performance multiplier and the user-configurable
> > >                  * latency_req to determine the maximum exit latency.
> > >                  */
> > > -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> > > +               interactivity_req = data->predicted_us /
> > > +                       performance_multiplier(nr_iowaiters);
> > 
> > I wouldn't break this line.
> 
> Ok, mind if I break the line in a separate patch before ? (my git
> pre-commit hook runs checkpatch and it complains and prevent to commit
> the patch because of the line length (94)).

A lot of this file uses > 80 column lines.
As well, the identifiers here are relatively long.

Long identifier lengths and 80 column lines are generally
incompatible.

I suggest you change your script to allow > 80 column lines
using the checkpatch command-line option --ignore==long_line
or perhaps add --max-line-length=<some higher value> or at
least allow some other senstible interactivity when the silly
script bleats some mindless warning or another.


