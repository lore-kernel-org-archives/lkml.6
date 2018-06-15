Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B059C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12174208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12174208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=icdsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbeFOTiK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:38:10 -0400
Received: from us.icdsoft.com ([192.252.146.184]:50662 "EHLO us.icdsoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965768AbeFOTiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:38:08 -0400
Received: (qmail 6326 invoked by uid 1001); 15 Jun 2018 19:38:08 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 15 Jun 2018 19:38:08 -0000
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
 <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
 <20180615154140.GV1351649@devbig577.frc2.facebook.com>
 <1d635d1d-6152-ecfc-d235-147ff1fe7c95@icdsoft.com>
 <20180615161647.GW1351649@devbig577.frc2.facebook.com>
 <6c2c9bfb-3175-b9ec-cf39-c9d4ebf654b2@icdsoft.com>
 <20180615190724.GX1351649@devbig577.frc2.facebook.com>
From:   Ivan Zahariev <famzah@icdsoft.com>
Message-ID: <d2c7a301-1d89-7019-8fca-3f34c853ce1a@icdsoft.com>
Date:   Fri, 15 Jun 2018 22:38:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615190724.GX1351649@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-bg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On 15.6.2018 г. 22:07 ч., Tejun Heo wrote:
> On Fri, Jun 15, 2018 at 08:40:02PM +0300, Ivan Zahariev wrote:
>> The lazy pids accounting + modern fast CPUs makes the "pids.current"
>> metric practically unusable for resource limiting in our case. For a
>> test, when we started and ended one single process very quickly, we
>> saw "pids.current" equal up to 185 (while the correct value at all
>> time is either 0 or 1). If we want that a "cgroup" can spawn maximum
>> 50 processes, we should use some high value like 300 for "pids.max",
>> in order to compensate the pids uncharge lag (and this depends on
>> the speed of the CPU and how busy the system is).
> Yeah, that actually makes a lot of sense.  We can't keep everything
> synchronous for obvious performance reasons but we definitely can wait
> for RCU grace period before failing.  Forking might become a bit
> slower while pids are draining but shouldn't fail and that shouldn't
> incur any performance overhead in normal conditions when pids aren't
> constrained.

I lack expertise to comment on this. As a system administrator, I can 
only remind that nowadays machines with 80+ CPU cores are something 
usual. I don't know how the RCU grace period scales with an increasing 
number of CPUs.

If you develop a patch for this, we can try it in production and give 
you feedback. Just send me an email notification.

Thank you for your time and attention!

--
Ivan
