Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E07C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F412083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJq7Vytp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F412083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJRPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:14:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45236 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeJRPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:14:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id d9-v6so11430419ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+MvWb7FScBQHpcA+MY4LKYbrHLopplNtJvf80AkolrM=;
        b=KJq7VytpQBf3J5notnZxP97abGDc+p3ux5/2r8GOxxxfAFY55HcDn7cukirqCxZ8Lf
         jQzz0ZO9dL3iyFPHM5KH9ViFO86p2QGzkNYTuzGy9jPe5upyHsR+dmp/bl7V1Awl9plx
         deQ3SH7vbt2t0fWY/kU912zuCsAzXAB9jpfw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+MvWb7FScBQHpcA+MY4LKYbrHLopplNtJvf80AkolrM=;
        b=uCW1zhCLkPM/j8QN0tbXanjTK4EAnh/VPjYBFb+NfKI4hbv75FzUFDgfRqCPhIPVrz
         OgCl+ReJYRDzw7202/N4kBCl1+AIcOKDdckh9TEN5pO6m0JRpifu2XQoyAxRNwKCqFcq
         2aQhQmRPtjgOheadsUCN50u/42uYfWF8oS0wJ9n6cOVI6+sKgpgmT5OTuDeNwGPKQz4W
         A96+TfYOaieR6hMy2pVnLILg9E3ch+5BmjimRkNsv60vdQCCGJbf9Ii+HJoEMYdKKzdd
         Y8U3a3zFKA0lqsbwUIOtjhR8lYsGeXzRLsaVLCnprd5lmaEQxp3ABnJwKojksXvKOSZQ
         lmQg==
X-Gm-Message-State: ABuFfojteb3qQ2N6g445Ham/AkskbV3+roVjcjScSvWx1BhmCWXdplaN
        14rtI4dB6ok7Pxoz1lxI/tRg5W9Byaw=
X-Google-Smtp-Source: ACcGV625QwCbVJ3IiYsrCsrDE1Rtx2IyjcKLJKduFWPpZF+H0ZCCYX0tCvy14+x/kGEJzBYE/ur0Tg==
X-Received: by 2002:a25:a1c4:: with SMTP id a62-v6mr16906389ybi.157.1539846892578;
        Thu, 18 Oct 2018 00:14:52 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id n128-v6sm4924734ywc.71.2018.10.18.00.14.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 00:14:50 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id m129-v6so11432388ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:14:50 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr18170922yws.168.1539846890055;
 Thu, 18 Oct 2018 00:14:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 00:14:49
 -0700 (PDT)
In-Reply-To: <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 00:14:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
Message-ID: <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:49 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Wed, Oct 17, 2018 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> When ramoops reserved a memory region in the kernel, it had an unhelpful
>> label of "persistent_memory". When reading /proc/iomem, it would be
>> repeated many times, did not hint that it was ramoops in particular,
>> and didn't clarify very much about what each was used for:
>>
>> 400000000-407ffffff : Persistent Memory (legacy)
>>   400000000-400000fff : persistent_memory
>>   400001000-400001fff : persistent_memory
>> ...
>>   4000ff000-4000fffff : persistent_memory
>>
>> Instead, this adds meaningful labels for how the various regions are
>> being used:
>>
>> 400000000-407ffffff : Persistent Memory (legacy)
>>   400000000-400000fff : ramoops:dump(0/252)
>>   400001000-400001fff : ramoops:dump(1/252)
>> ...
>>   4000fc000-4000fcfff : ramoops:dump(252/252)
>>   4000fd000-4000fdfff : ramoops:console
>>   4000fe000-4000fe3ff : ramoops:ftrace(0/3)
>>   4000fe400-4000fe7ff : ramoops:ftrace(1/3)
>>   4000fe800-4000febff : ramoops:ftrace(2/3)
>>   4000fec00-4000fefff : ramoops:ftrace(3/3)
>>   4000ff000-4000fffff : ramoops:pmsg
>
> Hopefully ramoops is doing request_region() before trying to do
> anything with its ranges, because it's going to collide with the pmem
> driver doing a request_region(). If we want to have pstore use pmem as
> a backing store that's a new drivers/nvdimm/ namespace personality
> driver to turn around and register a persistent memory range with
> pstore rather than the pmem block-device driver.

Yup: it's using request_mem_region() (that's where the labels above
are assigned).

As for nvdimm specifically, yes, I'd love to get pstore hooked up
correctly to nvdimm. How do the namespaces work? Right now pstore
depends one of platform driver data, device tree specification, or
manual module parameters.

-Kees

-- 
Kees Cook
Pixel Security
