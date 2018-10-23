Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECDBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A320813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l92DO8lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1A320813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeJWSYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:24:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33050 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbeJWSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:24:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so997606wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fMJsMfWFwitixPtd2Az/oid333JAYPCeGITQ7XlAM94=;
        b=l92DO8lIdZXExv4cxjymg5g5mu0QtymAPtaIfSpRpdoJ+k0uYtJUwFN4qdPIQ0qetl
         lhR2YJ7vKrXQ4qV73zPrrziivy/jFOksSQt7a7wOOwM5JTVKpDdEdbnmzI8w3tLoX+Ep
         n1dD6mDLEczZJW7UiqJJooFvfboqnzNZcLt7lxB6A68jB+80gvU/fRa4npjEhFEVnwIR
         +P6aqs3UeJlXaplsTpr/zMEdLC0GlxS5hxgO6ygU63nEAA1nx8MWnaT4wsFk+BEZnT8x
         Uve0/Pc2TFLRMqYKJQUeN+mI7JhGnGVlcaOWJVIuPQd0TqWTigGdme5edkLiKJGKliMA
         yENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMJsMfWFwitixPtd2Az/oid333JAYPCeGITQ7XlAM94=;
        b=AgSNrhQZuZ9SIi0LuarIRL3deHa4HggobxVtOHjEAXau504/Y6bDqv5A0ISZyl6oPN
         bdQJY9dlrLIpEKkxtnLccwqqJtltkv7WzedHmPQdF1Cu9wJwaPOrwphDjTKXuymCD3Xw
         oZCLndHr2GkRvq3kGn/xn/DbbsKhckLOQgLj5ITVysQ6nyhIld77h0IaE+glRMQ+38gR
         rToajGTpalNVjTL5Nnkfrd4501gshr85Gocre4O1rplN6WPCVYjeQ/5Muq0oB2iIytCQ
         HSA9QIqR62+adFva3OEUIbDfnDGqoLETYEsivF3oFbSJK08jg2ORmwlFX8ACpNEqRlrF
         nXiQ==
X-Gm-Message-State: AGRZ1gL7CEJJXMNLVPrgDQpVtVOI+0+nAhQYWkDNctAQj55dpCzFtxK7
        fKxz8w3YdmwDc4JjaEd6Ax9GNamZd77X9Q==
X-Google-Smtp-Source: AJdET5fCqMccwhFU8wp84WQUJUfEDTEnUMMapW/dYVtcWFHtAjo29KqlAWeJBPWr8uZ/5SoqRQzKug==
X-Received: by 2002:a5d:46ce:: with SMTP id g14-v6mr6079451wrs.263.1540288894506;
        Tue, 23 Oct 2018 03:01:34 -0700 (PDT)
Received: from [10.111.198.69] ([109.144.220.182])
        by smtp.gmail.com with ESMTPSA id u132-v6sm1469288wmg.17.2018.10.23.03.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:01:33 -0700 (PDT)
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To:     Kyungtae Kim <kt0755@gmail.com>, jikos@kernel.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
Date:   Tue, 23 Oct 2018 04:01:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 5:20 PM, Kyungtae Kim wrote:
> We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
> UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
> 
> kernel config: https://kt0755.github.io/etc/config_v2-4.19
> repro: https://kt0755.github.io/etc/repro.b4076.c
> 
> Analysis:
> 
> struct floppy_raw_cmd {
>    unsigned char cmd_count;
>    unsigned char cmd[16];
>   ...
> };
> 
> for (i=0; i<raw_cmd->cmd_count; i++)
>     output_byte(raw_cmd->cmd[i])
> 
> In driver/block/floppy.c:1495, the code snippet above is trying to
> write some bytes to the floppy disk controller, depending on "cmd_count".
> As you see "struct floppy_raw_cmd" above, the size of array “cmd” is
> fixed as 16.
> The thing is, there is no boundary check for the index of array "cmd"
> when this is used. Besides, "cmd_count" can be manipulated by raw_cmd_ioctl
> which is derived from ioctl system call.
> We observed that cmd_count is set at line 2540 (or 2111), but that is
> after such a bug arose in our experiment. So by manipulating system call ioctl,
> user program can have illegitimate memory access.
> 
> The following is a simple patch to stop this. (This might not be the
> best.)
> 
> diff --git a/linux-4.19-rc2/drivers/block/floppy.c
> b/linux-4.19-rc2/drivers/block/floppy.c
> index f2b6f4d..a3610c9 100644
> --- a/linux-4.19-rc2/drivers/block/floppy.c
> +++ b/linux-4.19-rc2/drivers/block/floppy.c
> @@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *param,
>                          */
>                 return -EINVAL;
> 
> +       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
> +               return -EINVAL;
> +
>         for (i = 0; i < 16; i++)
>                 ptr->reply[i] = 0;
>         ptr->resultcode = 0;

I think that's a decent way to fix it, but you probably want to
test your patch - it doesn't compile. Send something you've
tested that works.

-- 
Jens Axboe

