Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D53B1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C47208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jcline.org header.i=@jcline.org header.b="TDbeVzD6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fM2TuIMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C47208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jcline.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755351AbeFNSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:50:11 -0400
Received: from a8-62.smtp-out.amazonses.com ([54.240.8.62]:56338 "EHLO
        a8-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754833AbeFNSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rdybrs3533vx7mghocfwl3vdwgpl2v5u; d=jcline.org; t=1529002207;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=aJM6G6VTY0HULsySyBvg9tXsStvxbwrdmjmNHu2l+yM=;
        b=TDbeVzD6L+xSmDdHO3cxlofgp5m5faDzVoe7wq3OkkxC9I72s9hWz2AgVHPXcVzw
        hhbQCJd99lRpWqnj0iujMMw66Kc8UpLHNk9Zl8UhQK3UY2yuepgC4MFHdjSuw3y/miW
        g6Hbh3Q7TK7tnOmCimTn74dE2DBms/xo+nfFSCto=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1529002207;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=aJM6G6VTY0HULsySyBvg9tXsStvxbwrdmjmNHu2l+yM=;
        b=fM2TuIMCV9tMYMZxrX9geYVHW9HErJ/OcyZchC69RM3UBs9iVrvnorlYleKwgoc4
        g782SGPcpaiwG04iLuRZ7uHxmpZNkmpz5UYCIWv9ub3YtyQ9XoLMOfZxBswEOUCmUWL
        M+WRmSBZdaXOlBwZq9MATK4UI5YFI1n5wYCKeBhA=
X-Virus-Scanned: amavisd-new at jcline.org
Subject: Re: [PATCH 4.4 128/268] scsi: sd: Keep disk read-only when re-reading
 partition
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     stable@vger.kernel.org, Li Ning <lining916740672@icloud.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100216.627623125@linuxfoundation.org>
 <1528925110.2289.175.camel@codethink.co.uk>
From:   Jeremy Cline <jeremy@jcline.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jeremy@jcline.org; prefer-encrypt=mutual; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <01000163ffa22710-0b0e9a7d-6015-4612-8bdf-9bc46059bb57-000000@email.amazonses.com>
Date:   Thu, 14 Jun 2018 18:50:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528925110.2289.175.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.06.14-54.240.8.62
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On 06/13/2018 05:25 PM, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 12:01 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Jeremy Cline <jeremy@jcline.org>
>>
>> [ Upstream commit 20bd1d026aacc5399464f8328f305985c493cde3 ]
>>
>> If the read-only flag is true on a SCSI disk, re-reading the partition
>> table sets the flag back to false.
>>
>> To observe this bug, you can run:
>>
>> 1. blockdev --setro /dev/sda
>> 2. blockdev --rereadpt /dev/sda
>> 3. blockdev --getro /dev/sda
>>
>> This commit reads the disk's old state and combines it with the device
>> disk-reported state rather than unconditionally marking it as RW.
> 
> It seems to me that this change is likely to cause a regression: if a
> SCSI device switches from read-only to read-write state then a
> subsequent rescan won't automatically change the block device to read-
> write state.  The administrator will have to use the blockdev command
> too.
> 
> Even if this change in behaviour is acceptable, this commit does not
> implement it consistently.  The function starts by clearing the ro flag
> and this commit only changes one of the three exit paths to preserve
> it.  (The log message about Write Protect status also reports the
> underlying SCSI device flag and not the combined ro flag, but maybe
> that was intentional.)

Yes, it looks like I messed this up.

> 
> I think this commit should be reverted, both in stable and upstream.  A
> proper fix would involve splitting the ro flag into two flags—one
> controlled by user-space and one read from the device—with the
> effective read-only status being the logical-or of those two.

This seems sensible to me, for whatever that's worth. I'm new to the
kernel so I'm not certain I'll produce a reasonable patch, but I'm
willing to give it a shot.

So the change would be something like:

1. Add a flag to the gendisk struct to indicate if the device is
   read-only. The driver sets this.

2. In hd_struct struct's policy flag is one that indicates the
   user-space setting and this gets set by BLKROSET ioctl/set_disk_ro.

3. The effective read-only status reported by the BLKROGET ioctl and
   bdev_read_only is the logical-or of the hd_struct policy flag and the
   gendisk device flag.

Maybe that doesn't make sense at all, though. Thoughts?


Thanks,
Jeremy
