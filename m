Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68354C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAB12089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JrVJzn4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAB12089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeJOWfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:35:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37461 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJOWfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:35:45 -0400
Received: by mail-io1-f66.google.com with SMTP id m16-v6so14445299ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l5+boXJtzLEVyan9ZQRkbWHq+XC8FkJ5CIiMpv3LsWc=;
        b=JrVJzn4q0zbIEn1tYeIc2/yg308z7pL7iDtP5bO96zXzDbmpTAiXVk6DZ2y2ATjObE
         oIQPaBLKr2cMUk21VrVwRnUta8YbtT4+ajaXNpO/JK/zKIFAI/Z/RWvKY4755S0D8OEf
         Z3RU6dSOZxrrKEXp7oyJ6rodEqS5/wEfdq8Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l5+boXJtzLEVyan9ZQRkbWHq+XC8FkJ5CIiMpv3LsWc=;
        b=eOLzD9XGOsPSNs4lDij2pE9ObpFz7om7tspWvEZ5X8bgTMsbC5vr5Ceo0eZwCeKeay
         hoVdf76wZf8DgnEhzVj8fBZBBgekXaIKcXrhGj0v4ty+ZeQbYM7mX6q2Czq9EsJJ/si6
         wmDPF6KEsJPrvrmu1bOcaXXLFTNXSUTnUUNUJOxMIybpzaGv0IThvdG1HVPNRJuvJV/7
         4FMLxLCSctr00DD3QMsxTWE+ZhVrgsxaeOfaoBmSBI2WTT+8VrvZBvDfPbt/xL9+xoC2
         jQ7NYU/m1B4A29nVQWsWH+K2g5r9L2hj9soCZzcf9ldJhtkLbecfc/i32Ra7GV9TOzRA
         oQtA==
X-Gm-Message-State: ABuFfohVEECvRlujP7orZBXjr9gdmplcHvTFNDuo77jzxo5pVAYuPacE
        HeMn75KgtGRCACD6cUYBbQfHctQZBjzPGjV5bdt20w==
X-Google-Smtp-Source: ACcGV62qO0WgRH04CxJwu7JuXFtFme6UpsGslHuSvIH3/9hQVvDUDdC6IwgFG58/MnLUGVXXAs9iMu90ztqD6WJOEQY=
X-Received: by 2002:a6b:acc4:: with SMTP id v187-v6mr11606326ioe.246.1539615009361;
 Mon, 15 Oct 2018 07:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 07:50:08
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20181011151700.80485-1-dschatzberg@fb.com>
References: <20181011151700.80485-1-dschatzberg@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Oct 2018 16:50:08 +0200
Message-ID: <CAJfpegvLy+BiyOYCboNvcHbM-5jTwEUkh1u721WGzyH4aTAnjA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: enable caching of symlinks
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team <kernel-team@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 5:17 PM, Dan Schatzberg <dschatzberg@fb.com> wrote:
> FUSE file reads are cached in the page cache, but symlink reads are
> not. This patch enables FUSE READLINK operations to be cached which
> can improve performance of some FUSE workloads.
>
> In particular, I'm working on a FUSE filesystem for access to source
> code and discovered that about a 10% improvement to build times is
> achieved with this patch (there are a lot of symlinks in the source
> tree).

Pushed a modified version to for-next in the fuse tree.

One important change is to zero-terminate the link (do not rely on
i_size to provide the proper zero termination for fear of a trivial
information leak vector).  Other changes are: use of
inode_nohighmem(), which seems to be the idiomatic way of preventing
highmem, and merging the non-cached and cached code paths as much as
possible.

Thanks,
Miklos
