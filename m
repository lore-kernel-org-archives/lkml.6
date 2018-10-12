Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387CF20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387CF20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeJLUI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:08:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54755 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727816AbeJLUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:08:57 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9CCUG7H019323;
        Fri, 12 Oct 2018 14:36:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mxjgyc114-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 12 Oct 2018 14:36:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DD1C31;
        Fri, 12 Oct 2018 12:36:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED55E2C14;
        Fri, 12 Oct 2018 12:36:11 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.49) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 12 Oct
 2018 14:36:11 +0200
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <gottfried.haider@gmail.com>, <michal.vokac@ysoft.com>,
        <loic.pallardy@st.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hsweeten@visionengravers.com>,
        <broonie@kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
        <gohai@sukzessiv.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <20181012115500.GD31561@ulmo> <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b56bc059-573f-545e-da45-51765f8937a7@st.com>
Date:   Fri, 12 Oct 2018 14:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad0206b8-2cda-a147-1b71-8e2eced06e61@i2se.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 02:15 PM, Stefan Wahren wrote:
> Am 12.10.2018 um 13:55 schrieb Thierry Reding:
>> On Mon, Oct 01, 2018 at 03:23:55PM +0200, Fabrice Gasnier wrote:
>>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
>>> - it's not possible to export more than one PWM channel
>>> - ABI has changed, as a side effect. It may cause bad behavior as pwmchip
>>>   attributes are wrongly added to pwm channels and report wrong values.
>>> See [1] and [2].
>>>
>>> One purpose of the original patch is to send uevents to udev, when exporting a
>>> PWM channel through the sysfs. This series:
>>> - Reverts the original patch.
>>> - Proposes a new way to send notifications to be used by udev rules.
>>>
>>> - With this series:
>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>> $ ls /sys/class/pwm
>>> pwmchip0 pwmchip4
>>>
>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>> capture     enable      polarity    uevent
>>> duty_cycle  period      power
>>>
>>> - Without this series:
>>> $ echo 0 > /sys/class/pwm/pwmchip0/export
>>> $ ls /sys/class/pwm
>>> pwm0 pwmchip0 pwmchip4
>>>
>>> $ ls /sys/class/pwm/pwmchip0/pwm0/
>>> capture     duty_cycle  export      period      power       uevent
>>> device      enable      npwm        polarity    subsystem   unexport
>>>
>>> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
>>> $ echo 0 > /sys/class/pwm/pwmchip4/export
>>> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>>> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b49b0 #151
>>> [   95.301344] Hardware name: STM32 (Device Tree Support)
>>> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_stack+0xb/0xc)
>>> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_dup+0x31/0x48)
>>> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_create_link_sd+0x75/0x88)
>>> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (device_add+0x133/0x3b0)
>>> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+0xb5/0x12c)
>>> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_write+0x87/0xda)
>>> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_write+0x1d/0xe0)
>>> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x4f/0x7c)
>>> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x33/0x70)
>>> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
>>> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
>>> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e590 00000002 00000004
>>> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 00000020 00000000 00c4d008
>>> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
>>> -sh: write error: File exists
>>>
>>> [1] https://lkml.org/lkml/2018/9/25/713
>>> [2] https://lkml.org/lkml/2018/9/25/447
>>>
>>> ---
>>> Changes in v2:
>>> - update revert commit message
>>> - new patch 2/2 to propose uevent notification (change) on pwmchip
>>>
>>> Fabrice Gasnier (2):
>>>   Revert "pwm: Set class for exported channels in sysfs"
>>>   pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
>>>
>>>  drivers/pwm/sysfs.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>> Both patches applied, thanks. What do you think would be the importance
>> of getting this into stable kernels? We can't get one of the patches in
>> without the other, so they'd both have to be backported. The second one
>> is still fairly small, so would qualify for stable, I think.
> I think the revert patch should go to stable, because it fixes a regression.
> 

Hi,

Thierry, Thanks for taking these.
I also think at least the 1st patch (revert) should be backported in
stable branch. Not taking the second one may lead to another issue for
the users that now expect uevents. This is replacement patch to the
original one. So, I'd advise to push both: revert + replacement patch.

Fabrice

> Thanks
>>
>> However, given that it's taken a long time for somebody to notice this,
>> I'm not sure if this is something that people care about too much in the
>> stable kernels>>
>> Thierry
