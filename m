Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95063C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BAD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mo0zyB3S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mo0zyB3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BAD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeKGPuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:50:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeKGPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:50:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E382060A9B; Wed,  7 Nov 2018 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541571672;
        bh=hpuARF5Ld5ls4wve5IbIhIkQPc219aUgwsVT4sSlYMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mo0zyB3SyKC2RBs+A7NCmWI+8/KK+F+K3FM8hMhKgnWlTm+fDiEP+qza6asDM9BRa
         c44UPcwQwGtPV513bsFhqDkti284i1AmILe5fCpGHkM5kANnkqsSkrp3tJX433MYPC
         1iL2ITWTnIeOX7dUL7isDUqvNjfbupyNdyeDgB48=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 35854601D4;
        Wed,  7 Nov 2018 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541571672;
        bh=hpuARF5Ld5ls4wve5IbIhIkQPc219aUgwsVT4sSlYMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mo0zyB3SyKC2RBs+A7NCmWI+8/KK+F+K3FM8hMhKgnWlTm+fDiEP+qza6asDM9BRa
         c44UPcwQwGtPV513bsFhqDkti284i1AmILe5fCpGHkM5kANnkqsSkrp3tJX433MYPC
         1iL2ITWTnIeOX7dUL7isDUqvNjfbupyNdyeDgB48=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Nov 2018 11:51:12 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v6 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181106200823.GT27423@dhcp22.suse.cz>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <20181106140638.GN27423@dhcp22.suse.cz>
 <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
 <20181106200823.GT27423@dhcp22.suse.cz>
Message-ID: <5e55c6e64a2bfd6eed855ea17a34788b@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 01:38, Michal Hocko wrote:
> On Tue 06-11-18 21:01:29, Arun KS wrote:
>> On 2018-11-06 19:36, Michal Hocko wrote:
>> > On Tue 06-11-18 11:33:13, Arun KS wrote:
>> > > When free pages are done with higher order, time spend on
>> > > coalescing pages by buddy allocator can be reduced. With
>> > > section size of 256MB, hot add latency of a single section
>> > > shows improvement from 50-60 ms to less than 1 ms, hence
>> > > improving the hot add latency by 60%. Modify external
>> > > providers of online callback to align with the change.
>> > >
>> > > This patch modifies totalram_pages, zone->managed_pages and
>> > > totalhigh_pages outside managed_page_count_lock. A follow up
>> > > series will be send to convert these variable to atomic to
>> > > avoid readers potentially seeing a store tear.
>> >
>> > Is there any reason to rush this through rather than wait for counters
>> > conversion first?
>> 
>> Sure Michal.
>> 
>> Conversion patch, https://patchwork.kernel.org/cover/10657217/ is 
>> currently
>> incremental to this patch.
> 
> The ordering should be other way around. Because as things stand with
> this patch first it is possible to introduce a subtle race prone
> updates. As I've said I am skeptical the race would matter, really, but
> there is no real reason to risk for that. Especially when you have the
> other (first) half ready.

Makes sense. I have rebased the preparatory patch on top of -rc1.
https://patchwork.kernel.org/patch/10670787/

Regards,
Arun
