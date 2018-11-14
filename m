Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B502243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLfmCgmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B502243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeKOJcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:32:43 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38139 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeKOJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:32:43 -0500
Received: by mail-yb1-f194.google.com with SMTP id u103-v6so7641878ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UfwhaKc7q0EuCN4FB9Uuv3iZJXbFbcNYKpzhfERD2dA=;
        b=fLfmCgmuZlvjSklSa0K7EIkaoR+/nGeUiJfpEl1OFnwc4CJyZYs3aIYNm3MGN86Elh
         pWXcD45nbU3vZdK0iQAPItVlLD0oB+w2BSP8uqJorW6CC6KTazoqUrzPd6UXxcyDjZ//
         3MZOYSQ32xwRb1R19uaUdQHLI7qeyiz1TXoZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UfwhaKc7q0EuCN4FB9Uuv3iZJXbFbcNYKpzhfERD2dA=;
        b=Da+ZBe3/lP59d+pFbZJD8HojByaqcZvqBLgDpsN5Kk14j8ELMiBEuD1opzFwOUaEwD
         bdH2QP02IMfHC7LOGXxfEE029MJBV+RLB2RHwIiC3jQCn0H0DLU+jf35IQrXWdOG9MGQ
         lc28fF8K53k5pSBAcQb43U5jFIa6I2H07PaxuhYzOLaLBhO/+faCRExjsJFqsCrTYxtX
         ayOeGOQbtRg2eNLej5rnGI1rozlOLWqrmd7TQU9KYig1gW+lcyuq2uwAocA/+mGPIajq
         ayXI2s+hdg4ssGhiPfsWbPCC6cbIAaR2/AQz6G1tnNAr6txwLhyfIWOq0ySA1yzZVfDz
         kiQg==
X-Gm-Message-State: AGRZ1gJFRqVqMgScY7ZGI03q05eMAaGOnqZOYBBqbq/8lMgblN3T8Ibv
        r1c9ptYqRPIgPMb1ZIUxfas1K9Hvz+4=
X-Google-Smtp-Source: AJdET5eND4+i5siCz96sMsnML8KtUdAkuk6e4Q2cs/ccGnoOoQDS4tn99gbjQ/U16MJkrkWEQZIvJw==
X-Received: by 2002:a25:7811:: with SMTP id t17-v6mr3598620ybc.479.1542238040175;
        Wed, 14 Nov 2018 15:27:20 -0800 (PST)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id 203-v6sm6493823ywg.29.2018.11.14.15.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:27:19 -0800 (PST)
Received: by mail-yw1-f45.google.com with SMTP id i20so605117ywc.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:27:18 -0800 (PST)
X-Received: by 2002:a81:98cf:: with SMTP id p198-v6mr3742424ywg.353.1542238038318;
 Wed, 14 Nov 2018 15:27:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 15:27:17
 -0800 (PST)
In-Reply-To: <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org> <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 17:27:17 -0600
X-Gmail-Original-Message-ID: <CAGXu5j+pSP7+ScCc4PrM+PCRSO=3-1=OLdo8WBcgJpk7vjM1vw@mail.gmail.com>
Message-ID: <CAGXu5j+pSP7+ScCc4PrM+PCRSO=3-1=OLdo8WBcgJpk7vjM1vw@mail.gmail.com>
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 4:35 AM, William Kucharski
<william.kucharski@oracle.com> wrote:
>
>
>> On Nov 13, 2018, at 5:51 PM, Isaac J. Manjarres <isaacm@codeaurora.org> wrote:
>>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index 852eb4e..0293645 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -151,7 +151,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>>                                      bool to_user)
>> {
>>       /* Reject if object wraps past end of memory. */
>> -     if (ptr + n < ptr)
>> +     if (ptr + (n - 1) < ptr)
>>               usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
>
> I'm being paranoid, but is it possible this routine could ever be passed "n" set to zero?

It's a single-use inline, and zero is tested just before getting called:

        /* Skip all tests if size is zero. */
        if (!n)
                return;

        /* Check for invalid addresses. */
        check_bogus_address((const unsigned long)ptr, n, to_user);


>
> If so, it will erroneously abort indicating a wrapped address as (n - 1) wraps to ULONG_MAX.
>
> Easily fixed via:
>
>         if ((n != 0) && (ptr + (n - 1) < ptr))

Agreed. Thanks for noticing this!

-Kees

-- 
Kees Cook
