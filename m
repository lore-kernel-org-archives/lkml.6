Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2EAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA1F24915
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sJ5Uxe7R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ReHE6s+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA1F24915
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbeFVVeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:34:15 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35810 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeFVVeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:34:12 -0400
Received: by mail-yb0-f193.google.com with SMTP id a16-v6so3067549ybm.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XcTQLODXHU+wDft7pZx8MkvnuuW8RHYGuB1TSeattTg=;
        b=sJ5Uxe7R7ugy8yUsy/k1pO5b458f2b++cVBBCm/EBxjzF6rJ7sO+XgJRgLACp1DRtD
         LlMMaAysn5kp8U4VAjAcPExewDqHq5D/aOi+PQ5PrsvwXnW58Ds1IM59A5tqICMySkO5
         JkKLWFrRvTXN3FC/MrZVTF6QUBLUYEC24w4CcfZyH/8bZNho8EBkaB1QE7i4AJjmkjrK
         YBpPKja7R6BrnlhQapRM+j8zI2TGE1pdnwmXn+B0gViWqsPrgpN9SBECiGFjfzza/18Z
         8ajwOY7g9/E3+P7YXxlpi+vtDVmWPfi6KwMbb2E/XK+hnmrzCwF9vtPYgk2HLlnxSCOF
         Jh/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XcTQLODXHU+wDft7pZx8MkvnuuW8RHYGuB1TSeattTg=;
        b=ReHE6s+usK1J93txfi8hqj0ry9ft+lxMpZCFjQ+kUsJLmKq47COHHkw6doS1JfxYaK
         /6EkKSRY2imC95FWhpK+O5hX9uwTryMlXRDoPFUAjjf7ymFVCxufw7c8Ja1da+YuU6qj
         FbMvw/iieGiihPA0SJTfjxavwReKgpKDAm18E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XcTQLODXHU+wDft7pZx8MkvnuuW8RHYGuB1TSeattTg=;
        b=R33ceY3dl5tvpacsPKRJ/riEqHsNa6ykwm5n9cu3+zMB8vRxP365R3j5pSm9dgCFCx
         D/+SQcXkYM1tVQym+X1PntCdNDywpbCpZa/EHUjbqxBq9RI+7EpNBBe/oAHAmimsBT81
         Qj4UZBrziVuWlJjn5BXDV2HHxpWuOrh49pwvo3ErfoCRc6TfvgQBjiLrJXlYEEkj3f4G
         UVsxfC1dFz/FCJG/H0i0bNrpMA6QZhlkMFlkMQBt8KW6RyiMtE8pCCzr+bUW1TQXJ/dI
         1947vjeRSWoqGFZdbAWjuPHkwM/PHRVnf73baDNbIHuS9Gtg3Qlp4m4DlbFGBTpKUkuz
         6tyQ==
X-Gm-Message-State: APt69E31tQgjRifi6BtxPzbg4sYBS8RHp4ReG7HbcyBBapdOR9Vg/8PY
        7RzqS/lCv4Be5eQXlkOGkJvbps9QyqGjgxzeKo4WNw==
X-Google-Smtp-Source: ADUXVKJyfZNtYlvm/U+1UAhH98Hd2T3bnO1v5FFeQZgRDLt2TH0kLBAEvemKASWdYBcH/riL3J2MOIPOJ/Kk+Pu4ANQ=
X-Received: by 2002:a5b:b4e:: with SMTP id b14-v6mr1836407ybr.463.1529703251677;
 Fri, 22 Jun 2018 14:34:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 14:34:11
 -0700 (PDT)
In-Reply-To: <CACO55ttzvFZqUjXNut5n0ENR9e2+N2WfWnKnjfaWgNesspQ9UA@mail.gmail.com>
References: <20180524172436.GA17738@beast> <CACO55ttzvFZqUjXNut5n0ENR9e2+N2WfWnKnjfaWgNesspQ9UA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 22 Jun 2018 14:34:11 -0700
X-Google-Sender-Auth: Y5VGWqqoBwedmf8cxM2Ybua16Q0
Message-ID: <CAGXu5jL3GyJxd9EJ=gKb+SY98t2h2Q4VMt0b0fYt8KBBuP2_9Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/secboot/acr: Remove VLA usage
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 10:50 AM, Karol Herbst <kherbst@redhat.com> wrote:
> On Thu, May 24, 2018 at 7:24 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> allocates the working buffers before starting the writing so it won't
>> abort in the middle. This needs an initial walk of the lists to figure
>> out how large the buffer should be.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  .../nouveau/nvkm/subdev/secboot/acr_r352.c    | 25 ++++++++++++++++---
>>  .../nouveau/nvkm/subdev/secboot/acr_r367.c    | 16 +++++++++++-
>>  2 files changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> index a721354249ce..d02e183717dc 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> @@ -414,6 +414,20 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>>  {
>>         struct ls_ucode_img *_img;
>>         u32 pos = 0;
>> +       u32 max_desc_size = 0;
>> +       u8 *gdesc;
>> +
>> +       /* Figure out how large we need gdesc to be. */
>> +       list_for_each_entry(_img, imgs, node) {
>> +               const struct acr_r352_ls_func *ls_func =
>> +                                           acr->func->ls_func[_img->falcon_id];
>> +
>> +               max_desc_size = max(max_desc_size, ls_func->bl_desc_size);
>> +       }
>> +
>> +       gdesc = kmalloc(max_desc_size, GFP_KERNEL);
>> +       if (!gdesc)
>> +               return -ENOMEM;
>>
>>         nvkm_kmap(wpr_blob);
>>
>> @@ -421,7 +435,6 @@ acr_r352_ls_write_wpr(struct acr_r352 *acr, struct list_head *imgs,
>>                 struct ls_ucode_img_r352 *img = ls_ucode_img_r352(_img);
>>                 const struct acr_r352_ls_func *ls_func =
>>                                             acr->func->ls_func[_img->falcon_id];
>> -               u8 gdesc[ls_func->bl_desc_size];
>>
>
> if there are no guarantees that (ls_func->bl_desc_size & 0x4 == 0),
> then we need to memset a bit more, because 4 bytes at the time are
> actually copied inside nvkm_gpuobj_memcpy_to later in that code, but
> the last 4 bytes are only partly memset to 0.

I think this is unchanged from the original code, yes? The memset() is
always against bl_desc_size; I haven't changed that.

> If ls_func->bl_desc_size is always a multiple of 0x4, then it isn't as
> important, but still better to be fixed. Or maybe
> nvkm_gpuobj_memcpy_to should do that handling and check if the size is
> a multiple of 0x4 and otherwise handle that case?
>
> Same is valid for the changes in the r367 file.

Should I resend with both the allocation and the memset getting
rounded up to the next multiple of 4?

-Kees

-- 
Kees Cook
Pixel Security
