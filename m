Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF6FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D22175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tdx3KVLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248D22175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeKOJPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:15:04 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46498 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeKOJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:15:04 -0500
Received: by mail-yb1-f196.google.com with SMTP id i17-v6so7597473ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9+16vD7tcZqTqIQNEYNXJfNQR7PqVdvCAhaK0VxMFtk=;
        b=Tdx3KVLozLw4/a7w8oaceLG5wGCuCkBWTfIn1nKefu1fE4X3lrKGLSWol/vsUe/5as
         WjJPkLtcfbbNajPGIPgxWdZBuAAAQAGb2yfKFleJn4mvqdRcpwfGTwZ2mAgorMNcDINS
         ++kdzcu/9gDWv66dcvu4vNUDq+hj70NdvSnWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9+16vD7tcZqTqIQNEYNXJfNQR7PqVdvCAhaK0VxMFtk=;
        b=DTVs9XagQmERwrqRWW1n2yKmbAYHnUPX8fLjvra6SHidu/1g2uQcmldlvvfF4rEPYP
         XKBt47UVd6SSTyoVVhrpK7Dqk9zNaRevsdog/fumdpNF3iPUKqRhoU3nNvYF4xivEuxf
         t0DTRhNwf8sT7QJV62ZmcA9+kstKBJHMelqYghL7l1JHMQ/N9znGAB2dj9hpnPFVOT1E
         5pAJ8R7mBJMFP8sEildGOD7YpwVM5v5I4Q1k017IEOrr0i0frfm5pBBw+vmJkDkGXlfT
         qmONCNotwjZ9JOZjl0y3Ceys0TmQ3clpc+u+sZ/QpoT+o4ezUAkZ+IX6Ba4HnK3z/w7l
         AYrw==
X-Gm-Message-State: AGRZ1gLHaK7xKLk8EnBfGLB+DSzG9gktklVRhmzYiZfs3hlMyQ1B6TGN
        Rv4obaBDpV3RlY3+P/parFiONRvLZyk=
X-Google-Smtp-Source: AJdET5dmfQ67ExGAAHIS6FDqxo+jKDu1I2M2yyAvUJXqj7t03zAQShOwprmic9FdZ9OKW501coRQiQ==
X-Received: by 2002:a25:728b:: with SMTP id n133-v6mr3660772ybc.160.1542236985111;
        Wed, 14 Nov 2018 15:09:45 -0800 (PST)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id c6-v6sm19135900ywh.34.2018.11.14.15.09.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:09:44 -0800 (PST)
Received: by mail-yw1-f41.google.com with SMTP id t13so3795089ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:09:43 -0800 (PST)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr3823041ywd.124.1542236983381;
 Wed, 14 Nov 2018 15:09:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 15:09:42
 -0800 (PST)
In-Reply-To: <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
References: <20181114131642.21425-1-dh.herrmann@gmail.com> <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 17:09:42 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
Message-ID: <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
To:     David Herrmann <dh.herrmann@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 9:40 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 11/14/18 5:16 AM, David Herrmann wrote:
>>
>> This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.
>>
>> Please note that `strlcpy()` does *NOT* do what you think it does.
>> strlcpy() *ALWAYS* reads the full input string, regardless of the
>> 'length' parameter. That is, if the input is not zero-terminated,
>> strlcpy() will *READ* beyond input boundaries. It does this, because it
>> always returns the size it *would* copy if the target was big enough,
>> not the truncated size it actually copied.
>>
>> The original code was perfectly fine. The hid device is
>> zero-initialized and the strncpy() functions copied up to n-1
>> characters. The result is always zero-terminated this way.
>>
>> This is the third time someone tried to replace strncpy with strlcpy in
>> this function, and gets it wrong. I now added a comment that should at
>> least make people reconsider.
>>
>
> Can we switch to strscpy instead? This will quiet gcc and avoid the
> issues with strlcpy.

Yes please: it looks like these strings are expected to be NUL
terminated, so strscpy() without the "- 1" and min() logic would be
the correct solution here. If @hid is already zero, then this would
just be:

       strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
       strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
       strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));

If they are NOT NUL terminated, then keep using strncpy() but mark the
fields in the struct with the __nonstring attribute.

-Kees

>
>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>>   drivers/hid/uhid.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> index fefedc0b4dc6..0dfdd0ac7120 100644
>> --- a/drivers/hid/uhid.c
>> +++ b/drivers/hid/uhid.c
>> @@ -496,12 +496,13 @@ static int uhid_dev_create2(struct uhid_device
>> *uhid,
>>                 goto err_free;
>>         }
>>   -     len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
>> -       strlcpy(hid->name, ev->u.create2.name, len);
>> -       len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
>> -       strlcpy(hid->phys, ev->u.create2.phys, len);
>> -       len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
>> -       strlcpy(hid->uniq, ev->u.create2.uniq, len);
>> +       /* @hid is zero-initialized, strncpy() is correct, strlcpy() not
>> */
>> +       len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
>> +       strncpy(hid->name, ev->u.create2.name, len);
>> +       len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
>> +       strncpy(hid->phys, ev->u.create2.phys, len);
>> +       len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
>> +       strncpy(hid->uniq, ev->u.create2.uniq, len);
>>         hid->ll_driver = &uhid_hid_driver;
>>         hid->bus = ev->u.create2.bus;
>>
>



-- 
Kees Cook
