Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A427C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063DC2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4mal7p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063DC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeKEMkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:40:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39587 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKEMkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:40:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so12452917qkh.6;
        Sun, 04 Nov 2018 19:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPYWCGJbnd35ASLjxF4+ptBevLzINksqHn68zBUVvIU=;
        b=a4mal7p+CidlTno1yIKR9tcy90DoMJkCO4DtzBKf83exyL8xqRgKBEZ4NYtukzfPI7
         6WVJjRPZnnik+usYPzAaobD2h71CoMsbmytFxWronrGY5jZlIUQCz8DhJLw6UcX/QnAJ
         qIzib8LJmt58rqeIrNxLgYNW3Ab4l0A3sRrN+eHzqS1wG7a3VROweiJdE3NE4chkgzQg
         DXNPMsLBwzVyNd+vGqyBZ6F0qCSN43ONgdRmDzW3sJVCz0kQHAt8B0wvCWdOnlJBbx+Q
         fwyQEe80CeIYUIZmlyUvftJ7tD/p+It5O6JK2ii8X5vWVXkknalWLLjkrKD9Cwdc+J/l
         PQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPYWCGJbnd35ASLjxF4+ptBevLzINksqHn68zBUVvIU=;
        b=UWx23rVmZj6DSb60gbSoPp5h01XnSflCooEM9bIR8kpYXfnzLAL5SjzWbGDEbQk1KE
         IDLW65PqpY5PJeP9RgnGktOE8gEuIxSqf42az34nlkyg4eyGsy07D3jn31a1PI8b0+Ka
         MsOElb6sMni3zWg/rTjujZ+rvBn4J1kf4umr8ARrzvaeWa6pEBgNnlTTjwrNYVj/tXgD
         mZuQTYBbK34sMyEQhqUtVMuhu6ZWo7etaDInRvD4It3nlndlqEGLw55/jWn4gmHhM/5I
         7F8k3Y0Ej1xYKL0Q6Cj59o1KbqSmLt+ZFUp7ujqwnJlFjLmEi2mZPcyzXMadukPWhQhm
         CO/A==
X-Gm-Message-State: AGRZ1gJuLdBGrHPD7XPBNDGQfV2nRnEb6YBlwqvYwoCxARhGWSJPDDM/
        LvjGk6kLp+6iVtWFrFYul5OnEaWqagLv22TtHDA=
X-Google-Smtp-Source: AJdET5fIlGF1GRf1X40K2Skot2D5Y61HTbO3IJWQHotPM9jHUIwGtbM71B0T4RZtCwajLpiB4riQS3iZkHlXDCPotoY=
X-Received: by 2002:a0c:a802:: with SMTP id w2mr17102381qva.198.1541388196761;
 Sun, 04 Nov 2018 19:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
In-Reply-To: <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Sun, 4 Nov 2018 22:23:04 -0500
Message-ID: <CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 10:00 PM Jason Wang <jasowang@redhat.com> wrote:

> > # fio num-jobs
> > # A: bare metal over block
> > # B: bare metal over file
> > # C: virtio-blk over block
> > # D: virtio-blk over file
> > # E: vhost-blk bio over block
> > # F: vhost-blk kiocb over block
> > # G: vhost-blk kiocb over file
> > #
> > #  A     B     C    D    E     F     G

> > 16 1480k 1506k 101k 102k 1346k 1202k 566k

> Hi:
>
> Thanks for the patches.
>
> This is not the first attempt for having vhost-blk:
>
> - Badari's version: https://lwn.net/Articles/379864/
>
> - Asias' version: https://lwn.net/Articles/519880/
>
> It's better to describe the differences (kiocb vs bio? performance?).
> E.g if my memory is correct, Asias said it doesn't give much improvement
> compared with userspace qemu.
>
> And what's more important, I believe we tend to use virtio-scsi nowdays.
> So what's the advantages of vhost-blk over vhost-scsi?

Hi,

Yes, I saw both. Frankly, my implementation is not that different,
because the whole thing has only twice more LOC that vhost/test.c.

I posted my numbers (see in quoted text above the 16 queues case),
IOPS goes from ~100k to 1.2M and almost reaches the physical
limitation of the backend.

submit_bio() is a bit faster, but can't be used for disk images placed
on a file system. I have that submit_bio implementation too.

Storage industry is shifting away from SCSI, which has a scaling
problem. I can compare vhost-scsi vs vhost-blk if you are curious.

Thanks!
-- 
wbr, Vitaly
