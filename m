Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3370AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DFD21470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnIjRT3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DFD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJRGfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:35:08 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35964 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:35:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id e201-v6so11049761ywa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lg0GOna/bu3SR+krD9Mg3SxVQkU2T4SP5z5fCIw1bvI=;
        b=TnIjRT3wrnVh/VxzazJ+d5anZmywAl6XpjKbbqJ0Avo72T7/U0QrCFejeYmJv/icq/
         RTyKZ25P+EDrsWBhqCgbf2l/tyXvyXr7e376T4IXDilYh2gu81FQ3BEKDTboNg3nNb65
         UN13omd6L/QgFeAYskXg1JGjnvnTv7kT4gMB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lg0GOna/bu3SR+krD9Mg3SxVQkU2T4SP5z5fCIw1bvI=;
        b=dyEM3nXWk/rJQUUxhsnMFrpy0CcNVsnc9wbnUMFZWgUWNAsq/5pAUmDSss6GfjkD//
         kKPs5e4gI3mWv4+I+ld+3HM8p4P5umO8Xa+Xl+eJJeF4krJMGCrGbXW/u26C01uSBFDR
         CLp6EOGFFMNX226l9/yYwOBZK5bO0jj+IZA6tzdNJ/RacvQRnzqQnq3bhhROaPClj5WZ
         FcA6cOJmiI5qRYzWULkY1YJRkZCXcgTQTMpW7sSXsk9hfJvhERQ5eTX2+Wo5x9jNxN/k
         0JxTa1um5jflohQwVq8HPSMuZ69s0fvEQrMoL4q/Rj/eoUP6URU4EaWO6yQIhMTPz2zw
         v/8g==
X-Gm-Message-State: ABuFfoiBBEvvZxHeRbMkvvjTNf4XzFBN/NJD/bgm0+ciMvTrrYRoKy2d
        ZJNgunmvu8lda1eSVgHddR+bnnJDPHg=
X-Google-Smtp-Source: ACcGV632RoF6G8LanlBCiSE8A7JxQV6dqFmQ4LZWP4fqmf/fnWllWAmEQODyd4n978KHwGRjxiUCRg==
X-Received: by 2002:a81:e807:: with SMTP id a7-v6mr17376304ywm.9.1539815838294;
        Wed, 17 Oct 2018 15:37:18 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id z130-v6sm5900949ywd.91.2018.10.17.15.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:37:16 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id e201-v6so11049715ywa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:37:16 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr17142882yws.168.1539815836119;
 Wed, 17 Oct 2018 15:37:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 15:37:15
 -0700 (PDT)
In-Reply-To: <70d6b61f-25af-f903-0693-46e649c08aff@infradead.org>
References: <20181017021708.GA22211@beast> <aed0041d-7c28-4dfb-91b5-fc83174d8744@infradead.org>
 <875zy0ki3r.fsf@intel.com> <70d6b61f-25af-f903-0693-46e649c08aff@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 15:37:15 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJDZjaSLE9uPZVWCqrtSMh1-x8H=X+3ptSYrL5QZdo8xA@mail.gmail.com>
Message-ID: <CAGXu5jJDZjaSLE9uPZVWCqrtSMh1-x8H=X+3ptSYrL5QZdo8xA@mail.gmail.com>
Subject: Re: [PATCH] docs: Introduce deprecated APIs list
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/17/18 3:00 AM, Jani Nikula wrote:
>> On Tue, 16 Oct 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 10/16/18 7:17 PM, Kees Cook wrote:
>>>> As discussed in the "API replacement/deprecation" thread[1], this
>>>> makes an effort to document what things shouldn't get (re)added to the
>>>> kernel, by introducing Documentation/process/deprecated.rst. It also
>>>> adds the overflow kerndoc to ReST output, and tweaks the struct_size()
>>>> documentation to parse correctly.
>>>>
>>>> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005282.html
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>  Documentation/driver-api/basics.rst  |  3 +
>>>>  Documentation/process/deprecated.rst | 99 ++++++++++++++++++++++++++++
>>>>  Documentation/process/index.rst      |  1 +
>>>>  include/linux/overflow.h             |  2 +-
>>>>  4 files changed, 104 insertions(+), 1 deletion(-)
>>>>  create mode 100644 Documentation/process/deprecated.rst
>>>
>>>
>>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>>> index 40b48e2133cb..2f224f43dd06 100644
>>>> --- a/include/linux/overflow.h
>>>> +++ b/include/linux/overflow.h
>>>> @@ -291,7 +291,7 @@ static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
>>>>  }
>>>>
>>>>  /**
>>>> - * struct_size() - Calculate size of structure with trailing array.
>>>> + * function struct_size() - Calculate size of structure with trailing array.
>>>
>>> That syntax is not explained nor documented in Documentation/doc-guide/kernel-doc.rst.
>>>
>>> Is the root problem that the function name begins with "struct"?
>>> Please explain in the patch description.
>>
>> Indeed, shouldn't be needed.

I actually thought the problem was with it not knowing how to deal
with struct_size() being a macro instead of a real function.

> Well, this is just a guess (no testing), but in scripts/kernel-doc (at line
> 1907 in 4.19-rc8), we can see:
>
>         if ($identifier =~ m/^struct/) {
>             $decl_type = 'struct';
>         } elsif ($identifier =~ m/^union/) {
>             $decl_type = 'union';
>         } elsif ($identifier =~ m/^enum/) {
>             $decl_type = 'enum';
>         } elsif ($identifier =~ m/^typedef/) {
>             $decl_type = 'typedef';
>         } else {
>             $decl_type = 'function';
>         }
>
> I wouldn't be surprised if a function named "struct_size" looks like a
> type struct.  Maybe it needs to be more strict, with either a space or
> word boundary at the end of each type string.  E.g.:
>
>         if ($identifier =~ m/^struct\b/) {
>             $decl_type = 'struct';
>         } elsif ($identifier =~ m/^union\b/) {
>             $decl_type = 'union';
>         } elsif ($identifier =~ m/^enum\b/) {
>             $decl_type = 'enum';
>         } elsif ($identifier =~ m/^typedef\b/) {
>             $decl_type = 'typedef';
>         } else {
>             $decl_type = 'function';
>         }

But I see it's actually the prefix! :P

Using the above code fixes it for me. Can you send this fix with my
Tested-by, and I'll spin a v2 of my "deprecated.rst" patch without the
overflow.h change?

-Kees

-- 
Kees Cook
Pixel Security
