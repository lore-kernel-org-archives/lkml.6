Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D20C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B5522419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TBiBlagL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B5522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKOIx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:53:28 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42792 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:53:28 -0500
Received: by mail-yb1-f196.google.com with SMTP id o204-v6so7588114yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SY0zlOONuREE8Rl0qImCyrFTm0DYI7yiTyIKNGmeAJw=;
        b=TBiBlagL1QyupAp9ljD4IST7uGM2x9BED81N7wKsxdGS+7gsyAq6WkiYVPfp+ZkiDx
         g7/XU8qIKFw9H1iNoz1kI1W58ddtZDgNa8IwCZuKdUogpRY+mQ3qsO4OHB62d4ylx3Zo
         62n7OGfiUKD7AuSZNmKxbXD8NKk+TBV8w4Uf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SY0zlOONuREE8Rl0qImCyrFTm0DYI7yiTyIKNGmeAJw=;
        b=isxz9nmq2o7i5K8MJY8o6zThyyffIP7Ip/pTrFOllFTn6Z6e8EYlMHRP6mrt2kzsu6
         pl1ggXnR0qkGZWlAuRp4gt0/G0IFTWZIXuSkdo4RVBbUyPh7XEuE2lbTIK0cs6+4bBE7
         9d7pfkIhy8r7ZKE8Q8LczBea0dnUKcHt9Xjp25Zk/MlyZaziF4MhPRcQUjmEwYuWkvpu
         fMQyvAg0FeDuLneZ+bZJ9jRqtqWqRg4/H7W6T059Vi7Jkue65VKfXP4oAxrb6E6UxBuu
         RYZzz4Jqwkw1U4VouW80Igg/9CDmDlkOPEkBjbDSjt1QUQDqJX1gVlqULK9G6kAU9Vz7
         CVfw==
X-Gm-Message-State: AGRZ1gKhURL7Lm3zjmc43bbtgp5L6hEPwbc+A6EAVIp7qYPwHQFA0WL6
        KpbFWZMtUsjA3WWfH5NNAwovZ4KPcBQ=
X-Google-Smtp-Source: AJdET5c0iWfZ2YM4snx4cTHxzDAiStbszU2P/xrTnm5Fqxt/kPca9HBUlOPOu4z0XjO8PST0c8eHjA==
X-Received: by 2002:a25:2585:: with SMTP id l127-v6mr3715001ybl.324.1542235695271;
        Wed, 14 Nov 2018 14:48:15 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id q2-v6sm11900910ywa.24.2018.11.14.14.48.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:48:13 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id r199so309111ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:48:13 -0800 (PST)
X-Received: by 2002:a0d:e984:: with SMTP id s126-v6mr3551902ywe.47.1542235692507;
 Wed, 14 Nov 2018 14:48:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 14:48:11
 -0800 (PST)
In-Reply-To: <20181114214701.gdnrznakwtm76jlt@blommer>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
 <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com> <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
 <20181114214701.gdnrznakwtm76jlt@blommer>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 16:48:11 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJun3CuUa12aQpy+m7Op-g9XwPv3CygwqYX2dy0A4qt5Q@mail.gmail.com>
Message-ID: <CAGXu5jJun3CuUa12aQpy+m7Op-g9XwPv3CygwqYX2dy0A4qt5Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 3:47 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 13, 2018 at 05:09:00PM -0600, Kees Cook wrote:
>> On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
>> <kristina.martsenko@arm.com> wrote:
>> > When the PAC authentication fails, it doesn't actually generate an
>> > exception, it just flips a bit in the high-order bits of the pointer,
>> > making the pointer invalid. Then when the pointer is dereferenced (e.g.
>> > as a function return address), it generates the usual type of exception
>> > for an invalid address.
>>
>> Ah! Okay, thanks. I missed that detail. :)
>>
>> What area of memory ends up being addressable with such bit flips?
>> (i.e. is the kernel making sure nothing executable ends up there?)
>>
>> > So when a function return fails in user mode, the exception is handled
>> > in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
>> > function return fails in kernel mode, the exception is handled in
>> > __do_kernel_fault and the task is killed.
>> >
>> > This is different from stack protector as we don't panic the kernel, we
>> > just kill the task. It would be difficult to panic as we don't have a
>> > reliable way of knowing that the exception was caused by a PAC
>> > authentication failure (we just have an invalid pointer with a specific
>> > bit flipped). We also don't print out any PAC-related warning.
>>
>> There are other "guesses" in __do_kernel_fault(), I think? Could a
>> "PAC mismatch?" warning be included in the Oops if execution fails in
>> the address range that PAC failures would resolve into?
>
> I'd personally prefer that we didn't try to guess if a fault is due to a failed
> AUT*, even for logging.
>
> Presently, it's not possible to distinguish between a fault resulting from a
> failed AUT* and a fault which happens to have hte same bits/clear, so there are
> false positives. The architecture may also change the precise details of the
> faulting address, and we'd have false negatives in that case.
>
> Given that, I think suggesting that a fault is due to a failed AUT* is liable
> to make things more confusing.

Okay, no worries. It should be pretty clear from the back trace anyway. :)

As long as there isn't any way for the pointer bit flips to result in
an addressable range, I'm happy. :)

-Kees

-- 
Kees Cook
