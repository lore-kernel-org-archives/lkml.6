Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C0320857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C0320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIFGuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:50:39 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:48970 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:50:38 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65b908e3f4b2-f8a2d; Thu, 06 Sep 2018 10:17:35 +0800 (CST)
X-RM-TRANSID: 2ee65b908e3f4b2-f8a2d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.81] (unknown[112.25.154.148])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65b908e3e48e-c7e9c;
        Thu, 06 Sep 2018 10:17:34 +0800 (CST)
X-RM-TRANSID: 2ee65b908e3e48e-c7e9c
Subject: Re: [PATCH V2] mips: txx9: fix resource leak after register fail
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <20180906.003701.1191480642819924726.anemo@mba.ocn.ne.jp>
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
Message-ID: <d0386546-cb09-0ff6-2cc6-c6816f723289@cmss.chinamobile.com>
Date:   Thu, 6 Sep 2018 10:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180906.003701.1191480642819924726.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2018 11:37 PM, Atsushi Nemoto wrote:
> On Wed,  5 Sep 2018 19:22:19 +0800, Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:
>> the memory allocated and ioremap address need free after
>> device_register return error.
> ...
>>   exit_put:
>>   	put_device(&dev->dev);
>> -	return;
>> +exit_free:
>> +	iounmap(dev->base);
>> +	kfree(dev);
> This change will break exit_put error path.
> I think kfree will be called from txx9_device_release by put_device.
>
> Please refer James's comment on previous trial:
> <https://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20180305221833.GJ4197%40saruman>

yes, put_device will call txx9_device_release and free txx9_sramc_dev, 
and kfree in  sysfs_create_bin_file() error handle

is also unneeded, I will send a new patch soon



