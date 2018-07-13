Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2994ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC22087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUU9BiwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFC22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGMXix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeGMXix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:38:53 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A8D208CE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 23:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531524127;
        bh=X3fO/TB4wvKh2OodbCCLV5H0FDa2wEa0n2ACTxYOb1E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PUU9BiwO17OzFsep+t5zVmeP+qKlPFYlL7MWKFV8AsJWEBDFCEN7UgYwCQZ7pG7U3
         EAiefhKgc99gy4vZ4S3zyeVKog4mnmqo/9BsZAD34fZvXrwiyWOUoW7VMFeo6YOrq/
         A6Jeq/EVSPYkBlu+B82QrRkvwM1yN71MfKU0WgEg=
Received: by mail-wm0-f49.google.com with SMTP id s13-v6so5549899wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:22:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlEr/g2hmX6NFAaM7NDKwv1iHSTqOSXs7n4+5lF6ck1FK+uLGpTf
        Ghf69p9f6Wa5OcY97Tn96cVofbTZodJEEVYx4ssI7Q==
X-Google-Smtp-Source: AAOMgpep0L3Sp8vUm495MxnZBfLdYnzjh66ooyUQlvpozqAz0GV0oaqlPtRlffJyfX2zMej8hsRs3oENOKCjlC25tpQ=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr5178796wma.21.1531524125912;
 Fri, 13 Jul 2018 16:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:21:45
 -0700 (PDT)
In-Reply-To: <1531308586-29340-31-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-31-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 16:21:45 -0700
X-Gmail-Original-Message-ID: <CALCETrU9pe03cW2d+=nXy_iLbiYWzX1dU2wYCfHEN4gb69Q_EA@mail.gmail.com>
Message-ID: <CALCETrU9pe03cW2d+=nXy_iLbiYWzX1dU2wYCfHEN4gb69Q_EA@mail.gmail.com>
Subject: Re: [PATCH 30/39] x86/mm/pti: Clone entry-text again in pti_finalize()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> The mapping for entry-text might have changed in the kernel
> after it was cloned to the user page-table. Clone again
> to update the user page-table to bring the mapping in sync
> with the kernel again.

Can't we just defer pti_init() until after mark_readonly()?  What am I missing?
