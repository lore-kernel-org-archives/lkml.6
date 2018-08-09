Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F35C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D108222395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXXz2JYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D108222395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeHJAni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:43:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46767 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHJAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:43:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id e23-v6so6883248ywe.13;
        Thu, 09 Aug 2018 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ZMYxGClWdvoqNG1YkWwHplIN1M8KxFq9ed6A0vaT0c=;
        b=IXXz2JYATmpfEkZmznbeJ7mTzBrQ0FTbyVHe2cdKr87f/f/WNW+Cu5yZG++Eg2p1xi
         DVsFKnLDZV/bkjOHxATf1xH/YHP6E0hIhdAzImE4nblDkwcAayHueaoDefakeaDvrdar
         hGjOGe4hLaMhGxn+J7qO7mA62kFn8K5pQRzmlVN+VVuSeo7G32VY+k83190moGtE4l+/
         DabwlIfWO8K99B8ieD/TepVzXw3gBMmbnisPRLlq/t5nZqF3VnknEAD/FFFuTzROxZkU
         5KQQ/7F3qHSZmysfeN9f6AjsXwbNRn+4lvh5jSqSqZV74ysyiD1elaIL5JdMFuGizA9O
         5MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ZMYxGClWdvoqNG1YkWwHplIN1M8KxFq9ed6A0vaT0c=;
        b=mGvzaCdZb7n/P/RJIyr8yUnIpZV6vnCUAFtN3zN8CgRymIkOiiuF/B7QTkQ1pM0rGe
         9gEC1aRxAL2PfN1VGhLaQSfOq6KlTGEaYfdYgbrN1J3Io7faFDMGV5mi3POLfpeIR94t
         5Rx5IojJgdvZY94i9f1k5uWaxqyVldQd8obRjNjzdFv37re0UBrz4fz5pV624R/gwGLf
         e4/G845x4miRb1/V4uD7qD5m9ZTcac5ZlRhJesPj5pcrlYhs5KBsaLcwhikMkXy2AHNN
         xQvNgupRoBlvkhF6S2uj2tGG2jdJpTIqWMT+4dejvASlI0jroScf3ikeubkRb7xJ7zBS
         3Sdg==
X-Gm-Message-State: AOUpUlFddXqfVd8kgXIYDNgE3BYEhbEwC+h9vpwAV+4btULEQW73uzGf
        pS96uhrAapuKp2MDj2IbWKIvTpP+sUrv0rl3cyc=
X-Google-Smtp-Source: AA+uWPwJj9+OHz59DMtA8HM7NpNW2Ppfm+9bvEBC/+kbCIGZc/AnNfCt6X1syBsUZQJv6aZ22jBZcn+khM1wCOzXB3A=
X-Received: by 2002:a1f:730c:: with SMTP id o12-v6mr2571027vkc.33.1533853005756;
 Thu, 09 Aug 2018 15:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:688f:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 15:16:45 -0700 (PDT)
In-Reply-To: <CABo9ajBKEWmgh6tBbUnrY8zM3vAH+TKWwBHn-Vz556Up+614Zw@mail.gmail.com>
References: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2Arv-ZxUMTB_zKKy58CghWsZJbTOcNdiD3KVzxJ-v973g@mail.gmail.com> <CABo9ajBKEWmgh6tBbUnrY8zM3vAH+TKWwBHn-Vz556Up+614Zw@mail.gmail.com>
From:   gengdongjiu <gengdj.1984@gmail.com>
Date:   Fri, 10 Aug 2018 06:16:45 +0800
Message-ID: <CAMj-D2De_LzxMjNT_w-N2iiqBYq4wbdY6vEvjxr5yaAuhBg+jw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] arm64: clean the additional checks before
 calling ghes_notify_sea()
To:     Tyler Baicar <baicar.tyler@gmail.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Will Deacon <will.deacon@arm.com>, rafael.j.wysocki@intel.com,
        James Morse <james.morse@arm.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-10 5:05 GMT+08:00 Tyler Baicar <baicar.tyler@gmail.com>:
> On Thu, Aug 9, 2018 at 8:32 AM, gengdongjiu <gengdj.1984@gmail.com> wrote:
>>
>> 2018-08-08 0:26 GMT+08:00 Dongjiu Geng <gengdongjiu@huawei.com>:
>> > In order to remove the additional check before calling the
>> > ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>> >
>> > After this cleanup, we can simply call the ghes_notify_sea() to let
>> > APEI driver handle the SEA notification.
>> >
>> > CC: Tyler Baicar <tbaicar@codeaurora.org>
>> > CC: James Morse <james.morse@arm.com>
>> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> > Acked-by: Will Deacon <will.deacon@arm.com>
>> > ---
>> > This cleanup is ever mentioned by Mark Rutland in [1]
>> >
>> > [1]:
>> > https://lkml.org/lkml/2018/5/31/289
>> >
>
> FWIW - Looks good to me!

Thanks very much for this comments and review,
whether I can get your "Acked-by" or "Reviewed-by"? thanks

>
> Thanks,
> Tyler
