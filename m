Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C367C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D139F21E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuvC5hR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D139F21E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeHIX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:29:45 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45717 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeHIX3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:29:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id 139-v6so6579926ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pD9APMCaXOk6xKHeVUFM+ulLt5oIBtPuV27bG/upVrk=;
        b=cuvC5hR/nxwCFLwVPOcOTwq8v3Ogij2Ydys9mroXt62pJHxNY3xIOsf3C3NTJZp2mM
         ZqW1K1nv1eca9ZQlJWS+ApsJzakjxnLpd2KsJ3pULqQO5wWW3eDSwdmknJvYTnkvwHLP
         JQcWoLzbHt2pCVDMOvh1o3mI65LHjhlySyZWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD9APMCaXOk6xKHeVUFM+ulLt5oIBtPuV27bG/upVrk=;
        b=Pumo3PYRs8+2h4JgdJN8sedww+qa/6VJv4BkWkl9eetlWvAYhu7BJwToDNjvrZeZvu
         EjxbItGo2Tm9NnkZZwFON1Em+bqBqqUcECo1gCeA0XM5RRk7THVT8w/XEvyheQxdgJom
         fXcERe2+T2i/ni0BCJT6UmP9WvGhtY+Nch8ScfbTUwQfV7YBQ4DTxJYdEGTINEF7xMYF
         Kqat8FkdyZMfg5FbyEZdqN3Z+ltb1dJwE7ovNFtXSGcZkZTnx1L1sJzCNSuYTIwQm0JU
         6ZIYaGquC5IsMSy4nw7nEoqDbbT4ZeIIgyzmHTatSrrIACPGgCgfM5JB+3bLdCFMgYRX
         8Pcw==
X-Gm-Message-State: AOUpUlFLco+lML9rp+Ws4Ly2XWZCNoL/JUtuwb65T5U+USIpkX1FK8bt
        xPPkPvY1t0+Kmc01buauGZwz0TMhFYqowHQF53LJsA==
X-Google-Smtp-Source: AA+uWPwUq502mTS53iFkGOhwYHx41PgZXyPzz1Jhmlf3H6yFupKAoKI55gKkMHHwk8HK9tn2WzsuTiRmFh7RECAM9/4=
X-Received: by 2002:a1f:3b43:: with SMTP id i64-v6mr2369227vka.152.1533848587604;
 Thu, 09 Aug 2018 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-7-swboyd@chromium.org>
In-Reply-To: <20180809171722.144325-7-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 14:02:53 -0700
Message-ID: <CAODwPW-Qc3JanqsB0C42O796fbDiwvUKYOhUXNYOaS_mzgCS8g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] firmware: coreboot: Only populate devices in coreboot_table_init()
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 10:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This function checks the header for sanity, registers a bus, and
> populates devices for each coreboot table entry. Let's just populate
> devices here and pull the other bits up into the caller so that this
> function can be repurposed for pure device creation and registration. We
> can devm()ify the memory mapping at the same time to keep error paths
> simpler.
>
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Suggested-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table.c | 66 +++++++++++-------------
>  1 file changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index f343dbe86448..814913606d22 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -32,8 +32,6 @@
>  #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
>  #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
>
> -static struct coreboot_table_header *ptr_header;
> -
>  static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
>  {
>         struct coreboot_device *device = CB_DEV(dev);
> @@ -94,35 +92,21 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
>  }
>  EXPORT_SYMBOL(coreboot_driver_unregister);
>
> -static int coreboot_table_init(struct device *dev, void *ptr)
> +static int coreboot_table_populate(struct device *dev, void *ptr)
>  {
>         int i, ret;
>         void *ptr_entry;
>         struct coreboot_device *device;
>         struct coreboot_table_entry *entry;
> -       struct coreboot_table_header *header;
> -
> -       ptr_header = ptr;
> -       header = ptr;
> -
> -       if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
> -               pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
> -               return -ENODEV;
> -       }
> -
> -       ret = bus_register(&coreboot_bus_type);
> -       if (ret)
> -               return ret;
> +       struct coreboot_table_header *header = ptr;
>
> -       ptr_entry = ptr_header + header->header_bytes;
> +       ptr_entry = ptr + header->header_bytes;
>         for (i = 0; i < header->table_entries; i++) {
>                 entry = ptr_entry;
>
>                 device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
> -               if (!device) {
> -                       ret = -ENOMEM;
> -                       break;
> -               }
> +               if (!device)
> +                       return -ENOMEM;
>
>                 dev_set_name(&device->dev, "coreboot%d", i);
>                 device->dev.parent = dev;
> @@ -133,18 +117,13 @@ static int coreboot_table_init(struct device *dev, void *ptr)
>                 ret = device_register(&device->dev);
>                 if (ret) {
>                         put_device(&device->dev);
> -                       break;
> +                       return ret;
>                 }
>
>                 ptr_entry += entry->size;
>         }
>
> -       if (ret) {
> -               bus_unregister(&coreboot_bus_type);
> -               memunmap(ptr);
> -       }
> -
> -       return ret;
> +       return 0;
>  }
>
>  static int coreboot_table_probe(struct platform_device *pdev)
> @@ -152,7 +131,9 @@ static int coreboot_table_probe(struct platform_device *pdev)
>         resource_size_t len;
>         struct coreboot_table_header *header;
>         struct resource *res;
> +       struct device *dev = &pdev->dev;
>         void *ptr;
> +       int ret;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res)
> @@ -162,26 +143,37 @@ static int coreboot_table_probe(struct platform_device *pdev)
>         if (!res->start || !len)
>                 return -EINVAL;
>
> +       /* Map and check just the header first to make sure things are sane */
>         header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
> -       if (header == NULL)
> +       if (!header)
>                 return -ENOMEM;
>
> -       ptr = memremap(res->start, header->header_bytes + header->table_bytes,
> -                      MEMREMAP_WB);
> +       if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
> +               dev_warn(dev, "coreboot table missing or corrupt!\n");
> +               return -ENODEV;

Leaking the mapping here.

> +       }
> +
> +       ptr = devm_memremap(dev, res->start,
> +                           header->header_bytes + header->table_bytes,
> +                           MEMREMAP_WB);
>         memunmap(header);
>         if (!ptr)
>                 return -ENOMEM;
>
> -       return coreboot_table_init(&pdev->dev, ptr);
> +       ret = bus_register(&coreboot_bus_type);
> +       if (ret)
> +               return ret;
> +
> +       ret = coreboot_table_populate(dev, ptr);
> +       if (ret)
> +               bus_unregister(&coreboot_bus_type);
> +
> +       return ret;
>  }
>
>  static int coreboot_table_remove(struct platform_device *pdev)
>  {
> -       if (ptr_header) {
> -               bus_unregister(&coreboot_bus_type);
> -               memunmap(ptr_header);
> -               ptr_header = NULL;
> -       }
> +       bus_unregister(&coreboot_bus_type);
>
>         return 0;
>  }
> --
> Sent by a computer through tubes
>
