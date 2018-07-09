Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D063C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2642087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fl+2CkLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2642087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeGISEm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:04:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45216 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeGISEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:04:40 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so17862626ioh.12;
        Mon, 09 Jul 2018 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa1xusVboXCkqCacRrAsaOCtihfIK5/GT3tCUm4CBtk=;
        b=fl+2CkLR+MuSH3bnmIWWHygAuODBNKPx5rCOa7MX+eoKms9AuCeoRGNwY7sjcNxD3D
         093IoMUlFHQCTCKp3NK1BpXtkzTRyXSIL3pJEpkfu7gIzgwcasV+Qh46bhoAK1F4aiEx
         oVaTZhMuOWU2WMrQ7k0YAMGCxEoFnhyRHvBMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa1xusVboXCkqCacRrAsaOCtihfIK5/GT3tCUm4CBtk=;
        b=AnEXmQyMSZlECo3bCbWtWgZTMb0FjOSgo/c1ZKJsU0W5oE0tMRNfzT8JWu5wafwysn
         ooKGPK4MReDqjdYq+C9aVe7Cb5Dsn7rqo4YiXYmEzMMLx+OL9JpJChmtLv2l3LyqTG9J
         ti3oP4UQv0ASDRpN8HAmfEMOELkkI4IoXt+cHr2k/Tv8kJQmHwpi56jbOF2okL5lx34G
         weihbUmEQChhvHqXGc94+2qwFQIBQirF9asDKYEzxTS8ioWeNJmO+A34huTD3IOjk2od
         pquIzC+iHLs9c11ED6i5MHoCjBhp2fiAf7QFn+b7r8vmU0+ErvTXUrXQF73Wkmyt6fS7
         /ElA==
X-Gm-Message-State: APt69E32V9rSel6RZ6kCovuPtWlfZP5XPUS7Eh19z28lIDGsCBdz25eg
        +sdueV+HC0JzlrkQBZjC3lQTD1Ml/C7MOZiozBM=
X-Google-Smtp-Source: AAOMgpeaN5JmUqqlH4zQuLTrEci9bK8NoSW/ZDmNOsJ/AU0cRIS1ECGu3XSgHdFsVAD/zxnjj8jTgK6CKbRYg5unfAA=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr2743478iom.238.1531159479667;
 Mon, 09 Jul 2018 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
 <20180708210330.27324-3-mathieu.desnoyers@efficios.com> <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
In-Reply-To: <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jul 2018 11:04:28 -0700
Message-ID: <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
Subject: Re: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than __get_user/__put_user
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Andrew Hunter <ahh@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> So, another twist to this story: ppc32 does not implement u64 get_user().

I was going to say that "that's not possible", since we actually have
64-bit arguments at least in the form of "loff_t __user *".

But when I started looking, it turns out that yeah, we do
"copy_from_user()" on them, and instead made the x86 copy_from_user()
have special cases for constant sizes.

So a 8-byte copy_from_user() is fine. It ends up being a "get_user()"
on x86 anyway.

                Linus
