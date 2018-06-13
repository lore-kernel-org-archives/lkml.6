Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7CD15C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E62520693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E62520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934403AbeFMG6C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:58:02 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33715 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933318AbeFMG6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:58:01 -0400
Received: from [192.168.0.4] (ip5f5aec88.dynamic.kabel-deutschland.de [95.90.236.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 17D372012BA059;
        Wed, 13 Jun 2018 08:57:59 +0200 (CEST)
Subject: Re: nct6775: UBSAN: shift exponent 32 is too large for 32-bit type
 'long unsigned int'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d02001e2-fa4c-6a2e-cc50-a8d9a8146d57@molgen.mpg.de>
 <20180612221218.GA15406@roeck-us.net>
From:   Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Message-ID: <0591d6af-a9f4-c874-3ae8-a9a5c7161934@molgen.mpg.de>
Date:   Wed, 13 Jun 2018 08:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612221218.GA15406@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,


Am 13.06.2018 um 00:12 schrieb Guenter Roeck:

> On Tue, Jun 12, 2018 at 11:50:45PM +0200, Paul Menzel wrote:

>> Building Linux with the undefined behavior sanitizer (UBSAN), loading the
>> module *nct6775* on the ASRock E350M1 shows the error below.
>>
>> ```
>> [   28.322775] UBSAN: Undefined behaviour in drivers/hwmon/nct6775.c:4179:27
>> [   28.322833] shift exponent 32 is too large for 32-bit type 'long unsigned int'
>> ```
>>
>> I believe this was introduced by commit cc66b3038254 (hwmon: (nct6775)
>> Rework temperature source and label handling), but the same issue was
>> already present before.
> 
> I don't think so. The code used to be
> 	for (i = 0; i < data->temp_label_num - 1; i++) {
> Notice the "- 1". So it should be
> 	for (i = 0; i < 31; i++) {
> 
> In practice it doesn't matter because "data->temp_mask & BIT(31 + 1)"
> will always be false, causing the last loop iteration to abort, but
> it is nevertheless wrong.
> 
> Thanks a lot for the report. I'll prepare a patch.

Thank you for the instant response. I tested your proposed change, and, 
as expected, the error is gone.


Kind regards,

Paul
