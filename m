Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E5F20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E5F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeH1NF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:05:57 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:38162 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH1NF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:05:57 -0400
Received: from [109.168.11.45] (port=57182 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fua5H-00GEy8-MY; Tue, 28 Aug 2018 11:14:47 +0200
Subject: Re: [PATCH v6 1/2] media: imx274: use regmap_bulk_write to write
 multybyte registers
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180725162455.31381-1-luca@lucaceresoli.net>
 <20180725162455.31381-2-luca@lucaceresoli.net>
 <20180828090300.GA23579@frolo.macqel>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <9ed69bb8-ff2c-76bb-faef-71c06e96877b@lucaceresoli.net>
Date:   Tue, 28 Aug 2018 11:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828090300.GA23579@frolo.macqel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

thanks for you review.

On 28/08/2018 11:03, Philippe De Muyter wrote:
> On Wed, Jul 25, 2018 at 06:24:54PM +0200, Luca Ceresoli wrote:
>> Currently 2-bytes and 3-bytes registers are set by very similar
>> functions doing the needed shift & mask manipulation, followed by very
>> similar for loops setting one byte at a time over I2C.
>>
>> Replace all of this code by a unique helper function that calls
>> regmap_bulk_write(), which has two advantages:
>>  - sets all the bytes in a unique I2C transaction
>>  - removes lots of now unused code.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>
> ...
>> +/**
>> + * Write a multibyte register.
>> + *
>> + * Uses a bulk write where possible.
>> + *
>> + * @priv: Pointer to device structure
>> + * @addr: Address of the LSB register.  Other registers must be
>> + *        consecutive, least-to-most significant.
>> + * @val: Value to be written to the register (cpu endianness)
>> + * @nbytes: Number of bits to write (range: [1..3])
>> + */
>> +static int imx274_write_mbreg(struct stimx274 *priv, u16 addr, u32 val,
>> +			      size_t nbytes)
> 
> Should nbytes be called nbits, or is nbytes a 'Number of bytes' ?

This patch has already been applied, but I sent a fix:
https://patchwork.linuxtv.org/patch/51719/

-- 
Luca
