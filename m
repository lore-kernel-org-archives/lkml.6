Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFC7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCA1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="WlUNTYIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCA1208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeFZUoK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:44:10 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:22902 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeFZUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:44:09 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 16:44:08 EDT
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4E2F83974A6;
        Tue, 26 Jun 2018 22:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1530045319;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CIjjxwemthjiB0xPoGeI/oU4LFQJZa3PrnbEy9r0gc=;
        b=WlUNTYIiuQZEreMcXbfPzIvWwTS0KnAGM8441lTlruey49ja4Ni+D20qvPgioGyzrOHLCD
        ZEvBljiUsIZfn9OYzC/CdHBz3HT7pnzk9Sfu+uOnL+V1AG0963hwig8BaMv2XlA7h3SKTJ
        gNFUdwo0D4Cr333ZXWN3TNkLcmeWKy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 4E2F83974A6
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jun 2018 22:35:19 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
Message-ID: <c0098394dac86d23935276a6d25d1f3a@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1530045319;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CIjjxwemthjiB0xPoGeI/oU4LFQJZa3PrnbEy9r0gc=;
        b=vLlUegOsWJpu8iVqQmkBp+bvO0JFzUhL5osi4wg1/vnMLM6RoVoRLPNeQpGDz4jtwgjBjD
        yH6B2ONbm81YrnNfV0shJcuB7HEKUBH3avurxP9XMYKKYLu1HadA5tx6P3QUf/KFxORyUQ
        yhDQGvgSJZC/ud8UFMWmTKj9j86yyQo=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1530045319; a=rsa-sha256;
        cv=none;
        b=b77j0dllsBBnICpBEoBTGqQSIHkzFXmblhHqGX2ytuQ9eTR+0IA1Nshze+gYeRAea0IhB7+IVWHofBp1CODHraBJ2rBw2d0krhgC+FoL4QK4IxGDPdKy7NQTz/mlrNiXVj91beXy7SjmC7iWLSn922KQQVS/ZCF1HZwHd2H7IYI=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 25.06.2018 21:55, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
> 
> I guess these patches are appropriate for next kernel release.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (4):
>   block, bfq: add/remove entity weights correctly
>   block, bfq: do not expire a queue that will deserve dispatch plugging
>   block, bfq: fix service being wrongly set to zero in case of
>     preemption
>   block, bfq: give a better name to bfq_bfqq_may_idle
> 
>  block/bfq-iosched.c | 131 
> +++++++++++++++++++++++++++++++++++++++++++---------
>  block/bfq-iosched.h |   7 ++-
>  block/bfq-wf2q.c    |  30 ++++++------
>  3 files changed, 128 insertions(+), 40 deletions(-)
> 
> --
> 2.16.1

So far, no smoke or visible issues while running it on my 2 SSDs with a 
daily workload applied.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
