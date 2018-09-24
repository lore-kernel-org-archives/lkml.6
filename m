Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05684ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EB2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971EB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbeIXVh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:37:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20901 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbeIXVh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47B8030842D0;
        Mon, 24 Sep 2018 15:35:15 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A964C8AD4A;
        Mon, 24 Sep 2018 15:35:14 +0000 (UTC)
Subject: Re: [PATCH v2] clocksource: Warn if too many missing ticks are
 detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1537319979-6139-1-git-send-email-longman@redhat.com>
 <alpine.DEB.2.21.1809190948470.1468@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <267d64f5-ed31-f158-ee80-068b2be0fb74@redhat.com>
Date:   Mon, 24 Sep 2018 11:35:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809190948470.1468@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 24 Sep 2018 15:35:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 03:53 AM, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Waiman Long wrote:
>
>> The clocksource watchdog, when running, is scheduled on all the CPUs in
>> the system sequentially on a round-robin fashion with a period of 0.5s.
>> A bug in the 4.18 kernel is causing missing ticks when nohz_full
>> is specified. Under some circumstances, this causes the watchdog to
>> incorrectly state that the TSC is unstable because of counter overflow
>> in the hpet watchdog clock source after a few minutes delay.
>>
>> That particular bug is fixed by the 4.19 commit 7059b36636beab ("sched:
>> idle: Avoid retaining the tick when it has been stopped"). To make it
>> easier to catch this kind of bug in the future, a check is added to see
>> if there is too much delay in the invocation of the watchdog callback
>> and print a warning once if it happens.
> Second thoughts on this. Putting the check into the clocksource watchdog is
> the wrong place as it's just checking at a place where the symptom
> shows. What about putting it right to the source, i.e. in the timer wheel
> as it does not depend on the clocksource watchdog being active. The
> clocksource watchdog triggering is just one of the symptoms, but in general
> timers being massively late is not a good thing.
>
> Thanks,
>
> 	tglx
>
It looks like there are more complications to deal with in order to do
the proper check. I will leave the check in the watchdog for the time
being and see how thing works out.

-Longman

