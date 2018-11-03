Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B31CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513402081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rce+YVzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513402081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeKDCtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:49:32 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44311 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeKDCtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:49:31 -0400
Received: by mail-lf1-f51.google.com with SMTP id m18-v6so3373780lfl.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBp3JKp91RpawFuNjgjg9rejuXcgX0LTXR+OTZw67IE=;
        b=Rce+YVzf7QjVs8GrVzP1Ir/xK+S1e4VwhECYqkBBIUJgwOBa0pK3bLK8bjXOmOjh/K
         r9l9IZqdVLfXSjbLk7OicJ0vzwlO7k5EISoQA+6N6+RZ8A3vIr5QQOabJ9aZfKLBg4TD
         6/CZsQeAAxIS2kxnwBWgX1qTl37i5bQI5vBtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBp3JKp91RpawFuNjgjg9rejuXcgX0LTXR+OTZw67IE=;
        b=LT4IqSAgm50UOuY4epkUK2tZKum9gapI2m+tZyJPDKeP84bUBce3dMfJul4NgWHxhw
         8xrKd2UlSaMQkY2xbCo1EewlrVL2Dj0BF/YcEExdgRsxQHWxFpLGHKCYHVpVry3HCjby
         74jj51QDVGo/9jFcnBwRxFpWmCQmU0ffWrQOhobFucOzIQiAyO8FF0x52EwTd2YfsjgG
         ShQxFXIzamnDxP+WqOG82ix72fWPIMD5aQ8DbOOXEHO799KmumGWec4Sf+RGBIQAh/nw
         rVgqXxouYoDZ2SfLgIElc0M5UmU411rv3Ir2hmjSxv8AYOn7KU5iopE6Sfwo/+iduDAb
         w4Nw==
X-Gm-Message-State: AGRZ1gJZ54lSwWsumKyI2WOH1IhjVkiD2PIn2IjOGrlN/VQkwmrD11cT
        a+40QjUYvZ2dGoLbQmsrXRja1o30LD8flw==
X-Google-Smtp-Source: AJdET5ciYgXYuRJq5vK6rcUJB/Y2iAJtxVYAO9jYPLrl1XhpSSoTlh7w1WfjCeKj1k8ZwelX1lwlKw==
X-Received: by 2002:a19:d58e:: with SMTP id m136mr9966147lfg.70.1541266655391;
        Sat, 03 Nov 2018 10:37:35 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q5-v6sm5679207lfj.85.2018.11.03.10.37.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:37:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o2-v6so3373352lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:37:34 -0700 (PDT)
X-Received: by 2002:a19:982:: with SMTP id 124mr3640265lfj.138.1541266653751;
 Sat, 03 Nov 2018 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181103000630.GB32577@ZenIV.linux.org.uk>
In-Reply-To: <20181103000630.GB32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:37:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVt2GFcWcdtMRM_ReH6_j_kWY8kAYfKk7P5vcEFY3BbQ@mail.gmail.com>
Message-ID: <CAHk-=wjVt2GFcWcdtMRM_ReH6_j_kWY8kAYfKk7P5vcEFY3BbQ@mail.gmail.com>
Subject: Re: [git pull] followup fix to work.afs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 5:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Regression fix for net/9p handling of iov_iter; broken
> by braino when switching to iov_iter_is_kvec() et.al., spotted
> and fixed by Marc.

Pulled,

     Linus
