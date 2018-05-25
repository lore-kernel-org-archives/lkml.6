Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936174AbeEYOJi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:09:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43781 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936061AbeEYOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:09:37 -0400
X-Google-Smtp-Source: AB8JxZpN+gDWfqzx6zmQbJgDstVy5hHxmq8ipcY46fQZ3feNugnQDc2joeVLuhTApmQ77v6JJj850qMnLwEmPKBC/94=
MIME-Version: 1.0
References: <20180522165842.233949-1-groeck@google.com> <649b1c14-e440-0c89-a59c-dc663344faa3@linux.intel.com>
 <CABXOdTdyWVtbWXR6O3VenwTezVLGvEfKuvH=Xz6e5D3np-ZQNw@mail.gmail.com> <20180525134023.GJ3116@snc-desk>
In-Reply-To: <20180525134023.GJ3116@snc-desk>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 25 May 2018 07:09:24 -0700
Message-ID: <CABXOdTcrAoh_uhA=6AggUPFiGdFqwuFAHej50vK9gRMU9waUAQ@mail.gmail.com>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: shreyas.nc@intel.com
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 6:42 AM Shreyas NC <shreyas.nc@intel.com> wrote:

> > > > +struct skl_dfw_v4_pipe {
> > > > +     u8 pipe_id;
> > > > +     u8 pipe_priority;
> > > > +     u16 conn_type:4;
> > > > +     u16 rsvd:4;
> > > > +     u16 memory_pages:8;
> > > > +} __packed;
> > > > +
> > > > +struct skl_dfw_v4_module {
> > > > +     char uuid[SKL_UUID_STR_SZ];
> > > > +

> Any reason to not have this as u8?
> commit 09305da97c7808b900985526aa9198233f32fb37 had changed this to u8..

No reason. I'll fix it.

> <snip>

> > > > +
> > > > +     mconfig->params_fixup = dfw->params_fixup;
> > > > +     mconfig->converter = dfw->converter;
> > > > +     mconfig->m_type = dfw->module_type;
> > > > +     mconfig->vbus_id = dfw->vbus_id;
> > > > +     mconfig->module->resources[0].is_pages = dfw->mem_pages;
> > > > +
> > > > +     ret = skl_tplg_add_pipe_v4(dev, mconfig, skl, &dfw->pipe);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     mconfig->dev_type = dfw->dev_type;
> > > > +     mconfig->hw_conn_type = dfw->hw_conn_type;
> > > > +     mconfig->time_slot = dfw->time_slot;
> > > > +     mconfig->formats_config.caps_size = dfw->caps.caps_size;
> >
> > > chromeos-3.18 has this:
> > >       if (dfw_config->is_loadable)
> > >           memcpy(mconfig->guid, dfw_config->uuid,
> > >                       ARRAY_SIZE(dfw_config->uuid));
> >
> > > Is this needed here?
> >
> >
> > Direct memcpy doesn't work anymore since the uuid format is different.
The
> > above is replaced
> > with (unconditional)
> >
> >          ret = guid_parse(dfw->uuid, (guid_t *)mconfig->guid);
> >          if (ret)
> >                  return ret;
> >
> > at the beginning of skl_tplg_get_pvt_data_v4(). The new code, as far as
I
> > can see, loads
> > the uuid unconditionally if it finds SND_SOC_TPLG_TUPLE_TYPE_UUID. I
wanted
> > to
> > be on the safe side and decided to do the same.
> >

> In the new code, still does a memcpy(). So, I am not sure if I understand
> why memcpy() does not work.

>          if (uuid_tkn->token == SKL_TKN_UUID) {
>                  memcpy(guid, &uuid_tkn->uuid, 16);
>                  return 0;
>          }

The new (v5) configuration files provide the uuid as binary and no longer
as text.

Guenter
