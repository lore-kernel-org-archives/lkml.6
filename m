Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD70C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3083E206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8jdbwt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3083E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeI2EUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39634 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeI2EUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id c4-v6so3300519ybl.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6s+ZOaICUZVRqFQ9Pv/dCWYlSkWok16ggXbo3r84W2Q=;
        b=D8jdbwt6VfkvtaKVwYzuPqub/PpKJYeY85GZPTxtpFsuy7XvyVeyg87DCnqkh8O+Yp
         cQ7iG68cB0HY02JI7E07JfUjlC367kyLDEuCQyeKhSxS7x1hqDZgD+40PkiyeDa+5hN1
         49pWO1FnQXIjxiby1ygKnqqn5KZHf16zdWG0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6s+ZOaICUZVRqFQ9Pv/dCWYlSkWok16ggXbo3r84W2Q=;
        b=oXOgLYFKFyktDMlRu87NT0nu/bpVIl2hNMtvOi6C8A/CUZ936PSNfHALB3/sUTfLj/
         0LrMta7mITuYIP/AWtPDgUxOYv1jJTE7ZFOr2GJNZO9MSwyhl0eI9mZO/W83gfxkV2hS
         5cDLS3IN4fj1iMLHFVKHVK7uzudaM4ujAAYee2wULVSTbmmPf/HzlKHqeFJPdJ1mGTH5
         RsHqpuZSRT0hsq7eNvl2nU5OEbtwrMUqIhDTAli+C8gTrMTXgo6L6IIhOKccyC/EiU/Q
         FsyEV6ZIdPX2+IKeN672k1IiQ524rpMDysU6iZIB3pdupdM2vG2zX5NNUKvEwBYMabrw
         /YqA==
X-Gm-Message-State: ABuFfoiUxxprxTfj1H0RcBNTTzUzAcx7y6z5uEXOqG20N28uCEqHa+QY
        6cCQFFWuKoavdGqJL+qG7GAs98pBodE=
X-Google-Smtp-Source: ACcGV60A973aEXnCIfLhECTYxEY2rehoZMzgXjJdHW98uRsuVVsgyJIBN/7i5psT9iBgWpAhscByHg==
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr333129ybf.508.1538171693961;
        Fri, 28 Sep 2018 14:54:53 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w207-v6sm8973504yww.17.2018.09.28.14.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:54:52 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id w7-v6so3296441ybm.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:54:52 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr320269ybg.171.1538171691994;
 Fri, 28 Sep 2018 14:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 14:54:51
 -0700 (PDT)
In-Reply-To: <20180928142630.f4501105f413f2b5b4772a8b@linux-foundation.org>
References: <20180917091531.21356-1-nixiaoming@huawei.com> <20180928142630.f4501105f413f2b5b4772a8b@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 28 Sep 2018 14:54:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLOv6X8-c1gpRLF6te5hzFD=-b8CSUpb_s+Xa0Pyd4fjA@mail.gmail.com>
Message-ID: <CAGXu5jLOv6X8-c1gpRLF6te5hzFD=-b8CSUpb_s+Xa0Pyd4fjA@mail.gmail.com>
Subject: Re: [PATCH] fix memory leak in ramoops_init
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     nixiaoming <nixiaoming@huawei.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Geliang Tang <geliangtang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 2:26 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 17 Sep 2018 17:15:31 +0800 nixiaoming <nixiaoming@huawei.com> wrote:
>
>> 1, memory leak in ramoops_register_dummy.
>>    dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
>>    but no free when platform_device_register_data return fail
>>
>> 2, if kzalloc(sizeof(*dummy_data), GFP_KERNEL) return NULL,
>>     but platform_driver_register(&ramoops_driver) return 0
>>    kfree(NULL) in ramoops_exit
>> so, add return val for ramoops_register_dummy, and check it in ramoops_init
>>
>> 3, memory leak in ramoops_init.
>>    miss platform_device_unregister(dummy) and kfree(dummy_data)
>>    when platform_driver_register(&ramoops_driver) return fail
>
> Looks right.
>
> It's unclear (to me) who maintains fs/pstore/ram.c.  Let's add some
> Cc's and see if we can catch a reviewed-by.

It's me:

PSTORE FILESYSTEM
M:      Kees Cook <keescook@chromium.org>
M:      Anton Vorontsov <anton@enomsg.org>
M:      Colin Cross <ccross@android.com>
M:      Tony Luck <tony.luck@intel.com>
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
for-next/pstore
F:      fs/pstore/
F:      include/linux/pstore*
F:      drivers/firmware/efi/efi-pstore.c
F:      drivers/acpi/apei/erst.c
F:      Documentation/admin-guide/ramoops.rst
F:      Documentation/devicetree/bindings/reserved-memory/ramoops.txt
K:      \b(pstore|ramoops)

I'll take review it and take it via the pstore tree. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
