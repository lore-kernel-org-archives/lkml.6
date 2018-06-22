Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6459F23EDB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOatos6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6459F23EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbeFVIPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:15:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43400 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVIPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:15:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id l15-v6so1137848lfc.10;
        Fri, 22 Jun 2018 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EaoIhG985TfY4Gm1IjoesmKweWeETm5i/s641HIthjY=;
        b=HOatos6OIY7IiHHcCyaJY1ZupRNS+QZUvBtiKg6/iRDHi5nkUAG9OB0Rx4vl+Z8Zyh
         e5Mb5yxMlYq14cLN4QYBvFgN/Gcc2uEV7jGSYQ2UjGU8fEsCCRXa9en/5hS3W8t446RK
         Y3cJUt5y0yyArkRf0hrutixcNMHdC1jNB4Gzbai19moTWW0mgdYk2hnKkl1Xi7UXLQfp
         jH1vNIJFimq+XiMglwvLSrgW6OUtxeBkfL6o1FH6/HSxkiyKVfitT3Br81K2CXbCgomT
         4NTBTnKXiK0jZWYKtmzZfmsX/uWuJszdhylJTDfcoL4Vn86v6cpWp/eU7U0Xz6GpJRWo
         tQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EaoIhG985TfY4Gm1IjoesmKweWeETm5i/s641HIthjY=;
        b=gu6J9QnBe8G7hbhQ8Yn9rxytRPge1bb1JXdrSh3nMhvC8UNnypMUMnerKrU6bW79+G
         Ec43YP0tIRqJ6dzhtoKlzAAxQOlpWPrY5vRECCPq/ZEHy6p2cN7sSEQP33VlGfVhVL1i
         l1rEASqkhLkPV6zZ81B9Uza+S0hyuLQ0jX08kaz11Td0b/T2owX0CoxRXqPGtiLC8wx/
         ENW2nyoqR+e1YgUs4+FNp3vd6P4Fi1X1dOlDR/wGImz92nKKMoSGD5upzXnW0tkGyl9T
         c2c/ImjevszmeETZ6ZwmOnlOGbfM+jV/hHf3UUkYNrqkXSq4CWYp5TxxqpQ3vDDRp3eD
         S8Mw==
X-Gm-Message-State: APt69E2CO1YfnD+5LTuPUUWKydEkDsDYbnBFfa1H6LWpVrFNsi0M9xQ9
        cx37fUDsPti9XHLAcKuCIEHI9RrsbQf3hh/XkAvaSA==
X-Google-Smtp-Source: ADUXVKK3JVMl2A1suTKUQzMalNR+jCdcjOC32zHL+tYBuebVzeiX2K6bJOIbQoaJKxRdsQlAH7sX3qrVbDJfwfVjh/c=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr585524lfc.55.1529655317858;
 Fri, 22 Jun 2018 01:15:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:15:16
 -0700 (PDT)
In-Reply-To: <20180622073728.76imgamp3u4ivhf3@quack2.suse.cz>
References: <20180620153322.54221-1-arnd@arndb.de> <20180620153322.54221-4-arnd@arndb.de>
 <20180622073728.76imgamp3u4ivhf3@quack2.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jun 2018 10:15:16 +0200
X-Google-Sender-Auth: 3vMJvqiYRc3vn8-c3wvFQZQttgM
Message-ID: <CAK8P3a2cjQugQYcqBN0RLhgG2kX+Pr0S=vWvWNFyFN7ruE-t+Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] ext4: use timespec64 for all inode times
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 9:37 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 20-06-18 17:33:01, Arnd Bergmann wrote:
>> -static inline __le32 ext4_encode_extra_time(struct timespec *time)
>> +static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
>>  {
>>       u32 extra = sizeof(time->tv_sec) > 4 ?
>
> I suppose this condition can be removed now.

Right, good point. I also verified that we have no other similar
constructs in the kernel any more now.

>>               ((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK : 0;
>>       return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
>>  }
>>
>> -static inline void ext4_decode_extra_time(struct timespec *time, __le32 extra)
>> +static inline void ext4_decode_extra_time(struct timespec64 *time, __le32 extra)
>
> Wrap?

Ok, done.

> Otherwise the patch looks good.

Thanks!

      Arnd
