Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA57ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130C92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeIXUCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:02:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728809AbeIXUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:02:08 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8ODrpGt025143;
        Mon, 24 Sep 2018 15:59:06 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mnb6x3jgd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 15:59:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 575FD46;
        Mon, 24 Sep 2018 13:59:05 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C362A57D;
        Mon, 24 Sep 2018 13:59:05 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 24 Sep
 2018 15:59:04 +0200
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <stefan.wahren@i2se.com>, <gohai@sukzessiv.net>,
        <hsweeten@visionengravers.com>, <gottfried.haider@gmail.com>,
        <loic.pallardy@st.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
Date:   Mon, 24 Sep 2018 15:59:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924115301.GV21032@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 01:53 PM, Thierry Reding wrote:
> On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
>> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
>> regression with multiple pwm chip. It creates a new entry in
>> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
>> - 1st time export will create an entry in /sys/class/pwm/pwmX
>> - when another export happens on another pwmchip, it can't be created
>> (e.g. -EEXIST)
>>
>> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
>> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>>
>> Example on stm32 (stm32429i-eval) platform:
>> $ ls /sys/class/pwm
>> pwmchip0 pwmchip4
>>
>> $ cd /sys/class/pwm/pwmchip0/
>> $ echo 0 > export
>> $ ls /sys/class/pwm
>> pwm0 pwmchip0 pwmchip4
>>
>> $ cd /sys/class/pwm/pwmchip4/
>> $ echo 0 > export
>> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>> ...Exception stack follows...
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/pwm/sysfs.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Can we come up with an alternative that allows us to have both? We want
> uevent and proper sysfs creation, or is that not possible?

Hi Thierry, all,

With current approach:
- "export->child.class = parent->class"
- ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
I think this is not possible.

Trying to think of an alternative... I just did a quick test, by
changing device name, to take pwmchip into account:
+       export->child.class = parent->class;
        export->child.release = pwm_export_release;
        export->child.parent = parent;
        export->child.devt = MKDEV(0, 0);
        export->child.groups = pwm_groups;
-       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
pwm->hwpwm);

But this also impacts existing ABI :-(
Would you have suggestions to send an uevent, without modifying ABI ?

Please advise,
Best regards,
Fabrice

> 
> Thierry
> 
