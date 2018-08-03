Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B6EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A0F21784
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A0F21784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeHCTlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:41:51 -0400
Received: from smtp.infotech.no ([82.134.31.41]:52971 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbeHCTlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:41:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1E354204188;
        Fri,  3 Aug 2018 19:44:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t0WOa0v4SyK9; Fri,  3 Aug 2018 19:44:29 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-245-67.dyn.295.ca [45.58.245.67])
        by smtp.infotech.no (Postfix) with ESMTPA id 7259220416A;
        Fri,  3 Aug 2018 19:44:28 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [bug report] memory corruption panic caused by SG_IO ioctl()
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     gaowanlong <gaowanlong@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Wencongyang (UVP)" <wencongyang2@huawei.com>,
        "Wanghui (John)" <john.wanghui@huawei.com>,
        guijianfeng <guijianfeng@huawei.com>,
        "lipengfei (Y)" <lipengfei58@huawei.com>,
        qiaonuohan <qiaonuohan@huawei.com>
References: <a44201bc-d8d1-6d19-645e-07687ef4bc9e@huawei.com>
 <93359d1a-930f-5279-3ca8-800d5930562d@interlog.com>
 <F0DE9BB0B24B3E4F8304582FAD6F7BFF01B7CB04@DGGEMA505-MBS.china.huawei.com>
 <bc4ff9b5-230e-707d-2f81-f5a33e46fc34@interlog.com>
Message-ID: <94815265-6db3-35b3-b027-47819b963d4a@interlog.com>
Date:   Fri, 3 Aug 2018 13:44:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bc4ff9b5-230e-707d-2f81-f5a33e46fc34@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 12:17 PM, Douglas Gilbert wrote:
> On 2018-08-03 11:47 AM, gaowanlong wrote:
>> Doug,
>>
>> On 2018-08-03 04:46 AM, Wanlong Gao wrote:
>>> Hi Martinand all folks,
>>>
>>>
>>>> Recently we find a kernel panic with memory corruption caused by SG_IO ioctl(),
>>>> and it can be easily reproduced by running following reproducer about
>>>> minutes,any idea?
>>
>>> Which kernel?
>>
>> We've tested with 4.17.11 and 4.18.rc7 and both reproduced.
>>
>>> And what are the underlying devices (e.g. does /dev/sg0 refer to a SATA disk,
>>> a real SCSI disk (SAS for example), USB mass storage, etc)?
>>
>> We tested in a qemu-kvm guest and the sg0 refer to a virtual SATA disk.
> 
> Thanks for the prompt reply.
> 
> The first test I am doing, and you can also do, is to replace the virtual
> SATA disk with a scsi_debug pseudo SCSI disk(s). This will tell us
> whether libata has a hand in this (as that was the case in a previous
> syzkaller report on the SG_IO ioctl()).
> 
>>> Also can you get a copy of the kernel panic?
>>
>> Since the call traces are different every time it reproduced, that I didn't 
>> paste the
>> call trace or the vmcore, but this reproducer is very useful and I believe you 
>> can reproduce
>> it easily using the following code.
> 
> Okay.
> 
> As I write I'm running your reproducer with lk 4.18.0-rc6 against pseudo
> scsi_debug "disks". So far no problems (5 minutes) with no noise in syslog.

Ran for an hour before I stopped it. Before that I did a
   echo 1 > /sys/bus/pseudo/drivers/scsi_debug/opts

which causes a lot of noise in syslog. Then I could see every command was
being rejected with "LBA out of range". So I restarted scsi_debug with this:

   modprobe scsi_debug max_luns=8 sector_size=4096 virtual_gb=2000 ndelay=5000

To give 8 pseudo scsi disks of 2 TB size. Then it worked, this from syslog:
   sd 0:0:0:0: scsi_debug: tag=0x7e, cmd 08 f0 a8 77 d3 be 87 5d da 65 79 3f c7

That is certainly strange, a READ(6) [deprecated] with 13 bytes in the command!
But it doesn't seem to hurt scsi_debug. Still running 15 minutes later ...

Doug Gilbert

