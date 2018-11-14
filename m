Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EBDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F382D22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0j8+rXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F382D22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeKNR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:58:21 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41263 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:58:21 -0500
Received: by mail-yb1-f196.google.com with SMTP id t13-v6so6534918ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fxTIWxLlGa49q7Y48gaHhJ/0Wcn7grycx+kal8DRCD4=;
        b=W0j8+rXe9PP6eTDoy1fckevT1sgIm41mvdzQRQV/M0urdcVST4zMEfvYcHP6pGxykl
         ss1XGdga4v2KGX/eeYo9Wg/jJtfPo6saTj0/7j5dU7KLTdrLUlA8WBFrblWW8YQ66kVw
         3yOQd33H6mJFrrv7g4ndcTmbynC3WBvknn6N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fxTIWxLlGa49q7Y48gaHhJ/0Wcn7grycx+kal8DRCD4=;
        b=aKq/5+mtPdnnKQ3+MUNpoGQ1wOOJOgVsZbXNypXRXgSJfKtm+2pcNS2L8iXbvHBeeX
         A+YGCtAREvVzMduKYrWl7eLN4yHzoJhe9Dus5PPmSw2SAkT0rWf4Wq1EccZQ1uWlgeKf
         5t+KZT3MzNdKJxlAEpjNBzvDJ6PFxFw/3n6gnO6YUcT57A+aAw9K2ySCiul1lT3JBo9j
         urfgft1o5/ejhbcAWhwrznh6/Czwt+cjg7lWlETgEpddKE7iUUebPotcK2SSUPbn2NOQ
         WPxiEz1VkHL7Ca9NqBiLbMxWib15xSDo1+5VGxieT5pWe+Qv7C10611MCfgvPr4HgoJB
         ua2Q==
X-Gm-Message-State: AGRZ1gL4hKoZ8czSFjSPyl+tmiKohZEwJSrASLydJNcgFn9OCrakxH4X
        uA4G6XlT08IYL9Y9MtyutH7i6AIiMZU=
X-Google-Smtp-Source: AJdET5eAj2UFIx6hPaA3FS6ryw7VLM35LK3+e948jmik5SAWuk+gTWZgL3v3w+6jm9qj9BTfHc/2cw==
X-Received: by 2002:a25:8809:: with SMTP id c9-v6mr650163ybl.322.1542182173679;
        Tue, 13 Nov 2018 23:56:13 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id j64-v6sm4259305ywb.64.2018.11.13.23.56.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 23:56:11 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id z72-v6so6965230ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 23:56:11 -0800 (PST)
X-Received: by 2002:a81:29d4:: with SMTP id p203mr623494ywp.407.1542182170924;
 Tue, 13 Nov 2018 23:56:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 13 Nov 2018 23:56:09
 -0800 (PST)
In-Reply-To: <20181102182454.GB14942@google.com>
References: <20181101235200.28584-1-keescook@chromium.org> <20181101235200.28584-3-keescook@chromium.org>
 <20181102182454.GB14942@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 14 Nov 2018 01:56:09 -0600
X-Gmail-Original-Message-ID: <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
Message-ID: <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
Subject: Re: [PATCH 2/8] pstore: Do not use crash buffer for decompression
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 1:24 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Nov 01, 2018 at 04:51:54PM -0700, Kees Cook wrote:
>>  static void decompress_record(struct pstore_record *record)
>>  {
>> +     int ret;
>>       int unzipped_len;
>
> nit: We could get rid of the unzipped_len variable now I think.

I didn't follow this -- it gets used quite a bit. I don't see a clean
way to remove it?

>> +     workspace = kmalloc(unzipped_len + record->ecc_notice_size,
>
> Should tihs be unzipped_len + record->ecc_notice_size + 1. The extra byte
> being for the NULL character of the ecc notice?
>
> This occurred to me when I saw the + 1 in ram.c. It could be better to just
> abstract the size as a macro.

Ooh, yes, good catch. I'll get this fixed.

Thanks for the review!

-- 
Kees Cook
