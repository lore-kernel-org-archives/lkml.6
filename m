Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8315C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A876220811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUZdqvP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A876220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeKNJJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:09:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43114 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:09:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id l200so938242ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dW23sJSqGZYEsGYacxeAXaAmZgYhN2aWDEZRMxrjOVw=;
        b=aUZdqvP618inSoKDtHR34x+9IFIVya2VE5pNpAjyueA8T9APDcIgOPAUkakkf+rFKG
         x38KZwz8wC6Z1pXaMoe3g2RvTn7BoQkMmcSc11gtTu2Ir6QumuHwAAemTz0CXnavKEhZ
         jyVRd4Ly3OY3FYCZsb4EWpStKoVXBlu7n13bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dW23sJSqGZYEsGYacxeAXaAmZgYhN2aWDEZRMxrjOVw=;
        b=e3BcBleT8uE0bUWKib9FUxv/jHMhDPAuMd62sfd9SxArw2wa0zQgdTnLQK2CfamTCL
         lPlwiXkYf7o8UwuIqND0BQgz7kqGl0vXSIP4cY9ysLCkPRKqE2F+JqwJz4CYoZ/fjV3F
         p9gH2kjd6XVTO1NS1edamqDufKkeuVJELTGxKL5L5U6OKLBN69qGNMemC7A/luwbyTh5
         bVPdegjdh9JaNQP2hV/HfOpoq2ODxAkOmiAvHkxHxsMHk+56F1IAFIOeCp53IyKLfjqi
         9IloR2j/UeF4fjgL6ApPc1WKSwQ4s/7Pr2/pBRCPrr+/QEvlnlH36MHNzrqs+01qli39
         xVlg==
X-Gm-Message-State: AGRZ1gJ0tEOixew8aDqmIHQJdlpen/gw4Wzo+pPRJieCVh7PGeGRQ+Ye
        69SjGYVw0rCVzzhtL/MtqQmisYcGJpg=
X-Google-Smtp-Source: AJdET5enhIeXhwC2hDSEMzAnefcKUVUz8nPNMZV/7P3dy+hK5FrgQhHIYLvBNx2TH6kxo/UiJ0C/3w==
X-Received: by 2002:a81:98cf:: with SMTP id p198-v6mr7010871ywg.353.1542150544077;
        Tue, 13 Nov 2018 15:09:04 -0800 (PST)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id y16sm375511ywg.35.2018.11.13.15.09.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 15:09:02 -0800 (PST)
Received: by mail-yw1-f52.google.com with SMTP id l200so938205ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:09:02 -0800 (PST)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr7206345ywd.124.1542150541802;
 Tue, 13 Nov 2018 15:09:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 15:09:00
 -0800 (PST)
In-Reply-To: <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com> <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 13 Nov 2018 17:09:00 -0600
X-Gmail-Original-Message-ID: <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
Message-ID: <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> When the PAC authentication fails, it doesn't actually generate an
> exception, it just flips a bit in the high-order bits of the pointer,
> making the pointer invalid. Then when the pointer is dereferenced (e.g.
> as a function return address), it generates the usual type of exception
> for an invalid address.

Ah! Okay, thanks. I missed that detail. :)

What area of memory ends up being addressable with such bit flips?
(i.e. is the kernel making sure nothing executable ends up there?)

> So when a function return fails in user mode, the exception is handled
> in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
> function return fails in kernel mode, the exception is handled in
> __do_kernel_fault and the task is killed.
>
> This is different from stack protector as we don't panic the kernel, we
> just kill the task. It would be difficult to panic as we don't have a
> reliable way of knowing that the exception was caused by a PAC
> authentication failure (we just have an invalid pointer with a specific
> bit flipped). We also don't print out any PAC-related warning.

There are other "guesses" in __do_kernel_fault(), I think? Could a
"PAC mismatch?" warning be included in the Oops if execution fails in
the address range that PAC failures would resolve into?

-Kees

-- 
Kees Cook
