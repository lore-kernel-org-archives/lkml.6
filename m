Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB48C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D86F21715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D86F21715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbeHFTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:32:22 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34715 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFTcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:32:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so9469145qkj.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2Ns232tAggDWBJeAJuEprcwNOfoWMl+/jbLturgCmM=;
        b=i22i1dt8dQEGpMdiEIrt76AAPtjckRyWPp9YxUBnncyrRrmzVbh3rzvAF9zwX0GIno
         Bh0+M0VTFZACcTD6iHDwYCI0oyFK7++dSAC5zdYzEGKC6MmRmQopEeyOmBrsWbfT9z5U
         BQJZBO9oU+/CLX9jsVBW9AOpxaHEFoIfLXhTCswpIYVdtDYy4+BmrhGXGR+TP42qyh+L
         8qNd2zTEHapQ1P5YXdOkIOuGzXv8hYDC0oQ1ulnJNYfTtwnrgg15iWj/zORyCXkigWTL
         4t7KFYAPgptn6vSZvkwd5H/1XvYE4BzovBInbUElc2kXeWYLjD73lSSY7uweqjcaXxQV
         5Kow==
X-Gm-Message-State: AOUpUlFaGNeFiGyftmC96RADEBWem71l4Z7I3/S9wiAn0tFigqw5icG2
        UzySP/TG/SLcePiPEAeBhq043JPJLq65TPncKq8=
X-Google-Smtp-Source: AAOMgpcXmdBOVLw1CI8W32DrF/bckaffPnYr4vnZ184FJ/vDD54UKvJ4gPa2/QWGzDSb0/On2hjji8+3EFgZtFngcMo=
X-Received: by 2002:a37:9007:: with SMTP id s7-v6mr14085678qkd.243.1533576138085;
 Mon, 06 Aug 2018 10:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180806171047.227835-1-swboyd@chromium.org>
In-Reply-To: <20180806171047.227835-1-swboyd@chromium.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Mon, 6 Aug 2018 18:22:06 +0100
Message-ID: <CAPKp9ubtegG-WubpMFKuzBcUHpkZJfH3DZRJs83HHJeGCxK7qg@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>, wnhuang@chromium.org,
        jwerner@chromium.org, briannorris@chromium.org,
        samuel@sholland.org, thierry.escande@collabora.com,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 6:13 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Now that the /firmware/coreboot node in DT is populated by the core DT
> platform code with commit 3aa0582fdb82 ("of: platform: populate
> /firmware/ node from of_platform_default_populate_init()") we should and
> can remove the platform device creation here. Otherwise, the
> of_platform_device_create() call will fail, the coreboot of driver won't
> be registered, and this driver will never bind. At the same time, we can
> move this driver to use platform device APIs instead of DT specific ones
> and drop the of_node handling that was presumably placed there to hold a
> reference to the DT node created during module init.
>

Nice cleanup.

Reviewed-by: Sudeep Holla <Sudeep.Holla@arm.com>

--
Regards,
Sudeep
