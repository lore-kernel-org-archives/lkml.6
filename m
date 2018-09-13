Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D75FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7CE20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9WQtr2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7CE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeINCvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:51:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36286 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:51:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id i144-v6so1812542ywc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZfMrrqEqlBPDLlNRwG9FgFnYnuFp2yc5kMoAHIwceJ4=;
        b=F9WQtr2/PwFkfUMQPQrQZz/f+Jn4HJVufMWsDjM4/9OUtv73RfrtshmKX4ZcW9mXJf
         8TX8L1zd67IoEf9hpihIxPpBOZxh3cTzVhgwXQdE7BsHPO2SGuZxqDW58E5V9nisx/4U
         BEiYDNf69bgEW1PNIm1P2uu/OVf33S/vHnr+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZfMrrqEqlBPDLlNRwG9FgFnYnuFp2yc5kMoAHIwceJ4=;
        b=JR5IhafGlgjh0pbmKPxwC5MLF83JFhWGRdSqZ34e8jzCc0Jo+tRArJzKwqlAOREeDt
         r7z3M0rHtFPEoLBKJ3nA3zFUj/GYlcx69wCr/8SeTUwkpV3QobCa9Rw8vFIKnZ3+HzEF
         7ciNIPhC3m0O3AxWKPVXYlXj6KwSHkLuqz+kGhbCVlipTggrQO3uKst/1wztzkemn1Te
         ntN9vhg+ekV/VufzuRFeu5ZxttfIPKfiusC6+eMzcv30QnsqxL5MlJyLC69e26MXfTjk
         V80NS9eE7ZAhaAjmVs3nsVBL/Kt8hzywdChu5GeK7pw60MOIdXWvSh0R6INlDaK3Tw2i
         KdDg==
X-Gm-Message-State: APzg51C4m+GEdpo2uvbhKoEZceikloJW+JdX/GRTcnKbBbqMGXHw9Esj
        mrby6TQT5B5uPSfEjExsfY1e+kESQyU=
X-Google-Smtp-Source: ANB0VdbCrX00qAVHHkRwVaLsq3BlSqWYy+70bPEqSsIDQVJ96KAoQ5ADvxSrOXh68n2IkMHzjB125Q==
X-Received: by 2002:a81:ad62:: with SMTP id l34-v6mr4401708ywk.5.1536874816630;
        Thu, 13 Sep 2018 14:40:16 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1753769yww.77.2018.09.13.14.40.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:40:14 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g79-v6so1304510ybf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:40:13 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr4402115ybh.209.1536874813232;
 Thu, 13 Sep 2018 14:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 14:40:12
 -0700 (PDT)
In-Reply-To: <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
 <20180704075923.GF3701@osiris> <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 14:40:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ9hD8-2ioAKdXKc8uV+OjRSJVUftd9rY9RfW7Tkor=kw@mail.gmail.com>
Message-ID: <CAGXu5jJ9hD8-2ioAKdXKc8uV+OjRSJVUftd9rY9RfW7Tkor=kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 July 2018 at 09:59, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>> On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
>>> This series implements support for emitting the data structures associated
>>> with jump tables as 32-bit relative references instead of absolute
>>> references, which take up more space on builds that target 64-bit
>>> architectures, or implement self relocation [or both].
>>>
>>> This series enables it for arm64 and x86, although other architectures
>>> might benefit as well.
>>
>> Hello Ard,
>>
>> feel free to add the patch below which adds support for s390 to your series.
>>
>
> Thanks, I will incorporate it into v3 and beyond.

Just a quick status check! :) What're your plans for this series? I'd
still love to see it.

-Kees

-- 
Kees Cook
Pixel Security
