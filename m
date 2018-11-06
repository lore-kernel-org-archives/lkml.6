Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860ECC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E22081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fn9RoCgD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fn9RoCgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E22081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeKGA5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:57:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKGA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:57:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE8F0605A2; Tue,  6 Nov 2018 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541518289;
        bh=dJCLvK0/kguUHSD0MooRrNkFPab6Uj49lc3hhpL3PqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fn9RoCgDZGU3rAT3J6hJdjbhDn7wJPoWnOQndF3XtskUi4ZvfqhfdFKXtbJmVELhn
         pgwpGSfghWx1HPen1mL+uRNCgC3qszOI7Yz19nOfM/098UhKjOUCZfm+Zfu7/KjmPL
         fOPxk3ruwlbHh7+hyiUTdaNz8jHUSwVjnOgEIpvo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 64E9C601D7;
        Tue,  6 Nov 2018 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541518289;
        bh=dJCLvK0/kguUHSD0MooRrNkFPab6Uj49lc3hhpL3PqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fn9RoCgDZGU3rAT3J6hJdjbhDn7wJPoWnOQndF3XtskUi4ZvfqhfdFKXtbJmVELhn
         pgwpGSfghWx1HPen1mL+uRNCgC3qszOI7Yz19nOfM/098UhKjOUCZfm+Zfu7/KjmPL
         fOPxk3ruwlbHh7+hyiUTdaNz8jHUSwVjnOgEIpvo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Nov 2018 21:01:29 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v6 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181106140638.GN27423@dhcp22.suse.cz>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <20181106140638.GN27423@dhcp22.suse.cz>
Message-ID: <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 19:36, Michal Hocko wrote:
> On Tue 06-11-18 11:33:13, Arun KS wrote:
>> When free pages are done with higher order, time spend on
>> coalescing pages by buddy allocator can be reduced. With
>> section size of 256MB, hot add latency of a single section
>> shows improvement from 50-60 ms to less than 1 ms, hence
>> improving the hot add latency by 60%. Modify external
>> providers of online callback to align with the change.
>> 
>> This patch modifies totalram_pages, zone->managed_pages and
>> totalhigh_pages outside managed_page_count_lock. A follow up
>> series will be send to convert these variable to atomic to
>> avoid readers potentially seeing a store tear.
> 
> Is there any reason to rush this through rather than wait for counters
> conversion first?

Sure Michal.

Conversion patch, https://patchwork.kernel.org/cover/10657217/ is 
currently incremental to this patch. I ll change the order. Will wait 
for preparatory patch to settle first.

Regards,
Arun.

> 
> The patch as is looks good to me - modulo atomic counters of course. I
> cannot really judge whether existing updaters do really race in 
> practice
> to take this riskless.
> 
> The improvement is nice of course but this is a rare operation and 50ms
> vs 1ms is hardly noticeable. So I would rather wait for the preparatory
> work to settle. Btw. is there anything blocking that? It seems to be
> mostly automated.
