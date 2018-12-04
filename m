Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8172C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB182082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3orYWRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB182082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeLDU2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:28:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39163 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeLDU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:28:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so15480516oia.6;
        Tue, 04 Dec 2018 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmyebdSE7OyQ+RJcKewOxaIz1ejJWzbn+q+YyCFfbbY=;
        b=Y3orYWRWUNAN50mGD1igW6GdMtfCcy0062210pTlVzznozb57kBCtHPxQ5tv5unnTd
         JF2/EMi1TKfj5ClDbdUQcEM2hrF69AMRQ+fjJN+0BTferxsf97o1X82UeV3XSqcJX4pL
         uGyS+xjayoQR0W0110cqWxXibcNvS9VopBcuZHPf+mujUYUe0Gl2uSqGuVeQOZafnb1v
         gogJtXzB+aSZCMGYTchmAnPzhI2Z2S1gzCHYlGtLa3XMl//hon0f1foxCEZb0jK+yOpN
         ubWngO6JKOucN9JU/SllqvYZHsEDKeWdICr2zg0qL7v5UPDMxeHt5ofIJvjY1Z7WFplq
         BiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmyebdSE7OyQ+RJcKewOxaIz1ejJWzbn+q+YyCFfbbY=;
        b=M1okxcg84fwD8T4tMwTLtUP19dz6Mb2qxNic64ON0NzNS+JTU+nDvPSEBIOFotSID8
         lNRzisecvexR34sICHom/zbtNPbQ0XLLznP7/02LYgHZF/dEXrqQC6wvt3IfbDhaAQP3
         Y2tWglkEdN7+XbB8cWxuCjFup39Qh1aXSZueqW51PmBcwh9DxWaDIlul/3F34DGgnJZr
         hUbGXOLhq8gMibw4dDKRNqSEYvW07z2kjD0g4eVdp9qmgJA2VolT7DWjXgLtaSttlaTp
         OtXjxNbBHBIksqmuhaIyGlE4+ON/QQUrAJdfLzwJNjD/kVfNlHBiQ478auiEWVY+Gz+h
         2ThQ==
X-Gm-Message-State: AA+aEWYCNCeCeAA863o7QQcsZAwngY4vyATJQwQHjLLIshh0XSVWpQgm
        mpRITLPnQH7iKaQCj4MKKvlvPini4xeOfnLT52o=
X-Google-Smtp-Source: AFSGD/VW1wIH4VAGwlrb28tJo7dC3lHhdKj0gzOGytIeAJYIKqBeD541fXvhi89gf+gmhjUIXUZQD/z1LHJ6+vj0Tqo=
X-Received: by 2002:aca:4b4f:: with SMTP id y76mr13809934oia.88.1543955288749;
 Tue, 04 Dec 2018 12:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20181204103726.750894136@linuxfoundation.org> <20181204103729.017806593@linuxfoundation.org>
In-Reply-To: <20181204103729.017806593@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 4 Dec 2018 20:27:32 +0000
Message-ID: <CADVatmNvBKBKsC6CCeCGtHPb6v=F11vzU2FVq_nt0J+VdW8=og@mail.gmail.com>
Subject: Re: [PATCH 4.14 054/146] f2fs: fix to do sanity check with block
 address in main area
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, yuchao0@huawei.com,
        jaegeuk@kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Dec 4, 2018 at 11:05 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> commit c9b60788fc760d136211853f10ce73dc152d1f4a upstream.

There is another upstream commit which fixes this.
89d13c38501d ("f2fs: fix missing up_read")

-- 
Regards
Sudip
