Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91390C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467832064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="EuEHY/cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467832064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJCSok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:44:40 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:10932 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJCSok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:44:40 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2018 14:44:38 EDT
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C7F2E41EB8D;
        Wed,  3 Oct 2018 13:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1538567366;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkKmYlWkHHemij050YscC/BErDSwO4FtNfcOIl5gQkc=;
        b=EuEHY/cYMuOi+aOfJokyZR29b/FGnGeePiyerF5ymgSifzTVc0yO85SwHpSGbQBqcbjiGB
        hiH/tOJhpMrSF/L1p3snxKUxnx4wh4a8kSxoKkiAdWpisQskToqcmtptncUNvLd4Egue3/
        36QiZQ6csy4sizWhfLcC9Gzj+coREMw=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name C7F2E41EB8D
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 03 Oct 2018 13:49:25 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
Message-ID: <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1538567366;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkKmYlWkHHemij050YscC/BErDSwO4FtNfcOIl5gQkc=;
        b=iV+JrVPuRATxL3Lb65vWzCaET42VaHjatxRwHcOUCMUTVOF3aOxEL+XfToQ8TSAjpbfSEC
        WrCire5al3/9T/vqp40A13ctVvT5cVv4ad/3GNGUYK6OWC9MLUcmvTK3S03REHpO82qrZy
        Kly+WrHIOg+fQ8BWRfI8ZWzl39+X0dg=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1538567366; a=rsa-sha256;
        cv=none;
        b=DdvfF3JSdcwxXnR5u7+paHEE6T688DmWBgcXogiWZbojDdUM4hND8Wqm3F/uOp76Hc0qsh++RcXknZj6Jdks2LZE2mGOBAgjsneMDi6y5/OROFyXWbOJCbwD5BFJOcu/Q0xFOvLk0IJ8giuFh9jXs52lujjIzF9Khe63v2Uekhk=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 03.10.2018 08:29, Paolo Valente wrote:
> As also Linus Torvalds complained [1], people feel lost among
> I/O-scheduler options.  Actual differences across I/O schedulers are
> basically obscure to non experts.  In this respect, Linux-kernel
> 'users' are way more than a few top-level distros that can afford a
> strong performance team, and that, basing on the input of such a team,
> might venture light-heartedly to change a critical component like an
> I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
> are not distros that use udev.

I feel a contradiction in this counter-argument. On one hand, there are 
lots of, let's call them, home users, that use major distributions with 
udev, so the distribution maintainers can reasonably decide which 
scheduler to use for which type of device based on the udev rule and 
common sense provided via Documentation/ by linux-block devs. Moreover, 
most likely, those rules should be similar or the same across all the 
major distros and available via some (systemd?) upstream.

On another hand, the users of embedded devices, mentioned by Linus, 
should already know what scheduler to choose because dealing with 
embedded world assumes the person can decide this on their own, or with 
the help of abovementioned udev scripts and/or Documentation/ as a 
reference point.

So I see no obstacles here, and the choice to rely on udev by default 
sounds reasonable.

The question that remain is whether it is really important to mount a 
root partition while already using some specific scheduler? Why it 
cannot be done with "none", for instance?

> So, probably 99% of Linux-kernel users will just stick to the default
> I/O scheduler, mq-deadline, assuming that the algorithm by which that
> scheduler was chosen was not "pick the scheduler with the longest
> name", but "pick the best scheduler for most cases".  The problem is
> that, for single-queue devices with a speed below 400/500 KIOPS, the
> default scheduler is apparently incomparably worse than bfq in terms
> of responsiveness and latency for time-sensitive applications [2], and
> in terms of throughput reached while controlling I/O [3].  And, in all
> other tests ran so far, by any entity or group I'm aware of, bfq
> results basically on par with or better than mq-deadline.

And that's why major distributions are likely to default to BFQ via 
udev. No one argues with BFQ superiority here ☺.

> So, I do understand your need for conservativeness, but, after so much
> evidence on single-queue devices, and so many years! :), what's the
> point in keeping Linux worse for virtually everybody, by default?

 From my point of view this is not a conservative approach at all. On 
contrary, offloading decisions to userspace aligns pretty well with 
recent trends like pressure metrics/userspace OOM killer, eBPF etc. The 
less unnecessary logic the kernel handles, the more flexibility it 
affords.

-- 
   Oleksandr Natalenko (post-factum)
