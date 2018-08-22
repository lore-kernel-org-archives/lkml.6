Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E44CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D9820C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D9820C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeHVQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:27:52 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:33432 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeHVQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:27:51 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 12:27:50 EDT
Received: from tux.wizards.de (p3EE2F932.dip0.t-ipconnect.de [62.226.249.50])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 0461941678B7;
        Wed, 22 Aug 2018 14:54:16 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 8831FF015F9;
        Wed, 22 Aug 2018 14:54:15 +0200 (CEST)
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To:     Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amazon.com>
Cc:     fllinden@amazon.com, sblbir@amazon.com, msw@amazon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
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
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
Date:   Wed, 22 Aug 2018 14:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/18 06:10, Jens Axboe wrote:
> [...]
> If you have time, please look at the 3 patches I posted earlier today.
> Those are for mainline, so should be OK :-)

I'm just playing along at home but with those 3 I get repeatable
hangs & writeback not starting at all, but curiously *only* on my btrfs
device; for inexplicable reasons some other devices with ext4/xfs flush
properly. Yes, that surprised me too, but it's repeatable.
Now this may or may not have something to do with some of my in-testing
patches for btrfs itself, but if I remove those 3 wbt fixes, everything
is golden again. Not eager to repeat since it hangs sync & requires a
hard reboot.. :(
Just thought you'd like to know.

-h
