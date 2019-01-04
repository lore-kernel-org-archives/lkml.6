Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7195C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF5E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HVy+nOQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nzjVoyEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfADFGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:06:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfADFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:06:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 396BF6081B; Fri,  4 Jan 2019 05:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546578359;
        bh=p4hYRBMBz5M+YHHn8pLZuYvTovLuqvtKmAsC8TbXY5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVy+nOQr9jgSZ+axTEZDpTVcKnKsASg7fgjT5HYmJJ9uE0y8D7Qfr5/TEs5bnhrIP
         PVYN/v1cwm4UpA10IdZ+EyedDYfen1zWIt+QfXJid7LwBzRoxVXOsnK34sRk+2ghHu
         iZLounFmFXEc9cTCZ3/BC15Wm5KIyHNBGNNKWWuE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7A3876034F;
        Fri,  4 Jan 2019 05:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546578358;
        bh=p4hYRBMBz5M+YHHn8pLZuYvTovLuqvtKmAsC8TbXY5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nzjVoyEg0Sbhq0M0WQNRpfqqxHb8+ABjG+E9JKZLvuvHNJIEYrWOU9QRShN98AI14
         JtSVHwAHICLE+VdvCn2Nl5LPIQJGSZkmHs6HuFDJVfG+ksNYK0uWFjCm8J18L8ZRC1
         Vw776a70RVUdHW+h37RJWSia8Vullf7XPu29PCXc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 10:35:58 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v6 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <5e55c6e64a2bfd6eed855ea17a34788b@codeaurora.org>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <20181106140638.GN27423@dhcp22.suse.cz>
 <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
 <20181106200823.GT27423@dhcp22.suse.cz>
 <5e55c6e64a2bfd6eed855ea17a34788b@codeaurora.org>
Message-ID: <40a4d5154fbd0006fbe55eb68703bb65@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 11:51, Arun KS wrote:
> On 2018-11-07 01:38, Michal Hocko wrote:
>> On Tue 06-11-18 21:01:29, Arun KS wrote:
>>> On 2018-11-06 19:36, Michal Hocko wrote:
>>> > On Tue 06-11-18 11:33:13, Arun KS wrote:
>>> > > When free pages are done with higher order, time spend on
>>> > > coalescing pages by buddy allocator can be reduced. With
>>> > > section size of 256MB, hot add latency of a single section
>>> > > shows improvement from 50-60 ms to less than 1 ms, hence
>>> > > improving the hot add latency by 60%. Modify external
>>> > > providers of online callback to align with the change.
>>> > >
>>> > > This patch modifies totalram_pages, zone->managed_pages and
>>> > > totalhigh_pages outside managed_page_count_lock. A follow up
>>> > > series will be send to convert these variable to atomic to
>>> > > avoid readers potentially seeing a store tear.
>>> >
>>> > Is there any reason to rush this through rather than wait for counters
>>> > conversion first?
>>> 
>>> Sure Michal.
>>> 
>>> Conversion patch, https://patchwork.kernel.org/cover/10657217/ is 
>>> currently
>>> incremental to this patch.
>> 
>> The ordering should be other way around. Because as things stand with
>> this patch first it is possible to introduce a subtle race prone
>> updates. As I've said I am skeptical the race would matter, really, 
>> but
>> there is no real reason to risk for that. Especially when you have the
>> other (first) half ready.
> 
> Makes sense. I have rebased the preparatory patch on top of -rc1.
> https://patchwork.kernel.org/patch/10670787/

Hello Michal,

Please review version 7 sent,
https://lore.kernel.org/patchwork/patch/1028908/

Regards,
Arun
> 
> Regards,
> Arun
