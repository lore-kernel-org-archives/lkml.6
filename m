Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6920843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbuKd/Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA6920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeKCFIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:08:44 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43790 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeKCFIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:08:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id g75-v6so1261216yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l+lwlO8qAj1L+ygNyyf/Hxrs8p5HctdKaRew6DaO3r8=;
        b=ZbuKd/VqClYh4i0wY0Lein4Qes8KWRODNEEBfrCiu8qKEiWcm9MkupwDbzJTm3Zgna
         rKbdgfsKrpMc0ske7FT8kND8B02OxDNkxY3NiZmIuTm/2+3zJ3/GNSBL1lwyU3Fk+pyP
         KKnLc7ZXc7DilWg/WQ/qoZUJYxkLI4iBLq0p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l+lwlO8qAj1L+ygNyyf/Hxrs8p5HctdKaRew6DaO3r8=;
        b=aQfrFAm32I9vd3x2JpWrIZoqp3+wNjdaa3lH1FskxUHKPtXGsTPt3k59EmqEA6Ax3x
         C7ZgCFJ3v3bbQPvbUtbIKeo8TTAMtjxOp4jKBR0FHg5yOhuJU1zZcHWPoJ2KVVTIni0Z
         rokIszh7Kueru8F6r3oozySKlrly7gn03jQNn+dkl0N79ZD1eFym8ZYqTW0hDMMCpUlG
         tuNuCtAYJoAtJIYxmaJjjltH70dbk1rbaj74qR8IOwBlqgxN0OQu9yAvDs17eumoRtd5
         z7C0eDt9bRO6RuWz6aofErA5FdHCgjxE6Oz0mx58yUGrp2FFPgDUrP70YoQRqwxJO8IV
         lffQ==
X-Gm-Message-State: AGRZ1gL1XHjhO20xshpxlq5A1z0cgl6011mh+BnySlXGB2ty7MmRl05p
        RnfUX5BJ3mHH9LP+n/7wMEptwESUIO8=
X-Google-Smtp-Source: AJdET5fuYBuHV0cSM11Rm95N76bZ1r3KbyKkzIvQoMe9+TXfBBhgMrZqP3n7BvmjSM6jgiwS7Se8tg==
X-Received: by 2002:a25:eb11:: with SMTP id d17-v6mr13101994ybs.338.1541188811876;
        Fri, 02 Nov 2018 13:00:11 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id f68-v6sm8915260ywh.60.2018.11.02.13.00.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:00:10 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id j75-v6so1227719ywj.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:00:10 -0700 (PDT)
X-Received: by 2002:a81:813:: with SMTP id 19-v6mr13176409ywi.168.1541188809749;
 Fri, 02 Nov 2018 13:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 13:00:08 -0700 (PDT)
In-Reply-To: <20181102180111.GA14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org> <20181101235200.28584-9-keescook@chromium.org>
 <20181102180111.GA14942@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 2 Nov 2018 13:00:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
Message-ID: <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
Subject: Re: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:01 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Nov 01, 2018 at 04:52:00PM -0700, Kees Cook wrote:
>> The actual number of bytes stored in a PRZ is smaller than the
>> bytes requested by platform data, since there is a header on each
>> PRZ. Additionally, if ECC is enabled, there are trailing bytes used
>> as well. Normally this mismatch doesn't matter since PRZs are circular
>> buffers and the leading "overflow" bytes are just thrown away. However, in
>> the case of a compressed record, this rather badly corrupts the results.
>
> Actually this would also mean some data loss for non-compressed records were
> also there before, but is now fixed?

No, it's what I mentioned in the commit log: only the "tail" of any
data was getting stored, which is consistent with the configuration
given. The main problem is that ECC bytes weren't part of the
calculation the ram backend provided to pstore for pstore to pick the
correct amount of bytes to compress.

>> This corruption was visible with "ramoops.mem_size=204800 ramoops.ecc=1".
>> Any stored crashes would not be uncompressable (producing a pstorefs
>> "dmesg-*.enc.z" file), and triggering errors at boot:
>>
>>   [    2.790759] pstore: crypto_comp_decompress failed, ret = -22!
>>
>> Reported-by: Joel Fernandes <joel@joelfernandes.org>
>> Fixes: b0aad7a99c1d ("pstore: Add compression support to pstore")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Thanks!
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

> Also should this be fixed for other backends or are those good? AFAIR, I saw
> this for EFI too.

It seemed like the other backends were doing it correctly (e.g. erst
removes the header from calculation, etc). I did see that EFI
allocates more memory than needed?

        efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
        if (!efi_pstore_info.buf)
                return -ENOMEM;

        efi_pstore_info.bufsize = 1024;

efi_pstore_write() does:

        ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
                              !pstore_cannot_block_path(record->reason),
                              record->size, record->psi->buf);

and efivar_entry_set_safe() says:

 * Returns 0 on success, -ENOSPC if the firmware does not have enough
 * space for set_variable() to succeed, or a converted EFI status code
 * if set_variable() fails.

So I don't see how this could get truncated. (I'm not saying it
didn't... just that I can't see it in an obvious place.)

-Kees

-- 
Kees Cook
