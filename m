Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F5C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FCE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B1arXYMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FCE20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeJXE36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:29:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34780 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:29:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id v199-v6so1098445ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4MCSMXG0/Rs9wIHCX+w1Qy6QE/zsrASHTckZZZ6XpL8=;
        b=B1arXYMO15yLSTL7xIOmMxOad8mI/VlMGmQ2ZM9VD+2Jjkun70oiCvt9sUOrS4reie
         bBLUljDLzhICa7Q9HSXW6mc8P6nlFdc1LsVPjm1aa722iQprKpiqgzqnQzGGdH7g0jW6
         5LYu+K0Y1l24ICXZt+oZd4BevrIwzuJJqh+Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4MCSMXG0/Rs9wIHCX+w1Qy6QE/zsrASHTckZZZ6XpL8=;
        b=Vj2hz6U6HghxGNIV8zgwUVcvsr9cFaFthvImNIsdXwDvu16V9tnhrDmalTAHa4hnMY
         pxlmSFxzbyT+ISdeuhJPNP1B4huDUWzXHyKKIB8jQiWfRfdz9jD+TctBBLRkcGKgCPCK
         YpgCbP8Nt4Jr9WiqFPVH/OKxBrf7FbteJt9s8G6LjJlQQv/Ytfcm7An0C8gJL0fmOMTo
         SODU2e5v5kCRasL3/RyK3IO//2d82FXxUrcEeYNQ6cspGhxiGu8wDPY2PprZRQ9v/ntD
         iULSU8TkY09kThGcGiO7HkQU9X95+V8wkmMw9MKBempsB6QULKBqmrkUYaw+yGLh9kYI
         z7kg==
X-Gm-Message-State: ABuFfohmc8oBDZjU/jQZwHfTN6+FUoBqljDL86FvuOBfG3H7ASwir1Mv
        dJO0QN4u2OfRBwjglJuTUkdSYZPpnXk=
X-Google-Smtp-Source: ACcGV63An8651URZ24JiHnEUMMNVs+cxSsZVaF2de0vtwH6nYgUi02fkRZ4vAA6FiLGUwE1eZ//xjw==
X-Received: by 2002:a81:f104:: with SMTP id h4-v6mr30822213ywm.20.1540325102945;
        Tue, 23 Oct 2018 13:05:02 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o131-v6sm528237ywb.107.2018.10.23.13.05.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 13:05:01 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g75-v6so1106302yba.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:05:01 -0700 (PDT)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr9847950ybi.141.1540325100703;
 Tue, 23 Oct 2018 13:05:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 13:04:59
 -0700 (PDT)
In-Reply-To: <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com> <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 13:04:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
Message-ID: <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Joe Perches <joe@perches.com>, Arun KS <arunks@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:11 PM, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> On 23.10.2018 7:15, Joe Perches wrote:> On Mon, 2018-10-22 at 22:53 +0530,
> Arun KS wrote:
>>> Remove managed_page_count_lock spinlock and instead use atomic
>>> variables.
>>
>> Perhaps better to define and use macros for the accesses
>> instead of specific uses of atomic_long_<inc/dec/read>
>>
>> Something like:
>>
>> #define totalram_pages()      (unsigned
>> long)atomic_long_read(&_totalram_pages)
>
> or proper static inline
> this code isn't so low level for breaking include dependencies with macro

BTW, I noticed a few places in the patch that did multiple evaluations
of totalram_pages. It might be worth fixing those prior to doing the
conversion, too. e.g.:

if (totalram_pages > something)
   foobar(totalram_pages); <- value may have changed here

should, instead, be:

var = totalram_pages; <- get stable view of the value
if (var > something)
    foobar(var);

-Kees

> [dropped bloated cc - my server rejects this mess]

Thank you -- I was struggling to figure out the best way to reply to this. :)

-Kees

-- 
Kees Cook
