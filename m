Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 690B3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41CC208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41CC208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934331AbeFLVuv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:50:51 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42253 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754400AbeFLVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:50:48 -0400
Received: from [192.168.0.4] (ip5f5ae9d1.dynamic.kabel-deutschland.de [95.90.233.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D7F882012BA059;
        Tue, 12 Jun 2018 23:50:45 +0200 (CEST)
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Subject: nct6775: UBSAN: shift exponent 32 is too large for 32-bit type 'long
 unsigned int'
Message-ID: <d02001e2-fa4c-6a2e-cc50-a8d9a8146d57@molgen.mpg.de>
Date:   Tue, 12 Jun 2018 23:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenther, dear Jean,


Building Linux with the undefined behavior sanitizer (UBSAN), loading 
the module *nct6775* on the ASRock E350M1 shows the error below.

```
[   28.322775] UBSAN: Undefined behaviour in drivers/hwmon/nct6775.c:4179:27
[   28.322833] shift exponent 32 is too large for 32-bit type 'long 
unsigned int'
```

I believe this was introduced by commit cc66b3038254 (hwmon: (nct6775) 
Rework temperature source and label handling), but the same issue was 
already present before.

```
-       for (i = 0; i < data->temp_label_num - 1; i++) {
+       for (i = 0; i < 32; i++) {
+               if (!(data->temp_mask & BIT(i + 1)))
+                       continue;
```

`include/linux/bitops.h` has the macros below.

```
#define BIT(nr)                 (1UL << (nr))
#define BIT_ULL(nr)             (1ULL << (nr))
```

Maybe `BIT_ULL` should be used, but I do not know, if that’d would work 
with `data->temp_mask`, which has type `u32`.


Kind regards,

Paul
