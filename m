Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C187C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFE3208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEFWhKDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFE3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeFRDkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:40:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43922 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeFRDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:40:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id x13-v6so6954323lff.10;
        Sun, 17 Jun 2018 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=e/w2kQQHxzlmA1zyKdUdlN+5OYqE7edlFjhNCLdZOfQ=;
        b=vEFWhKDtNQ/BJyY75q2DURdnj2rM4TJv9upKLmUDQmMdGnCBH1lzYtvA4PxX/Y+G/6
         me+/enp6XiQ4qxy9V+zmYgAYDR1DiLx7Vg7QFTIGGMxI9P1bsJs552TgxFQeWuZIomTT
         IIHGPdlbE4TdbHwzHvlTp0h2D6RubCD40IJb0pwB/jyPv4OfbL81LjE26lTY3mUmK3co
         /IxoPzf0pa41KuQCX2oJURa4LfFsccqiOImP3R6P0y3+k4Eo1V+Q2behOpivTVBpSF/g
         o0fHVjwiSNDLAPygvwpDgkYCFB69gRptuii8SDhYykIkrtC2BlIar2TnXnpNPOI2IVn/
         EljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=e/w2kQQHxzlmA1zyKdUdlN+5OYqE7edlFjhNCLdZOfQ=;
        b=Rpct7foozOhwXF8xcwSSPr94FXE2dSA2M/sKbJmlFM+ymAN6aqQWRAUFxOT2nmYCzc
         EM/eiNE16z0EsoCOviy0XmQbr7T8F/VBmomOO+039fAKymAwNMDbT7If5yolqUvrQeUg
         F247IcnzAV0Isa0pdAR1lSSmf/FKhedFQr1mYXsD4RqhJyuRgSKcBgSerND7cQc8bzSo
         HCjpbA9cgavjqpo08GvcvvaJZXg9NVloRohyr6vVAqmlYMT4Q3E7pNE157SARxHUT2LC
         xVNeW3Bwpg4ltblV63vHPqknLYY86Dai4tb665pby760vBllb+ldaNaCrhcw6FoAu9J5
         7alA==
X-Gm-Message-State: APt69E2Smr6bBu0iEUM2/2wyxsZiz/9YlPgrWEBIGUs9lo7nzxUg6yxW
        FjZoWMZq3hL6oKK2vkYHvCrEFHtGVjNW2j/XOVc=
X-Google-Smtp-Source: ADUXVKLx4uoic23Gfu2pIzaPjXr8vLczgeSW91eGLlw98N1oxxiRaIOWaiFFqH2tZNvhmcpshiQYx4J9K0MH9p7O/Wo=
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr6537985lfe.60.1529293232308;
 Sun, 17 Jun 2018 20:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 20:40:31
 -0700 (PDT)
In-Reply-To: <20180531175902.GC11565@jcrouse-lnx.qualcomm.com>
References: <20180521172948.GA18605@jordon-HP-15-Notebook-PC>
 <CAFqt6zY8VJ791_6C_pqrGgjG91T1kirEmUyA3JC+3JsN8QjFAw@mail.gmail.com> <20180531175902.GC11565@jcrouse-lnx.qualcomm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 18 Jun 2018 09:10:31 +0530
Message-ID: <CAFqt6zaVbJWCvCf8AF5nKPCpqrSi1Aweog2=V9xzJFzWGbmd3w@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] gpu: drm: msm: Change return type to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Rob Clark <robdclark@gmail.com>, airlied@linux.ie,
        Matthew Wilcox <willy@infradead.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:29 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> On Mon, May 28, 2018 at 12:38:41PM +0530, Souptick Joarder wrote:
>> On Mon, May 21, 2018 at 10:59 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > Use new return type vm_fault_t for fault handler. For
>> > now, this is just documenting that the function returns
>> > a VM_FAULT value rather than an errno. Once all instances
>> > are converted, vm_fault_t will become a distinct type.
>> >
>> > Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>> >
>> > Previously vm_insert_mixed() returns err which driver
>> > mapped into VM_FAULT_* type. The new function
>> > vmf_insert_mixed() will replace this inefficiency by
>> > returning VM_FAULT_* type.
>> >
>> > vmf_error() is the newly introduce inline function
>> > in 4.17-rc6.
>> >
>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> > ---
>> >  drivers/gpu/drm/msm/msm_drv.h |  3 ++-
>> >  drivers/gpu/drm/msm/msm_gem.c | 33 ++++++++++-----------------------
>> >  2 files changed, 12 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>> > index 0a653dd..44b4ca7 100644
>> > --- a/drivers/gpu/drm/msm/msm_drv.h
>> > +++ b/drivers/gpu/drm/msm/msm_drv.h
>> > @@ -33,6 +33,7 @@
>> >  #include <linux/of_graph.h>
>> >  #include <linux/of_device.h>
>> >  #include <asm/sizes.h>
>> > +#include <linux/mm_types.h>
>> >
>> >  #include <drm/drmP.h>
>> >  #include <drm/drm_atomic.h>
>> > @@ -188,7 +189,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>> >  int msm_gem_mmap_obj(struct drm_gem_object *obj,
>> >                         struct vm_area_struct *vma);
>> >  int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>> > -int msm_gem_fault(struct vm_fault *vmf);
>> > +vm_fault_t msm_gem_fault(struct vm_fault *vmf);
>> >  uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
>> >  int msm_gem_get_iova(struct drm_gem_object *obj,
>> >                 struct msm_gem_address_space *aspace, uint64_t *iova);
>> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
>> > index 07376de..27a5ab5 100644
>> > --- a/drivers/gpu/drm/msm/msm_gem.c
>> > +++ b/drivers/gpu/drm/msm/msm_gem.c
>> > @@ -217,7 +217,7 @@ int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>> >         return msm_gem_mmap_obj(vma->vm_private_data, vma);
>> >  }
>> >
>> > -int msm_gem_fault(struct vm_fault *vmf)
>> > +vm_fault_t msm_gem_fault(struct vm_fault *vmf)
>> >  {
>> >         struct vm_area_struct *vma = vmf->vma;
>> >         struct drm_gem_object *obj = vma->vm_private_data;
>> > @@ -225,15 +225,18 @@ int msm_gem_fault(struct vm_fault *vmf)
>> >         struct page **pages;
>> >         unsigned long pfn;
>> >         pgoff_t pgoff;
>> > -       int ret;
>> > +       int err;
>> > +       vm_fault_t ret;
>> >
>> >         /*
>> >          * vm_ops.open/drm_gem_mmap_obj and close get and put
>> >          * a reference on obj. So, we dont need to hold one here.
>> >          */
>> > -       ret = mutex_lock_interruptible(&msm_obj->lock);
>> > -       if (ret)
>> > +       err = mutex_lock_interruptible(&msm_obj->lock);
>> > +       if (err) {
>> > +               ret = VM_FAULT_NOPAGE;
>> >                 goto out;
>> > +       }
>> >
>> >         if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
>> >                 mutex_unlock(&msm_obj->lock);
>> > @@ -243,7 +246,7 @@ int msm_gem_fault(struct vm_fault *vmf)
>> >         /* make sure we have pages attached now */
>> >         pages = get_pages(obj);
>> >         if (IS_ERR(pages)) {
>> > -               ret = PTR_ERR(pages);
>> > +               ret = vmf_error(PTR_ERR(pages));
>> >                 goto out_unlock;
>> >         }
>> >
>> > @@ -255,27 +258,11 @@ int msm_gem_fault(struct vm_fault *vmf)
>> >         VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
>> >                         pfn, pfn << PAGE_SHIFT);
>> >
>> > -       ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
>> > -
>> > +       ret = vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
>> >  out_unlock:
>> >         mutex_unlock(&msm_obj->lock);
>> >  out:
>> > -       switch (ret) {
>> > -       case -EAGAIN:
>> > -       case 0:
>> > -       case -ERESTARTSYS:
>> > -       case -EINTR:
>> > -       case -EBUSY:
>> > -               /*
>> > -                * EBUSY is ok: this just means that another thread
>> > -                * already did the job.
>> > -                */
>> > -               return VM_FAULT_NOPAGE;
>> > -       case -ENOMEM:
>> > -               return VM_FAULT_OOM;
>> > -       default:
>> > -               return VM_FAULT_SIGBUS;
>> > -       }
>> > +       return ret;
>> >  }
>> >
>> >  /** get mmap offset */
>> > --
>> > 1.9.1
>> >
>>
>> Any comment for this patch ?
>
> Sorry for the delay, I wanted to get a chance to test it. It seems to pass the
> usual regression tests. LGTM.
>

Jordan, This patch is not merged in 4.18-rc-1.
