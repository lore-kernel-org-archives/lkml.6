Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E75C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6302075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ID9txlw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6302075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030595AbeFSV4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:56:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51477 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030526AbeFSV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:56:16 -0400
Received: by mail-it0-f67.google.com with SMTP id n7-v6so2646096itn.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue+inuZntFbZiuS0QNXbHPnvizRmpPRdRQ91W3wDdBg=;
        b=ID9txlw7fOLjfTsocSsQvOKe4AP9vAsHKUTRexXtMfMwiqMKKNL9RWa//MeAU6Ye47
         5+ju/h+dWHKAVuLxPvjTLs7EYmT6r454hf3XbBnhuQyVnZS3MPK/1fO5OoZ4tsuLH1eI
         W+cDS1lx1QnDQhFfkpO+GcQi2rLwjP3iTHADA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue+inuZntFbZiuS0QNXbHPnvizRmpPRdRQ91W3wDdBg=;
        b=GfTUe0RI8zvs7kANnUOe8yYSn1xe/DkH5dc/CP4i3Tfc3BNczllmP+ovepRCo0FSy6
         2DkntO6qqDklaVVaFVCbo3dcf0RG1igxnR0I0Cj3PFkHSS7vqmvXg8xYBZ14dHdSXVzm
         rN7FNO5F93T9avb0hAKL9MwyB+tF7m1DSXrryKXyUtTQ3Y3Q10dB8bc+VbvOAzD8pqhh
         KBSFWRTHsfj9h/qW3H4z/FbCC1c/ep+HQbaeJeSns7hnW7v6+uuRh37kvZHpCz6xOz1U
         E10meAznQIyq+pDB+afSOtVqUjbuIbamLb9qwEy4OG5/uCdlwOo12AZvutvsJtGHvyeW
         i/NQ==
X-Gm-Message-State: APt69E3ZQTv/GiToam23fhar6RKHnqQAwyr+7iDGNt8M+WjW9S4LJlhw
        v24Nro9fNdOaBly4vF8cxpseyZAFiKcr5RW75vw=
X-Google-Smtp-Source: ADUXVKJfExtSTCy5uiH9X7i5aTdZBryGXv51ipBO5auQfXhnVvMpLzzLCbvrqvMUvrSj6/TVGOK7ixMnYX5EziFO5ak=
X-Received: by 2002:a02:666a:: with SMTP id l42-v6mr15572063jaf.70.1529445375139;
 Tue, 19 Jun 2018 14:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz> <20180619162411.B2B7AA1081@unicorn.suse.cz>
In-Reply-To: <20180619162411.B2B7AA1081@unicorn.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 06:56:04 +0900
Message-ID: <CA+55aFwa-mxOFKGiLmbxyJ+LyEjOG07fuYOmcWaYf-SJntneuw@mail.gmail.com>
Subject: Re: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004a079d056f05c07e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004a079d056f05c07e
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 20, 2018 at 1:24 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> Recent rewrite introduced a regression, /proc/$pid/cmdline is missing the
> trailing null character:
>
> mike@lion:/tmp> cat /proc/self/cmdline | od -t c
> 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> 0000020   m   d   l   i   n   e
> 0000026

Thanks, and obviously right you are.

That said, I'm not a fan of your patch. I'd much rather just tweak the
"strnlen()" logic a bit instead, and make the rule be that when we go
into the "slop" area, we always include the last byte of the "real"
argv area.

That limits the slop to a page (well, one byte less, since we want the
one byte of non-slop), but honestly, a page for *everything* was what
we used to do originally, so..

How does the attached patch work for you?

                    Linus

--0000000000004a079d056f05c07e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jim87sy90>
X-Attachment-Id: f_jim87sy90

IGZzL3Byb2MvYmFzZS5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvcHJvYy9iYXNlLmMgYi9mcy9wcm9jL2Jhc2UuYwppbmRleCBiNjU3Mjk0NGVmYzMuLmFhZmZj
MGMzMDIxNiAxMDA2NDQKLS0tIGEvZnMvcHJvYy9iYXNlLmMKKysrIGIvZnMvcHJvYy9iYXNlLmMK
QEAgLTIzNSw2ICsyMzUsMTAgQEAgc3RhdGljIHNzaXplX3QgZ2V0X21tX2NtZGxpbmUoc3RydWN0
IG1tX3N0cnVjdCAqbW0sIGNoYXIgX191c2VyICpidWYsCiAJaWYgKGVudl9zdGFydCAhPSBhcmdf
ZW5kIHx8IGVudl9zdGFydCA+PSBlbnZfZW5kKQogCQllbnZfc3RhcnQgPSBlbnZfZW5kID0gYXJn
X2VuZDsKIAorCS8qIC4uIGFuZCBsaW1pdCBpdCB0byBhIG1heGltdW0gb2Ygb25lIHBhZ2Ugb2Yg
c2xvcCAqLworCWlmIChlbnZfZW5kID49IGFyZ19lbmQgKyBQQUdFX1NJWkUpCisJCWVudl9lbmQg
PSBhcmdfZW5kICsgUEFHRV9TSVpFIC0gMTsKKwogCS8qIFdlJ3JlIG5vdCBnb2luZyB0byBjYXJl
IGlmICIqcHBvcyIgaGFzIGhpZ2ggYml0cyBzZXQgKi8KIAlwb3MgPSBhcmdfc3RhcnQgKyAqcHBv
czsKIApAQCAtMjU0LDEwICsyNTgsMTkgQEAgc3RhdGljIHNzaXplX3QgZ2V0X21tX2NtZGxpbmUo
c3RydWN0IG1tX3N0cnVjdCAqbW0sIGNoYXIgX191c2VyICpidWYsCiAJd2hpbGUgKGNvdW50KSB7
CiAJCWludCBnb3Q7CiAJCXNpemVfdCBzaXplID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUsIGNv
dW50KTsKKwkJbG9uZyBvZmZzZXQ7CiAKLQkJZ290ID0gYWNjZXNzX3JlbW90ZV92bShtbSwgcG9z
LCBwYWdlLCBzaXplLCBGT0xMX0FOT04pOwotCQlpZiAoZ290IDw9IDApCisJCS8qCisJCSAqIEFy
ZSB3ZSBhbHJlYWR5IHN0YXJ0aW5nIHBhc3QgdGhlIG9mZmljaWFsIGVuZD8KKwkJICogV2UgYWx3
YXlzIGluY2x1ZGUgdGhlIGxhc3QgYnl0ZSB0aGF0IGlzICpzdXBwb3NlZCoKKwkJICogdG8gYmUg
TlVMCisJCSAqLworCQlvZmZzZXQgPSAocG9zID49IGFyZ19lbmQpID8gcG9zIC0gYXJnX2VuZCAr
IDEgOiAwOworCisJCWdvdCA9IGFjY2Vzc19yZW1vdGVfdm0obW0sIHBvcyAtIG9mZnNldCwgcGFn
ZSwgc2l6ZSArIG9mZnNldCwgRk9MTF9BTk9OKTsKKwkJaWYgKGdvdCA8PSBvZmZzZXQpCiAJCQli
cmVhazsKKwkJZ290IC09IG9mZnNldDsKIAogCQkvKiBEb24ndCB3YWxrIHBhc3QgYSBOVUwgY2hh
cmFjdGVyIG9uY2UgeW91IGhpdCBhcmdfZW5kICovCiAJCWlmIChwb3MgKyBnb3QgPj0gYXJnX2Vu
ZCkgewpAQCAtMjc2LDEyICsyODksMTcgQEAgc3RhdGljIHNzaXplX3QgZ2V0X21tX2NtZGxpbmUo
c3RydWN0IG1tX3N0cnVjdCAqbW0sIGNoYXIgX191c2VyICpidWYsCiAJCQkJbiA9IGFyZ19lbmQg
LSBwb3MgLSAxOwogCiAJCQkvKiBDdXQgb2ZmIGF0IGZpcnN0IE5VTCBhZnRlciAnbicgKi8KLQkJ
CWdvdCA9IG4gKyBzdHJubGVuKHBhZ2UrbiwgZ290LW4pOwotCQkJaWYgKCFnb3QpCisJCQlnb3Qg
PSBuICsgc3RybmxlbihwYWdlK24sIG9mZnNldCtnb3Qtbik7CisJCQlpZiAoZ290IDwgb2Zmc2V0
KQogCQkJCWJyZWFrOworCQkJZ290IC09IG9mZnNldDsKKworCQkJLyogSW5jbHVkZSB0aGUgTlVM
IGlmIGl0IGV4aXN0ZWQgKi8KKwkJCWlmIChnb3QgPCBzaXplKQorCQkJCWdvdCsrOwogCQl9CiAK
LQkJZ290IC09IGNvcHlfdG9fdXNlcihidWYsIHBhZ2UsIGdvdCk7CisJCWdvdCAtPSBjb3B5X3Rv
X3VzZXIoYnVmLCBwYWdlK29mZnNldCwgZ290KTsKIAkJaWYgKHVubGlrZWx5KCFnb3QpKSB7CiAJ
CQlpZiAoIWxlbikKIAkJCQlsZW4gPSAtRUZBVUxUOwo=
--0000000000004a079d056f05c07e--
