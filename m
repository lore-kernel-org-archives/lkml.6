Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1523C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DC6208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ha8uTBda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DC6208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965608AbeFONLc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:11:32 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54517 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936144AbeFONLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:11:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 899d2237
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=AD2nk5
        uymHhBT8XbLMXduM0LCNA=; b=Ha8uTBdaNluTBZmGwV8JhrA9D07erFAjjwCg15
        oULihI4HIItAuehVw1K4irPvsTzpMZfUcMn2fP08lF5ccUnBdwqotBPrVz2JtUCp
        XIW71SbPVaLbUkcTB47qF+X4uNJNrQZ27NAYiOEZO+93AAx8Nus2DIh+KK5pWF0G
        +N9i1qT0zchSiqagT66rBNN9LAb0jvlZo1CIVJzLjSDZ8fEZO3mAh6OCkHto89TW
        7HqHq3eo7PR39//uNwp836cdTZdaXoiU5BAxJCgGHOZODCky7AFZs0jz+SD5k8Eu
        PRKPuLn/Pfx4tKT7PsulZyMtKJubOeNsqlvjpjqTUs9fd3jA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 169695b6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 13:06:08 +0000 (UTC)
Received: by mail-ot0-f175.google.com with SMTP id 101-v6so10927422oth.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:11:29 -0700 (PDT)
X-Gm-Message-State: APt69E235EaU6LpkwjZyjv+OUKRuINq7RDk3yeeYTHlDxxxW/MYdv6Nk
        ne12WyZEFSzXxAPQTj6R7raT3NkAn6dM6JOJJvQ=
X-Google-Smtp-Source: ADUXVKKmEVztk+8gqnNwgDNoE7U0nqdCFvPHBYxL8Qmt4FjGucmfjGQHYX3vxjTHqrBsCBPUtGazP9c1fC0zFB2ToLc=
X-Received: by 2002:a9d:20e3:: with SMTP id x90-v6mr1010389ota.338.1529068287965;
 Fri, 15 Jun 2018 06:11:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 15 Jun 2018 15:11:15 +0200
X-Gmail-Original-Message-ID: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
Message-ID: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
Subject: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy & folks,

Lots of crypto routines look like this:

kernel_fpu_begin();
encrypt();
kernel_fpu_end();

If you call such a routine twice, you get:

kernel_fpu_begin();
encrypt();
kernel_fpu_end();
kernel_fpu_begin();
encrypt();
kernel_fpu_end();

In a loop this looks like:

for (thing) {
  kernel_fpu_begin();
  encrypt(thing);
  kernel_fpu_end();
}

This is obviously very bad, because begin() and end() are slow, so
WireGuard does the obvious:

kernel_fpu_begin();
for (thing)
  encrypt(thing);
kernel_fpu_end();

This is fine and well, and the crypto API I'm working on will enable
this to be done in a clear way, but I do wonder if maybe this is not
something that should be happening at the level of the caller, but
rather in the fpu functions themselves. Namely, what are your thoughts
on modifying kernel_fpu_end() so that it doesn't actually restore the
state, but just reenables preemption and marks that on the next
context switch, the state should be restored? Then, essentially,
kernel_fpu_begin() and end() become free after the first usage of
kernel_fpu_begin().

Is this something feasible? I know that performance-wise, I'm really
gaining a lot from hoisting those functions out of the loops, and API
wise, it'd be slightly simpler to implement if I didn't have to all
for that hoisting.

Regards,
Jason
