Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6472147D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 07:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6472147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHYLW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:22:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbeHYLW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:22:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E8A517F48374;
        Sat, 25 Aug 2018 15:44:46 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.399.0; Sat, 25 Aug
 2018 15:44:43 +0800
Subject: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
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
 <20180825041647.GA726@sol.localdomain>
 <21e86199-28a7-4693-aef5-5fc28842535c@huawei.com>
 <20180825071827.GD726@sol.localdomain>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c907ad1d-c7c8-714a-0e59-373c1df3afe8@huawei.com>
Date:   Sat, 25 Aug 2018 15:43:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180825071827.GD726@sol.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2018/8/25 15:18, Eric Biggers wrote:
> We do have to be very careful here, but the same restriction already exists with
> fscrypt which both f2fs and ext4 already support too.  With fscrypt, each page
> is decrypted with the key from page->mapping->host->i_crypt_info and the
> initialization vector from page->index.  With fs-verity, each page is verified
> using the Merkle tree state from page->mapping->host->i_verify_info and the
> block location from page->index.  So, they are very similar.
> 
> On f2fs, any pages submitted via META_MAPPING just skip both fscrypt and
> fs-verity since the "meta_inode" doesn't have either feature enabled.  That's
> done intentionally, so that garbage collection can move the blocks on-disk.
> Regular reads aren't done via META_MAPPING.
> 

I think you deal with the existed cases quite well, I was just thinking about EROFS... :)

> I don't know of any plan to use fs-verity on Android's system partition or to
> replace dm-verity on the system partition.  The use cases so far have been
> verifying files on /data, like APK files.
> 
> So I don't think you need to support fs-verity in EROFS.
> 

Thanks for your information about fs-verity, that is quite useful for us
Actually, I was worrying about that these months...  :)

> Re: the compression, I don't see how it would be much of a problem (even if you
> did need or want to add fs-verity support).  Assuming that the verification is
> done over the uncompressed version of the data, you wouldn't verify the pages
> directly from the bio's page list since those would contain compressed data.
> But even without fs-verity you'd need to decompress the data into pagecache
> pages... so you could just call fsverity_verify_page() on each of those
> decompressed pages before unlocking them and setting them Uptodate.  You don't
> *have* to call fsverity_verify_bio() to do the verification; it's just a helper
> for the case where the list of pages to verify happens to be in a completed bio.
> 

I haven't look into all patches, I will look into that carefully if I finish my current job.
It is wonderful to have such a helper --- fsverity_verify_page :)

I have no other problem currently, and look forward for your final implementation.

Best Regards,
Gao Xiang

> - Eric
