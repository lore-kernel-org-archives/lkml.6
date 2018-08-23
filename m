Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC70C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413C208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K0ESeMNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6413C208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeHWHDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:03:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35700 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeHWHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:03:03 -0400
Received: by mail-it0-f67.google.com with SMTP id 139-v6so5856480itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNbqYs8y/43kbt63Jw7JGtKxtIBvNb8eoOg9L2PkQsE=;
        b=K0ESeMNrENm+ixWuiotdeMV0sE8E1wGYCEPQKc4eNDFMQAtFiwuyB/DZP+IQEyKWY+
         tPHkMYrUR+YNYh5uCquu4wdYsqWWGyMe7yKAo6b20heBl/9wGeE56M66gmK7O/RKYPzJ
         vCwJlZxq0RgAbxJM05RSdEbnLZQGHupM/X3UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNbqYs8y/43kbt63Jw7JGtKxtIBvNb8eoOg9L2PkQsE=;
        b=PfzCZp2qEYP6AkXcBkh0pdWHiihrKf4pj02TbSVmeDLJXsVulTU4oCxGzDNyFhhTA1
         a3P2jzcwWj5oFm43egYBp8Hqkvp06hVsONblzPU+N6uaWjOeSguDzJ7wPeemHSziPYsI
         d4fwTogvbPPzIc4hPf90HoXFOOfi81qM9LXmsI7oi1tRH2pr/MZgYuDVnlxlFuomtd3p
         R+u+1LJPVOPm7zmXoXt8qCA4vpRZrXIj/dfVCWdj46vz4IxnkyQ201M22aBoN/cTzaxZ
         wGnPW3qXUUEbv9LATK3z3e8D38ECOjaXBZpyQbBUlVRSMbMjEiqZ2ekbGiwEVXOldJMO
         EHLA==
X-Gm-Message-State: APzg51CPr7AIEF7gMWhSrWmeMsBKZrhuPrv/+zs8WyzfTAKqMtYVl0uN
        GfIic0ckaI8bKDSyFfUCjIBNN+lVwi8Co7Xycuw=
X-Google-Smtp-Source: ANB0VdYQSDXw3WG10B4J8Y/60CH6jiYmLosweVtbzaL1mGzQzN/mKaTQ1Zycyilo225XavXo/IkPFAgtPS4uezOZW80=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr5790351itq.9.1534995328275;
 Wed, 22 Aug 2018 20:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.772017055@infradead.org>
 <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
In-Reply-To: <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 20:35:16 -0700
Message-ID: <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent condition
To:     Nick Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 8:31 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
>
> So that leaves speculative operations. I don't see where the problem is
> with those either -- this shortcut needs to ensure there are no other
> *non speculative* operations. mm_users is correct for that.

No. Because mm_users doesn't contain any lazy tlb users.

And yes, those lazy tlbs are all kernel threads, but they can still
speculatively load user addresses.

           Linus
