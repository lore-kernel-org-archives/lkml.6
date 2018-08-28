Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA0F2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu1Nt7YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA0F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeH1SFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1SFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:05:19 -0400
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E14D720894;
        Tue, 28 Aug 2018 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535465608;
        bh=JK8G/NIMr71xk49X+FD6nwoHurpR4/oiyqQlKm2kiYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pu1Nt7YX3O2VhXW5AdiqR2EeEtcvrKe71bvnQTO1FYu6EW03trGTqxiCYNh5zrVmc
         4QlQDoZi8SYQc0l7lBGOfbw9toMSfHLdGH6wsqE+WcnbIjutwKV71k5rfVrnAjKS/e
         jUrbel6bxvAnJKATshT01zFdyYJb6juzUUD80pYM=
Received: by mail-qk0-f182.google.com with SMTP id z125-v6so1047720qkb.12;
        Tue, 28 Aug 2018 07:13:27 -0700 (PDT)
X-Gm-Message-State: APzg51B7P35po7El8cPLnKR50Qta04XhR7uyTU0TpUcyhXwab+6WCESp
        GLE4CVAib1NKJwPyyShg9Tp9mi0LUpphjgq1jg==
X-Google-Smtp-Source: ANB0VdYBTrDRIrdCQRrUWeCPPfFBvIRxGcxH4HU1RUbNvqcXfR1FKqlIjZdwP0Ueyg0NI8PvVXcKfpqoupzRzty55Fg=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr1702155qkf.326.1535465607128;
 Tue, 28 Aug 2018 07:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-7-robh@kernel.org>
In-Reply-To: <20180828015252.28511-7-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Aug 2018 09:13:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-U02dwj8H5KW9uF06NuK7AgCfAVeatsB-F-GGsxafvg@mail.gmail.com>
Message-ID: <CAL_JsqK-U02dwj8H5KW9uF06NuK7AgCfAVeatsB-F-GGsxafvg@mail.gmail.com>
Subject: Re: [PATCH] sparc: Convert to using %pOFn instead of device_node.name
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:52 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

> @@ -201,7 +201,7 @@ char * __init build_path_component(struct device_node *dp)
>         tmp_buf[0] = '\0';
>         __build_path_component(dp, tmp_buf);
>         if (tmp_buf[0] == '\0')
> -               strcpy(tmp_buf, dp->name);
> +               snprint(tmp_buf, sizeof(tmp_buf), "%pOFn", dp);

Ugg, v2 coming soon.

Rob
