Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD16ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081721479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zw+BfZI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8081721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbeIUX3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:29:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33324 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so3069855pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=V+cxAXiVMnX2b70SkcgiptOz0EzyE+5rO61ahVGZR7E=;
        b=Zw+BfZI7RNzPSrccU2BNVq8o9p1qb3hfTO7kp8rG2gcsJ0L6dA8ISYoatE16hPL71O
         PrKx9Zl+AdNw5w2OXoXyqXpxYd9lkcNf91A0W+QDZWejJdVmpLvGpA2aP1ET3vrS3Q/4
         YvH7BLMplIxT5iPL5F7e/st7n391Uye2zmCsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=V+cxAXiVMnX2b70SkcgiptOz0EzyE+5rO61ahVGZR7E=;
        b=JLOh6V12Y/Tbp4rgh6maDvjOizrXcwmlm/syB14WS/v6oQWPeISjowbzjZLlzbmXPR
         SAAyBo2FofSdWURu3Xgp9OyyWinV/8LlL1f0kGel326TcovoTrHScYuDWIMuyi5KQFZL
         mmMKXOkBpKwMZ4qpKptoK7lSZvBfmpJm7MkyNgsTQ9UoqF8ITJuYxUUUxASl4nHhZBO5
         unSnXJQbZXTbZ9QjFQqwCQwcfNo/H9FDDTqHajcf7T1p9bGnrFkM71NiNtbSKIVjA/In
         dwem2hSRyDiN9tNLOdOo+5mMJwyXh7+/3s53TGKe9+MrT59AFRKNbdmnLkJsdwfjm8gt
         KRkg==
X-Gm-Message-State: APzg51ARzNcf4o+q1UCnylI/RuEh8WpHhNKrDKqEKAlJoJA2W8RWnri1
        uyiWlybj9ZuwhTLyP5Lz2jYz3w==
X-Google-Smtp-Source: ANB0VdYRuhlbjIBVFVI4v2YEMSujvJI+L4WCUO+TL2Ik6/lj6/bUWgG03+/Fk89mo+HLOJ5ffnxWbw==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr42549041pgg.40.1537551594526;
        Fri, 21 Sep 2018 10:39:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d19-v6sm60187717pfe.42.2018.09.21.10.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:39:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180920223559.136915-1-swboyd@chromium.org>
 <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
Message-ID: <153755159334.119890.13825040401066852769@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date:   Fri, 21 Sep 2018 10:39:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robin Murphy (2018-09-21 04:09:50)
> Hi Stephen,
> =

> On 20/09/18 23:35, Stephen Boyd wrote:
> > I recently debugged a DMA mapping oops where a driver was trying to map
> > a buffer returned from request_firmware() with dma_map_single(). Memory
> > returned from request_firmware() is mapped into the vmalloc region and
> > this isn't a valid region to map with dma_map_single() per the DMA
> > documentation's "What memory is DMA'able?" section.
> > =

> > Unfortunately, we don't really check that in the DMA debugging code, so
> > enabling DMA debugging doesn't help catch this problem. Let's add a new
> > DMA debug function to check for a vmalloc address and print a warning if
> > this happens. This makes it a little easier to debug these sorts of
> > problems, instead of seeing odd behavior or crashes when drivers attempt
> > to map the vmalloc space for DMA.
> =

> Good idea!
> =

> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   include/linux/dma-debug.h   |  8 ++++++++
> >   include/linux/dma-mapping.h |  1 +
> >   kernel/dma/debug.c          | 12 ++++++++++++
> >   3 files changed, 21 insertions(+)
> =

> However I can't help thinking this looks a little heavyweight for a =

> single specific check. It seems like it would be enough to simply pass =

> the VA as an extra argument to debug_dma_map_page(), since we already =

> have the map_single argument which would indicate when it's valid. What =

> do you reckon?

I thought about augmenting debug_dma_map_page() but that has another
problem where those checks are done after the page has been mapped. The
kernel can oops when it's operating on the incorrect page so we need to
check things before calling the dma ops.

So I split that check up into pre_map and post_map parts but then that
seemed like overkill just to check for this vmalloc problem. Here's the
patch if you're interested. I can make it a little nicer if you think
it's also worthwhile.

---8<----
 include/linux/dma-debug.h   |  8 ++++++++
 include/linux/dma-mapping.h |  3 +++
 kernel/dma/debug.c          | 24 ++++++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 5aec2ca8a426..3287240a474c 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -35,6 +35,9 @@ extern int dma_debug_resize_entries(u32 num_entries);
 extern void debug_dma_check_vmalloc(struct device *dev, const void *addr,
 				    unsigned long len);
 =

+extern void debug_dma_pre_map_page(struct device *dev, struct page *page,
+				   size_t offset, size_t size);
+
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr,
@@ -111,6 +114,11 @@ static inline void debug_dma_check_vmalloc(struct devi=
ce *dev, const void *addr,
 {
 }
 =

+static inline void debug_dma_pre_map_page(struct device *dev, struct page =
*page,
+					  size_t offset, size_t size)
+{
+}
+
 static inline void debug_dma_map_page(struct device *dev, struct page *pag=
e,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a0e67fd5433c..4839bbb4fdc7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -233,6 +233,8 @@ static inline dma_addr_t dma_map_single_attrs(struct de=
vice *dev, void *ptr,
 =

 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_check_vmalloc(dev, ptr, size);
+	debug_dma_pre_map_page(dev, virt_to_page(ptr),
+			       offset_in_page(ptr), size);
 	addr =3D ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
@@ -296,6 +298,7 @@ static inline dma_addr_t dma_map_page_attrs(struct devi=
ce *dev,
 	dma_addr_t addr;
 =

 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_pre_map_page(dev, page, offset, size);
 	addr =3D ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 =

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7ee7978868d4..dd1ff9f7d783 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1324,6 +1324,22 @@ void debug_dma_check_vmalloc(struct device *dev, con=
st void *addr,
 }
 EXPORT_SYMBOL(debug_dma_check_vmalloc);
 =

+void debug_dma_pre_map_page(struct device *dev, struct page *page, size_t =
offset,
+			    size_t size)
+{
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_for_stack(dev, page, offset);
+
+	if (!PageHighMem(page)) {
+		void *addr =3D page_address(page) + offset;
+
+		check_for_illegal_area(dev, addr, size);
+	}
+}
+EXPORT_SYMBOL(debug_dma_pre_map_page);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offs=
et,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
@@ -1352,14 +1368,6 @@ void debug_dma_map_page(struct device *dev, struct p=
age *page, size_t offset,
 	if (map_single)
 		entry->type =3D dma_debug_single;
 =

-	check_for_stack(dev, page, offset);
-
-	if (!PageHighMem(page)) {
-		void *addr =3D page_address(page) + offset;
-
-		check_for_illegal_area(dev, addr, size);
-	}
-
 	add_dma_entry(entry);
 }
 EXPORT_SYMBOL(debug_dma_map_page);
-- =

Sent by a computer through tubes

