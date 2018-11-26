Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2097620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8nG7ZPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2097620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeK0GZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:25:35 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:33506 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0GZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:25:35 -0500
Received: by mail-lf1-f42.google.com with SMTP id i26so14497852lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfSiWt4TASYtU/aFn7VLqQdRvKbL6KMMgypgppPpkhY=;
        b=N8nG7ZPglfkvB0ldspGZvLQddmNZyuLR7Z3MR219b49nwAaRPvLcs0SJDtKpcMpL9n
         zuavdtsP/caU7W+DhTHc047XdfIkaTGOZn2fM9vwxoDm5K0EACXcEH2UClBcfqUj9kOt
         iQBm/0jYMv5twHMm/OjKlYhn3n6hMjy8T/r5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfSiWt4TASYtU/aFn7VLqQdRvKbL6KMMgypgppPpkhY=;
        b=G/zomABfIhE+QxmUm2SdHtelp4jOleKWg3pUqs3vMubMVwpnHyYjjB4sadSzx+Wafk
         v+kxd3hTdQw5qYkrKR77/GXzxh+nvueOjxKmWO/mDULPYWnb45P+5PISuyVaezs9OPBC
         VeWSwgVwBsr6btxvqdvuqO/ShiFChJXx2/q5pLwst6yuyLwmbFAOF7UiJ/Ea+YiwGtbO
         oPmyX5/wfZzsUNVlHTu/rpNhhItGs3kd9OYpMBIv/So8LKTFqYV7iJfVABTC00qIPIMa
         Bmsr4GmO/odPtYajrUZTsKoiEBvXl9WrBgC9dtNf5qxDeoNhZEmR4i+EOJnLisZGcclN
         HBPQ==
X-Gm-Message-State: AGRZ1gJIXyA7yR0YC5kFBwF/St09oBhUq6FN2gjBGGoQ/mSEfxoMpb7x
        iDoYIi2JFvhjIdqeDMBXCDivcRTQAK4=
X-Google-Smtp-Source: AJdET5dDPvnWUMn/8UPVGOEFeZmdgEWTvQeK6S4JjKZYAAObpX20GdH9HnYeMhJaQ8f5+ORvRkQNtw==
X-Received: by 2002:a19:1cd3:: with SMTP id c202mr17486782lfc.33.1543260625672;
        Mon, 26 Nov 2018 11:30:25 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n187sm191831lfn.59.2018.11.26.11.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:30:24 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so17736878lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:30:24 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr19811291ljk.80.1543260623475;
 Mon, 26 Nov 2018 11:30:23 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Nov 2018 11:30:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wix+0_ED+78Q43Sk+hoObO+Q1DoSOqq_TLnH2=wcNHx2A@mail.gmail.com>
Message-ID: <CAHk-=wix+0_ED+78Q43Sk+hoObO+Q1DoSOqq_TLnH2=wcNHx2A@mail.gmail.com>
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is migrated
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, david@redhat.com,
        mgorman@techsingularity.net,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, kan.liang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:27 AM Hugh Dickins <hughd@google.com> wrote:
>
> +enum behavior {
> +       EXCLUSIVE,      /* Hold ref to page and take the bit when woken, like
> +                        * __lock_page() waiting on then setting PG_locked.
> +                        */
> +       SHARED,         /* Hold ref to page and check the bit when woken, like
> +                        * wait_on_page_writeback() waiting on PG_writeback.
> +                        */
> +       DROP,           /* Drop ref to page before wait, no check when woken,
> +                        * like put_and_wait_on_page_locked() on PG_locked.
> +                        */
> +};

Ack, thanks.

                Linus
