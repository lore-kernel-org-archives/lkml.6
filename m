Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EEA20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoGb9CHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EEA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeK1Jtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:49:55 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33349 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1Jtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:49:53 -0500
Received: by mail-yw1-f66.google.com with SMTP id q11so9915177ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gxd2c4cHXDCaojmIun0dqsNVAUESyY75uu1aUTy7jBk=;
        b=QoGb9CHWfCdCggZmyzbZ0eXJ0w/Yol0jgj2FArNP0dhTygJWUKSo5y3aGTYtfaKDvC
         HbMGsa0myKuN8RIERKjzpGp3d8T8L1REX2DAFFyLjbxDCdgVodJdanCj93OLPjKB45vO
         sFuHVFwW+3YsIlMskKV2ua6aSSBsFb8Tvxcno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gxd2c4cHXDCaojmIun0dqsNVAUESyY75uu1aUTy7jBk=;
        b=DpDCzTCJD3R+UmvooXtpxJGjTAde+uMeuFIexinFlSyBLrfDzhy+J1lqDv48FgXFLM
         XUTFl4p4BU9XmMZ/mw6w51dkgJmH4d0p0UkXcakklD2IvvV7za2qXWZFcUuyP+5xT0Up
         v390nuXcHtNy0ZnveMAg8GHEWqAN6XNhF4y1QFhucfH88kR2PXEHNNhGZ/wAX37gFimU
         b176pNFoHjsYCPAsRo+rQU8rbys99Pd+lyQ+iNIod5/o7e7RW29GlN3dfC0cfvYNxzv4
         +0+aqrZVGkIM1nSKYSsFIbmSwU0dpF6+wvnbwqr8TpQzU5D+5aBPck/V5XLHB4X8APeb
         PjRw==
X-Gm-Message-State: AA+aEWYwCzzbfhMeRsgt7l/lN+QIlwbBICoyKvecuPs+oWxX70hIF3yP
        zw+cYpVkqK2UfxImksfAoPE69XCx7bc=
X-Google-Smtp-Source: AFSGD/VcgPd+ODdRkgWvmCRL5KpIhE5gAXX6S4SRELAiGkIIp4SNMeB2mTU3GSoQhhCd6V+wBQy/Ag==
X-Received: by 2002:a81:7d5:: with SMTP id 204mr12953255ywh.143.1543359026929;
        Tue, 27 Nov 2018 14:50:26 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id z128sm1249162ywb.96.2018.11.27.14.50.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:50:25 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id p144-v6so9794434yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:50:25 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr34005552ybi.171.1543359024985;
 Tue, 27 Nov 2018 14:50:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 14:50:24
 -0800 (PST)
In-Reply-To: <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
References: <20181119154334.18265-1-tiny.windzz@gmail.com> <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 14:50:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJuHQOi3C7_xH7Fo2H-=EmzKkwAPWmWPOUNb0WWMTLnJQ@mail.gmail.com>
Message-ID: <CAGXu5jJuHQOi3C7_xH7Fo2H-=EmzKkwAPWmWPOUNb0WWMTLnJQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 9:06 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 11/19/18 7:43 AM, Yangtao Li wrote:
>> -static const struct file_operations ptdump_curusr_fops = {
>> -     .owner          = THIS_MODULE,
>> -     .open           = ptdump_open_curusr,
>> -     .read           = seq_read,
>> -     .llseek         = seq_lseek,
>> -     .release        = single_release,
>> -};
>> +DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
>
> FWIW, I rather dislike this conversion and the DEFINE_SHOW_ATTRIBUTE()
> approach in general.  It makes it basically impossible to go from
> ptdump_curusr to ptdump_open_curusr without opening up the macro and
> reverse-engineering it.
>
> My test is that for these macros to be sane, I need to be able to find
> "ptdump_open_curusr" by grepping for "ptdump_curusr".  This fails the test.

Er, "ptdump_curusr" matches the generated name "ptdump_curusr_show",
is that what you mean?

> I don't think saving a few lines of code is worth the obfuscation.

This is the standard boilerplate for attributes, though. I'd be nice
to drop all the copy/pasted code...

-- 
Kees Cook
