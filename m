Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61609C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1505A223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="b+GRVjQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1505A223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHJEST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:18:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42397 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeHJEST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:18:19 -0400
Received: by mail-pl0-f66.google.com with SMTP id g6-v6so3329842plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 18:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6Pk5xjC+A6P1vMMRU6RIuH4TvlyAhlhdL3i7d78PMtw=;
        b=b+GRVjQEX8ITWftlCKzp7lZEjGfJmPSEe2LIPFH4FJknbCFjwJ8iPsJ1prhqU0RoVT
         vfOTPXisT4IIUmpmoQKYNnbr8TVJ92N1yhMHgxe20nGW13K1jzF6U3GAO+IadeB7xMHL
         iRYygWjN4HPbcvSk2JcWM3Wd/u6C5YnBS9/wTbrQbNkIjzODWYBLoNbIQTSzzXOrXdha
         gcK96X61xoHaxLIn4ru2HdUTetuqxVcl0A9VQGQIDWaqBy9eJAVukfblvmOGyB6VQC5T
         urMChIIAw1ttJmbenSgnxLFeLPds35LCo+8cTXAvMe9nyNggz0uLudTBl5X411ksQ61S
         MGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6Pk5xjC+A6P1vMMRU6RIuH4TvlyAhlhdL3i7d78PMtw=;
        b=RFaw1EaHjz5vi8wxNEvdznmYlvi/O2fyer9v9nNHjrrrGZNHeDRaTby+O3gC1o7wxX
         KDBRTcCqAQ3iOuLdaLwBvnbcPnYScy8pBwSNaHxSs/XD8pNMbV2NxN8QyyJSOv5VaInX
         s6DPFCnS1QtVemU/G8+vtTS6FsLtUBWRx64eNg8JvYt/9RMqkwxz+OQhaa97Na97LGnH
         LcdZ3+vDbcF3O5wJu2bF/TiPB4t2pZqR9ApH0oYhWrVBNbCqaRZ2X724rsnrjZmVZGCs
         xhZjfyWv5l/udhqA19QzdN2nLAAO0bMCmPL67zrCcjjr4aNFtSfQuZ+/S6E/r6SifHeD
         D0nQ==
X-Gm-Message-State: AOUpUlFihMOdXipPKr8QrHIy4zhibHS49XPP7UyoRK8MK1fXxvPvQbcK
        MDTVxoK6B7fdV7iJzSlXkoOQjg==
X-Google-Smtp-Source: AA+uWPxNCBkBk90o174VM0GX78Ip1z7+1lfJkVSWUKh5WUA6MEYbofyvI2Wex6Jfcx4CYavWhQKT/A==
X-Received: by 2002:a17:902:934a:: with SMTP id g10-v6mr4174079plp.121.1533865843474;
        Thu, 09 Aug 2018 18:50:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l84-v6sm13915051pfg.3.2018.08.09.18.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 18:50:42 -0700 (PDT)
Date:   Thu, 09 Aug 2018 18:50:42 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 18:48:26 PDT (-0700)
Subject:     Re: FW: [PATCH v2] RISC-V: Add the directive for alignment of stvec's value
In-Reply-To: <CA+ZOyajyOfjZh8tQB4reAka3s+tqXachY4hiAtpA4Bb67x58AQ@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com, greentime@adnestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     zongbox@gmail.com
Message-ID: <mhng-0cd89708-476d-4cd0-81a2-8ba5d18114ee@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 17:37:39 PDT (-0700), zongbox@gmail.com wrote:
>> Subject: [PATCH v2] RISC-V: Add the directive for alignment of stvec's value
>>
>> The stvec's value must be 4 byte alignment by specification definition.
>> These directives avoid to stvec be set the non-alignment value.
>>
>> Signed-off-by: Zong Li <zong@andestech.com>
>> ---
>>  arch/riscv/kernel/head.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S index 3b6293f..11066d5 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -94,6 +94,7 @@ relocate:
>>         or a0, a0, a1
>>         sfence.vma
>>         csrw sptbr, a0
>> +.align 2
>>  1:
>>         /* Set trap vector to spin forever to help debug */
>>         la a0, .Lsecondary_park
>> @@ -143,6 +144,7 @@ relocate:
>>         tail smp_callin
>>  #endif
>>
>> +.align 2
>>  .Lsecondary_park:
>>         /* We lack SMP support or have too many harts, so park this hart */
>>         wfi

Thanks, this got lost in the shuffle somewhere.  It's in for-next now.
