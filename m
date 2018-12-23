Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF60C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4662070D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d614fuCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeLWG4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:56:13 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:41549 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeLWG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:56:13 -0500
Received: by mail-vs1-f41.google.com with SMTP id t17so5774316vsc.8;
        Sat, 22 Dec 2018 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=99WBOf5UoAPsWbdwuj7ZlNsSBTYs3KFdTC1Z3Pp7lX8=;
        b=d614fuCn1s/3Gd8sRoXWrelq8zDAF6F3Q8NAA5TZH25ttQH4cboZhtQCg+JFhQs3d7
         68meu54C2YQxR9hxclBaBS52WBkd/nUn070DKaXkLCqao5gsZyLkoXRKdcECfkRmbqcf
         ur3T7WWNo0kQnSWucOf+o/OO3gzJC7Ens2FmervMYDXcB5oCmr4cailoCTz4CAxloIvU
         Zzk0LF9vTP7YMYNgndVvP43mOd4xLNXe4fDWkiGKleVEm+s3SvBvGZ1B6dBIUoE7eQxU
         iBC77xo5XavU7OiW3if9nw/5rAG9i6xpSnCdXjaUQtToQiHdc6iU7IFe1eGkR5EZ7rUr
         EmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=99WBOf5UoAPsWbdwuj7ZlNsSBTYs3KFdTC1Z3Pp7lX8=;
        b=EUj0xMwE54Ev9zWVbVuEZtZd0AWzdJV7ryr5T02atljDwBQ1EHzMSYKo2CoJ84Juty
         eJW94asAyiIDr9sm6xE1ZVoIq/J//XOm7RDaKTf3c+VlZ85tGk7uJP/QFFF0WIsqpow8
         UaeBFDYi2yVJwc+uYnxioJr0gevBQkRWrxJkAVdoYBQ32FOk2wF9Dc5kyldxeZCUDoFy
         qxVjdUKRmkVrcUVayc5cG1B3tV4Q3Rsjxpyl/60jd3bVuZh/myX+4GrobZ2H59CyEVUM
         sDW4OnWHt7a9MURM0bHn0EZ4kcL1gHc8PkY5YPzk++SqWStX3hxdEV9Zo2fRgfDUouwf
         oEOQ==
X-Gm-Message-State: AA+aEWZXqKZSlbgo69NKlLT8WQQaAAJ1x8FWLL8ijwfFr5ylZuFSzCZW
        Fzi48dYxfRTsaVvX+/SE8Z6ZOAEHP0cSjA9ayFVRoTls
X-Google-Smtp-Source: ALg8bN4S4EUyxpS65PiRBmv5/fBt26d3FMFUBVZt3bqHOC0JbGYPkPPwtL3j56f68cQbodxuyveI2bo6yxrj72KuK/E=
X-Received: by 2002:a67:4e5d:: with SMTP id c90mr3654106vsb.72.1545548172143;
 Sat, 22 Dec 2018 22:56:12 -0800 (PST)
MIME-Version: 1.0
From:   Da Shi Cao <dscao999@gmail.com>
Date:   Sun, 23 Dec 2018 14:56:01 +0800
Message-ID: <CAG3POBnGPabdLQ2wvJc9HTKeHszf+RytV6t+hPyh0k=hjGd+8g@mail.gmail.com>
Subject: [BUG]Uncalibrated TSC is not accurate enough as a time keeper
To:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_khz and tsc_khz are now read directly by the cpuid
instruction, and they are deemed to be very accurate. But this is not
the case in our situation. The OS time lags behind about 8 seconds per
hour. The CPU information is as follows:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 85
model name      : Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz
stepping        : 4
microcode       : 0x200004d
cpu MHz         : 2300.000
cache size      : 25344 KB
physical id     : 0
siblings        : 36
core id         : 0
cpu cores       : 18
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
It is this "cpuid level 22" that makes the kernel 4.14 to read both
cpu_khz and tsc_khz directly by instruction "cpuid", and the TSC is
thought to be very accurate, but in fact it is not.
------------
* TSC frequency determined by CPUID is a "hardware reported"
* frequency and is the most accurate one so far we have. This
* is considered a known frequency.
+*
+*  The assumption may not be valid!
+*
*/
-  setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
