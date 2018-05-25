Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935656AbeEYNmH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:42:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:60048 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934397AbeEYNmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:42:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="227212395"
Date: Fri, 25 May 2018 19:10:23 +0530
From: Shreyas NC <shreyas.nc@intel.com>
To: Guenter Roeck <groeck@google.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Message-ID: <20180525134023.GJ3116@snc-desk>
References: <20180522165842.233949-1-groeck@google.com>
 <649b1c14-e440-0c89-a59c-dc663344faa3@linux.intel.com>
 <CABXOdTdyWVtbWXR6O3VenwTezVLGvEfKuvH=Xz6e5D3np-ZQNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdyWVtbWXR6O3VenwTezVLGvEfKuvH=Xz6e5D3np-ZQNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +struct skl_dfw_v4_pipe {
> > > +     u8 pipe_id;
> > > +     u8 pipe_priority;
> > > +     u16 conn_type:4;
> > > +     u16 rsvd:4;
> > > +     u16 memory_pages:8;
> > > +} __packed;
> > > +
> > > +struct skl_dfw_v4_module {
> > > +     char uuid[SKL_UUID_STR_SZ];
> > > +

Any reason to not have this as u8?
commit 09305da97c7808b900985526aa9198233f32fb37 had changed this to u8..

<snip>

> > > +
> > > +     mconfig->params_fixup = dfw->params_fixup;
> > > +     mconfig->converter = dfw->converter;
> > > +     mconfig->m_type = dfw->module_type;
> > > +     mconfig->vbus_id = dfw->vbus_id;
> > > +     mconfig->module->resources[0].is_pages = dfw->mem_pages;
> > > +
> > > +     ret = skl_tplg_add_pipe_v4(dev, mconfig, skl, &dfw->pipe);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     mconfig->dev_type = dfw->dev_type;
> > > +     mconfig->hw_conn_type = dfw->hw_conn_type;
> > > +     mconfig->time_slot = dfw->time_slot;
> > > +     mconfig->formats_config.caps_size = dfw->caps.caps_size;
> 
> > chromeos-3.18 has this:
> >       if (dfw_config->is_loadable)
> >           memcpy(mconfig->guid, dfw_config->uuid,
> >                       ARRAY_SIZE(dfw_config->uuid));
> 
> > Is this needed here?
> 
> 
> Direct memcpy doesn't work anymore since the uuid format is different. The
> above is replaced
> with (unconditional)
> 
>          ret = guid_parse(dfw->uuid, (guid_t *)mconfig->guid);
>          if (ret)
>                  return ret;
> 
> at the beginning of skl_tplg_get_pvt_data_v4(). The new code, as far as I
> can see, loads
> the uuid unconditionally if it finds SND_SOC_TPLG_TUPLE_TYPE_UUID. I wanted
> to
> be on the safe side and decided to do the same.
> 

In the new code, still does a memcpy(). So, I am not sure if I understand
why memcpy() does not work.

        if (uuid_tkn->token == SKL_TKN_UUID) {
                memcpy(guid, &uuid_tkn->uuid, 16);
                return 0;
        }

Replied on the older mail since Pierre had a similar question as well.

--Shreyas

-- 
