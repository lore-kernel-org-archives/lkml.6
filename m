Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABEFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F1214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123226;
	bh=PZfFQHgPhfnrQsoGI+ugTruNtJFLmEKXux5V5+SUkEI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fjhIEKsSE3VP6lM4ExwnsL86PrlJ6em4lMECpYc2VON2yKaKYAsyx9YN5Ppn3mMbx
	 +kol28LVoDC1G479TeBh0n/SDPBhcXWmW7TgIAdXyAZt50CPLsN/ZiSuVFH1X8CC+e
	 uHm2sdT7W2RyzyyiwNa51dVDisMi0b4JUkRmElws=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2F1214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLFTHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFTHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:07:04 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EBA214DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123224;
        bh=PZfFQHgPhfnrQsoGI+ugTruNtJFLmEKXux5V5+SUkEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=feRJW+RKIiuvTM8LyY7Cd1bQVB73mu6YH0Wa4IslQGjJM313SpRyezF626CqpqMEJ
         K/WG9E8tj4u65q7RbL67oysTVsI40mKZ7gzGCOaXFdkziQlmPhZpEInvhJ9uZJTcDR
         fymqQ+v1lqSjD2BwaLHLwPaWoN48O/P+vDyfwpOE=
Received: by mail-wm1-f51.google.com with SMTP id a18so2213504wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:07:03 -0800 (PST)
X-Gm-Message-State: AA+aEWZlQloS4BlWtXe2yBGynSsolMvkivEG5RxxtCL/GYOXDHv0cluk
        XLpHvmQyRUDtiwOUo7lBkMtoM3a8xFSJbPeEXMuQsw==
X-Google-Smtp-Source: AFSGD/XUMSWmyPVCLcwH/XQ+ANlaUoIfLcriV64AGoWR8Shbzr+Mbndp7WGRpc0JagT5ySoJTwxuKcLoXLVFexhSoOA=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr21646562wmf.32.1544123222198;
 Thu, 06 Dec 2018 11:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com> <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgrpUQyux2ZTJj8FUEdHcEoM0KUNrN3KCc+bBhi0fRhaQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 11:06:50 -0800
X-Gmail-Original-Message-ID: <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com>
Message-ID: <CALCETrUc7Y+WFkS1=ECXgtLoUXb3HPXsF+x+TCpiuuh3sXFjfA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: multipart/mixed; boundary="000000000000264e69057c5f34f1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000264e69057c5f34f1
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 6, 2018 at 10:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 5, 2018 at 11:34 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Yeah, so I don't like the overly long 'SUPERVISOR' and the somewhat
> > inconsistent, sporadic handling of negatives. Here's our error code bits:
> >
> > /*
> >  * Page fault error code bits:
> >  *
> >  *   bit 0 ==    0: no page found       1: protection fault
> >  *   bit 1 ==    0: read access         1: write access
> >  *   bit 2 ==    0: kernel-mode access  1: user-mode access
>
> No. Really not at all.
>
> Bit 2 is *not* "kernel vs user".  Never has been. Never will be.
>
> It's a single bit that mixes up *three* different cases:
>
>  - regular user mode access (value: 1)
>
>  - regular CPL0 access (value: 0)
>
>  - CPU system access (value: 0)
>
> and that third case really is important and relevant. And importantly,
> it can happen from user space.
>
> In fact, these days we possibly have a fourth case:
>
>  - kernel access using wruss (value: 1)

Indeed.

>
> and I'd rather see just the numbers (which you have to know to decode)
> than see the simplified AND WRONG decoding of those numbers.

That's why the very next line in the OOPS explains this.

>
> Please don't ever confuse the fault U/S bit with "user vs kernel".
> It's just not true, and people should be very very aware of it now
> being true.
>
> If you care whether a page fault happened in user mode or not, you
> have to look at the register state (ie "user_mode(regs)").

The code we're arguing over was part of a patch set to fix this
confusion in the page fault code for real.

>
> Please call the U/S bit something else than "user" or "kernel".

Dunno.  I kind of like following the SDM.

How do you like the attached patch?

--000000000000264e69057c5f34f1
Content-Type: text/x-patch; charset="US-ASCII"; name="fault.patch"
Content-Disposition: attachment; filename="fault.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jpcz31rf0>
X-Attachment-Id: f_jpcz31rf0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2ZhdWx0LmMgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jCmlu
ZGV4IDJmZjI1YWQzMzIzMy4uZjFmOWUxOTY0NmY1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9m
YXVsdC5jCisrKyBiL2FyY2gveDg2L21tL2ZhdWx0LmMKQEAgLTYxMCw4ICs2MTAsNyBAQCBzdGF0
aWMgdm9pZCBzaG93X2xkdHRzcyhjb25zdCBzdHJ1Y3QgZGVzY19wdHIgKmdkdCwgY29uc3QgY2hh
ciAqbmFtZSwgdTE2IGluZGV4KQogc3RhdGljIHZvaWQgZXJyX3N0cl9hcHBlbmQodW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlLCBjaGFyICpidWYsIHVuc2lnbmVkIGxvbmcgbWFzaywgY29uc3QgY2hh
ciAqdHh0KQogewogCWlmIChlcnJvcl9jb2RlICYgbWFzaykgewotCQlpZiAoYnVmWzBdKQotCQkJ
c3RyY2F0KGJ1ZiwgIiAiKTsKKwkJc3RyY2F0KGJ1ZiwgIiAiKTsKIAkJc3RyY2F0KGJ1ZiwgdHh0
KTsKIAl9CiB9CkBAIC02NTEsMjMgKzY1MCwzMCBAQCBzaG93X2ZhdWx0X29vcHMoc3RydWN0IHB0
X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSwgdW5zaWduZWQgbG9uZyBhZAog
CWVycl90eHRbMF0gPSAwOwogCiAJLyoKLQkgKiBOb3RlOiBsZW5ndGggb2YgdGhlc2UgYXBwZW5k
ZWQgc3RyaW5ncyBpbmNsdWRpbmcgdGhlIHNlcGFyYXRpb24gc3BhY2UgYW5kIHRoZQotCSAqIHpl
cm8gZGVsaW1pdGVyIG11c3QgZml0IGludG8gZXJyX3R4dFtdLgorCSAqIE5vdGU6IGxlbmd0aCBv
ZiB0aGVzZSBhcHBlbmRlZCBzdHJpbmdzIGluY2x1ZGluZyB0aGUgc2VwYXJhdGlvbgorCSAqIHNw
YWNlIGFuZCB0aGUgemVybyBkZWxpbWl0ZXIgbXVzdCBmaXQgaW50byBlcnJfdHh0W10uCiAJICov
CiAJZXJyX3N0cl9hcHBlbmQoZXJyb3JfY29kZSwgZXJyX3R4dCwgWDg2X1BGX1BST1QsICAiW1BS
T1RdIiApOwogCWVycl9zdHJfYXBwZW5kKGVycm9yX2NvZGUsIGVycl90eHQsIFg4Nl9QRl9XUklU
RSwgIltXUklURV0iKTsKKwlpZiAoKGVycm9yX2NvZGUgJiAoWDg2X1BGX1dSSVRFIHwgWDg2X1BG
X0lOU1RSKSkgPT0gMCkKKwkJc3RyY2F0KGVycl90eHQsICIgW3JlYWRdIik7CiAJZXJyX3N0cl9h
cHBlbmQoZXJyb3JfY29kZSwgZXJyX3R4dCwgWDg2X1BGX1VTRVIsICAiW1VTRVJdIiApOwogCWVy
cl9zdHJfYXBwZW5kKGVycm9yX2NvZGUsIGVycl90eHQsIFg4Nl9QRl9SU1ZELCAgIltSU1ZEXSIg
KTsKIAllcnJfc3RyX2FwcGVuZChlcnJvcl9jb2RlLCBlcnJfdHh0LCBYODZfUEZfSU5TVFIsICJb
SU5TVFJdIik7CiAJZXJyX3N0cl9hcHBlbmQoZXJyb3JfY29kZSwgZXJyX3R4dCwgWDg2X1BGX1BL
LCAgICAiW1BLXSIgICApOwogCi0JcHJfYWxlcnQoIiNQRiBlcnJvcjogJXNcbiIsIGVycm9yX2Nv
ZGUgPyBlcnJfdHh0IDogIltub3JtYWwga2VybmVsIHJlYWQgZmF1bHRdIik7CisJcHJfYWxlcnQo
IiNQRiBlcnJvcjogMHglMDRseCVzXG4iLCBlcnJvcl9jb2RlLCBlcnJfdHh0KTsKIAorCS8qCisJ
ICogVGhlIFg4Nl9QRl9VU0VSIGJpdCBkb2VzICpub3QqIG1lYW4gdGhlIHNhbWUgdGhpbmcgYXMK
KwkgKiB1c2VyX21vZGUocmVncykuICBNYWtlIHN1cmUgdGhhdCB0aGUgdW51c3VhbCBjYXNlcyBh
cmUgb2J2aW91cyB0bworCSAqIHRoZSByZWFkZXIuCisJICovCiAJaWYgKCEoZXJyb3JfY29kZSAm
IFg4Nl9QRl9VU0VSKSAmJiB1c2VyX21vZGUocmVncykpIHsKIAkJc3RydWN0IGRlc2NfcHRyIGlk
dCwgZ2R0OwogCQl1MTYgbGR0ciwgdHI7CiAKLQkJcHJfYWxlcnQoIlRoaXMgd2FzIGEgc3lzdGVt
IGFjY2VzcyBmcm9tIHVzZXIgY29kZVxuIik7CisJCXByX2FsZXJ0KCJOQjogVGhpcyB3YXMgYSBz
dXBlcnZpc29yLXByaXZpbGVnZWQgYWNjZXNzIGZyb20gdXNlciBjb2RlLlxuIik7CiAKIAkJLyoK
IAkJICogVGhpcyBjYW4gaGFwcGVuIGZvciBxdWl0ZSBhIGZldyByZWFzb25zLiAgVGhlIG1vcmUg
b2J2aW91cwpAQCAtNjkyLDYgKzY5OCwxNCBAQCBzaG93X2ZhdWx0X29vcHMoc3RydWN0IHB0X3Jl
Z3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSwgdW5zaWduZWQgbG9uZyBhZAogCiAJ
CXN0b3JlX3RyKHRyKTsKIAkJc2hvd19sZHR0c3MoJmdkdCwgIlRSIiwgdHIpOworCX0gZWxzZSBp
ZiAoKGVycm9yX2NvZGUgJiBYODZfUEZfVVNFUikgJiYgIXVzZXJfbW9kZShyZWdzKSkgeworCQkv
KgorCQkgKiBUaGlzIGNhbiBoYXBwZW4gZHVlIHRvIFdSVVNTLiAgSWYgYW4gSVNBIGV4dGVuc2lv
biBldmVyCisJCSAqIGdpdmVzIG5ldyBpbnN0cnVjdGlvbnMgdG8gZG8gdXNlciBtZW1vcnkgYWNj
ZXNzIGZyb20ga2VybmVsCisJCSAqIG1vZGUgYW5kIHdlIE9PUFMgZHVlIHRvIGEgYnJva2VuIGZp
eHVwLCB3ZSdsbCBwcmVzdW1hYmx5IGxhbmQKKwkJICogaGVyZSBhcyB3ZWxsLgorCQkgKi8KKwkJ
cHJfYWxlcnQoIk5COiBUaGlzIHdhcyBhIHVzZXItcHJpdmlsZWdlZCBhY2Nlc3MgZnJvbSBrZXJu
ZWwgY29kZS5cbiIpOwogCX0KIAogCWR1bXBfcGFnZXRhYmxlKGFkZHJlc3MpOwo=
--000000000000264e69057c5f34f1--
