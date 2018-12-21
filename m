Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5021903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLFz+84N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeLUPhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:37:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33829 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeLUPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:37:20 -0500
Received: by mail-io1-f65.google.com with SMTP id l22so760304ioh.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nux+WIMdjrFe5ctfdbiOAVW2IoHuttwcjmO4rDIlz4c=;
        b=GLFz+84NZAGGQ0tEbOJDZyO0qnWI3gB9ROEux/TeJnsr3E52g5koHP2U9Ss+Tt8yw9
         SSHXluBAJyO/FuYRuYFpHSec4U0/ZzZCyQwJU08XYWuXF7eBapaqF6oQcK1R0nbbU9vN
         I3jqi5fUkq7ETKrmRRFh6rEjsjP+yUwOldvRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nux+WIMdjrFe5ctfdbiOAVW2IoHuttwcjmO4rDIlz4c=;
        b=BTbBqqSA1hBsosWPeknTdBrPp+wCvXQWo3Kb1vdvHC7wr0iIwhRuUdx18M0M+FKOB1
         jkhNaLRw88dsxgFr8ESSS+nRNakHClZXzVNotOFU9Zod1LSNe8x1iaoimyI0z5N2i+UY
         PgEv0ZAowNilEMQN+ipXmcuF/lXq50jl32b1J+s7ka1Ygz05bN5sXPhbqBV8wy23gp/5
         nG2eg8lDdOJOXmyP14PZ/DQbB5QAN9cZibhIQbtiQRA8oW/WYKg6t2Kt0zD1xt4OsXcp
         0M4QPcP86IM7AsY4XJRlwMzIUrZzHd9fnxW+Bylh9k90JnL8Z9kDDNLQAia5+rAD9g66
         BQ3g==
X-Gm-Message-State: AJcUukeYlROhLE9KkO3GOKGlcCUsyF3icbKVW7ObhAMGJY7/5x4Y5d52
        G5qSz943oRiCUwBsZc7wI6zxZH5sFY/tbqkjvmKG5w==
X-Google-Smtp-Source: ALg8bN7pu6amHgza86GECEHZaE3B7fTgzyHb3ZZwXaN3vCM2SQM2vyqG3+/k5PwhQf8i3hvBtnatVVcxnfdpn9nvkJk=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr36231ion.173.1545406639091;
 Fri, 21 Dec 2018 07:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <20181204154056.iyf333bcxqwk3obe@linutronix.de>
 <CAGXu5jLUMW3cCi1KVdSmOVn3O9BQ6ptYnyJbLHxojgzXd_YUxQ@mail.gmail.com> <20181204180612.z4az5yplw5oqb26a@linutronix.de>
In-Reply-To: <20181204180612.z4az5yplw5oqb26a@linutronix.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Dec 2018 16:37:07 +0100
Message-ID: <CAKv+Gu8tXHmXrGezZpfkPsVpF09G1XfkpcsxeU2zyP+6OxRLmQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 19:06, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-12-04 09:23:13 [-0800], Kees Cook wrote:
> > Okay, so, if kmsg_dump() uses rcu_read_lock(), that means efi-pstore
> > can _never_ sleep, and it's nothing to do with pstore internals. :( I
> > guess we just hard-code it, then? And efi-pstore should probably only
> > attach to pstore if it has a nonblock implementation (and warn if one
> > isn't available).
>
> I was about to suggest that. I am not aware if anything else could use
> efi_pstore_write() use that but otherwise you could hardcode it.
>

efivar_entry_set_safe() will only use the default backend if no
non-blocking variant is provided, in which case it assumes that the
default one is non-blocking. Perhaps we should just assign both
function pointers to the same function in this case.
