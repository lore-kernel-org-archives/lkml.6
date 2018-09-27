Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3F21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ehuk.net header.i=@ehuk.net header.b="Yplx7gBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED3F21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehuk.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeI0WSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:18:42 -0400
Received: from schatzi.steelbluetech.co.uk ([92.63.139.240]:20293 "EHLO
        schatzi.steelbluetech.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbeI0WSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:18:41 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 18:18:41 EDT
Received: from [10.0.5.25] (tv.ehuk.net [10.0.5.25])
        by schatzi.steelbluetech.co.uk (Postfix) with ESMTP id 38930BFD9D;
        Thu, 27 Sep 2018 16:53:07 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 schatzi.steelbluetech.co.uk 38930BFD9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ehuk.net; s=default;
        t=1538063587; bh=WNEFfHpCfyRzcbusg4oaXRZRRFlQ4V1L/pGtXbDijko=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=Yplx7gBgq+WvL/cmCZ+hWrQoa1cPMGXTDGswt/yPq7c2qIWhZaFim/nZYYtQQUkHb
         UwqVKDSxcFDiVi9tUlnqEHCKN6JKcS7cqKRD9xQb0tDE/lfAYbziNBPUNxTTyaM2U/
         8genTI1YdA2YHv2WC0K+Cvxc9SS8ppLiI3nVEHiY=
Subject: Re: [PATCH] bcache: add separate workqueue for journal_write to avoid
 deadlock
To:     Coly Li <colyli@suse.de>, guoju <fangguoju@gmail.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
 <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
From:   Eddie Chapman <eddie@ehuk.net>
Reply-To: Eddie Chapman <eddie@ehuk.net>
Message-ID: <9b1abe65-c6f5-77b4-290e-e6af21723cfc@ehuk.net>
Date:   Thu, 27 Sep 2018 16:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bda92f58-d321-d4db-c73f-0ceecbfd9c38@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 16:23, Coly Li wrote:
> 
> On 9/27/18 9:45 PM, guoju wrote:
>> After write SSD completed, bcache schedule journal_write work to
>> system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM
>> flag. system_wq is also a bound wq, and there may be no idle kworker on
>> current processor. Creating a new kworker may unfortunately need to
>> reclaim memory first, by shrinking cache and slab used by vfs, which
>> depends on bcache device. That's a deadlock.
>>
>> This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
>> flag. It's rescuer thread will work to avoid the deadlock.
>>
>> Signed-off-by: guoju <fangguoju@gmail.com>
> 
> Nice catch, this fix is quite important. I will try to submit to Jens ASAP.
> 
> Thanks.
> 
> Coly Li

Once this goes into 4.19, would this be a candidate for backporting to 
any stable kernels, or does it only fix something introduced in this cycle?

thanks,
Eddie
