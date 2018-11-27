Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636142145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NMG1WpT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbeK1D5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:57:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39470 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbeK1D5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:57:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so16998052lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irQrZ6DfxW1N1L8CqFqg5rqEpddiPsOVqPg9YJGZ3bE=;
        b=NMG1WpT74QkG56LLr6Vf38yjYRJeT1mWAnXXlj75iW48bcB68MLjr/IM0gSw7zoWXO
         zs+lwEaX1V5xC85xGvByMZSobI9Quz9IQ4SdOS6kVZnChm3F/pT+xDsA9JSGDcz9U88h
         9N+wOAS0zxnD4n78R9uZimN3i9ePrvBeh6ZE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irQrZ6DfxW1N1L8CqFqg5rqEpddiPsOVqPg9YJGZ3bE=;
        b=EnsuqnxTGco1leHRQAAJHieOsMxqRCeq1Z5mOVy+OisDfOx7YtZjfbB0DS8zqJcy3j
         fhyUYqPKIAphmO/48eux2aEB6yuvJCjfmyeUrb0bbm+Xj4ALQGmAAkXZEmd3UnPmUSOg
         Iv7A6vt7nCY9Gw0KuyXPtRq1U8BAVUyyl1TUlfvQwhOWOIAMBpPV07QW8Rq9yeekn95K
         ugej2VYF9G08OQmed1CQV4vwWbQTMUhDn8+ZJ77vI326RQ2+HV5LWKoL6ZI0FlxJfpHg
         sVCXAVmI9zQmYOALXlB+hVhWH9OGeCnAj+YgjmSlKInO6D0ln7DzTd7c84M0PX8T/VeW
         7AZQ==
X-Gm-Message-State: AGRZ1gLDHTV7m6HK8cK5Sm9xsAc5+qzikKhihQ7iLc6il5SdiyY8PZi3
        hRSDh3wRU3aKHVrrt/s6Q/hST4SLbtU=
X-Google-Smtp-Source: AJdET5cPiQYPjAunDbs5IH8Bzl9F3LQExe4Qy9myepTFsvYHFUoz/IKC1x7TU+isav/MoyiDBqXD3A==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr18064527lfk.155.1543337929273;
        Tue, 27 Nov 2018 08:58:49 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c20sm674681lfj.67.2018.11.27.08.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:58:48 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id p17so17008962lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:58:47 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr20755156lfc.147.1543337927283;
 Tue, 27 Nov 2018 08:58:47 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
 <20181126205351.GM3065@bombadil.infradead.org> <20181127105602.GC16502@rapoport-lnx>
 <010001675613a406-89de05df-ccf6-4bfa-ae3b-6f94148d514a-000000@email.amazonses.com>
In-Reply-To: <010001675613a406-89de05df-ccf6-4bfa-ae3b-6f94148d514a-000000@email.amazonses.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Nov 2018 08:58:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisu7SHwHYo6TKo6t5CM6Da66jGsMgXKdrfNa-fDzdP5g@mail.gmail.com>
Message-ID: <CAHk-=wisu7SHwHYo6TKo6t5CM6Da66jGsMgXKdrfNa-fDzdP5g@mail.gmail.com>
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is migrated
To:     Christoph Lameter <cl@linux.com>
Cc:     rppt@linux.ibm.com, Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, david@redhat.com,
        mgorman@techsingularity.net,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, kan.liang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 8:49 AM Christopher Lameter <cl@linux.com> wrote:
>
> A process has no refcount on a page struct and is waiting for it to become
> unlocked? Why? Should it not simply ignore that page and continue?

The problem isn't that you can just "continue".

You need to *retry*.

And you can't just busy-loop. You want to wait until the page state
has changed, and _then_ retry.

                  Linus
