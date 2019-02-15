Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1882AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92D12192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550195825;
	bh=4K53UDdx78F4UBGvMl07QBDfjh5AmGkqdyuCcnG32+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2eZ2yq83rlaJLgTYkk+UKgzbpt29YPoVOK2CG3V1Bo+kBU56ljZQyZEgqsUEWPPeI
	 vtlfHMhhMoF6pEHxAC1TVpKhe8BglLa9W4hQwMdBnRbM9ZY5StaApqr/giZOmxqCC+
	 UjCyE1boVGc4tiOKiAZSu+IbkxQdA+jkyExuoxCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfBOB5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfBOB5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:57:04 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6242B2192D;
        Fri, 15 Feb 2019 01:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550195823;
        bh=4K53UDdx78F4UBGvMl07QBDfjh5AmGkqdyuCcnG32+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyWi2AA5GdgLm1MjJaLnfpjQdPhEWOolfUC3hgm/yv+5ZM2v5MGKs/2mWSeCMeLd7
         dtTCxfJMUuJIj4fdkHOkeWczIeAZnLlv+VnwZkJ8LJgnP+YFGd+NTf9gZh8Z3EsBRi
         AIl9Agtvvt5JwpAcNNKkrDYZd9oPHRZu3yBlK6HI=
Date:   Thu, 14 Feb 2019 20:57:02 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Message-ID: <20190215015702.GL69686@sasha-vm>
References: <20190117043759.GA3395@ubu-Virtual-Machine>
 <20190204071309.GA3470@ubu-Virtual-Machine>
 <DM5PR2101MB091863AD0DEF25395352BF98D76D0@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB091863AD0DEF25395352BF98D76D0@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:25:34PM +0000, Michael Kelley wrote:
>From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Sunday, February 3, 2019 11:13 PM
>>
>> Counter values for per-channel interrupts and ring buffer full
>> conditions are useful for investigating performance.
>>
>> Expose counters in sysfs for 2 types of guest to host interrupts:
>> 1) Interrupts caused by the channel's outbound ring buffer transitioning
>> from empty to not empty
>> 2) Interrupts caused by the channel's inbound ring buffer transitioning
>> from full to not full while a packet is waiting for enough buffer space to
>> become available
>>
>> Expose 2 counters in sysfs for the number of times that write operations
>> encountered a full outbound ring buffer:
>> 1) The total number of write operations that encountered a full
>> condition
>> 2) The number of write operations that were the first to encounter a
>> full condition
>>
>> Increment the outbound full condition counters in the
>> hv_ringbuffer_write() function because, for most drivers, a full
>> outbound ring buffer is detected in that function. Also increment the
>> outbound full condition counters in the set_channel_pending_send_size()
>> function. In the hv_sock driver, a full outbound ring buffer is detected
>> and set_channel_pending_send_size() is called before
>> hv_ringbuffer_write() is called.
>>
>> I tested this patch by confirming that the sysfs files were created and
>> observing the counter values. The values seemed to increase by a
>> reasonable amount when the Hyper-v related drivers were in use.
>>
>> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
>> ---
>>
>Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

Queued for hyperv-next, thanks Kimberly!

--
Thanks,
Sasha
