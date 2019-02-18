Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9621C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E39217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eblau.com header.i=@eblau.com header.b="fJSDa5Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfBRSuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44180 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBRSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:50:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so14639518edw.11;
        Mon, 18 Feb 2019 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eblau.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HYnI0pKPwLMrXoZ67fMcaawonsUJOabh0lXdrscyIk=;
        b=fJSDa5Vzy0vcbWsCVe9n9MXYHCcQAr8ZAi0hwhflza0qtTiC9UPZNvNqdG089w4k8j
         2/6QNF4cpV5y0otIGdF4cKPChMY/+QmZwzMBNlBRWjjZaUgp21jXc5jDnxVkmWLKVE8/
         BJVItCk5KnkVZAfsUstXveSWkLCngXY3zCiU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HYnI0pKPwLMrXoZ67fMcaawonsUJOabh0lXdrscyIk=;
        b=fuH7N35Ut70uM+NMGSJZQaQQ1s3ZIwqtXi5mjjkqGLxbgho8xnCrwiPalEVow1JR6y
         OjU3FXvqr7HNwtF1dBlHb3ItMMLOyENAuvPXgN1pgKw4d8bdIKPFc9+kkC7EevlFEPdk
         9lcV9bm7Kn6/6KNxy7H2D8mpSW/uPND8AtqgdqKaSKP8nHGsFcRQP7TIR0VKsBlHLT48
         YolqopswK4IeGVE61TZD7Y4QNAIKsZQ0Evfr7QnTH2+XDYZpGr1Y3IGx5P8LNRNFB8S1
         gMPggIk9JMA0efKdF/esS8YDoEf6A6gDpDNO2rGqr8FW/MYfRNRR43xLvshYRdSwAW2N
         BafA==
X-Gm-Message-State: AHQUAuYaQc69zOp8JqqI8xZxkQspajCpGUvOijB7ilGx/dNtFYS8Hqes
        fUkpKMT6Myb9pdfcOiCxDAwBra77wPAUYxVWv5hphPDz
X-Google-Smtp-Source: AHgI3IaZzUsxeD4lO4dzvjcBWI8xxCbkvtFAyaSN/QkVE3TEYRSuLfq8QIsOsPKKr/aAHEZGr5DMIcd8odnV2/QH1g4=
X-Received: by 2002:a50:b16d:: with SMTP id l42mr17862054edd.98.1550515842360;
 Mon, 18 Feb 2019 10:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
In-Reply-To: <20190213211323.6072-1-mironov.ivan@gmail.com>
From:   Eric Blau <eblau@eblau.com>
Date:   Mon, 18 Feb 2019 10:50:33 -0800
Message-ID: <CADU241P6-VZggZ44ZEcLOj+A0zWqvWRUSoTLdmWAGCS+aiseog@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix for the internal card reader and suspend on MacBooks
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 1:14 PM Ivan Mironov <mironov.ivan@gmail.com> wrote:
>
> First patch adds code for this new quirk, and second patch enables this
> quirk for card reader device which is used in my macbook.

Hi Ivan,

Thanks for sending these patches along. I've applied them against
4.20.8 and they fix the suspend/resume issues I've hit since November
in the -stable series. On resume, I see logs indicating that the stuck
card reader on usb2-3 on my MacBook Pro is being reset. It shows up
fine afterwards.

Thanks,
Eric
