Return-Path: <kernel-hardening-return-12971-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48BiS8utOpachMgLJqn/sL2FSalre2DsvH+K2bnOWs7c3OsNucMPcK3SZgX+lP3CiWFHx4V
ARC-Seal: i=1; a=rsa-sha256; t=1523429646; cv=none;
        d=google.com; s=arc-20160816;
        b=cAc1X4IF3rd/ztoRst4ZWbyR8WFgbmcJg7voDdFCmRInF6lw1/Ukrmbw/EFVqdMHje
         h0KFuqqWHpf3gB6bkS/QEQPxqdulA2nar51yN8cBNKS5k+/i0aVM/TjexdmJ/Wd+7H7s
         uK39UOnTmfgnlgHJIp5CSGN8jvzx37P8vNO4ikd8yE6shDSW6tiyR3hhkxzTtXfzDiWy
         UT7jXHIR/S7tZxbyU/C9HDWPLR0IMslMB9cnD1u97xJnsOJiGZ/bSdd+FQ2WFHj0ug5d
         mbFzZG+2VUBJaS6Y4+ZZ07vk5y7oeZcWS57J3BHfvuacLDc6yEc3+S6ctDDQevssF6r9
         CMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=27h2DHNjsfcWTToDxWc87ZOYS4/Vyvdt21ZJWKTl/1s=;
        b=CyT5m2BHO5kkyqYQZ9ATrQuZHyOK9zFZ7qQsJ2+Ytgiqf8hixvz0sr5ZPXv29XTETg
         tmatGRM6l8HJfpI1i+cOXfC4F57+4B3XRLQr9vvP56HWySZQz0iz2QXluTwCEbC7jdBQ
         0iTQQXSyf3789sb6Gw8Uzzh2BVkGhQzsyKAgK24AZiLOywY/zA/c4Tmyz8LMUMIGtzds
         zHXqQZgkevH5s3RcEET+EGwBSe3CLTowFdO2i/add9mmL0YZly6tErdUh4JW20A2No6a
         iDzy3WpZLKJpbwoK3ZtKRl+BPG5aaRVdzJ7y/nalxwDNdJnXP5PzcW5c7XhNMPJtcEYI
         1TlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=jTLLc4cF;
       spf=pass (google.com: domain of kernel-hardening-return-12971-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12971-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=jTLLc4cF;
       spf=pass (google.com: domain of kernel-hardening-return-12971-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12971-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
References: <20180411010352.17929-1-labbott@redhat.com>
In-Reply-To: <20180411010352.17929-1-labbott@redhat.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Wed, 11 Apr 2018 03:44:33 +0000
Message-ID: <CAKwiHFj2Ram90uPVhX+2PvfgcNwcTMfg+M2E3tCOgi4eGyJ6Sg@mail.gmail.com>
Subject: Re: [PATCHv4] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
	Lukas Wunner <lukas@wunner.de>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Content-Type: multipart/alternative; boundary="000000000000aabd4405698a7508"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1597431765903354589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000aabd4405698a7508
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 11, 2018, 03:04 Laura Abbott <labbott@redhat.com> wrote:

>                 ret = gpio_chip_get_multiple(chip, mask, bits);
> -               if (ret)
> +               if (ret) {
> +                       /*
> +                        * Go against style and intentionally do the check
> for
> +                        * performance reasons
> +                        */
> +                       if (mask != fastpath)
> +                               kfree(mask);
>

Sorry, but that comment is now both unnecessary and actively wrong. You
can't kfree a stack array, so the check is  required, hence certainly not
against style :-)

--000000000000aabd4405698a7508
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJs
dHIiPk9uIFdlZCwgQXByIDExLCAyMDE4LCAwMzowNCBMYXVyYSBBYmJvdHQgJmx0OzxhIGhyZWY9
Im1haWx0bzpsYWJib3R0QHJlZGhhdC5jb20iPmxhYmJvdHRAcmVkaGF0LmNvbTwvYT4mZ3Q7IHdy
b3RlOjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0ID0gZ3Bpb19jaGlwX2dldF9tdWx0aXBsZShjaGlw
LCBtYXNrLCBiaXRzKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAvKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAqIEdvIGFnYWluc3Qgc3R5bGUgYW5kIGludGVudGlvbmFsbHkgZG8gdGhlIGNoZWNr
IGZvcjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIHBlcmZvcm1h
bmNlIHJlYXNvbnM8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobWFzayAhPSBmYXN0
cGF0aCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBrZnJlZShtYXNrKTs8YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRv
Ij48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPlNvcnJ5LCBidXQgdGhhdCBjb21tZW50IGlzIG5v
dyBib3RoIHVubmVjZXNzYXJ5IGFuZCBhY3RpdmVseSB3cm9uZy4gWW91IGNhbiYjMzk7dCBrZnJl
ZSBhIHN0YWNrIGFycmF5LCBzbyB0aGUgY2hlY2sgaXPCoCByZXF1aXJlZCwgaGVuY2UgY2VydGFp
bmx5IG5vdCBhZ2FpbnN0IHN0eWxlIDotKTwvZGl2PjwvZGl2Pg0K
--000000000000aabd4405698a7508--
