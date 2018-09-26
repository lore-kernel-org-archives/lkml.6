Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2343C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F9E2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgiNjAMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F9E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeI0AOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:14:16 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:36232 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0AOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:14:16 -0400
Received: by mail-it1-f174.google.com with SMTP id c85-v6so4118770itd.1;
        Wed, 26 Sep 2018 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ubQly2OZgpLfKsgSV7U/N//718E2LTyFxm1rjCRrdU4=;
        b=rgiNjAMMttzlRJVK6RbbEjxiODO4RViWYkRCgWEC0nb148bg3ggGTKJtzc7MvYd9E9
         1FgVo3DZcqwhgq1y9ZuhwF29YRwns5zF3bi6YchIzqwFAujbWLyJxfn8PMeu6uBvW0Ry
         +gKnFYNmob9CurmZOA8w7Dt7eVbcB347TKfjpR6Vb9gG0axTC+uYxBmskecrU9GDTUPw
         7RECly0XSKkx7uVGbjBwOby3y8PmNezNI81uXjyKcNb+QFlrRjA6UvVtgnYeqOjsM/Qh
         uUKdmgLI4QGsakLArX/RD9wXyzC3AyDczMEKkuhbTW654Nlrx6PDL+slJcZg5i9uBvH1
         zEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ubQly2OZgpLfKsgSV7U/N//718E2LTyFxm1rjCRrdU4=;
        b=YICXIWHRrJv/L7TregGPKqOuWzHXrEInAsf0Ex4VcCG3x40vi6yt4Ovj9SnYII73yt
         A4OoUGs6mXheq8wzoDH5JnLvIe7CBDRCvyHAjaI071//mwUncQqDJRDm4kgcyIowq/u9
         HrkgnYXwerDxfNrbCG9zosDOyUeG0QACbJK0SnQqqxUjyd6HULZyfIF+3N2QV1qza236
         34pvtGbPHFQpGhVKZM77Fk/GCc5V5P9x3n17+WNqKeez3seiK9v53Bc1hfkyecJ+rawp
         ZJ2YOj3ZigGSFwdbD+rbT/UgxjVgGZApRKHIltO+ZznqoY5X03R6I4osFTY56XR+QZxi
         zA5A==
X-Gm-Message-State: ABuFfoi1LGCJTc6H2dkcMIU6+m9JGUTeOi/aGrSCz/15YuJODTR9dCh6
        xjZwUX6G71P0AN0F3/L941BqTYfebXiSpHJ7nYM=
X-Google-Smtp-Source: ACcGV62HztWP/BqS/C/N68tnDFcbYgnO9g/u5u8ZaX+FDNOf9sJRiV/1YlRTqQckEufJwomna7MYgXo3draRIR2uWog=
X-Received: by 2002:a02:1bce:: with SMTP id 75-v6mr6946171jas.29.1537984809813;
 Wed, 26 Sep 2018 11:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:ab5c:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 10:59:49
 -0700 (PDT)
In-Reply-To: <87zhw4rwiq.fsf@xmission.com>
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com>
 <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com>
 <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Wed, 26 Sep 2018 18:59:49 +0100
Message-ID: <CAJwJo6bseG42YNqA0cxWpB0C252_CWER0gDrF0OUOm+=DJ7XdQ@mail.gmail.com>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-26 18:36 GMT+01:00 Eric W. Biederman <ebiederm@xmission.com>:
> The advantage of timekeeping_update per time namespace is that it allows
> different lengths of seconds per time namespace.  Which allows testing
> ntp and the kernel in interesting ways while still having a working
> production configuration on the same system.

Just a quick note: the different length of second per namespace sounds
very interesting in my POV, I remember I've seen this article:
http://publish.illinois.edu/science-of-security-lablet/files/2014/05/DSSnet-A-Smart-Grid-Modeling-Platform-Combining-Electrical-Power-Distributtion-System-Simulation-and-Software-Defined-Networking-Emulation.pdf

And their realisation with a simulation of time going with different speed
per-pid  (with vdso disabled):
https://github.com/littlepretty/VirtualTimeKernel

Thanks,
             Dmitry
