Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D06C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A7A21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="nNZr4Ujd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A7A21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHXT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:28:02 -0400
Received: from cmta19.telus.net ([209.171.16.92]:43233 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeHXT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:28:01 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 15:28:00 EDT
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id tEGKfqAmEwgrmtEGMfSN5M; Fri, 24 Aug 2018 09:44:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1535125480; bh=kHwnEMB2JFA7XmA39PsoVK+QqTOFudP/zv5mvW3OgW0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=nNZr4Ujd5VUXDvlGoHqF+Fl3Bno4sVM8J2VTvI5kuF/PAA+niX34+WAyuzesaVe9O
         9kkYdP5U3bFjx+nebzCjZUkoBMrifdDvS0MXD3/F7ZJZgagn2rEKon7fOHP0dBzLPv
         DvO8bbIcZL31s4vx9rayXiJvQvlwuhQ5rxWm0hQYGs9QzjYUkVaX4aa2kU1I7kM4Sx
         YyWupFCwKeZ4B+hWBh130+hCDJ/pinPh18lrL0Al4mn63Bl+AbaX6ZpoY8MAtsiDkE
         g3LEnDzKEIbqyslJCh6GRBXBodvPjEdMQJhWc6VVQdCYqfdn0bvjP9tGhSQWp+CHQw
         /BQMETZkEyhJw==
X-Authority-Analysis: v=2.3 cv=D4zz1cZj c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=O76VCmqbo-wA:10
 a=QyXUC8HyAAAA:8 a=gGYOLuhWAgdjI3FwMKYA:9 a=CjuIK1q_8ugA:10
 a=IeVV3oy9AQTmNaZTXIJc:22 a=HH7FIXwXL_sUf1zzYxQd:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Leo Yan'" <leo.yan@linaro.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> t8fgfrW4IttF2t8fhf7XeN
In-Reply-To: t8fgfrW4IttF2t8fhf7XeN
Subject: RE: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date:   Fri, 24 Aug 2018 08:44:35 -0700
Message-ID: <000701d43bc1$5e0c2c50$1a2484f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdQ7j1MIbCuLKpY8QPiv9wfWSVHCMgAL1+AQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfPQ8OuOPzraUliJ+JZ6/vU6+mt+BJLLRmSlvg5YDO/s4YxCVPmh7UsvKFQWtxkSUcJ+ooxsdPHTiqP//zmuEKURHc7JtriUUxeNqgZF0SuuQiAK9qxyq
 zMHKNVvMAy+2QTJ4oPrSi8FKw0HutDQSK1u5qKwckvRPfIy3+rugBvVQ4Snhby0JLER8+GsWVFgQ5SWUeBkTXPnMVobwzHmnl0WENdEq7MYgvTQJqKYrZRCc
 O5l2qo7nLpl+O4Kq2Kc/NtNNhSLZLWbBx8DYV1FWEG3OHHNXfDvTmzQ2s/ptLzKGtIfL959kTmiNv9hlQkKld6EAv3PAI5mjewKAJUl4hhdfQjP8Mi8Ai/14
 DV5q45xeEbY9+vJRROHud5KbNZHgQFDBf+jFvwmx21oVUtLL8Fc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.08.24 02:44 Rafael J. Wysocki wrote:
> On Tuesday, August 21, 2018 10:44:10 AM CEST Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
>> stopped tick more aggressively) in the stopped tick case is present
>> when the tick has not been stopped yet too.

... [snip] ...

>> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)

... [snip] ...

> Due to the lack of objections, I'm inclined to queue this up.

I have been following these threads.
Recall that I was involved, over a period of months, in the original
"powernightmare" stuff.
I have revived my tests (and wish I had left myself better notes), and
am establishing a baseline before adding and trying this patch.
My baseline is actually two tests with and without the previous two patches (the ones
that were just sent a couple of days ago in "More power management updates for v4.19-rc1".
I might have those results in some presentable form by later today (it looks O.K.)
Results with this patch will take another couple of days.

... Doug


