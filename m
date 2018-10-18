Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D0AC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25F12098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqlZeWq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25F12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJSG3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:29:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39227 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSG3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:29:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id j193-v6so1254438ybj.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SiUcwziMywRZkXsfLZKuHpLJiHlHg4IXWhJErpBLgbQ=;
        b=WqlZeWq2E7lVQTJMpzCWQWHkObmLI3ihd8ikfH6Ht3oxzHXoCJHCsyQjFol7/6zaRf
         yP+fiZ/6nGgUmu14fxiTUEYpV+jni3mrBsqq5OGsvSn5s3cXkXAwQsorwMe+lIAXDoyG
         nwChSFKH0v6Inzm7mmQ70tPFmRN1bKI0AKiDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SiUcwziMywRZkXsfLZKuHpLJiHlHg4IXWhJErpBLgbQ=;
        b=G7yOQ3tmk50R2RoJeqXJegs9W0f78YBPozP41I43PVa5OvNO79oLU1vuzpiIIkQZni
         NPNkGCNYKEh/X4GFQgCnv3yH8Lfdt13KPqHfohnvDudIURkK+IPBTk7ydXpd4khwrV8k
         8aJZhXoGybEPNqF1gZJgCuWKN3n5dDV/pA1gMBv0WMrF1acPQpwemsjAo8wgMA0CA88R
         cQn7IcWuGFeNkzmIteAa4MSARkJLp4WtKw31nMvrCa3xSyU7Tts2JChvb9HBK5alie0m
         tIcaDAdAlu/ARCiBgx1BWjcJ+6tueYePGGAcscsFosQq+hhl9v34WoCqihsEUN2kI0vq
         R89w==
X-Gm-Message-State: ABuFfoj9TKzhdEmcP298NcwaEvpITCscTdoZaRO9Q9fF+Iv+sAsyv2fw
        wQYTma1AT8+sysbQ7iEXz5rWKt/PPhE=
X-Google-Smtp-Source: ACcGV6008bdCp7k2Rn0G5Jf3nWrwDoKgap6iHeFH7IBoM3b5ZM5sTApnKFPitij3dSkYQhN9+E7tDg==
X-Received: by 2002:a25:30c1:: with SMTP id w184-v6mr20219650ybw.47.1539901600400;
        Thu, 18 Oct 2018 15:26:40 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id d18-v6sm482175ywa.38.2018.10.18.15.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:26:38 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id y76-v6so12469553ywd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:26:38 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr21297427yws.168.1539901598269;
 Thu, 18 Oct 2018 15:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 15:26:37
 -0700 (PDT)
In-Reply-To: <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
 <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com> <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 15:26:37 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
Message-ID: <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:23 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Thu, Oct 18, 2018 at 3:19 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Oct 18, 2018 at 2:35 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> > On Thu, Oct 18, 2018 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
> [..]
>> > I cringe at users picking addresses because someone is going to enable
>> > ramoops on top of their persistent memory namespace and wonder why
>> > their filesystem got clobbered. Should attempts to specify an explicit
>> > ramoops range that intersects EfiPersistentMemory fail by default? The
>> > memmap=ss!nn parameter has burned us many times with users picking the
>> > wrong address, so I'd be inclined to hide this ramoops sharp edge from
>> > them.
>>
>> Yeah, this is what I'm trying to solve. I'd like ramoops to find the
>> address itself, but it has to do it really early, so if I can't have
>> nvdimm handle it directly, will having regions already allocated with
>> request_mem_region() "get along" with the rest of nvdimm?
>
> If the filesystem existed on the namespace before the user specified
> the ramoops command line then ramoops will clobber the filesystem and
> the user will only find out when mount later fails. All the kernel
> will say is:
>
>     dev_warn(dev, "could not reserve region %pR\n", res);
>
> ...from the pmem driver, and then the only way to figure who the
> conflict is with is to look at /proc/iomem, but the damage is already
> likely done by that point.

Yeah, bleh. Okay, well, let's just skip this for now, since ramoops
doesn't do _anything_ with pmem now. No need to go crazy right from
the start. Instead, let's make it work "normally", and if someone
needs it for very early boot, they can manually enter the mem_address.

How should I attach a ramoops_probe() call to pmem?

-Kees

-- 
Kees Cook
Pixel Security
