Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E55CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AC7222BD
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GX6t7spD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfAEXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:16:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36397 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfAEXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:16:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so35234730ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7trfwmfneYK4SSNw/SfOGj8r9QOI6ygQ5c1r2wUbls=;
        b=GX6t7spD5TCxKk9/FB+FddDtgEmf/Maam6t7a9rOK2vbaIIrD7ipWwjLrJy7cSGVdH
         R+Qiu4e2Pu8D4WjZKvjAOeGOLZaOwd61Fj6waEP5yhL2Zf3+tKQ8S/xYB36PjA2OBYon
         MlgJzdnqL24g1b2TS29Yq2aY33fEwWDl2gHu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7trfwmfneYK4SSNw/SfOGj8r9QOI6ygQ5c1r2wUbls=;
        b=BkQ7ockpxSUY75oYzxXCY3a7A3lRmvyhHzBtRMH6CnUc+Bj64t30rEj2SXs+tQB3Z3
         medHXomKDH+vTqiLWBRxwao5bar7d7Jn5zyY2Zv49+9W+ax9GaEHn/fLbfsd0hdp22Bi
         gxLArvp/oJ8EXmO/MRIJwQcTaIpxpXoB00gw5SGFMMt9KGfz1sLcAZbWYEyice9XKk+W
         FqC1FXsPlIg+fRy+uW10SoIV71pFBUwRyN/U9x+CYRdztGIK+zkYwOveXHIt+vMNTwsG
         tcAhGcdxYGMShd5OWj48ps7FRZv8o+Z93t0wfFQaq4Id2haDN5pn2olw2sqerojyO/8i
         tWLQ==
X-Gm-Message-State: AJcUukd/zDMk1jkjw6Mdpg9ThjxTPyRuiW1VMwnEGjRdozNoHMTs5CxV
        djyM+91IS2Y9oLEHVHN9exexXKuMopo=
X-Google-Smtp-Source: ALg8bN6n/qrVW1PknJqyjcYRwc54E3+xu22iMuPMVPUIi4NxRORBWXrfoCXUcDkdU1UFrJBVu6Vsjw==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr34304254ljb.52.1546730210786;
        Sat, 05 Jan 2019 15:16:50 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f20-v6sm13025233ljk.33.2019.01.05.15.16.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 15:16:48 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id a8so2715818lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:16:48 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr26813387lfj.138.1546730208114;
 Sat, 05 Jan 2019 15:16:48 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com> <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
In-Reply-To: <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 15:16:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
Message-ID: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009e74e7057ebe30b7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009e74e7057ebe30b7
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 5, 2019 at 3:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That would be nicer than my patch, simply because removing code is
> always nice. And arguably it's a better semantic anyway.

Yeah, I wonder why we did that thing where mincore() walks the page
tables, but if they are empty it looks in the page cache.

[... goes and looks in history ..]

It goes back to forever, it looks like. I can't find a reason.

Anyway, a removal patch would look something like the attached, I
think. That makes mincore() actually say how many pages are in _this_
mapping, not how many pages could be paged in without doing IO.

Hmm. Maybe we should try this first. Simplicity is always good.

Again, obviously untested.

                   Linus

--0000000000009e74e7057ebe30b7
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jqk37sgx0>
X-Attachment-Id: f_jqk37sgx0

IG1tL21pbmNvcmUuYyB8IDc0ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
NjggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbWluY29yZS5jIGIvbW0vbWluY29yZS5j
CmluZGV4IDIxODA5OWI1ZWQzMS4uMzE3ZWI2NGVhNGVmIDEwMDY0NAotLS0gYS9tbS9taW5jb3Jl
LmMKKysrIGIvbW0vbWluY29yZS5jCkBAIC00Miw2NCArNDIsMTIgQEAgc3RhdGljIGludCBtaW5j
b3JlX2h1Z2V0bGIocHRlX3QgKnB0ZSwgdW5zaWduZWQgbG9uZyBobWFzaywgdW5zaWduZWQgbG9u
ZyBhZGRyLAogCXJldHVybiAwOwogfQogCi0vKgotICogTGF0ZXIgd2UgY2FuIGdldCBtb3JlIHBp
Y2t5IGFib3V0IHdoYXQgImluIGNvcmUiIG1lYW5zIHByZWNpc2VseS4KLSAqIEZvciBub3csIHNp
bXBseSBjaGVjayB0byBzZWUgaWYgdGhlIHBhZ2UgaXMgaW4gdGhlIHBhZ2UgY2FjaGUsCi0gKiBh
bmQgaXMgdXAgdG8gZGF0ZTsgaS5lLiB0aGF0IG5vIHBhZ2UtaW4gb3BlcmF0aW9uIHdvdWxkIGJl
IHJlcXVpcmVkCi0gKiBhdCB0aGlzIHRpbWUgaWYgYW4gYXBwbGljYXRpb24gd2VyZSB0byBtYXAg
YW5kIGFjY2VzcyB0aGlzIHBhZ2UuCi0gKi8KLXN0YXRpYyB1bnNpZ25lZCBjaGFyIG1pbmNvcmVf
cGFnZShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBwZ29mZikKLXsKLQl1
bnNpZ25lZCBjaGFyIHByZXNlbnQgPSAwOwotCXN0cnVjdCBwYWdlICpwYWdlOwotCi0JLyoKLQkg
KiBXaGVuIHRtcGZzIHN3YXBzIG91dCBhIHBhZ2UgZnJvbSBhIGZpbGUsIGFueSBwcm9jZXNzIG1h
cHBpbmcgdGhhdAotCSAqIGZpbGUgd2lsbCBub3QgZ2V0IGEgc3dwX2VudHJ5X3QgaW4gaXRzIHB0
ZSwgYnV0IHJhdGhlciBpdCBpcyBsaWtlCi0JICogYW55IG90aGVyIGZpbGUgbWFwcGluZyAoaWUu
IG1hcmtlZCAhcHJlc2VudCBhbmQgZmF1bHRlZCBpbiB3aXRoCi0JICogdG1wZnMncyAuZmF1bHQp
LiBTbyBzd2FwcGVkIG91dCB0bXBmcyBtYXBwaW5ncyBhcmUgdGVzdGVkIGhlcmUuCi0JICovCi0j
aWZkZWYgQ09ORklHX1NXQVAKLQlpZiAoc2htZW1fbWFwcGluZyhtYXBwaW5nKSkgewotCQlwYWdl
ID0gZmluZF9nZXRfZW50cnkobWFwcGluZywgcGdvZmYpOwotCQkvKgotCQkgKiBzaG1lbS90bXBm
cyBtYXkgcmV0dXJuIHN3YXA6IGFjY291bnQgZm9yIHN3YXBjYWNoZQotCQkgKiBwYWdlIHRvby4K
LQkJICovCi0JCWlmICh4YV9pc192YWx1ZShwYWdlKSkgewotCQkJc3dwX2VudHJ5X3Qgc3dwID0g
cmFkaXhfdG9fc3dwX2VudHJ5KHBhZ2UpOwotCQkJcGFnZSA9IGZpbmRfZ2V0X3BhZ2Uoc3dhcF9h
ZGRyZXNzX3NwYWNlKHN3cCksCi0JCQkJCSAgICAgc3dwX29mZnNldChzd3ApKTsKLQkJfQotCX0g
ZWxzZQotCQlwYWdlID0gZmluZF9nZXRfcGFnZShtYXBwaW5nLCBwZ29mZik7Ci0jZWxzZQotCXBh
Z2UgPSBmaW5kX2dldF9wYWdlKG1hcHBpbmcsIHBnb2ZmKTsKLSNlbmRpZgotCWlmIChwYWdlKSB7
Ci0JCXByZXNlbnQgPSBQYWdlVXB0b2RhdGUocGFnZSk7Ci0JCXB1dF9wYWdlKHBhZ2UpOwotCX0K
LQotCXJldHVybiBwcmVzZW50OwotfQotCiBzdGF0aWMgaW50IF9fbWluY29yZV91bm1hcHBlZF9y
YW5nZSh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQkJCXN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBjaGFyICp2ZWMpCiB7CiAJdW5zaWduZWQgbG9u
ZyBuciA9IChlbmQgLSBhZGRyKSA+PiBQQUdFX1NISUZUOwotCWludCBpOwogCi0JaWYgKHZtYS0+
dm1fZmlsZSkgewotCQlwZ29mZl90IHBnb2ZmOwotCi0JCXBnb2ZmID0gbGluZWFyX3BhZ2VfaW5k
ZXgodm1hLCBhZGRyKTsKLQkJZm9yIChpID0gMDsgaSA8IG5yOyBpKyssIHBnb2ZmKyspCi0JCQl2
ZWNbaV0gPSBtaW5jb3JlX3BhZ2Uodm1hLT52bV9maWxlLT5mX21hcHBpbmcsIHBnb2ZmKTsKLQl9
IGVsc2UgewotCQlmb3IgKGkgPSAwOyBpIDwgbnI7IGkrKykKLQkJCXZlY1tpXSA9IDA7Ci0JfQor
CW1lbXNldCh2ZWMsIDAsIG5yKTsKIAlyZXR1cm4gbnI7CiB9CiAKQEAgLTE0NCwyMSArOTIsMTEg
QEAgc3RhdGljIGludCBtaW5jb3JlX3B0ZV9yYW5nZShwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25n
IGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQllbHNlIHsgLyogcHRlIGlzIGEgc3dhcCBlbnRy
eSAqLwogCQkJc3dwX2VudHJ5X3QgZW50cnkgPSBwdGVfdG9fc3dwX2VudHJ5KHB0ZSk7CiAKLQkJ
CWlmIChub25fc3dhcF9lbnRyeShlbnRyeSkpIHsKLQkJCQkvKgotCQkJCSAqIG1pZ3JhdGlvbiBv
ciBod3BvaXNvbiBlbnRyaWVzIGFyZSBhbHdheXMKLQkJCQkgKiB1cHRvZGF0ZQotCQkJCSAqLwot
CQkJCSp2ZWMgPSAxOwotCQkJfSBlbHNlIHsKLSNpZmRlZiBDT05GSUdfU1dBUAotCQkJCSp2ZWMg
PSBtaW5jb3JlX3BhZ2Uoc3dhcF9hZGRyZXNzX3NwYWNlKGVudHJ5KSwKLQkJCQkJCSAgICBzd3Bf
b2Zmc2V0KGVudHJ5KSk7Ci0jZWxzZQotCQkJCVdBUk5fT04oMSk7Ci0JCQkJKnZlYyA9IDE7Ci0j
ZW5kaWYKLQkJCX0KKwkJCS8qCisJCQkgKiBtaWdyYXRpb24gb3IgaHdwb2lzb24gZW50cmllcyBh
cmUgYWx3YXlzCisJCQkgKiB1cHRvZGF0ZQorCQkJICovCisJCQkqdmVjID0gISFub25fc3dhcF9l
bnRyeShlbnRyeSk7CiAJCX0KIAkJdmVjKys7CiAJfQo=
--0000000000009e74e7057ebe30b7--
