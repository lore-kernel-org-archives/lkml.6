Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943FAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A26C24625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REfGxBv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A26C24625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeGCTdB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:33:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34132 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934525AbeGCTc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:32:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so2518719lfi.1;
        Tue, 03 Jul 2018 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5Ce/Az5SEvAiqoIMKijIdSvweqZ8RrrxKlQ+9FKyeQQ=;
        b=REfGxBv/GAli35iJj3X+eDFvnXSkDnWZCiJJzyQjtFgQovJ0ihlxANll+NibigeLvm
         NpfAEZ6vzAbIP1k21Au8Hkmh8zuWoBsn5VnB7xyNAp3+aV6lLmn+RbgyF2ZFpW2HM7mv
         dJBFUBylHVlLmpcx4HYQvwq6BWd/gx56YtZCa3i3wuy1Ikw8DNv3cxyARJ3TRHHPQq33
         1xOH3MOvFmy8u4FOZwUSJAOJh/EO189ZVbYP+XePpKYDEv7hme0QTC+iQ/nXNa8jJoA/
         KTGpMHznm3/cS00wl1FlvCf9ytycNPGqTjImu2QEU2swRwqDo4GsJdNfU1enuFc7NvrK
         I4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5Ce/Az5SEvAiqoIMKijIdSvweqZ8RrrxKlQ+9FKyeQQ=;
        b=I92qklMr7fy7K/gH6n0GH6P+Bc1ykx86CnFMyT46pZFLSRDGK9vtU03Q129qIhE6u8
         U4MZhq2l8NJrrN4A7DSwBu1H2cvnfw/bEKovpqC8/DIj3M6vxJE6biulcyzLWSgmXlL3
         P97qz3GVq0dUFuvzQ1voLOLJYxGrnc1MgaMNyovUx7cah/7lNDyLzSiQdyP2wZ5AuHSz
         MGKH5ijTrLv8uyjw7WQb7ESu4m6g43jVys9lq6L8jZgLgB5VIj8GRc1Mc/1TgKCIg2nC
         zYwnq7PmLaa3rD2OBuTMF1+BrHHJci1c28GulDQAGkGqrpPIOhlIbwGyd/hAqIFW2/AT
         G1ow==
X-Gm-Message-State: APt69E0MHAtgXX2GLHmu1jNxPgir/s+aOz1ukmUX3txg+UJSefoqUfFH
        juQ4sD1+Z3vh8NHWT0l4uuuNbQEE7YsyK1vZ2Bw=
X-Google-Smtp-Source: AAOMgpdlptwPAipKeXzmtvjqyNH3Nk0Oy1x9BJM/F4IZ9wd04GXiDotoJLgc34JQJ5dTBCNv979yFWMzfZ/zRUCFVgY=
X-Received: by 2002:a19:c218:: with SMTP id l24-v6mr766211lfc.55.1530646377288;
 Tue, 03 Jul 2018 12:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:32:56 -0700 (PDT)
In-Reply-To: <20180703072305.29169-1-colin.king@canonical.com>
References: <20180703072305.29169-1-colin.king@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 21:32:56 +0200
X-Google-Sender-Auth: tL-csSyzmaeGGqGrPtuHPbDlOko
Message-ID: <CAK8P3a3A_qN_DjfT8ck3Xr87Li6wa8oPEHBMJ-Bu1EONN=jS5w@mail.gmail.com>
Subject: Re: [PATCH] sgi-xp: remove redundant pointers ch and rp
To:     Colin King <colin.king@canonical.com>
Cc:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:23 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointers ch and rp are set but are never used hence they are
> redundant and can be removed.
>
> Cleans up clang warnings:
> warning: variable 'ch' set but not used [-Wunused-but-set-variable]
> warning: variable 'rp' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/sgi-xp/xpc_channel.c   | 3 ---
>  drivers/misc/sgi-xp/xpc_partition.c | 3 ---
>  2 files changed, 6 deletions(-)
>
> diff --git a/drivers/misc/sgi-xp/xpc_channel.c b/drivers/misc/sgi-xp/xpc_channel.c
> index 128d5615c804..05a890ce2ab8 100644
> --- a/drivers/misc/sgi-xp/xpc_channel.c
> +++ b/drivers/misc/sgi-xp/xpc_channel.c
> @@ -656,7 +656,6 @@ xpc_initiate_connect(int ch_number)
>  {
>         short partid;
>         struct xpc_partition *part;
> -       struct xpc_channel *ch;
>
>         DBUG_ON(ch_number < 0 || ch_number >= XPC_MAX_NCHANNELS);
>
> @@ -664,8 +663,6 @@ xpc_initiate_connect(int ch_number)
>                 part = &xpc_partitions[partid];
>
>                 if (xpc_part_ref(part)) {
> -                       ch = &part->channels[ch_number];
> -
>                         /*
>                          * Initiate the establishment of a connection on the
>                          * newly registered channel to the remote partition.

This was left behind in 2005 when the last use of that variable
got removed in commit e54af724c1ae ("[IA64-SGI] fixes for XPC
disengage and open/close protocol")


> diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
> index 7284413dabfd..4e59b01ad7eb 100644
> --- a/drivers/misc/sgi-xp/xpc_partition.c
> +++ b/drivers/misc/sgi-xp/xpc_partition.c
> @@ -415,7 +415,6 @@ xpc_discovery(void)
>         int region_size;
>         int max_regions;
>         int nasid;
> -       struct xpc_rsvd_page *rp;
>         unsigned long *discovered_nasids;
>         enum xp_retval ret;
>
> @@ -432,8 +431,6 @@ xpc_discovery(void)
>                 return;
>         }
>
> -       rp = (struct xpc_rsvd_page *)xpc_rsvd_page;
> -

And this one in
4b38fcd48582 ("[IA64-SGI] XPC changes to support more than 2k nasids")

Both changes look correct to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
