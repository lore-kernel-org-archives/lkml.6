Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LfREkMXd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LfREkMXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BE520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbeKGPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:48:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeKGPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:48:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F004F6083C; Wed,  7 Nov 2018 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541571584;
        bh=HvpLavO+GmYf9GHLQ65PRFffMVWFQXEE/f33R+iPmMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LfREkMXdQzvQBxv/AnSTUnD6TeRc0bAYlgccZqCov+dCXpYJLXIx9Q2YeKRnYQTjH
         SBgQzv6l9h8pQpiNwlvqmQaUqSz+8XvrmSI/I5x51+IXlV4glRIxg+RJbfbN5OCX2w
         oC97fZZWHTK3+oJYNfBtcQo4L1H+R84RKMMafugw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3978A603D2;
        Wed,  7 Nov 2018 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541571584;
        bh=HvpLavO+GmYf9GHLQ65PRFffMVWFQXEE/f33R+iPmMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LfREkMXdQzvQBxv/AnSTUnD6TeRc0bAYlgccZqCov+dCXpYJLXIx9Q2YeKRnYQTjH
         SBgQzv6l9h8pQpiNwlvqmQaUqSz+8XvrmSI/I5x51+IXlV4glRIxg+RJbfbN5OCX2w
         oC97fZZWHTK3+oJYNfBtcQo4L1H+R84RKMMafugw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Nov 2018 11:49:44 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, mhocko@kernel.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/4]mm: convert totalram_pages, totalhigh_pages and
 managed pages to atomic
In-Reply-To: <20181106162206.0f43c1eb16c3dd812bdadbdd@linux-foundation.org>
References: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
 <20181106162206.0f43c1eb16c3dd812bdadbdd@linux-foundation.org>
Message-ID: <33a9d26369468824e27de5a636e4e843@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 05:52, Andrew Morton wrote:
> On Fri, 26 Oct 2018 16:30:58 +0530 Arun KS <arunks@codeaurora.org> 
> wrote:
> 
>> This series convert totalram_pages, totalhigh_pages and
>> zone->managed_pages to atomic variables.
> 
> The whole point appears to be removal of managed_page_count_lock, yes?
> 
> Why?  What is the value of this patchset?  If "performance" then are 
> any
> measurements available?

Hello Andrew,

https://patchwork.kernel.org/patch/10670787/
In version 2, I have added motivation behind this conversion. Pasting 
same here,

totalram_pages, zone->managed_pages and totalhigh_pages updates are 
protected by managed_page_count_lock, but readers never care about it. 
Convert these variables to atomic to avoid readers potentially seeing a 
store tear. I don't think we have a performance improvement here.

Regards,
Arun
