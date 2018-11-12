Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860DBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30602224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gQG5XWPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30602224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeKMCzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:55:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeKMCzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:55:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id y18-v6so4614272pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FlIKg5lhT269jOPYhE3sQoXCF9ftbT13Wqnr++tZwcA=;
        b=gQG5XWPrG3VCOI7EVo5Vbb8aIjHZJwbapTdR73lfiuwzckUzbk4PZnoCL8Ny9yCCFJ
         TJPQkurlv5tjnWsQ9mECVHFY043CiznhE4vhCHckWf32mNI0na7P3Hy6lP6kBPflMFsX
         wB/V8pNXMAJuKMaWEAlFw0Cb5nxVePnXPRS8tKcpSafRMGq73rUaKCxiH2zBnoopSjjd
         IdHU92PFJkKz22eDytdpCpktl1oe+w8igXqTYIVHvPGXYmPGC0R7EZjFPLDouHDD5QCh
         AvDHByNlBDgHu23cteCrs8xJscXVFkXu30GP9rxMAY3oExBy10SH3QbMZIrX6jiM76Yp
         qllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FlIKg5lhT269jOPYhE3sQoXCF9ftbT13Wqnr++tZwcA=;
        b=e45uszjKp7vp56M2lKwE2XbK20X+CT33kEyRebEUZFOcNmIKCZWbbHgPqraC0cCurr
         r4XRTs2y1zXmIx/RpwsgUFGn8iQuULKp6FOfauuCdRmvFCrcAEfOLG3Qkbn+BaCqqil3
         PyqXVQkSESZTwCnkQRzEwY8Uo8civOoybTQWwIfM7QU83rCOQJpkHGLkg0WL+Ygxw0P2
         ea8GtQEGCVBWVuP2g7vRJpMdWyzCnR/ilBYwWttmpcGOqSxSKSewwPV34KVKEq7Yac7d
         aYEJsqFN/FrJE2ustxyWoVNyBorJfvOubR53hQtH099adpZBOFODoZhYPP1WvWJpCGcM
         BsPA==
X-Gm-Message-State: AGRZ1gJM0owiMV1Ou6ouiFMbVKR/czxvbNIhuDJ6LZbyDETgT49+IGig
        AuYlvtebAGUNPAe5sAc7F2Wn1g==
X-Google-Smtp-Source: AJdET5eGGOE9AhUIv8hr9TSusDVXZYrNFlD4N5vjO5tKj4SntibiuSoHH7KOMLhzS1AvlXdjhhuQlg==
X-Received: by 2002:a63:7044:: with SMTP id a4mr1442956pgn.359.1542042104144;
        Mon, 12 Nov 2018 09:01:44 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l72-v6sm20339328pfi.149.2018.11.12.09.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:01:43 -0800 (PST)
Date:   Mon, 12 Nov 2018 09:01:43 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 08:27:32 PST (-0800)
Subject:     Re: [PATCH 1/2] RISC-V: Request stat64 on RV32
In-Reply-To: <CAEn-LTpXnzSG-rVVvv_2cbxqY2vTchOKn6M0isRBovoq4jpZGw@mail.gmail.com>
CC:     zongbox@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com, marcin.juszkiewicz@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-63079855-2270-4a5b-bde6-82a13f29230a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 22:19:02 PST (-0800), david.abdurachmanov@gmail.com wrote:
> On Mon, Nov 12, 2018 at 5:10 AM Zong Li <zongbox@gmail.com> wrote:
>>
>> The stat64 family that is used on 32-bit architectures to replace
>> newstat.
>>
>> Since commit 67314ec7b0250290cc85eaa7a2f88a8ddb9e8547 ("RISC-V: Request
>> newstat syscalls"), the RV32 build fail with undeclared 'sys_fstatat64'
>>
>> Signed-off-by: Zong Li <zong@andestech.com>
>> ---
>>  arch/riscv/include/asm/unistd.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
>> index eff7aa9..a4aade9 100644
>> --- a/arch/riscv/include/asm/unistd.h
>> +++ b/arch/riscv/include/asm/unistd.h
>> @@ -18,5 +18,6 @@
>>
>>  #define __ARCH_WANT_NEW_STAT
>>  #define __ARCH_WANT_SYS_CLONE
>> +#define __ARCH_WANT_STAT64
>>  #include <uapi/asm/unistd.h>
>>  #include <uapi/asm/syscalls.h>
>> --
>
> See: http://lists.infradead.org/pipermail/linux-riscv/2018-November/002087.html
>
> The plan is not to have old stat syscalls and support statx on
> riscv32, which is y2038 safe.
>
> The issue you see is a bug in include/uapi/asm-generic/unistd.h.
> Marcin (CC) already sent a patch to Arnd (CC) IIRC. Basically without
> __ARCH_WANT_NEW_STAT or __ARCH_WANT_STAT64 two macros are not defined:
> __NR3264_fstatat and __NR3264_fstat. Which is later used (without any
> guards):
>
> 763 #define __NR_newfstatat __NR3264_fstatat
> 764 #define __NR_fstat __NR3264_fstat

I agree.  Thanks!
