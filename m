Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A3C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0127C9C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC0127C9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=candelatech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936550AbeF2TBJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:01:09 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:33460 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbeF2TBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:01:07 -0400
Received: from [192.168.100.149] (firewall.candelatech.com [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail2.candelatech.com (Postfix) with ESMTPSA id 78D4440A626;
        Fri, 29 Jun 2018 12:01:04 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: use IDA to allocate wiphy indeces
To:     Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20180621012945.185705-1-briannorris@chromium.org>
 <1530258140.3481.4.camel@sipsolutions.net>
 <20180629184847.GA251207@ban.mtv.corp.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <278cfd54-204b-2ff7-a8d2-575a01151667@candelatech.com>
Date:   Fri, 29 Jun 2018 12:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <20180629184847.GA251207@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 11:48 AM, Brian Norris wrote:
> Hi Johannes,
>
> On Fri, Jun 29, 2018 at 09:42:20AM +0200, Johannes Berg wrote:
>> On Wed, 2018-06-20 at 18:29 -0700, Brian Norris wrote:
>>> It's annoying to see the phy index increase arbitrarily, just because a
>>> device got removed and re-probed (e.g., during a device reset, or due to
>>> probe testing). We can use the in-kernel index allocator for this,
>>> instead of just an increasing counter.
>>
>> I can understand that it's somewhat annoying to people, but it was
>> actually done on purpose to avoid userspace talking to the wrong device.
>
> Hmm, interesting. I'm not dead-set on this patch, so if there are good
> reasons to reject it, I won't fret.
>
>> Imagine you have some userspace process running that has remembered the
>> wiphy index to use it to talk to nl80211, and now underneath the device
>> goes away and reappears. This process should understand that situation,
>> and handle it accordingly, rather than being blind to the reset.
>
> How is this different from the wlan (netdev) device naming? We allow
> 'wlan0' to leave and return under the same name. Isn't the right answer
> that user space should be listening for udev and/or netlink events?
>
> Brian
>

For what it is worth, we use udev to rename the phyX to wiphyZ devices based on
their MAC address, and that seems to work OK.

I can't think of any reason why user-space would need the phy index number
to increase as modules are loaded/unloaded though.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

