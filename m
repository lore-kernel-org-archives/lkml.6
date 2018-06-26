Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF5FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178626D50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/z1bRj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0178626D50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFZTSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:18:03 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37280 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeFZTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:18:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so18234262lfb.4;
        Tue, 26 Jun 2018 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HRnOsWYtAEhbFhgBHU1RV6bWprWz01uyhv9jcYPYjhw=;
        b=u/z1bRj/2Qi6AOcmZ9gXj/PTmHGOUCFtX8abaGWhlzdnS1nBtHXRDydMyVLv19QAa3
         TiZYtA+y4E9nN4WvfWokrZaTy19W+GG5Sq7TcVadqPhkKZZzt7FHpynl2K7SaIanCPBS
         uYF7LZBUvscaa7tDziid/Gsm7xp2Wy43ziROk99KC/V9vmz9mKq/GGM950ywApUqiUMP
         ao/EKgMzi5080BnWRL6QTTlEzaA6Y0xdDsOCT5q4u8y/ww21ICAESl/eRrPaE0P543Sc
         oAfnTHggFSqiiFTbh9qiB+1FimeEGVd+BZ1XNVgBPjU0U+EKBectJhIwvVea4LpyJfeR
         duhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HRnOsWYtAEhbFhgBHU1RV6bWprWz01uyhv9jcYPYjhw=;
        b=YMkP3fzgq7IZfGunirfliVR3n9n6JNe25TFpGXXClUpVhdlZn1r/jwdrw6rsiTRllN
         TKE/UtKH2L3FH0cvosUsI7rh3qBTGEQVYoU9IBpXCii+FEWSb1FiauLmYxOVJsuUuxSC
         TE9zTGhkdzpGycFgBKcsOYulhT9t9rYSJ49anG4tzzhYBFLeh3lHXhb58PnVln+uBwOl
         EC5r9/+g4zmVP5d3oj3ir3woTbmpJ1v8YxaN31DmlQKIOLz/+EJtOrn6BxnpGGIXfB8D
         uCXT4T0V0xB4Ldr0LkvrbUsUOZLLBKQ5d1/8MlPQ5/NSCgkpY3Dsy7QyYS9C8Ji9lvkS
         nu+Q==
X-Gm-Message-State: APt69E1xjbeVd5g+dpr+86XpX9vA1gcD+RALKLcoS5jYyTbP6J1DNlM3
        6MWc8V+hRPP0G+TN1Rg96JtOEFuPIG6XyD8T35U=
X-Google-Smtp-Source: AAOMgpdhxSNGeDpcPm07TEP0VwA0aWc+xCl66Q1CPGdRmheBT+HjJrlVye16sTafQh/MmtHSsecRR9hZlslWqbYuaGs=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr2229282lfc.55.1530040679819;
 Tue, 26 Jun 2018 12:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:17:59
 -0700 (PDT)
In-Reply-To: <d437aba7-f25f-0a96-e42b-997a3b6cda23@infradead.org>
References: <20180626160442.572358-1-arnd@arndb.de> <d437aba7-f25f-0a96-e42b-997a3b6cda23@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Jun 2018 21:17:59 +0200
X-Google-Sender-Auth: 2BpAUYHqtnp6LoXehDEObU9a1Kg
Message-ID: <CAK8P3a2b=mTi1cM_wzzcPyDpxmhHhMx8wFtVqAocordoiMwstw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: document ktime_get_*() APIs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Dave Chinner <david@fromorbit.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:19 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/26/2018 09:03 AM, Arnd Bergmann wrote:

>> diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
>> new file mode 100644
>> index 000000000000..97dafa69dddf
>> --- /dev/null
>> +++ b/Documentation/core-api/timekeeping.rst
>> @@ -0,0 +1,185 @@
>> +ktime access
>> +============
>
> I would prefer "ktime accessors" or "ktime interfaces", but no big deal.

Ok, changed to "ktime accessors".

>> +nanosecond, timespec64, and second output
>> +-------------------------------------
>

Fixed.

> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

      Arnd
