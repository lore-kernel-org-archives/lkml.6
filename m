Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D10C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB472098B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 04:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB472098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeHYHjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 03:39:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeHYHjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 03:39:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 160A4DA30EA79;
        Sat, 25 Aug 2018 12:01:51 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.399.0; Sat, 25 Aug
 2018 12:01:51 +0800
Subject: Re: [f2fs-dev] [RFC PATCH 02/10] fs-verity: add data verification
 hooks for ->readpages()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
 <20180825034544.GA5281@thunk.org>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <cb646950-94ea-9b28-80f1-3c840ad85581@huawei.com>
Date:   Sat, 25 Aug 2018 12:00:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180825034544.GA5281@thunk.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On 2018/8/25 11:45, Theodore Y. Ts'o wrote:
> On Sat, Aug 25, 2018 at 10:29:26AM +0800, Gao Xiang wrote:
>> My first question is that 'Is there any way to skip to verify pages in a bio?'
>> I am thinking about
>> If metadata and data page are mixed in a filesystem of such kind, they could submit together in a bio, but metadata could be unsuitable for such kind of verification.
>>
>> The second question is related to the first question --- 'Is there any way to verify a partial page?'
>> Take scalability into consideration, some files could be totally inlined or partially inlined in metadata.
>> Is there any way to deal with them in per-file approach? at least --- support for the interface?
> A requirement of both fscrypt and fsverity is that is that block size
> == page size, and that all data is stored in blocks.  Inline data is
> not supported.
> 
> The files that are intended for use with fsverity are large files
> (such as APK files), so optimizing for files smaller than a block was
> not a design goal.

Thanks for your quickly reply. :)

I had seen the background of why Google/Android introduces fs-verity before.

> 

But I have some consideration than the current implementation.... (if it is suitable to discuss, thanks...)

1) Since it is the libfs-like library, I think bio-strict is too strict for its future fs users.

bios could be already organized in filesystem-specific way, which could include some other pages that is unnecessary to be verified.

I could give some example, if some filesystem organizes its bios for decompression, and some data exist in metadata.
It could be hard to use this libfs-like fsverity interface.

2) My last question
"At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better....."

is also for some files partially or totally encoded (eg. compressed, or whatever ...)

I think the hash tree is unnecessary to be compressed...so I think it could be better that it can be selected by users (filesystems of course).

Thanks,
Gao Xiang.

> 					- Ted
