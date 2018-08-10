Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE35C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB43222404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uB6q56oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB43222404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHJWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:37:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57377 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:37:49 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2018 18:37:48 EDT
Received: from pb-smtp21.pobox.com (unknown [10.110.30.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPS id E2A47104006;
        Fri, 10 Aug 2018 16:00:19 -0400 (EDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39E5C20870;
        Fri, 10 Aug 2018 16:00:19 -0400 (EDT)
        (envelope-from nico@linaro.org)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=mRby9ClM1gS/bMYRoI7CFyEeIa4=; b=uB6q56
        oocOFqHyk8SGfrh3iQ4qsKXmRc9L31jegoDo8i0wogS12pwfSEPXUIuMmbbhNryw
        eaPPBx6mHJzFWdIdC4p46MAPex6H9Oim8TYgq+VOwlMMC9u6IoWyUhh2mIX6EKlQ
        ff8whOM02Qa9cSR/ctHkNuExfT39405wmELsw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 315B82086F;
        Fri, 10 Aug 2018 16:00:19 -0400 (EDT)
        (envelope-from nico@linaro.org)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B0CA2086B;
        Fri, 10 Aug 2018 16:00:15 -0400 (EDT)
        (envelope-from nico@linaro.org)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id F42052DA000B;
        Fri, 10 Aug 2018 16:00:12 -0400 (EDT)
Date:   Fri, 10 Aug 2018 16:00:12 -0400 (EDT)
From:   Nicolas Pitre <nico@linaro.org>
To:     Jeff Lien <jeff.lien@wdc.com>
cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <nycvar.YSQ.7.76.1808101550460.13885@knanqh.ubzr>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FF57031A-9CD7-11E8-9920-CC883AD79A78-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018, Jeff Lien wrote:

> This patch provides a performance improvement for the CRC16 calculations done in read/write
> workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> with a larger CRC table to match.  The result has shown 5x performance improvements on various
> big endian and little endian systems running the 4.18.0 kernel version.

You are nevertheless increasing the kernel size by 7.5 KB.

Could the small table still be preserved with a config option for those 
who require small more than fast?

That could look like:

static const __u16 t10_dif_crc_table[][256] = {
	{
	[...]
	},
#ifndef CONFIG_CRC16_SMALL
	{
	[...]
	[...]
	},
#endif
};

and the code to suit.


Nicolas
