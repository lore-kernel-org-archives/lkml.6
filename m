Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C9208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UrWs5FIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4C9208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeHWHLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:11:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40086 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHWHLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:11:53 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so5844947ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 20:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5LWD3y3RVUxSneEjqYeEe1dx9vBhG/Uow6+EM6si/Y=;
        b=UrWs5FISCagdEpyZ5N5gDm3heMqEDrpJ4f15iJs01npIjWNZv98zNqpUEaDXn4/c42
         +esOZkUFTOQiYe19M887uOpmP52c5hJhAqvuo+sKzWw5A5iG45gugWBnUtraxTMT0dQn
         CgNHFeQK4dT/WjxNqnguE58oVSwuCffXDMfxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5LWD3y3RVUxSneEjqYeEe1dx9vBhG/Uow6+EM6si/Y=;
        b=RU4gHRaqpWvQnFOIY9trPctdZadgMqDM9qWBi5Xa5w2yK4xkuHTu2fWNa/Q7bYwjFh
         ZwMk5yRyjQws+pLtUi6jubS5WY8j/UnkyW5RwPCpCmYvGYS3O7ThLjAYKYyg9yxqu0J5
         fB1aSJjKi/ekQWgSR+jOY/1nOz+w2SPc+UkjRSJVnDXqghsXHME9ntfLDZVQ4LVms88Z
         aMgeElZw3HGmXIl/TjbggyIYaKbIhUmCvL12caDPe11+hkfVk8roBNC7HKCy5YeORxch
         htKcMdBUWJPY+MYnhNR6wHCbC368l33GjCKEnrvCsY6b/wxfEloKLAKw/yCRtstHJTqp
         /Ugw==
X-Gm-Message-State: AOUpUlHuqkdtvo2+bWNIf+uOJWex1G1xzBDkr2uJZeonn+pIKaGM/+60
        ftn3oWWzbi2sTvLXCexnRgN2zriapROLT7dDJGk=
X-Google-Smtp-Source: AA+uWPynAbrXSDapQ3ECurc2j9OIgIp3qw5j0um7ds9r4US5ChpqIn/2C5BXvrD90uXYyrTb60iRpA/mDzzgWJfgtRc=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr51821539jaf.70.1534995856989;
 Wed, 22 Aug 2018 20:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.772017055@infradead.org>
 <20180823133103.30d6a16b@roar.ozlabs.ibm.com> <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
In-Reply-To: <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 20:44:05 -0700
Message-ID: <CA+55aFwMu2cN44WL7hK-xZmHUcSiifYkADTzFnQBO1jmJpZhmg@mail.gmail.com>
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

On Wed, Aug 22, 2018 at 8:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No. Because mm_users doesn't contain any lazy tlb users.

.. or, as it turns out, the use_mm() case either, which can do
gup_fast(). Oh well.

            Linus
