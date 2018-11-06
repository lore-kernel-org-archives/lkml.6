Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195762085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195762085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbeKFXz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:55:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39174 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbeKFXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:55:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so11552709oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MeaJLuyzTj5y4S/PumqUqKqJlwAbRWxfNw+8S6qG5k=;
        b=DsBz2g+9Rj522RCD3IPbZhz0UFAnfWY/vrbX3w0R/YJqmc0+RjBpOGCwusneCEV23v
         q2ZscOe0ruPAHxblcgfMngQUNJVE52cgcRlm5tYDpFPS1uBueHsnwBxonCOzIcOS2wcP
         om7fwFvbzPFu+aWR4vhA9q9v2wNz0RV59jI6JDWJ8YDMQo9v65pujX11YzPcmtT4kzWa
         QDv2SwDsNwZQ7NrW9AFQQj/6+q7P+qv9wljUCioIIjxcdS0ZMbtLzu2As/oEgxzZ44fv
         CpnuGZXgk4C7fZNBlNx5XqXqKgOW34q8G2eKWe6DcjCAxnGn+6vYL0fKLfAWfoopH3zp
         8UXQ==
X-Gm-Message-State: AGRZ1gIa+vvzSGnr8DbG/PjLVShnNHM6EPW+MMTJ5/9odl0BlpBHFqx1
        r+5kB7a02SaJK62CPnm/fwE8glOX/XmddfifEck=
X-Google-Smtp-Source: AJdET5fV6a/oxagrzDwL8vXNIbvCRjMniEaeU5yqhbPhMZNxvf+Xm7+ZhWS9tibHO2lZDmJ3fqRFwbk61FjOO9JJwwE=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr10285128otf.124.1541514626499;
 Tue, 06 Nov 2018 06:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20181106134630.29591-1-smuchun@gmail.com>
In-Reply-To: <20181106134630.29591-1-smuchun@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 15:30:14 +0100
Message-ID: <CAJZ5v0ifsQqkoFw2tossFKJAUkqDLdR9NpN3eZTn3t0xUz6K-g@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add branch prediction hints in really_probe()
To:     smuchun@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 2:47 PM Muchun Song <smuchun@gmail.com> wrote:
>
> If condition is false in most cases. So, add an unlikely() to the if
> condition, so that the optimizer assumes that the condition is false.
>
> Signed-off-by: Muchun Song <smuchun@gmail.com>

Have you measured the practical impact of this patch in any way?

> ---
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..8eba453c4e5d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -450,7 +450,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>         bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>                            !drv->suppress_bind_attrs;
>
> -       if (defer_all_probes) {
> +       if (unlikely(defer_all_probes)) {
>                 /*
>                  * Value of defer_all_probes can be set only by
>                  * device_defer_all_probes_enable() which, in turn, will call
> @@ -508,7 +508,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>                         goto probe_failed;
>         }
>
> -       if (test_remove) {
> +       if (unlikely(test_remove)) {
>                 test_remove = false;
>
>                 if (dev->bus->remove)
> --
> 2.17.1
>
