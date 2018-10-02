Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF320C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B842082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B842082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJCDkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:40:53 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:49678 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeJCDkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:40:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 8349642705;
        Tue,  2 Oct 2018 20:55:38 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VV67ZuhJoV9v; Tue,  2 Oct 2018 20:55:38 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 8D5B041369;
        Tue,  2 Oct 2018 20:55:25 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] selftests: gpio: restructure Makefile
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
 <CAEUSe79yNJ_2FsLsxKW6J0dfrJ2HoVvk+_NZGWHCsy_Kc0+pQw@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <aee2d946-eecb-ca39-0802-9755a01a7312@kernel.org>
Date:   Tue, 2 Oct 2018 14:55:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEUSe79yNJ_2FsLsxKW6J0dfrJ2HoVvk+_NZGWHCsy_Kc0+pQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 02:48 PM, Daniel Díaz wrote:
> Hello!
> 
> On Fri, 7 Sep 2018 at 09:35, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>> From: Fathi Boudra <fathi.boudra@linaro.org>
>>
>> This patch cleans up the Makefile by restructuring a couple of
>> things, namely:
>> 1) change explicit paths in targets for variables
>> 2) substitute a variable (BINARIES) for another, part of the
>>    selftests build system (TEST_PROGS_EXTENDED)
>> 3) proper cleaning up of the EXTRA objects
>>
>> The resulting Makefile is much more readable and manageable.
>>
>> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
>> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
>> ---
>>  tools/testing/selftests/gpio/Makefile | 32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
>> index 4665cdb..a4a01ec8 100644
>> --- a/tools/testing/selftests/gpio/Makefile
>> +++ b/tools/testing/selftests/gpio/Makefile
>> @@ -1,28 +1,26 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>
>> +CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
>> +LDLIBS += -lmount -I/usr/include/libmount
>> +
>>  TEST_PROGS := gpio-mockup.sh
>> -TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
>> -BINARIES := gpio-mockup-chardev
>> -EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
>> -EXTRA_DIRS := ../gpioinclude/
>> -EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
>> -EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
>> -EXTRA_OBJS += ../gpiolsgpio.o
>> +TEST_FILES := gpio-mockup-sysfs.sh
>> +TEST_PROGS_EXTENDED := gpio-mockup-chardev
>> +
>> +GPIODIR := ../../../gpio
>> +GPIOOBJ := gpio-utils.o
>>
>>  include ../lib.mk
>>
>> -all: $(BINARIES)
>> +all: $(TEST_PROGS_EXTENDED)
>>
>>  override define CLEAN
>> -       $(RM) $(BINARIES) $(EXTRA_PROGS) $(EXTRA_OBJS)
>> -       $(RM) -r $(EXTRA_DIRS)
>> +       $(RM) $(TEST_PROGS_EXTENDED)
>> +       $(MAKE) -C $(GPIODIR) clean
>>  endef
>>
>> -CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
>> -LDLIBS += -lmount -I/usr/include/libmount
>> -
>> -$(BINARIES):| khdr
>> -$(BINARIES): ../../../gpio/gpio-utils.o
>> +$(TEST_PROGS_EXTENDED):| khdr
>> +$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
>>
>> -../../../gpio/gpio-utils.o:
>> -       make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
>> +$(GPIODIR)/$(GPIOOBJ):
>> +       $(MAKE) -C $(GPIODIR)
>> --
>> 2.7.4
> 
> Ping on this series.
> 

Thanks for the ping. I will queue these up for 4.20-rc1.

thanks,
-- Shuah
