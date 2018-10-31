Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D238C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630C52064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qp45lwd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630C52064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKAGoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:44:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45166 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeKAGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:44:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so16251921ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9fcscqnQ3LG9N2ksVfU6ZEoExmVUG3rU+QYY/1YFT0=;
        b=Qp45lwd/1R40fhwMU1liqO543LgHi0Ozk+xelSJJ0Whc+r+rWRfUZlCJXRMeI33Rk/
         uBlFjiHHqAAI1XJM3/8fnLkb/llqmMJtbKHhvylayG9m79TT32m5etOPu3fMQa2XOtJ7
         rsZK85KO2QKEYdzj+cm/1I0LuMHBEW7U0F3Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9fcscqnQ3LG9N2ksVfU6ZEoExmVUG3rU+QYY/1YFT0=;
        b=ZaR3Py85nTGcWgd1uxFh9LTprJZaAMWg3chNlESu8vYKjBaYcC/Ua9x5XfRceHHcV/
         4R0lkvEjZ305imQBZtpPj+FDHNuelBBt3woP82yqJlsxheM/lydbCmTefqGSoOqKOAnv
         TkNqgFUjLYIU/GyM7Ioj+2OfnDj5JhKJr/0ZlbTlnXRr/sB/5/VK22UMHFpNZUtl6RIp
         lMiLAR5eZvHfhGHUB6H1rgbP3eSfsGjfg7JC129aJfGM66ATegMOjnfZO8CGG+oakTml
         kiZYE4gHwgMUA11wa0yAoDCYDdAPFnBL0zza0Bs1IYcYlgypVbQX47J0LZOQhA54hadG
         ZVsw==
X-Gm-Message-State: AGRZ1gKYlUDGzA2YyvCClHySrdQVJ0MZ09bN/FMEZB0eOuuR3Zmd5gxJ
        HfFZYKpWs/9VWWPUXcX0QJm81an4PgPIUA==
X-Google-Smtp-Source: AJdET5dIr5pd7OAEmwJoykgpNDuaf1iSEOmQe2xwiq59FBN+/ML1EBjjf3EMeRFH/RP7+CZFXStV8w==
X-Received: by 2002:a2e:9e81:: with SMTP id f1-v6mr3458069ljk.100.1541022262080;
        Wed, 31 Oct 2018 14:44:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o25sm980955lfd.29.2018.10.31.14.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:44:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d7-v6so12816526lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:44:20 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr2752877lfj.16.1541022260180;
 Wed, 31 Oct 2018 14:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181031174425.27372-1-idryomov@gmail.com>
In-Reply-To: <20181031174425.27372-1-idryomov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 14:44:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbb5FZ7O8MgO8w6yY-1ZkhLGOXA8o7Pkcg+pxdZLh8Ww@mail.gmail.com>
Message-ID: <CAHk-=whbb5FZ7O8MgO8w6yY-1ZkhLGOXA8o7Pkcg+pxdZLh8Ww@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph updates for 4.20-rc1
To:     idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:44 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> - a series that fixes some old memory allocation issues in libceph
>   (myself).  We no longer allocate memory in places where allocation
>   failures cannot be handled and BUG when the allocation fails.
>
> - support for copy_file_range() syscall (Luis Henriques).  If size and
>   alignment conditions are met, it leverages RADOS copy-from operation.
>   Otherwise, a local copy is performed.
>
> - a patch that reduces memory requirement of ceph_sync_read() from the
>   size of the entire read to the size of one object (Zheng Yan).
>
> - fallocate() syscall is now restricted to FALLOC_FL_PUNCH_HOLE (Luis
>   Henriques)

Pulled.

                   Linus
