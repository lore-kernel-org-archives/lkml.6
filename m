Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E90C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25419208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RWPFdp2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25419208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeHVUKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:10:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24931 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1534956296; x=1566492296;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rfa9i4A44ju9+WUjkzZDjS7IX+yEnwKUjVoCHRY8Wbs=;
  b=RWPFdp2ASS4YATB6ZseOSnxTAPC0g7w41dcjrSEUAY1n6eMiVYA0DT5/
   OxI7yhX6ptKyZpD4RwwIfuhF1ujW+u3QmZsZaZEybokNvObbcflG7da7v
   r97ew4yT8dAqknHyOrHUhVGO69ZQznUyYQpk95jz9ou2fuaXlNsTG+xoH
   0=;
X-IronPort-AV: E=Sophos;i="5.53,274,1531785600"; 
   d="scan'208";a="358691505"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2018 16:44:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7MGgaHB100304
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 Aug 2018 16:42:42 GMT
Received: from EX13D10UWB001.ant.amazon.com (10.43.161.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 16:42:41 +0000
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13D10UWB001.ant.amazon.com (10.43.161.111) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 16:42:41 +0000
Received: from EX13D13UWB002.ant.amazon.com ([10.43.161.21]) by
 EX13D13UWB002.ant.amazon.com ([10.43.161.21]) with mapi id 15.00.1367.000;
 Wed, 22 Aug 2018 16:42:41 +0000
From:   "van der Linden, Frank" <fllinden@amazon.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?iso-8859-1?Q?Holger_Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        "Agarwal, Anchal" <anchalag@amazon.com>
CC:     "Singh, Balbir" <sblbir@amazon.com>,
        "Wilson, Matt" <msw@amazon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
Thread-Topic: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
Thread-Index: AQHUKRY5/qMn8blD+E2lEmZxUfmzSA==
Date:   Wed, 22 Aug 2018 16:42:41 +0000
Message-ID: <f71cf3f9c54346e1b69ab42601404597@EX13D13UWB002.ant.amazon.com>
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <72f90be2-0b63-d3a0-e953-da9232f44d5b@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.91]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 7:27 AM, Jens Axboe wrote:=0A=
> On 8/22/18 6:54 AM, Holger Hoffst=E4tte wrote:=0A=
>> On 08/22/18 06:10, Jens Axboe wrote:=0A=
>>> [...]=0A=
>>> If you have time, please look at the 3 patches I posted earlier today.=
=0A=
>>> Those are for mainline, so should be OK :-)=0A=
>> I'm just playing along at home but with those 3 I get repeatable=0A=
>> hangs & writeback not starting at all, but curiously *only* on my btrfs=
=0A=
>> device; for inexplicable reasons some other devices with ext4/xfs flush=
=0A=
>> properly. Yes, that surprised me too, but it's repeatable.=0A=
>> Now this may or may not have something to do with some of my in-testing=
=0A=
>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything=
=0A=
>> is golden again. Not eager to repeat since it hangs sync & requires a=0A=
>> hard reboot.. :(=0A=
>> Just thought you'd like to know.=0A=
> Thanks, that's very useful info! I'll see if I can reproduce that.=0A=
>=0A=
I think it might be useful to kind of give a dump of what we discussed=0A=
before this patch was sent, there was a little more than was in the=0A=
description.=0A=
=0A=
We saw hangs and heavy lock contention in the wbt code under a specific=0A=
workload, on XFS. Crash dump analysis showed the following issues:=0A=
=0A=
1) wbt_done uses wake_up_all, which causes a thundering herd=0A=
2) __wbt_wait sets up a wait queue with the auto remove wake function=0A=
(via DEFINE_WAIT), which caused two problems:=0A=
   * combined with the use of wake_up_all, the wait queue would=0A=
essentially be randomly reordered for tasks that did not get to run=0A=
   * the waitqueue_active check in may_queue was not valid with the auto=0A=
remove function, which could lead incoming tasks with requests to=0A=
overtake existing requests=0A=
=0A=
1) was fixed by using a plain wake_up=0A=
2) was fixed by keeping tasks on the queue until they could break out of=0A=
the wait loop in __wbt_wait=0A=
=0A=
=0A=
The random reordering, causing task starvation in __wbt_wait, was the=0A=
main problem. Simply not using the auto remove wait function, e.g.=0A=
*only* changing DEFINE_WAIT(wait) to DEFINE_WAIT_FUNC(wait,=0A=
default_wake_function), fixed the hang / task starvation issue in our=0A=
tests. But there was still more lock contention than there should be, so=0A=
we also changed wake_up_all to wake_up.=0A=
=0A=
It might be useful to run your tests with only the DEFINE_WAIT change I=0A=
describe above added to the original code to see if that still has any=0A=
problems. That would give a good datapoint whether any remaining issues=0A=
are due to missed wakeups or not.=0A=
=0A=
There is the issue of making forward progress, or at least making it=0A=
fast enough. With the changes as they stand now, you could come up with=0A=
a scenario where the throttling limit is hit, but then is raised. Since=0A=
there might still be a wait queue, you could end up putting each=0A=
incoming task to sleep, even though it's not needed.=0A=
=0A=
One way to guarantee that the wait queue clears up as fast as possible,=0A=
without resorting to wakeup_all, is to use wakeup_nr, where the number=0A=
of tasks to wake up is (limit - inflight).=0A=
=0A=
Also, to avoid having tasks going back to sleep in the loop, you could=0A=
do what you already proposed - always just sleep at most once, and=0A=
unconditionally proceed after waking up. To avoid incoming tasks=0A=
overtaking the ones that are being woken up, you could have wbt_done=0A=
increment inflight, effectively reserving a spot for the tasks that are=0A=
about to be woken up.=0A=
=0A=
Another thing I thought about was recording the number of waiters in the=0A=
wait queue, and modify the check from (inflight < limit) to (inflight <=0A=
(limit - nwaiters)), and no longer use any waitqueue_active checks.=0A=
=0A=
The condition checks are of course complicated by the fact that=0A=
condition manipulation is not always done under the same lock (e.g.=0A=
wbt_wait can be called with a NULL lock).=0A=
=0A=
=0A=
So, these are just some of the things to consider here - maybe there's=0A=
nothing in there that you hadn't already considered, but I thought it'd=0A=
be useful to summarize them.=0A=
=0A=
Thanks for looking in to this!=0A=
=0A=
Frank=0A=
=0A=
=0A=
