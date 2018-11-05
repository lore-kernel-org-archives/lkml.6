Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D883C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616C420862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e49fRszP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbeKFCgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:36:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36557 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbeKFCgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:36:09 -0500
Received: by mail-yw1-f68.google.com with SMTP id h21-v6so3961015ywa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aOT/h0lm2p7viryfXX18Mcr8nwTdQnxQm2yhu0f+A+M=;
        b=e49fRszPReqRn89BQ4C6mlO044o9SAgyfma/oHThimqvCqymsgRmA61vBta4VHZ3XR
         pdYooMKB3r0Ir8UFXRcR4PW+G2eFFoD7Qo4Ug2itvPtJPiG9AWyTdRfUBxd2wDAxnfjj
         lXZtm9g5Rf/syFXnBgkgnurdHjoCj2McBstKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aOT/h0lm2p7viryfXX18Mcr8nwTdQnxQm2yhu0f+A+M=;
        b=pNbndTIBxwkSXDVp8WjUpeP27cOO8JqEtkFZY52nsUxJzbcdnUP9eMNe+ipRRKLw2j
         kHRvKwGycgAkQi8Qr1Gz7EsP+IFW/mdZc0dKKw5OfYFiULoXEXuqpPDJTWCn0iK5N1bP
         NiDRih1ru5h18oN+DY76Gu4Bf0kjvDb6xVycYRNzUSwomoCUTUab6J6ieSTlH4eRSNoD
         TY4yIB3oaieg09Or+vUs6FFVRDvPFIN/UKnSmmaNO2+kI9mwtUz6hHQUiBq86gh5CB8T
         Iq27e22V/JdsY+m67Eo8cJBbC7ZvvJ8vQVZNz4jxuABKqIZpQma4Sgd2U2Yx6ky4L956
         0+lQ==
X-Gm-Message-State: AGRZ1gLFjItpuyyLE9Cp+ZLOdpK0Z/rIpHfYcNjNG0jCa4MFMjaVQSqf
        a3JPOeZ27vsOTa613eQL7fzxBhn1gNg=
X-Google-Smtp-Source: AJdET5fVeLDF5J1zt+fbY8J7PFaSFlYOtFWVq1iWxUV1jtOWstHSMKQyud6ZazHtFY1Vs1WdZQuAtg==
X-Received: by 2002:a81:716:: with SMTP id 22-v6mr21813173ywh.129.1541438128703;
        Mon, 05 Nov 2018 09:15:28 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id s187-v6sm11751554ywe.10.2018.11.05.09.15.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:15:28 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id v199-v6so3970181ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:15:27 -0800 (PST)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr22462241ywd.124.1541438126451;
 Mon, 05 Nov 2018 09:15:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 09:15:25 -0800 (PST)
In-Reply-To: <14239857-9885-caf1-ded3-044f30f48e2e@redhat.com>
References: <20181105143234.6015-1-tiny.windzz@gmail.com> <14239857-9885-caf1-ded3-044f30f48e2e@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 5 Nov 2018 09:15:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKndtQw=RBaSFtuTRTgnET-VJpPBb2dWSJnig57GPPRrA@mail.gmail.com>
Message-ID: <CAGXu5jKndtQw=RBaSFtuTRTgnET-VJpPBb2dWSJnig57GPPRrA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: dump: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Laura Abbott <labbott@redhat.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jinbum Park <jinb.park7@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:01 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 11/5/18 6:32 AM, Yangtao Li wrote:
>>
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>
> Acked-by: Laura Abbott <labbott@redhat.com>
>
>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>>   arch/arm/mm/ptdump_debugfs.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
>> index be8d87be4b93..201cd467a739 100644
>> --- a/arch/arm/mm/ptdump_debugfs.c
>> +++ b/arch/arm/mm/ptdump_debugfs.c
>> @@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>>         return 0;
>>   }
>>   -static int ptdump_open(struct inode *inode, struct file *file)
>> -{
>> -       return single_open(file, ptdump_show, inode->i_private);
>> -}
>> -
>> -static const struct file_operations ptdump_fops = {
>> -       .open           = ptdump_open,
>> -       .read           = seq_read,
>> -       .llseek         = seq_lseek,
>> -       .release        = single_release,
>> -};
>> +DEFINE_SHOW_ATTRIBUTE(ptdump);

Nice! Can you do the same for arch/x86/mm/debug_pagetables.c too?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>>     int ptdump_debugfs_register(struct ptdump_info *info, const char
>> *name)
>>   {
>>
>



-- 
Kees Cook
