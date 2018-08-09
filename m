Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E3C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE71721EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WbQUdwOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE71721EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHIUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:50:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45932 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeHIUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:50:47 -0400
Received: by mail-yw1-f65.google.com with SMTP id 139-v6so5761505ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQiWb8GC3gv+Nn87RzRiath9No2TT7cC5BxoF9sbtxw=;
        b=WbQUdwOKy/hQMkGcBsUG30dfEV6PQkQBuwf+y9yYKAyzRsfWB0B6zhC0y01nWDrF/h
         St6MK2tQphdNJAH4dpC2wuiIU+JlzHdhjW1EQVTHntpRTLUNB0owNoZimvYPZ/bN7mBy
         LONAEk9GC1tqNv65x/9fAKujwWS0mZUyZo5cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQiWb8GC3gv+Nn87RzRiath9No2TT7cC5BxoF9sbtxw=;
        b=tbbWAUJKfD8mJBGAiOdnkUBUSmfQ9Sxpzn1FkxEo3OgEcoNJPdyNMbquGmKvJFpxiW
         JGG4ggODSWoJZGv/hx7xCD+SpAXt6e0Z9tAVvvpO/U5dN87T7lvA1Nbljnoq1IJSksZb
         nMHTdF2ItiPBVYgXs57UoztqRJHwGq9nZ/6flG39Wqm99GDAzbH+bic5Ay17vOcAZnGm
         +DaYlWSxupr0lEhGrlKln6yz+TjRL44jZ1yXWDWW1Pkqilxd/xUnXbqM5E7u3xyNkjCi
         nCIL0FyQHEB+4nyTGGw33FyFb63swuk3M1EQfLK7poBE4Ioso4WuG/RGkzR8Rw2OpIt/
         4olg==
X-Gm-Message-State: AOUpUlE2bWE2liWcTbnqAdF1NLOlMLh8evwe1TmOs1y0Z9Xcn9hlhs9A
        WETMJ2kFw3cCnVM6wDMsC0aQPPjLhVQ+SeEPscaPVQ==
X-Google-Smtp-Source: AA+uWPwghnhawrdoIakorXucyvRgLYnp/HyDX/YTQl9wxIdsTwURp3VVDFVgexr49H1g7IjFlBWzrWpFEexNLEekFR0=
X-Received: by 2002:a1f:f284:: with SMTP id q126-v6mr2108207vkh.38.1533839082279;
 Thu, 09 Aug 2018 11:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-6-swboyd@chromium.org>
In-Reply-To: <20180809171722.144325-6-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 11:24:29 -0700
Message-ID: <CAODwPW8x=ghbVpo4q48jh-xGScP+2O_Vt7LTtSqhLvAAnCVXuA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] firmware: coreboot: Remap RAM with memremap()
 instead of ioremap()
To:     swboyd@chromium.org, Aaron Durbin <adurbin@chromium.org>
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

One thing to note is that we still want this space to be mappable by
userspace applications via /dev/mem, so we need to make sure that
there's no weird memory type mismatch that causes problems with that.
Adding Aaron to see if he has any concerns here, since I think he's
seen something like that in the past (not sure if it was related to
what this kernel driver does).

Can you please test this on an x86 Chromebook and run the 'cbmem'
userspace utility, make sure it doesn't fail after this?

Also, stupid question after taking a step back and looking at this
again: why do we keep a mapping alive for the lifetime of the driver
at all? It used to be necessary when this driver was
find-entry-on-demand, but nowadays it just goes through all entries
once at probe time and immediately memcpy_fromio()s out all the
relevant information into (struct coreboot_device)s. After that we're
done accessing the "real" coreboot table, forever. Why not just unmap
it again at the end of coreboot_table_init()?
On Thu, Aug 9, 2018 at 10:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is all system memory, so we shouldn't be mapping this all with
> ioremap() as these aren't I/O regions. Instead, they're memory regions
> so we should use memremap(). Pick MEMREMAP_WB so we can map memory from
> RAM directly if that's possible, otherwise it falls back to
> ioremap_cache() like is being done here already. This also nicely
> silences the sparse warnings in this code and reduces the need to copy
> anything around anymore.
>
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table.c | 42 +++++++++++-------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index feb31502f64b..f343dbe86448 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -32,7 +32,7 @@
>  #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
>  #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
>
> -static struct coreboot_table_header __iomem *ptr_header;
> +static struct coreboot_table_header *ptr_header;
>
>  static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
>  {
> @@ -94,18 +94,18 @@ void coreboot_driver_unregister(struct coreboot_driver *driver)
>  }
>  EXPORT_SYMBOL(coreboot_driver_unregister);
>
> -static int coreboot_table_init(struct device *dev, void __iomem *ptr)
> +static int coreboot_table_init(struct device *dev, void *ptr)
>  {
>         int i, ret;
>         void *ptr_entry;
>         struct coreboot_device *device;
> -       struct coreboot_table_entry entry;
> -       struct coreboot_table_header header;
> +       struct coreboot_table_entry *entry;
> +       struct coreboot_table_header *header;
>
>         ptr_header = ptr;
> -       memcpy_fromio(&header, ptr_header, sizeof(header));
> +       header = ptr;
>
> -       if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
> +       if (strncmp(header->signature, "LBIO", sizeof(header->signature))) {
>                 pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
>                 return -ENODEV;
>         }
> @@ -114,11 +114,11 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
>         if (ret)
>                 return ret;
>
> -       ptr_entry = (void *)ptr_header + header.header_bytes;
> -       for (i = 0; i < header.table_entries; i++) {
> -               memcpy_fromio(&entry, ptr_entry, sizeof(entry));
> +       ptr_entry = ptr_header + header->header_bytes;
> +       for (i = 0; i < header->table_entries; i++) {
> +               entry = ptr_entry;
>
> -               device = kzalloc(sizeof(struct device) + entry.size, GFP_KERNEL);
> +               device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
>                 if (!device) {
>                         ret = -ENOMEM;
>                         break;
> @@ -128,7 +128,7 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
>                 device->dev.parent = dev;
>                 device->dev.bus = &coreboot_bus_type;
>                 device->dev.release = coreboot_device_release;
> -               memcpy_fromio(&device->entry, ptr_entry, entry.size);
> +               memcpy(&device->entry, ptr_entry, entry->size);
>
>                 ret = device_register(&device->dev);
>                 if (ret) {
> @@ -136,12 +136,12 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
>                         break;
>                 }
>
> -               ptr_entry += entry.size;
> +               ptr_entry += entry->size;
>         }
>
>         if (ret) {
>                 bus_unregister(&coreboot_bus_type);
> -               iounmap(ptr);
> +               memunmap(ptr);
>         }
>
>         return ret;
> @@ -149,11 +149,10 @@ static int coreboot_table_init(struct device *dev, void __iomem *ptr)
>
>  static int coreboot_table_probe(struct platform_device *pdev)
>  {
> -       phys_addr_t phyaddr;
>         resource_size_t len;
> -       struct coreboot_table_header __iomem *header = NULL;
> +       struct coreboot_table_header *header;
>         struct resource *res;
> -       void __iomem *ptr = NULL;
> +       void *ptr;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res)
> @@ -163,14 +162,13 @@ static int coreboot_table_probe(struct platform_device *pdev)
>         if (!res->start || !len)
>                 return -EINVAL;
>
> -       phyaddr = res->start;
> -       header = ioremap_cache(phyaddr, sizeof(*header));
> +       header = memremap(res->start, sizeof(*header), MEMREMAP_WB);
>         if (header == NULL)
>                 return -ENOMEM;
>
> -       ptr = ioremap_cache(phyaddr,
> -                           header->header_bytes + header->table_bytes);
> -       iounmap(header);
> +       ptr = memremap(res->start, header->header_bytes + header->table_bytes,
> +                      MEMREMAP_WB);
> +       memunmap(header);
>         if (!ptr)
>                 return -ENOMEM;
>
> @@ -181,7 +179,7 @@ static int coreboot_table_remove(struct platform_device *pdev)
>  {
>         if (ptr_header) {
>                 bus_unregister(&coreboot_bus_type);
> -               iounmap(ptr_header);
> +               memunmap(ptr_header);
>                 ptr_header = NULL;
>         }
>
> --
> Sent by a computer through tubes
>
