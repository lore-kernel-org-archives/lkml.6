Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321F7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0452083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0452083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeGZKIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:08:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55280 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbeGZKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:08:16 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 8405abc3c1254872; Thu, 26 Jul 2018 10:52:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
Date:   Thu, 26 Jul 2018 10:50:35 +0200
Message-ID: <24724042.UC9DsrE2FJ@aspire.rjw.lan>
In-Reply-To: <76C1A830-EEE1-486B-9B06-6C915C269278@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com> <CAJZ5v0ifKcipGG0sM0iK0p4K0-V-PyoL-JfTH6uVVWoCA-eXnw@mail.gmail.com> <76C1A830-EEE1-486B-9B06-6C915C269278@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 10:15:03 AM CEST Kai-Heng Feng wrote:
> 
> > On 2018Jul26, at 16:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > 
> > On Thu, Jul 26, 2018 at 5:46 AM, Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> Hi Rafael,
> >> 
> >>> On 2018Jul24, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> 
> >>> On Tuesday, July 24, 2018 11:13:42 AM CEST Rafael J. Wysocki wrote:
> >>>> On Tuesday, July 24, 2018 10:46:09 AM CEST Kai Heng Feng wrote:
> >>>>> Hi Rafael,
> >>>>> 
> >>>>>> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>>>>> 
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>> 
> >>>>>> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> >>>>>> runtime PM and system sleep handling) introduced a system suspend
> >>>>>> regression on some machines, but the only functional change made by
> >>>>>> it was to cause the PM quirks in the LPSS to also be used during
> >>>>>> system suspend and resume.  While that should always work for
> >>>>>> suspend-to-idle, it turns out to be problematic for S3
> >>>>>> (suspend-to-RAM).
> >>>>>> 
> >>>>>> To address that issue restore the previous S3 suspend and resume
> >>>>>> behavior of the LPSS to avoid applying PM quirks then.
> >>>>> 
> >>>>> The users reported that this patch does fix the S3 issue, but the S4 still
> >>>>> fails.
> >>>>> 
> >>>>> Please refer to [1] for more for user's testing result.
> >>>>> 
> >>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60
> >>>> 
> >>>> Please ask the users to test the patch below, then, on top of the $subject one.
> >>> 
> >>> There was a mistake in the previous patch I posted, sorry about that.
> >>> 
> >>> Please test this one instead:
> >> 
> >> The result is positive, thanks!
> > 
> > Good, thanks!
> > 
> > I assume that S3 still works with this patch applied too.
> 
> Yes, S3 continues to work with this patch.

OK, thanks!

Let me resend the patch with a proper subject and changelog, then.

