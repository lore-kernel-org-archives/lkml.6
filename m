Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F47C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8B2064C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="cFSIzPI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF8B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeJ0PR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:17:27 -0400
Received: from cmta18.telus.net ([209.171.16.91]:57162 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeJ0PR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:17:26 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id GIDtgZdMYiBO5GIDvgMvJl; Sat, 27 Oct 2018 00:37:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1540622250; bh=KYNAyi15HY+wSJz15EFdb9FS9k28v2JxwZM3dkfcFTA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=cFSIzPI0kDsvjc3XnsEz+FG+by00ZC5Tle5yP92dy2ajjO28+bh6OyfgMZtDJRwgw
         yODNewYsoLw52peJ/vC3khEvMcyjuizm6ohVkZ2rvADO6fjuxXrGfD1DLi6pDe8x6N
         pb0n7IqjU/Zdw4ZXOAlP5gFreTbE61oBoWMBTOYaiehB21/hcHEymHgRTFOPeY5Z83
         gLKm71uCc4OLR+SWdRXRyx+Q4PPzYFVcrg0f0eEjjFsXznvJMbbk0W11Plhtx6Iml0
         A9Obt0sGcHicL6a3jLUkjB7cDyb5UFlXcvSqX8rBO4T/T+F8JmYx9JmAyQVRxPI9EJ
         UN4flCygi7iBQ==
X-Authority-Analysis: v=2.3 cv=d5AkNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8
 a=0igoudQp0_ATWZdRAXoA:9 a=CjuIK1q_8ugA:10 a=JZBxSqCIBzwA:10
 a=W4TVW4IDbPiebHqcZpNg:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: FyDdgD8Nty5tHFyDfgBIL9
In-Reply-To: FyDdgD8Nty5tHFyDfgBIL9
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date:   Fri, 26 Oct 2018 23:37:24 -0700
Message-ID: <001201d46dbf$88339510$989abf30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdRtDH3oudDuSet0QzO8Qu9q0tpqpwAsSDAw
X-CMAE-Envelope: MS4wfIqZcX7ef17TlyzbBLgRoUqidBvOdB/Y/4Z82Unkx2N40mfIS+ChQ66NjZgJRf+IhmqORMabWlWuy7vHtNu7ttqoUpKxxjIR77Emz3ECa5PfoCI+u5Y1
 dFqv5o/YVuTSv0LP/o5TBuGbPyB47bWd6eNBNfa9BFWBIINxWNTw/J1qzx0SXlunqI3dpNJpQR6OmoINiYigOGHb+r6whQABJgP/j+8Kh5AGhTrvnrJNVoRI
 Gl3lr1YRrdJ35QTXcuY8l6+FFvhc4wSXgctZXQ8pnEf0mJjpPaTvMrGePhg4HufR/EWqmROYzz00FDi1+MTUYPIc63d93fcfxAOauNBiUCdvxRCI7Ja9xECI
 LQYOEnvTgb5R9bBzTWGjvoN2KeoCIRmgxbN1Ce6DibHEN3VUbvA7DHLMzUqxxB5vFIf2USEB5cTDKkYZbcfF8VTvDv284ib35gBOzeA+m3h35bz7nBkME6bP
 3yV+7k/DVy2kutP4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just for anybody else trying to compile:

On 2018.10.26 02:12 Rafael J. Wysocki wrote:

> The venerable menu governor does some thigns that are quite

Typo: thigns -> things

...[snip]...

> The patch should apply on top of 4.19, although I'm running it on
> top of my linux-next branch.

No, it uses "poll_time_limit" which was introduced in patch 1 of 6
[1] in that group of menu changes from October 2nd.

"[PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for polling state"

... Doug

[1] https://lkml.org/lkml/2018/10/3/42


