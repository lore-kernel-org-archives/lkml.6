Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70720208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70720208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeH0TVU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:21:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbeH0TVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99ECD40241D8;
        Mon, 27 Aug 2018 15:34:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B0EF10EE821;
        Mon, 27 Aug 2018 15:34:13 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] xfs: Prevent multiple wakeups of the same log
 space waiter
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
 <1535316795-21560-3-git-send-email-longman@redhat.com>
 <20180827002134.GE2234@dastard>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c4ecb0d3-843b-3d9b-d7e0-acda77881f3a@redhat.com>
Date:   Mon, 27 Aug 2018 11:34:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180827002134.GE2234@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 15:34:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 15:34:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/26/2018 08:21 PM, Dave Chinner wrote:
> On Sun, Aug 26, 2018 at 04:53:14PM -0400, Waiman Long wrote:
>> The current log space reservation code allows multiple wakeups of the
>> same sleeping waiter to happen. This is a just a waste of cpu time as
>> well as increasing spin lock hold time. So a new XLOG_TIC_WAKING flag is
>> added to track if a task is being waken up and skip the wake_up_process()
>> call if the flag is set.
>>
>> Running the AIM7 fserver workload on a 2-socket 24-core 48-thread
>> Broadwell system with a small xfs filesystem on ramfs, the performance
>> increased from 91,486 jobs/min to 192,666 jobs/min with this change.
> Oh, I just noticed you are using a ramfs for this benchmark,
>
> tl; dr: Once you pass a certain point, ramdisks can be *much* slower
> than SSDs on journal intensive workloads like AIM7. Hence it would be
> useful to see if you have the same problems on, say, high
> performance nvme SSDs.

Oh sorry, I made a mistake.

There were some problems with my test configuration. I was actually
running the test on a regular enterprise-class disk device mount on /.

Filesystem                              1K-blocks     Used Available
Use% Mounted on
/dev/mapper/rhel_hp--xl420gen9--01-root  52403200 11284408  41118792  22% /

It was not an SSD, nor ramdisk. I reran the test on ramdisk, the
performance of the patched kernel was 679,880 jobs/min which was a bit
more than double the 285,221 score that I got on a regular disk.

So the filesystem used wasn't tiny, though it is still not very large.
The test was supposed to create 16 ramdisks and distribute the test
tasks to the ramdisks. Instead, they were all pounding on the same
filesystem worsening the spinlock contention problem.

Cheers,
Longman

