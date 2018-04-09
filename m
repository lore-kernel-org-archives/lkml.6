Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeDIRO3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:14:29 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52788 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeDIRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:14:27 -0400
X-Google-Smtp-Source: AIpwx49mcRjJOimF4Oaxp0tgDjwhFmR6zFtCBNpOPXTMUJFPogPgDgUEybS1tv8BXI7PcQEFDLruq/pCyc0OCeUT3eg=
MIME-Version: 1.0
In-Reply-To: <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 10:14:25 -0700
X-Google-Sender-Auth: EPQm1K2UT7wWGoJcQmAPdfJT6jY
Message-ID: <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b484fa05696d89e5"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b484fa05696d89e5
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 9, 2018 at 10:03 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Our old "min()" had the internal variables called "min1" and "min2",
> which is crazy too.

Actually, no, it used the really cumbersome "__UNIQUE_ID" and then
passed that odd as the name 'min1/2',

Ugh, I find that really nasty to read, but it was obviously done
because we hit this before.

And our __UNIQUE_ID() macro is garbage anyway, since it falls back on
the line number, which doesn't really work for macros anyway. But we
have proper macros for both clang and gcc, so maybe we should ignore
the broken fallback.

A patch like the attached, perhaps?

                    Linus

--000000000000b484fa05696d89e5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfshydrl0

IGluY2x1ZGUvbGludXgva2VybmVsLmggfCAxNyArKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2tlcm5lbC5oIGIvaW5jbHVkZS9saW51eC9rZXJuZWwuaAppbmRleCA0YWUxZGZk
OWJmMDUuLjUyYjcwODk0ZWFhNSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9rZXJuZWwuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oCkBAIC04MjIsMTQgKzgyMiwxNSBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgZnRyYWNlX2R1bXAoZW51bSBmdHJhY2VfZHVtcF9tb2RlIG9vcHNfZHVtcF9t
b2RlKSB7IH0KIAogI2RlZmluZSBfX2NtcCh4LCB5LCBvcCkJKCh4KSBvcCAoeSkgPyAoeCkgOiAo
eSkpCiAKLSNkZWZpbmUgX19jbXBfb25jZSh4LCB5LCBvcCkgKHsJCVwKLQkJdHlwZW9mKHgpIF9f
eCA9ICh4KTsJXAotCQl0eXBlb2YoeSkgX195ID0gKHkpOwlcCi0JCV9fY21wKF9feCwgX195LCBv
cCk7IH0pCi0KLSNkZWZpbmUgX19jYXJlZnVsX2NtcCh4LCB5LCBvcCkJCQkJXAotCQlfX2J1aWx0
aW5fY2hvb3NlX2V4cHIoX19zYWZlX2NtcCh4LCB5KSwJXAotCQkJCSAgICAgIF9fY21wKHgsIHks
IG9wKSwgX19jbXBfb25jZSh4LCB5LCBvcCkpCisjZGVmaW5lIF9fY21wX29uY2UoeCwgeSwgdW5p
cXVlX3gsIHVuaXF1ZV95LCBvcCkgKHsJXAorCQl0eXBlb2YoeCkgdW5pcXVlX3ggPSAoeCk7CQlc
CisJCXR5cGVvZih5KSB1bmlxdWVfeSA9ICh5KTsJCVwKKwkJX19jbXAodW5pcXVlX3gsIHVuaXF1
ZV95LCBvcCk7IH0pCisKKyNkZWZpbmUgX19jYXJlZnVsX2NtcCh4LCB5LCBvcCkgXAorCV9fYnVp
bHRpbl9jaG9vc2VfZXhwcihfX3NhZmVfY21wKHgsIHkpLCBcCisJCV9fY21wKHgsIHksIG9wKSwg
XAorCQlfX2NtcF9vbmNlKHgsIHksIF9fVU5JUVVFX0lEKF9feCksIF9fVU5JUVVFX0lEKF9feSks
IG9wKSkKIAogLyoqCiAgKiBtaW4gLSByZXR1cm4gbWluaW11bSBvZiB0d28gdmFsdWVzIG9mIHRo
ZSBzYW1lIG9yIGNvbXBhdGlibGUgdHlwZXMK
--000000000000b484fa05696d89e5--
