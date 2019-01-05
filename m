Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E38C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABA5222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ovm4s7qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAEUNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:13:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46228 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAEUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:13:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so35081119ljh.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pdi+Bg1i6iYAyJ/YB9jfmxDEJpBzO7ZGd7liVQjUxaA=;
        b=Ovm4s7qzBlZaFkhRQHYQAfhZuyMy8xnAoaOuLMym+53o/QgkGGfnxgHlttRFkYO0Gj
         7+uqgCM/NMv2jKFKNKxBNgXexzIvyLZduESW3zVSmxX5oY85FuDM23SDZkRu/VBjDrFH
         ktPUT1ftZfADhqSMujGo9gCGz4FRn/hgRLlz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pdi+Bg1i6iYAyJ/YB9jfmxDEJpBzO7ZGd7liVQjUxaA=;
        b=PS9xlBtyVvKnWUI4qIfsbvy+6pJMMz9MgrC2DCCEwQZAGYgNr8ZtPz18cVzJY3ShGH
         rUx8jcTQd76/lLgte5u3ZzDLG8b1k1yCcFoOteMqnRT0dfXTbBJmA1sFwf3qk2G/yL1T
         wfGVnaXDze8p4Rn8O8wlyyd2mdljfG3SVKKAwIxOnYVw35Y2HhHn7BN1IuFvMqZuScWU
         0JZMZC87e6TShnC1E8tle9GEAsyjNyiFE3eZ04ReNDtVoSzh9kJgHFXG8purfTRtYSkp
         Aw6glZEfLH9HlB4STHMfbiKjsT9IdWeayF+bNxHmxifFsbqf/nwmvPZuvktuCW2ELUFk
         OUSA==
X-Gm-Message-State: AJcUukdvlqyMhqUn4qtJSUO1NzqatsJzIwKAI4MEYbeP0AG3jmS27vG5
        a0ImCjwGTj4+G0xmDNzf5/F8L0YND9o=
X-Google-Smtp-Source: ALg8bN4XYYKc3Mo4VAiiV4gao+UValvS46eiUuC3Ql+vATk6KqVqkBiEALeGit/M36n5VYt18IzZag==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr31243424ljd.45.1546719200193;
        Sat, 05 Jan 2019 12:13:20 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b21sm11757204lfi.7.2019.01.05.12.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:13:19 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id p6so27672950lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:13:18 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr26631654lfa.106.1546719198576;
 Sat, 05 Jan 2019 12:13:18 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
In-Reply-To: <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 12:13:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wif_9nvNHJiyxHzJ80_WUb0P7CXNBvXkjZz-r1u0ozp7g@mail.gmail.com>
Message-ID: <CAHk-=wif_9nvNHJiyxHzJ80_WUb0P7CXNBvXkjZz-r1u0ozp7g@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006646d6057ebba023"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006646d6057ebba023
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 5, 2019 at 11:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Can we please just limit it to vma's that are either anonymous, or map
> a file that the user actually owns?

.. or slightly simpler: a file that the user opened for writing.

IOW, some (TOTALLY UNTESTED!) patch like this?

               Linus

--0000000000006646d6057ebba023
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jqjwnxes0>
X-Attachment-Id: f_jqjwnxes0

IG1tL21pbmNvcmUuYyB8IDE0ICsrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL21tL21pbmNvcmUuYyBiL21t
L21pbmNvcmUuYwppbmRleCAyMTgwOTliNWVkMzEuLjYxZTM4ODk1ZmIwMiAxMDA2NDQKLS0tIGEv
bW0vbWluY29yZS5jCisrKyBiL21tL21pbmNvcmUuYwpAQCAtMTY5LDYgKzE2OSwxMyBAQCBzdGF0
aWMgaW50IG1pbmNvcmVfcHRlX3JhbmdlKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgYWRkciwg
dW5zaWduZWQgbG9uZyBlbmQsCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBj
YW5fZG9fbWluY29yZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKK3sKKwlyZXR1cm4gdm1h
X2lzX2Fub255bW91cyh2bWEpCisJCXx8ICh2bWEtPnZtX2ZpbGUgJiYgKHZtYS0+dm1fZmlsZS0+
Zl9tb2RlICYgRk1PREVfV1JJVEUpKQorCQl8fCBjYXBhYmxlKENBUF9TWVNfQURNSU4pOworfQor
CiAvKgogICogRG8gYSBjaHVuayBvZiAic3lzX21pbmNvcmUoKSIuIFdlJ3ZlIGFscmVhZHkgY2hl
Y2tlZAogICogYWxsIHRoZSBhcmd1bWVudHMsIHdlIGhvbGQgdGhlIG1tYXAgc2VtYXBob3JlOiB3
ZSBzaG91bGQKQEAgLTE4OSw4ICsxOTYsMTMgQEAgc3RhdGljIGxvbmcgZG9fbWluY29yZSh1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgcGFnZXMsIHVuc2lnbmVkIGNoYXIgKnYKIAl2
bWEgPSBmaW5kX3ZtYShjdXJyZW50LT5tbSwgYWRkcik7CiAJaWYgKCF2bWEgfHwgYWRkciA8IHZt
YS0+dm1fc3RhcnQpCiAJCXJldHVybiAtRU5PTUVNOwotCW1pbmNvcmVfd2Fsay5tbSA9IHZtYS0+
dm1fbW07CiAJZW5kID0gbWluKHZtYS0+dm1fZW5kLCBhZGRyICsgKHBhZ2VzIDw8IFBBR0VfU0hJ
RlQpKTsKKwlpZiAoIWNhbl9kb19taW5jb3JlKHZtYSkpIHsKKwkJdW5zaWduZWQgbG9uZyBwYWdl
cyA9IChlbmQgLSBhZGRyKSA+PiBQQUdFX1NISUZUOworCQltZW1zZXQodmVjLCAxLCBwYWdlcyk7
CisJCXJldHVybiBwYWdlczsKKwl9CisJbWluY29yZV93YWxrLm1tID0gdm1hLT52bV9tbTsKIAll
cnIgPSB3YWxrX3BhZ2VfcmFuZ2UoYWRkciwgZW5kLCAmbWluY29yZV93YWxrKTsKIAlpZiAoZXJy
IDwgMCkKIAkJcmV0dXJuIGVycjsK
--0000000000006646d6057ebba023--
