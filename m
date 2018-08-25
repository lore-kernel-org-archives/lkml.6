Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E74C208A5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 05:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E74C208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeHYJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 05:32:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55433 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbeHYJcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 05:32:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A7949C5CCD81;
        Sat, 25 Aug 2018 13:54:08 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Sat, 25 Aug 2018
 13:54:09 +0800
Subject: Re: [f2fs-dev] [RFC PATCH 10/10] f2fs: fs-verity support
To:     Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-11-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b2b6a810-9605-15c8-b905-a4591c0cf3a5@huawei.com>
Date:   Sat, 25 Aug 2018 13:54:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824161642.1144-11-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/25 0:16, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>  #ifdef CONFIG_F2FS_CHECK_FS
>  #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
>  #else
> @@ -146,7 +149,7 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_QUOTA_INO		0x0080
>  #define F2FS_FEATURE_INODE_CRTIME	0x0100
>  #define F2FS_FEATURE_LOST_FOUND		0x0200
> -#define F2FS_FEATURE_VERITY		0x0400	/* reserved */
> +#define F2FS_FEATURE_VERITY		0x0400
>  
>  #define F2FS_HAS_FEATURE(sb, mask)					\
>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -598,7 +601,7 @@ enum {
>  #define FADVISE_ENC_NAME_BIT	0x08
>  #define FADVISE_KEEP_SIZE_BIT	0x10
>  #define FADVISE_HOT_BIT		0x20
> -#define FADVISE_VERITY_BIT	0x40	/* reserved */
> +#define FADVISE_VERITY_BIT	0x40

As I suggested before, how about moving f2fs' verity_bit from i_fadvise to more
generic i_flags field like ext4, so we can a) remaining more bits for those
demands which really need file advise fields. b) using i_flags bits keeping line
with ext4. Not sure, if user want to know whether the file is verity one, it
will be easy for f2fs to export the status through FS_IOC_SETFLAGS.

#define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */

#define F2FS_VERITY_FL			0x00100000 /* Verity protected inode */

Thanks,

