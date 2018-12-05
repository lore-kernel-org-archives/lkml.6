Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1774C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3448208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex4kS9Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3448208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeLEXiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:38:02 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46923 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEXiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:38:02 -0500
Received: by mail-yb1-f196.google.com with SMTP id l126so5711856ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ir9MSZpuxM6D+erZKZloWc1q6q+x3L3ZGqxz9Yh0TO4=;
        b=Ex4kS9DtDYkQSIpsukKr0vhqfyhKwtBBAxa+l0KRVdbys2db0GHKhtpTI8P/60oSf5
         TbN0Z5qLrMprijW2j70mBM4T84o953HSSt5xaYgiT+7SeqkVjRctaS+3Accf69cce6TM
         aL4RlmS3NGyupnxZ+/atvbPk0L+VejHQcvcrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ir9MSZpuxM6D+erZKZloWc1q6q+x3L3ZGqxz9Yh0TO4=;
        b=hV4dKJVgScUfBKg8kesKM0o0geCKlyGWWJG7jkzOApFxHVDSRhxmJye9Ch7qiA3JKZ
         H7hj5+E1VI/w6VRvxr1bAzickHsWEvRK0iDIkfzdRDO0/8xyc6wli3Wfre4uNhsAxi1G
         8ZamNPQMEIaW/rimilyYrWdJoMQK4DHM7SuQFeXGGAuQRrCAQsLutrh/OC4YPdBYJ114
         LXXw6coABl9l9gRugm6alg5mhxd1kdOyBclCClkU0bI3Z2RCIMfrzvw1U0ba3Emeo+M7
         VPyIQM2JPui6DP2BcRnX+4n/AGYC7noOEu6zTHvNpldVKrMH0eqXDOcMFumWOvPHK1p4
         9bhg==
X-Gm-Message-State: AA+aEWaaHbXJykJINiyTzZ7qaF4St1cYWcsApMBARdTkeBV6xgP+FMKT
        hGJaq99jy4kFy9GDztuafSd/qMc81rg=
X-Google-Smtp-Source: AFSGD/V6NHl4fvX1pfCVVTWcmPqO+K59rdY0o36S/+0numSmPPD1kEc/XUwSIkcoAVuS59mUha5yfA==
X-Received: by 2002:a81:af27:: with SMTP id n39mr26412162ywh.452.1544053081256;
        Wed, 05 Dec 2018 15:38:01 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id r20sm14578351ywa.13.2018.12.05.15.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:38:00 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id d187so1345283ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:37:59 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr24461270ybi.171.1544053079487;
 Wed, 05 Dec 2018 15:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-2-ard.biesheuvel@linaro.org> <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
In-Reply-To: <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 15:37:48 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ915yAyLWQgGHLH5w8zn4rZTP1VTj=egReG5edwTh8pA@mail.gmail.com>
Message-ID: <CAGXu5jJ915yAyLWQgGHLH5w8zn4rZTP1VTj=egReG5edwTh8pA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bpf: add __weak hook for allocating executable memory
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:02 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2018-11-23 at 23:18 +0100, Ard Biesheuvel wrote:
> > By default, BPF uses module_alloc() to allocate executable memory,
> > but this is not necessary on all arches and potentially undesirable
> > on some of them.
> >
> > So break out the module_alloc() and module_memfree() calls into __weak
> > functions to allow them to be overridden in arch code.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
>
> It looks like some of the architectures call module_alloc directly in their
> bpf_jit_compile implementations as well.

Ew, good catch. :P

-- 
Kees Cook
