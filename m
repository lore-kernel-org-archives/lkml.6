Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA83C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88202089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88202089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJCQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:29:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51722 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:29:38 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 6b40d08789310677; Wed, 3 Oct 2018 11:41:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date:   Wed, 03 Oct 2018 11:38:58 +0200
Message-ID: <3282057.yGUaGxRyCs@aspire.rjw.lan>
In-Reply-To: <20180514154523.GA17331@sandybridge-desktop>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com> <8775668.fKKdjnIWAU@aspire.rjw.lan> <20180514154523.GA17331@sandybridge-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 14, 2018 5:45:23 PM CEST Yu Chen wrote:
> On Sun, May 13, 2018 at 11:30:52AM +0200, Rafael J. Wysocki wrote:
> > On Saturday, May 5, 2018 1:53:22 PM CEST Chen Yu wrote:
> > > According to current implementation of acpi_pad driver,
> > > it does not make sense to spawn any power saving threads
> > > on the cpus which are already idle - it might bring
> > > unnecessary overhead on these idle cpus and causes power
> > > waste. So verify the condition that if the number of 'busy'
> > > cpus exceeds the amount of the 'forced idle' cpus is met.
> > > This is applicable due to round-robin attribute of the
> > > power saving threads, otherwise ignore the setting/ACPI
> > > notification.
> > 
> > OK, but CPUs are busy, because they are running tasks.  If acpi_pad
> > kthreads run on them, the tasks they are running will migrate to the
> > currently idle CPUs (unless they have specific CPU affinity) and the
> > throttling will not really be effective.
> >
> OK, I think this makes sense, I missed the load balance scenario.
> > I would think that acpi_pad should ensure that the requested number of
> > CPUs will not run anything other than throttling kthreads.  Isn't that
> > the case?
> > 
> Do you mean, we should check if the number of 'idle'(rather than the 'busy' one
> in this patch) cpus is larger than the requested one? Then I think we should also
> add a patch to use the play_idle() as power_clamp to treat the throttling kthreads
> as idle threads thus to stop system tick. Such as the patch Jacob proposed:

I wonder if that can be switched over to the new idle injection framework
added recently?

Thanks,
Rafael

