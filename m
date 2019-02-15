Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B859C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B8D2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NySOxpvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfBOPzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:55:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35197 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfBOPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:55:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so7556479lfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmNuGA2Kd0mQVfKFX4ACmGEe90v/s5CllvwMo1sHlqc=;
        b=NySOxpvQfVFtNEETfRATuEbB4eDot3Kim9TEHCzcG0Yq6JWs1VjlnbZNbHE7moMfrn
         5XLB8TiOMYv69QhszUILpXF7NiV661JyELLwYfSe0nK3l/XZWFzeNLcCpEiYSwUfLKrI
         RkZ2ydkjPw21SjagZUr0hAFmlUmXyIL5olTMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmNuGA2Kd0mQVfKFX4ACmGEe90v/s5CllvwMo1sHlqc=;
        b=EdVRk31T7PIgUNn8CQLD3c0uDdFynSWyQMHYDoL4goTJVMjetHx/4EM2hZU4IRzVp8
         /T2jxUCwF5fWjfs7S2x08MyuW33h8vpUicliV6igG+04kegexbuhvFTr6T4g6kfR1bFw
         iwsuqmXJzOWJuqE72aUwL5RbPNh1eJrobojx534P0e+ChbLboIJBdbOqellJcDmXw3+N
         uTWqQSpwYiCvX/YeVhRkDtPDTUFcx6mCI+Vb2B7/jnJ3jThpzXf/PKjksLETHaXKxUqa
         jhyUlmkLATZkMTxl9h9abS9+wlJfK4gyfrfVWMphryY2Ki/tdn9zfExWY4hae0i01Djf
         pDEg==
X-Gm-Message-State: AHQUAuZ2v34ylvWiEWm+hZMxmw02pFMVAH6biZO2hCISFj0d84cQiWNW
        afsI0qZ/8/gvMZydu3z+Z3V4LAgmLIQ=
X-Google-Smtp-Source: AHgI3Ib08IvB5KjBJJgcOSHPsY+rzOHS5WI0lQDpdSec3IjGu/IWCItg4fDNR9F+f/6HPxhLGRLj4w==
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr1131184lfl.93.1550246107142;
        Fri, 15 Feb 2019 07:55:07 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t14sm1375050lft.96.2019.02.15.07.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:55:05 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id j13-v6so8808510ljc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:55:04 -0800 (PST)
X-Received: by 2002:a2e:9bc2:: with SMTP id w2-v6mr5898592ljj.87.1550246104567;
 Fri, 15 Feb 2019 07:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
In-Reply-To: <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 07:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
Message-ID: <CAHk-=whBnu7TQTOoOiqSmDGpH0oxrFo9sDzJTZRFhFCv69BMrg@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000060f2b60581f0cc3b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000060f2b60581f0cc3b
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 14, 2019 at 10:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> The only way we know the interpreter wasn't truncated in the
> no-newline case is if we see whitespace after first skipping any
> leading whitespace, and it seemed really ugly to add a special scan
> there.

No, much easier (and likely better code too), to just use 'memchr()'.

What's wrong with this simple and fairly self-describing patch?

And I'll rather add a few lines due to helper functions with names to
make it more legible, rather than code in that already fairly long
existing function.

          Linus

--00000000000060f2b60581f0cc3b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_js68hrx50>
X-Attachment-Id: f_js68hrx50

IGZzL2JpbmZtdF9zY3JpcHQuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2JpbmZtdF9zY3JpcHQuYyBiL2ZzL2JpbmZtdF9zY3JpcHQuYwppbmRleCA3Y2RlM2Y0NmFk
MjYuLmM5YTdhZmQ0NzdhOSAxMDA2NDQKLS0tIGEvZnMvYmluZm10X3NjcmlwdC5jCisrKyBiL2Zz
L2JpbmZtdF9zY3JpcHQuYwpAQCAtMTQsNiArMTQsMjQgQEAKICNpbmNsdWRlIDxsaW51eC9lcnIu
aD4KICNpbmNsdWRlIDxsaW51eC9mcy5oPgogCisvKgorICogRG8gd2UgaGF2ZSB3aGl0ZXNwYWNl
IChpZ25vcmluZyBsZWFkaW5nKSBiZXR3ZWVuIGZpcnN0IGFuZCBsYXN0CisgKiAoaW5jbHVzaXZl
KS4gVGhpcyBpcyB0aGUgIndlIGFyZSB0cnVuY2F0aW5nIHRoZSBzY3JpcHQgY29tbWFuZAorICog
bGluZSIgY2FzZS4KKyAqLworc3RhdGljIGlubGluZSBib29sIHRhYnNwYyhjaGFyIGMpIHsgcmV0
dXJuIGMgPT0gJyAnIHx8IGMgPT0gJ1x0JzsgfQorc3RhdGljIGlubGluZSBib29sIG5vX3RhYl9v
cl9zcGFjZShjb25zdCBjaGFyICpmaXJzdCwgY29uc3QgY2hhciAqbGFzdCkKK3sKKwkvKiBTa2lw
IGxlYWRpbmcgc3BhY2UgKGFuZCBmaXJzdCBub24tc3BhY2UpICovCisJd2hpbGUgKHRhYnNwYygq
Zmlyc3QrKykpCisJCWlmIChmaXJzdCA+IGxhc3QpCisJCQlyZXR1cm4gZmFsc2U7CisJd2hpbGUg
KGZpcnN0IDw9IGxhc3QpCisJCWlmICh0YWJzcGMoKmZpcnN0KyspKQorCQkJcmV0dXJuIHRydWU7
CisJcmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgaW50IGxvYWRfc2NyaXB0KHN0cnVjdCBsaW51
eF9iaW5wcm0gKmJwcm0pCiB7CiAJY29uc3QgY2hhciAqaV9hcmcsICppX25hbWU7CkBAIC00Miw5
ICs2MCwxMiBAQCBzdGF0aWMgaW50IGxvYWRfc2NyaXB0KHN0cnVjdCBsaW51eF9iaW5wcm0gKmJw
cm0pCiAJZnB1dChicHJtLT5maWxlKTsKIAlicHJtLT5maWxlID0gTlVMTDsKIAotCWJwcm0tPmJ1
ZltCSU5QUk1fQlVGX1NJWkUgLSAxXSA9ICdcMCc7Ci0JaWYgKChjcCA9IHN0cmNocihicHJtLT5i
dWYsICdcbicpKSA9PSBOVUxMKQorCWNwID0gbWVtY2hyKGJwcm0tPmJ1ZiwgQklOUFJNX0JVRl9T
SVpFLCAnXG4nKTsKKwlpZiAoIWNwKSB7CiAJCWNwID0gYnBybS0+YnVmK0JJTlBSTV9CVUZfU0la
RS0xOworCQlpZiAobm9fdGFiX29yX3NwYWNlKGJwcm0tPmJ1ZisyLCBjcCkpCisJCQlyZXR1cm4g
LUVOT0VYRUM7CisJfQogCSpjcCA9ICdcMCc7CiAJd2hpbGUgKGNwID4gYnBybS0+YnVmKSB7CiAJ
CWNwLS07Cg==
--00000000000060f2b60581f0cc3b--
