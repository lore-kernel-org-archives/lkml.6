Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B59C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5356222A6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH5JZYQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbfBMV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:26:37 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:50360 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbfBMV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:26:37 -0500
Received: by mail-it1-f175.google.com with SMTP id z7so9610151iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HzhQaGiMD2Kbo9RwshR9uKQOLpMXHBFaj9IEGbE21U8=;
        b=pH5JZYQm3/iQKZuCKQ2FtvSLiPiA/f8FrOiA09HG58eHpH36rKdBJLqA00jBU7yumx
         kYnGJYBs04i/KNUt3kRMUnKOzeSDu471L5B57lFI99mvjlLH8AzlV0wd2DjGiwcBTCWS
         T7ksz3899rdBxtxeGVVwFWIqB7pHfvN50g4oSvzeSb9Vfo/YI2w3tzOLNg3DaDkDV4vD
         7FQJH6Ianq5Tt6EdQs7gQpeuUZ9a9RYI6xh/RmVqKwS6jyq+oF7EBsuZgWZ0nEQ1/EIz
         ALGL4RUbbncjd8VvRZ6nqjN9erb3yVrrairpJi0lSIaCyWPOXTVs5KTffkoBCnx4epjD
         zItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HzhQaGiMD2Kbo9RwshR9uKQOLpMXHBFaj9IEGbE21U8=;
        b=MQEFvAza76UW9gT2NJ0TSu4sMguEyLswBJUZjDJVLEvcieFe73ZRjIRLJiYASfD73M
         IA4HHYOlS3Qet7nRbN1aHSm3ExbHHmfTgaeGZx3SpHZG5WhCucsK1ZqWljuKHXJyApBq
         emVy9dhOF5kaSPk19YyBw2j/6R8VdKTvEySxCpKDJrD2A1L6eEkq1IH8j2fqHzpJCI//
         vFNBrVcnn4Prajb2T3hnceKpLYRO748XKWH4jikL0uQdiGsiUCSLbbuXjaGN06bTI4pj
         k3YP+CshBw1dch86LhrSkz5ePy9/05TAj9PRcbT1HkbSN/2rnReHugFip4k7EBpppxrp
         dmAw==
X-Gm-Message-State: AHQUAuabHY1BTFfjYMnlizwAifqwLfo2PLPB/mjBOq1/nAVvawcBU3L+
        14YnKSkC6YmO+y/x82B2JxDDPcqJVjE4h1BuBcduHg==
X-Google-Smtp-Source: AHgI3IafLzvIq0JPlNJ6NvlFtYZT4KNeC52qU4jyPRnj9KXSxoHtCCgu3JP0xeesJceizIPp74SbwxURqVsJQQ1FQ1M=
X-Received: by 2002:a6b:c8cc:: with SMTP id y195mr163011iof.86.1550093196119;
 Wed, 13 Feb 2019 13:26:36 -0800 (PST)
MIME-Version: 1.0
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 13 Feb 2019 14:26:25 -0700
Message-ID: <CANLsYkynsuO7mQxnfSrctOtUtjeokgMX5f9hqG0muufJsKfdbA@mail.gmail.com>
Subject: [v5.0-rc6 regression] "perf/core: Don't WARN() for impossible
 ring-buffer sizes"
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, julien.thierry@arm.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

CoreSight trace collection is broken on v5.0-rc6 due to this commit:

9dff0aa95a32 perf/core: Don't WARN() for impossible ring-buffer sizes

Before:
root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/u
--per-thread  uname
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.036 MB perf.data ]
root@juno:/home/linaro#

After:
root@juno:/home/linaro# perf record -e cs_etm/@20070000.etr/u
--per-thread  uname
failed to mmap with 12 (Cannot allocate memory)
root@juno:/home/linaro#

The problem is related to the order_base_2() [1] test with a size of
1264, stemming from nr_pages equal to 128.  The combination yields an
order of 11, something leading directly to the error path.

The results are the same with linux-next 20190213.  This was tested on
a Juno R0 and R1 with a 4K page configuration.  I haven't tried but
I'm pretty sure it breaks IntelPT as well.

Please have a look when you have a minute.  Leo Yan and I will be
happy to test patches.

Thanks,
Mathieu

[1].  https://elixir.bootlin.com/linux/v5.0-rc6/source/kernel/events/ring_buffer.c#L737
