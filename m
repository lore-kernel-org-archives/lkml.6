Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A4C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C7206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0C7206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeIMOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:47:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44488 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeIMOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5475480D;
        Thu, 13 Sep 2018 02:39:13 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49373F575;
        Thu, 13 Sep 2018 02:39:11 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Brice Goglin <brice.goglin@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
 <4f253bf4-ef2d-849f-b793-9b0530e72aab@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c7e74980-eb5d-1b2a-8ebb-7210b4f507a2@arm.com>
Date:   Thu, 13 Sep 2018 10:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4f253bf4-ef2d-849f-b793-9b0530e72aab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brice,

On 13/09/18 06:51, Brice Goglin wrote:
> Le 12/09/2018 à 11:49, Sudeep Holla a écrit :
>>> Yes.  Without this change, we hit the lscpu error in the commit message,
>>> and get zero output about the system.  We don't even get information
>>> about the caches which are architecturally specified or how many cpus
>>> are present.  With this change, we get what we expect out of lscpu (and
>>> also lstopo) including the cache(s) which are not architecturally
>>> specified.
>>>
>> lscpu and lstopo are so broken. They just assume everything on CPU0.
>> If you hotplug them out, you start seeing issues. So reading and file
>> that doesn't exist and then bail out on other essential info though they
>> are present, hmmm ...
> 
> Can you elaborate?
> 
> I am not sure cpu0 is supposed to be offlineable on Linux. There's no
> "online" file in /sys/devices/system/cpu/cpu0. That's why former lstopo
> doesn't like CPU0 being hotplugged out. We are actually making that case
> work for another non-standard corner case. But offlining "cpu0" this is
> considered "normal", somebody must add that missing "online" sysfs
> attribute for "cpu0" (change
> https://elixir.bootlin.com/linux/latest/source/drivers/base/cpu.c#L375).

On x86 you can't normally offline CPU0, its something to do with certain
interrupts always being routed to CPU0, (oh, and hibernate).
You should be able to enable this behaviour with 'cpu0_hotplug' on the kernel
command line.

(Kconfig's CONFIG_BOOTPARAM_HOTPLUG_CPU0 and CONFIG_DEBUG_HOTPLUG_CPU0 are also
worth a look)


On arm64 at least, cpu0 is just like the others, and can be offlined.


Thanks,

James


> By the way, did anybody actually see an error with lstopo when there's
> no "type" attribute for L3? I can't reproduce any issue, we just skip
> that specific cache entirely, but everything else appears. If you guys
> want to make that "no_cache" cache appear, I'll make it a Unified cache
> unless you tell me what to show :)
