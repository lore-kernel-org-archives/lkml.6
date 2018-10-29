Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C15BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F182082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BwrRZDJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F182082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJ3AFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:05:45 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41070 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeJ3AFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:05:44 -0400
Received: by mail-lj1-f170.google.com with SMTP id z80-v6so2100509ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ad7JmFwvQi5rh7yBEPchr5v3P/0GAv7ynfrhYPUPjw4=;
        b=BwrRZDJmrSG8PbX371ounciT2741wy2QkcLuZmsguqdXZDmRKFW56Ds96arBOAR55D
         540oZQZ7l2L6orLQ8UZB51GD4HWc365IcJLE+2Il2VDfrDH6LKQ1ilhoFmRoY6BZOrG7
         rCxsxj0nyL6uOlv8Es5EMRsLJ4AadzL06rlV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ad7JmFwvQi5rh7yBEPchr5v3P/0GAv7ynfrhYPUPjw4=;
        b=r/VmkYtmyrEqDaeFVsQEA8ZeyW4Rh5LuZRYbguXowfp7poO1twe9cNfJcaK0/6Dz+D
         tBCA8w0XAMNUOGZyUrIZV4zIi38VrhY3pbBArDFBujMsXYIOiQOR1KO7Mmb4wahU+zAm
         kaKhHwxtonegC/BkADDNggDog0tWW/+ki1cKLPz4D/G0wk9gZSvRqOnpTCG6lELqBETi
         iCPmtDH12TlIWi3bKwD6ihgD55osCUpfUguHAho23ZxEchWkyd+Rg6NOB+3zy7+6w4qR
         aWIm3EZxQ6KwUVlsTo8dRm0nHhVzEIbmbtzoxVuWFXXTp3RvAf0BUk0ITDCc40b3FPLY
         Onxg==
X-Gm-Message-State: AGRZ1gJPxDMhBJYoQbjOQ6gQYyhkYqWRgAHqmzMpkAWY4Ne0hqlw3SrF
        JCx4NzU9gEOpN+1f0aiitzw8o9l1lALTjw==
X-Google-Smtp-Source: AJdET5cZ2y0Wq5n5gr/9iG0KQsM8twnGLG+NIdGFe2mG0Imu2cyoPVagoqRUqWKyJKAlMEbcPY+BdA==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr9723061ljb.106.1540826198568;
        Mon, 29 Oct 2018 08:16:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s3-v6sm850102lje.73.2018.10.29.08.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 08:16:36 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id q6-v6so6315584lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:16:35 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr8959498lfc.147.1540826195229;
 Mon, 29 Oct 2018 08:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 08:16:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
Message-ID: <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peter.hutterer@who-t.net
Content-Type: multipart/mixed; boundary="00000000000007413e05795f8e85"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000007413e05795f8e85
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 29, 2018 at 6:18 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> Benjamin indicated that Peter probably has found the issue in the code
> (failure to properly reset on direction change) that might be causing
> this.

So honestly, once I looked at that hid_scroll_counter_handle_scroll()
function, that's the first thing I tried - get rid of the "half-way
threshold" thing, and reset on direction changes.

It fixes the instability, and I don't see the "back-and-forth"
movements and I don't get the "move the mouse and it generates mouse
wheel events" any more.

It basically makes the wheel _work_ for me.

I'm not entirely convinced it's as good as it used to be, though. It
still feels like it might be a bit over-sensitive, but that may be
because now I'm just looking for it..

Patch I'm using attached. I'm inclined to just commit it, but if
somebody has a better idea, I can test alternatives too.

                    Linus

--00000000000007413e05795f8e85
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jnug1vmy0>
X-Attachment-Id: f_jnug1vmy0

IGRyaXZlcnMvaGlkL2hpZC1pbnB1dC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1pbnB1dC5jIGIvZHJpdmVy
cy9oaWQvaGlkLWlucHV0LmMKaW5kZXggNTY3YzNiZjY0NTE1Li5hMmY3NGU2YWRjNzAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZC1pbnB1dC5jCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1pbnB1
dC5jCkBAIC0xODU1LDMxICsxODU1LDMwIEBAIEVYUE9SVF9TWU1CT0xfR1BMKGhpZGlucHV0X2Rp
c2Nvbm5lY3QpOwogdm9pZCBoaWRfc2Nyb2xsX2NvdW50ZXJfaGFuZGxlX3Njcm9sbChzdHJ1Y3Qg
aGlkX3Njcm9sbF9jb3VudGVyICpjb3VudGVyLAogCQkJCSAgICAgIGludCBoaV9yZXNfdmFsdWUp
CiB7Ci0JaW50IGxvd19yZXNfc2Nyb2xsX2Ftb3VudDsKLQkvKiBTb21lIHdoZWVscyB3aWxsIHJl
c3QgNy84dGhzIG9mIGEgbm90Y2ggZnJvbSB0aGUgcHJldmlvdXMgbm90Y2gKLQkgKiBhZnRlciBz
bG93IG1vdmVtZW50LCBzbyB3ZSB3YW50IHRoZSB0aHJlc2hvbGQgZm9yIGxvdy1yZXMgZXZlbnRz
IHRvCi0JICogYmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgbm90Y2hlcyAoZS5nLiBhZnRlciA0Lzh0
aHMpIGFzIG9wcG9zZWQgdG8gb24KLQkgKiB0aGUgbm90Y2hlcyB0aGVtc2VsdmVzICg4Lzh0aHMp
LgotCSAqLwotCWludCB0aHJlc2hvbGQgPSBjb3VudGVyLT5yZXNvbHV0aW9uX211bHRpcGxpZXIg
LyAyOworCWludCBsb3dfcmVzX3ZhbHVlLCByZW1haW5kZXIsIG11bHRpcGxpZXI7CiAKIAlpbnB1
dF9yZXBvcnRfcmVsKGNvdW50ZXItPmRldiwgUkVMX1dIRUVMX0hJX1JFUywKIAkJCSBoaV9yZXNf
dmFsdWUgKiBjb3VudGVyLT5taWNyb25zX3Blcl9oaV9yZXNfdW5pdCk7CiAKLQljb3VudGVyLT5y
ZW1haW5kZXIgKz0gaGlfcmVzX3ZhbHVlOwotCWlmIChhYnMoY291bnRlci0+cmVtYWluZGVyKSA+
PSB0aHJlc2hvbGQpIHsKLQkJLyogQWRkIChvciBzdWJ0cmFjdCkgMSBiZWNhdXNlIHdlIHdhbnQg
dG8gdHJpZ2dlciB3aGVuIHRoZSB3aGVlbAotCQkgKiBpcyBoYWxmLXdheSB0byB0aGUgbmV4dCBu
b3RjaCAoaS5lLiBzY3JvbGwgMSBub3RjaCBhZnRlciBhCi0JCSAqIDEvMiBub3RjaCBtb3ZlbWVu
dCwgMiBub3RjaGVzIGFmdGVyIGEgMSAxLzIgbm90Y2ggbW92ZW1lbnQsCi0JCSAqIGV0Yy4pLgot
CQkgKi8KLQkJbG93X3Jlc19zY3JvbGxfYW1vdW50ID0KLQkJCWNvdW50ZXItPnJlbWFpbmRlciAv
IGNvdW50ZXItPnJlc29sdXRpb25fbXVsdGlwbGllcgotCQkJKyAoaGlfcmVzX3ZhbHVlID4gMCA/
IDEgOiAtMSk7Ci0JCWlucHV0X3JlcG9ydF9yZWwoY291bnRlci0+ZGV2LCBSRUxfV0hFRUwsCi0J
CQkJIGxvd19yZXNfc2Nyb2xsX2Ftb3VudCk7Ci0JCWNvdW50ZXItPnJlbWFpbmRlciAtPQotCQkJ
bG93X3Jlc19zY3JvbGxfYW1vdW50ICogY291bnRlci0+cmVzb2x1dGlvbl9tdWx0aXBsaWVyOwot
CX0KKwkvKgorCSAqIFVwZGF0ZSB0aGUgbG93LXJlcyByZW1haW5kZXIgd2l0aCB0aGUgaGlnaC1y
ZXMgdmFsdWUsCisJICogYnV0IHJlc2V0IGlmIHRoZSBkaXJlY3Rpb24gaGFzIGNoYW5nZWQuCisJ
ICovCisJcmVtYWluZGVyID0gY291bnRlci0+cmVtYWluZGVyOworCWlmICgocmVtYWluZGVyIF4g
aGlfcmVzX3ZhbHVlKSA8IDApCisJCXJlbWFpbmRlciA9IDA7CisJcmVtYWluZGVyICs9IGhpX3Jl
c192YWx1ZTsKKworCS8qCisJICogVGhlbiBqdXN0IHVzZSB0aGUgcmVzb2x1dGlvbiBtdWx0aXBs
aWVyIHRvIHNlZSBpZgorCSAqIHdlIHNob3VsZCBzZW5kIGEgbG93LXJlcyAoYWthIHJlZ3VsYXIg
d2hlZWwpIGV2ZW50LgorCSAqLworCW11bHRpcGxpZXIgPSBjb3VudGVyLT5yZXNvbHV0aW9uX211
bHRpcGxpZXI7CisJbG93X3Jlc192YWx1ZSA9IHJlbWFpbmRlciAvIG11bHRpcGxpZXI7CisJcmVt
YWluZGVyIC09IGxvd19yZXNfdmFsdWUgKiBtdWx0aXBsaWVyOworCWNvdW50ZXItPnJlbWFpbmRl
ciA9IHJlbWFpbmRlcjsKKworCWlmIChsb3dfcmVzX3ZhbHVlKQorCQlpbnB1dF9yZXBvcnRfcmVs
KGNvdW50ZXItPmRldiwgUkVMX1dIRUVMLCBsb3dfcmVzX3ZhbHVlKTsKIH0KIEVYUE9SVF9TWU1C
T0xfR1BMKGhpZF9zY3JvbGxfY291bnRlcl9oYW5kbGVfc2Nyb2xsKTsK
--00000000000007413e05795f8e85--
