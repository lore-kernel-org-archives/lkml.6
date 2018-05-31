Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeEaHGY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:06:24 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41473 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeEaHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:06:20 -0400
X-Google-Smtp-Source: ADUXVKJY/WtSKMSW5g1105xoNTAcj1dB3D8y46ZV72xnNAPEFeI/rO/fmdjRMLTnj47Y2wfBW5+weA==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-13-stanimir.varbanov@linaro.org> <CAAFQd5Bj73zyi0vsaSJ2sam2TGm7agshXg+n+sa2c7HoqLRGUw@mail.gmail.com>
 <13c7aec1-2bb9-f449-6b7d-7ec93be4ec71@linaro.org>
In-Reply-To: <13c7aec1-2bb9-f449-6b7d-7ec93be4ec71@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 16:06:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
Message-ID: <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
Subject: Re: [PATCH v2 12/29] venus: add common capability parser
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V78Ofn021906

On Thu, May 31, 2018 at 1:21 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 05/24/2018 05:16 PM, Tomasz Figa wrote:
> > Hi Stanimir,
> >
> > On Tue, May 15, 2018 at 5:08 PM Stanimir Varbanov <
> > [snip]
> >> diff --git a/drivers/media/platform/qcom/venus/core.h
> > b/drivers/media/platform/qcom/venus/core.h
> >> index b5b9a84e9155..fe2d2b9e8af8 100644
> >> --- a/drivers/media/platform/qcom/venus/core.h
> >> +++ b/drivers/media/platform/qcom/venus/core.h
> >> @@ -57,6 +57,29 @@ struct venus_format {
> >>           u32 type;
> >>    };
> >
> >> +#define MAX_PLANES             4
> >
> > We have VIDEO_MAX_PLANES (== 8) already.
>
> yes, but venus has maximum of 4
>

Generally we tend to avoid inventing new constants and so you can see
that many drivers just use VIDEO_MAX_PLANES. I can also see drivers
that don't, so I guess we can keep it as is.

> >>    #define IS_V1(core)    ((core)->res->hfi_version == HFI_VERSION_1XX)
> >> @@ -322,4 +320,18 @@ static inline void *to_hfi_priv(struct venus_core
> > *core)
> >>           return core->priv;
> >>    }
> >
> >> +static inline struct venus_caps *
> >
> > I'd leave the decision whether to inline this or not to the compiler.
> > (Although these days the "inline" keyword is just a hint anyway... but
> > still just wasted bytes in kernel's git repo.)
>
> I just followed the other code examples in the kernel and in venus. If
> you insist I can drop 'inline'.

https://www.kernel.org/doc/html/latest/process/coding-style.html#the-inline-disease

> >> +static void for_each_codec(struct venus_caps *caps, unsigned int
> > caps_num,
> >> +                          u32 codecs, u32 domain, func cb, void *data,
> >> +                          unsigned int size)
> >> +{
> >> +       struct venus_caps *cap;
> >> +       unsigned int i;
> >> +
> >> +       for (i = 0; i < caps_num; i++) {
> >> +               cap = &caps[i];
> >> +               if (cap->valid && cap->domain == domain)
> >
> > Is there any need to check cap->domain == domain? We could just skip if
> > cap->valid.
>
> yes, we need to check the domain because we can have the same codec for
> both domains decoder and encoder but with different capabilities.
>

Sorry, I guess my comment wasn't clear. The second if below was
already checking the domain.

> >
> > If we want to shorten the code, we could even do (cap->valid || cap->domain
> > != domain) and remove domain check from the if below.
> >
> >> +                       continue;
> >> +               if (cap->codec & codecs && cap->domain == domain)

Here ^

But generally, if we consider second part of my comment, the problem
would disappear.

> >> +                       cb(cap, data, size);
> >> +       }
> >> +}
[snip]
> >> +static void parse_profile_level(u32 codecs, u32 domain, void *data)
> >> +{
> >> +       struct hfi_profile_level_supported *pl = data;
> >> +       struct hfi_profile_level *proflevel = pl->profile_level;
> >> +       u32 count = pl->profile_count;
> >> +
> >> +       if (count > HFI_MAX_PROFILE_COUNT)
> >> +               return;
> >> +
> >> +       while (count) {
> >> +               proflevel = (void *)proflevel + sizeof(*proflevel);
> >
> > Isn’t this just ++proflevel?
>
> yes
>
> >
> >> +               count--;
> >> +       }
> >
> > Am I missing something or this function doesn’t to do anything?
>
> yes, currently it is not used. I'll update it.
>

I'd say we should just remove it for now and add it only when it is
actually needed for something.

> >
> >> +}
> >> +
> >> +static void fill_caps(struct venus_caps *cap, void *data, unsigned int
> > num)
> >> +{
> >> +       struct hfi_capability *caps = data;
> >> +       unsigned int i;
> >> +
> >
> > Should we have some check to avoid overflowing cap->caps[]?
>
> No, we checked that below 'num_caps > MAX_CAP_ENTRIES'
>

Ack.

> >> +static void parse_raw_formats(struct venus_core *core, struct venus_inst
> > *inst,
> >> +                             u32 codecs, u32 domain, void *data)
> >> +{
> >> +       struct hfi_uncompressed_format_supported *fmt = data;
> >> +       struct hfi_uncompressed_plane_info *pinfo = fmt->format_info;
> >> +       struct hfi_uncompressed_plane_constraints *constr;
> >> +       u32 entries = fmt->format_entries;
> >> +       u32 num_planes;
> >> +       struct raw_formats rfmts[MAX_FMT_ENTRIES] = {};
> >> +       unsigned int i = 0;
> >> +
> >> +       while (entries) {
> >> +               num_planes = pinfo->num_planes;
> >> +
> >> +               rfmts[i].fmt = pinfo->format;
> >> +               rfmts[i].buftype = fmt->buffer_type;
> >> +               i++;
> >> +
> >> +               if (pinfo->num_planes > MAX_PLANES)
> >> +                       break;
> >> +
> >> +               constr = pinfo->plane_format;
> >> +
> >> +               while (pinfo->num_planes) {
> >> +                       constr = (void *)constr + sizeof(*constr);
> >
> > ++constr?
> >
> >> +                       pinfo->num_planes--;
> >> +               }
> >
> > What is this loop supposed to do?
>
> It is a leftover for constraints per format and plane. Currently we
> don't use them, or at least the values returned by the firmware.
>

I guess it means we can remove it. :)

> >
> >> +
> >> +               pinfo = (void *)pinfo + sizeof(*constr) * num_planes +
> >> +                       2 * sizeof(u32);
> >> +               entries--;
> >> +       }
> >> +
> >> +       for_each_codec(core->caps, ARRAY_SIZE(core->caps), codecs, domain,
> >> +                      fill_raw_fmts, rfmts, i);
> >> +}
> > [snip]
> >> +static void parser_fini(struct venus_core *core, struct venus_inst *inst,
> >> +                       u32 codecs, u32 domain)
> >> +{
> >> +       struct venus_caps *caps = core->caps;
> >> +       struct venus_caps *cap;
> >> +       u32 dom;
> >> +       unsigned int i;
> >> +
> >> +       if (core->res->hfi_version != HFI_VERSION_1XX)
> >> +               return;
> >
> > Hmm, if the code below is executed only for 1XX, who will set cap->valid to
> > true for newer versions?
>
> cap::valid is used only for v1xx. Will add a comment in the structure.
>

Yes, please.

> >
> >> +
> >> +       if (!inst)
> >> +               return;
> >> +
> >> +       dom = inst->session_type;
> >> +
> >> +       for (i = 0; i < MAX_CODEC_NUM; i++) {
> >> +               cap = &caps[i];
> >> +               if (cap->codec & codecs && cap->domain == dom)
> >> +                       cap->valid = true;
> >> +       }
> >> +}
> >> +
> >> +u32 hfi_parser(struct venus_core *core, struct venus_inst *inst,
> >> +              u32 num_properties, void *buf, u32 size)
> >> +{
> >> +       unsigned int words_count = size >> 2;
> >> +       u32 *word = buf, *data, codecs = 0, domain = 0;
> >> +
> >> +       if (size % 4)
> >> +               return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> >> +
> >> +       parser_init(core, inst, &codecs, &domain);
> >> +
> >> +       while (words_count) {
> >> +               data = word + 1;
> >> +
> >> +               switch (*word) {
> >> +               case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
> >> +                       parse_codecs(core, data);
> >> +                       init_codecs_vcaps(core);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
> >> +                       parse_max_sessions(core, data);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
> >> +                       parse_codecs_mask(&codecs, &domain, data);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
> >> +                       parse_raw_formats(core, inst, codecs, domain,
> > data);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
> >> +                       parse_caps(core, inst, codecs, domain, data);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
> >> +                       parse_profile_level(codecs, domain, data);
> >> +                       break;
> >> +               case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
> >> +                       parse_alloc_mode(core, inst, codecs, domain,
> > data);
> >> +                       break;
> >> +               default:
> >
> > Should we perhaps print something to let us know that something
> > unrecognized was reported? (Or it is expected that something unrecognized
> > is there?)
>
> The default case will be very loaded with the data of the structures, so
> I don't think a print is a good idea.
>

Ack.

> >
> >> +                       break;
> >> +               }
> >> +
> >> +               word++;
> >> +               words_count--;
> >
> > If data is at |word + 1|, shouldn’t we increment |word| by |1 + |data
> > size||?
>
> yes, that could be possible but the firmware packets are with variable
> data length and don't want to make the code so complex.
>
> The idea is to search for HFI_PROPERTY_PARAM* key numbers. Yes it is not
> optimal but this enumeration is happen only once during driver probe.
>

Hmm, do we have a guarantee that we will never find a value that
matches HFI_PROPERTY_PARAM*, but would be actually just some data
inside the payload?

Best regards,
Tomasz
