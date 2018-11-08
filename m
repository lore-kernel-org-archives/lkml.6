Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E7FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33CC20685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNZqjvjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33CC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeKHURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:17:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39766 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:17:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id 192-v6so15750076oii.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lkmh31+hoVnFy+XkyCL9z7DMuR9lvV88UEn3MyyZNoc=;
        b=SNZqjvjRIqO1LvQS/BQpIZK4G3NqHEPyCs7tpTdeMg+EtbOMmdZWoDlLcHpTKEqqPS
         HqChvflQaptYoSBadPMvoq7xdE7IuLicyboAU4Lb+zYhLSCpNPrwmleJFhr3CK9ThGhx
         9mFBZgFg6bsNedZJW3DePk96NHpEwXFfzsl84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lkmh31+hoVnFy+XkyCL9z7DMuR9lvV88UEn3MyyZNoc=;
        b=W9mVmtynt80OVLiZ4rH6BHWjf2064G3j5OsRExhPDOJsdND41H4C++DmZLUhazmoqQ
         WTrLmVGTliEwW7EaPMqu2UwxokmEsVpC9vITjes46BuwwymNLBTM1Y1K7ENMHZ9AbPfI
         cMyr8drC7fD80sNqr3eJz8F1yqrM4pbGjAGIWD72tGQ8TivyXSUYfISiB0kONZqTb/Go
         PBKw9U7bcsWoenRycEn1ARAe6YqizTLdlSyC8rmTD8HkEtD57wciCANqKjQ9CR2ASXAV
         y2WNmf4D8ckosrBKYNQKKOqzIq+HUd+ffaD8sM1HHmczUviyf67PygS1Vwk0Li6EW4SE
         Y9iw==
X-Gm-Message-State: AGRZ1gLnaK9lblzA8eeg1hkExUstdasEENGZSra8uBqloz83bUYDKB6V
        TRgnC9jDXMLnHSt9KsiciTcVIRXzuiJ/1Q==
X-Google-Smtp-Source: AJdET5dz2rmtPBUk3VQn4Z5OTIWknnH/Svz6xPR6dL2SDFBYPnMUluKiWzkA+goQXO+oK0VWpK3MPA==
X-Received: by 2002:aca:bc44:: with SMTP id m65-v6mr2355988oif.28.1541673738610;
        Thu, 08 Nov 2018 02:42:18 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id e191-v6sm286780oig.39.2018.11.08.02.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 02:42:17 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id t5so14083469otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:42:16 -0800 (PST)
X-Received: by 2002:a9d:635a:: with SMTP id y26mr2254628otk.27.1541673736486;
 Thu, 08 Nov 2018 02:42:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:775a:0:0:0:0:0 with HTTP; Thu, 8 Nov 2018 02:41:46 -0800 (PST)
In-Reply-To: <20181015172140.GJ2401@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
 <20181011205601.GA32757@avx2> <20181011210256.GE2401@uranus.lan>
 <20181011213006.GA13485@avx2> <20181011220009.GF2401@uranus.lan>
 <52504bd5-b4ed-518b-f748-c634172c6c68@linaro.org> <20181015172140.GJ2401@uranus.lan>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Date:   Thu, 8 Nov 2018 08:41:46 -0200
X-Gmail-Original-Message-ID: <CABdQkv_vWNbMgvR+1q9gNGHUjvvR5Pb3Z9t3YKhahp4h4P5isQ@mail.gmail.com>
Message-ID: <CABdQkv_vWNbMgvR+1q9gNGHUjvvR5Pb3Z9t3YKhahp4h4P5isQ@mail.gmail.com>
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:21 PM, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> On Mon, Oct 15, 2018 at 01:55:14PM -0300, Rafael David Tinoco wrote:
>> That is what I also had in mind, thus the patch. I just realized we had
>> another issue on LKFT (our functional tests tool) for
>> proc-self-map-files-001.c. Test 001 does pretty much the same as 002, but
>> without the MAP_FIXED mmap flag.
>>
>> Is it okay to consolidate both tests into just 1, and focus in checking
>> procfs numbers conversion only, rather than if mapping 0 is allowed or not ?
>> Can I send a v2 with that in mind ?
>
> As to me -- yes, I would move zero page testing to a separate memory testcase.
> But since Alexey is the former author of the tests better wait for his opinion.

Alexey,

would you care if we turn those 2 tests into 1, taking care of the
zero page testing elsewhere ? Would you mind if I send out a patch for
that ?
