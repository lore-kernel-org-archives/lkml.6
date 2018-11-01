Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DBBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48DD20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g1Hu729q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48DD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKBGuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:50:07 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46300 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeKBGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:50:07 -0400
Received: by mail-lj1-f181.google.com with SMTP id x3-v6so19418333lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGxk4OGAwF/iVTkojljEJL5LJnOlx4xx7Nbm+rz8ajg=;
        b=g1Hu729qEkIZqhptEbCC48BszDVRPgAP2hgybB+hXQMRCmFpuyhxTk9lzYVOT3eAQn
         M+cYUONuCWpvuzZl6J1ez2EaWFITkAkEvlWdeifIj6HE2Y7uJupKQtG9feACwYvB03k/
         WrthxTWtypvLYemBh6wNzY1I3n+HYPdA2P/rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGxk4OGAwF/iVTkojljEJL5LJnOlx4xx7Nbm+rz8ajg=;
        b=kdbbtUCZ8AfMOVaKq+ZjXtdLhd/S8ybEssrRbJ1vHHiNyJc+bOyKbi13wl3BKyFa29
         ZQ9J8gIHgeAYXY9koGNDraSCtgg7aW2GpSka0LKOltb4LZbXh6zr/c3dNzKtjzzIY4le
         EUSpDG2DtArujmm61zmzMy179TbHT24aPmf5CsPoDThDMzEYPg9bRBQSHcoadIUKiOlf
         QVTaI2VOH1pgDWdssGU2nYFHVoiyOFA18/2JMYkvXg+h0naU5F+Ogd0RTWx5pMrLwrKE
         yWbgb42byFVCRrpECwzu6lrZRpcbObBylvzepStUxaer5uGdJ7hzd+HgJ3E4W7G2QG+H
         JbeA==
X-Gm-Message-State: AGRZ1gIgHmMGc47iAmLzSFxMBxfHkjMAHIU0z7HS3QFP5KnU6++hUF+U
        Pm8jwmMtv/ycxT+maH+OnCC7nA2Kr/5xjQ==
X-Google-Smtp-Source: AJdET5eipJfq9NKzUmaDVtHwODeHWeTBcd2aOMfTl2st4SBO7KWVfTtAh5QtdYCDYP+Nqh5Scsf2Kw==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr6032572lje.110.1541108718482;
        Thu, 01 Nov 2018 14:45:18 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y10-v6sm5055813lje.30.2018.11.01.14.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:45:16 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f3-v6so19425507ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:45:16 -0700 (PDT)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr74001ljk.80.1541108715802;
 Thu, 01 Nov 2018 14:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181101171938-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 14:44:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgouhOtiucUdox2LfGTyNed3djnG2DWSuSgDgmbJuOMGA@mail.gmail.com>
Message-ID: <CAHk-=wgouhOtiucUdox2LfGTyNed3djnG2DWSuSgDgmbJuOMGA@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio, vhost: fixes, tweaks

Pulled.

                   Linus
