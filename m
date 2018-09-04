Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABACC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OUJE5yDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5100320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeIDIHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:07:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38885 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIDIHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:07:14 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so3113382ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 20:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDotbDmjgK1ChKMiVVgSyzpMcHf9vdJ+z5CczE5yK1k=;
        b=OUJE5yDEWrTAt1GjegYVlZjPpUHiUUG4lJqHVB6So56Tlx0SGnqGKlOVnbBYgvMEMr
         5915xhY6r8TJYIoOONH8S535q4jUyTFIvnOOTegXK4takqRvP4Jg+3gW7Et4Kp+ZTJum
         3ggL3YMq+CboptHIVxlVieJXjBCNc+FfrQyr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDotbDmjgK1ChKMiVVgSyzpMcHf9vdJ+z5CczE5yK1k=;
        b=HpVJsCObowHs2dyPyi2LHpvVnIgpRqdCXjr6IgL+dxAf97DZg2UcT0YyoLow14iT62
         BNO5Ay8H3qc7u6ozN5eR2X24UMKsVMNn8TYLrhwo6POvKviVRJ+PrNeRKOQPtZai0zZQ
         pR+bqQGIXBxskGn89HX245LoBWRaxqIRpu8cIXqyWJXisDqJtzcxoCi4tOt8C6ur4oN3
         Xugi4Eal2S7/pp6/WeJZVmcbPwkuhHWdgAQbyWdyCofBDiBJ+Cf4E9ZqxXliUSW2cUtg
         /dMLzxlsB9fE+S/sr8gYE3PsNDTHp5JpJJ6DwGOwCQe8kfxXgpl9x6PGkajNHhZwQllr
         8QvA==
X-Gm-Message-State: APzg51ARvmHRzhpsXRNgTzrdG1jO2qAtG0RBbKNEKmKPu3Riki/+pr8Q
        B6rddQV9T4Td6DgOuoNfTrDbBH50713sQ597evK/Eg==
X-Google-Smtp-Source: ANB0VdYDxEg0Jw5rkKwQEhvY8u5KaOmQl5dOFip5naYG/Iru86UCYxFL82V8sApN/OY78v1RXRB7FX4mYwIXnDE7j7U=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr7020387itq.9.1536032646982;
 Mon, 03 Sep 2018 20:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536015544.git.luto@kernel.org>
In-Reply-To: <cover.1536015544.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Sep 2018 20:43:56 -0700
Message-ID: <CA+55aFz1BMeJ9P0MAG3BfmpX0gj3urVpaSy388j6TkkqhkPDMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] x86/pti: Get rid of entry trampolines and add some docs
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 3:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Changes from v1: Get rid of the rsp_scratch macro

I can't see anything wrong with this.

            Linus
