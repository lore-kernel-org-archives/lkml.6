Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD2DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C620A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392998AbfBMR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:26:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53256 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbfBMR0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:26:08 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 622191B4058;
        Thu, 14 Feb 2019 02:19:30 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x1DHJTBv019927
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 02:19:30 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x1DHJSl8013024
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 02:19:28 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x1DHJSRo013023;
        Thu, 14 Feb 2019 02:19:28 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hou Tao <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fat: enable .splice_write to support splice on O_DIRECT file
References: <20190210094754.56355-1-houtao1@huawei.com>
        <871s4b7gkj.fsf@mail.parknet.co.jp>
Date:   Thu, 14 Feb 2019 02:19:28 +0900
In-Reply-To: <871s4b7gkj.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
        "Thu, 14 Feb 2019 02:18:20 +0900")
Message-ID: <87wom361y7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Hou Tao <houtao1@huawei.com> writes:
>
>> Now splice() on O_DIRECT-opened fat file will return -EFAULT, that is
>> because the default .splice_write, namely default_file_splice_write(),
>> will construct an ITER_KVEC iov_iter and dio_refill_pages() in dio path
>> can not handle it.
>>
>> Fix it by implementing .splice_write through iter_file_splice_write().
>>
>> Spotted by xfs-tests generic/091.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  fs/fat/file.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/fat/file.c b/fs/fat/file.c
>> index 13935ee99e1e..b3bed32946b1 100644
>> --- a/fs/fat/file.c
>> +++ b/fs/fat/file.c
>> @@ -214,6 +214,7 @@ const struct file_operations fat_file_operations = {
>>  #endif
>>  	.fsync		= fat_file_fsync,
>>  	.splice_read	= generic_file_splice_read,
>> +	.splice_write	= iter_file_splice_write,
>>  	.fallocate	= fat_fallocate,
>>  };
>
> Looks good.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Thanks.

Forgot to include akpm to addresses.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
