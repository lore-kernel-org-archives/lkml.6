Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B4BC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AF120851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0znvO8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AF120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLKVTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:19:36 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40413 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:19:31 -0500
Received: by mail-yw1-f66.google.com with SMTP id r130so6059141ywg.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xWaaxa58ld/0XY9eXbIfbQ6/2aD189NGyWhxpL68oA=;
        b=W0znvO8VZaxP3Om1dPhhcL8wqSLjMM4Tlqf9/SmIWK9K2fhQlt4w9bqrD29tqpYUF1
         jT7S4VAzuwcpT3xA06OtRiljTaqpcMbO7EewyNIsQq3bx3+IanoM5Gmja9qMTON2LWYD
         1WrvEHlk4xoj/YSjWyjyCq/3YekfNv9IcIDPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xWaaxa58ld/0XY9eXbIfbQ6/2aD189NGyWhxpL68oA=;
        b=reDt1mgmZpKrNglsokp2oiyNlJ3uCOsc+gXXjnI8SVA2Sm+8kbO2d7CllkUbExhVSR
         wHMkKqC6UaV4itYWP3chpRagZet1KH55PO4A7Z8mfGiA2gr94aBwQv8ivdAISaSlVtZs
         kHHddpUFySR7eIoeaf2KWfyPPPlWBT/rFYTvYpG7nro4okdOoq9N7LwdbqNiOWfIX1sQ
         Yeu5U8mITchBlFCUNSzz6Iay/3K2LmF7abEj/6o2gw3cwI7QuCmjNEgPmooaDdAKly2I
         L5Ux5CI6X+jFSUUKj3Ow/ROqS5gp1lHdhGXlxfHo2DVazP6iHg6mzspcXMIPKOY5w8eH
         5z5Q==
X-Gm-Message-State: AA+aEWZUrtYZ4Qj36xrW+BCnZ829WqSgGb6xoAVbskDfUE/P7A4bM/RD
        0lsNwpe7oWJ67LczyYsJCYQ+ZmZ4mD4=
X-Google-Smtp-Source: AFSGD/V9ZwMuLPcG/Oo8XZ4WR0obLQC1a1pUR4Xf0N/ygidP3svLvNPjeves/+c6DBfldnzGjx2l3g==
X-Received: by 2002:a81:5fd5:: with SMTP id t204mr17651561ywb.312.1544563169898;
        Tue, 11 Dec 2018 13:19:29 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id d85sm5330802ywd.22.2018.12.11.13.19.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:19:28 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id l200so6065282ywe.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:19:27 -0800 (PST)
X-Received: by 2002:a81:29cc:: with SMTP id p195mr18729229ywp.407.1544563167538;
 Tue, 11 Dec 2018 13:19:27 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com> <alpine.LRH.2.21.1812120556040.11653@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812120556040.11653@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 13:19:16 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
Message-ID: <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 4 Dec 2018, Kees Cook wrote:
>
> > On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > v5: Include Kees Cook's rework of the lsm command
> > >     line interface. Stacking is not conditional.
> >
> > Can you resend this series with corrected "From:" lines in the body, etc?
> >
> > Beyond that, I obviously like it. James, what's needed for this to move forward?
>
> If there are no outstanding issues, I plan to merge this for 4.21.

Yeah, it looks good to me. (Excepting getting the authorship sorted.)

Thanks!

-- 
Kees Cook
