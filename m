Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166423AbeBOSZo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:25:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163288AbeBOSZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:25:41 -0500
Date: Thu, 15 Feb 2018 20:25:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau
        <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Subject: Re: [PATCH v14 3/9] fw_cfg: fix sparse warnings in
 fw_cfg_sel_endianness()
Message-ID: <20180215202216-mutt-send-email-mst@kernel.org>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
 <20180214141850.4017-4-marcandre.lureau@redhat.com>
 <20180214224149-mutt-send-email-mst@kernel.org>
 <CAMxuvaw_z=MZj+i7+qxWhoF=mmEsWFa41h0BfSp15dH160oUQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaw_z=MZj+i7+qxWhoF=mmEsWFa41h0BfSp15dH160oUQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:34:28AM +0100, Marc-Andre Lureau wrote:
> On Wed, Feb 14, 2018 at 9:46 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Feb 14, 2018 at 03:18:44PM +0100, Marc-André Lureau wrote:
> >> The function is used for both LE & BE target type, use __force casting.
> >>
> >> Fixes:
> >> $ make C=1 CF=-D__CHECK_ENDIAN__ drivers/firmware/qemu_fw_cfg.o
> >>
> >> drivers/firmware/qemu_fw_cfg.c:55:33: warning: restricted __be16 degrades to integer
> >> drivers/firmware/qemu_fw_cfg.c:55:52: warning: restricted __le16 degrades to integer
> >>
> >> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  drivers/firmware/qemu_fw_cfg.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> >> index 90f467232777..85e693287d87 100644
> >> --- a/drivers/firmware/qemu_fw_cfg.c
> >> +++ b/drivers/firmware/qemu_fw_cfg.c
> >> @@ -52,7 +52,9 @@ static DEFINE_MUTEX(fw_cfg_dev_lock);
> >>  /* pick appropriate endianness for selector key */
> >>  static inline u16 fw_cfg_sel_endianness(u16 key)
> >>  {
> >> -     return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
> >> +     return fw_cfg_is_mmio ?
> >> +             (u16 __force)cpu_to_be16(key) :
> >> +             (u16 __force)cpu_to_le16(key);
> >>  }
> >>
> >>  /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
> >
> > Well the caller does cpu_to_le16 on the result ...
> > All this makes my head spin.
> >
> > IMHO what you want is a wrapper that does iowrite and iowritebe
> > rather than __force.
> 
> iowrite16(key) is the same as iowrite16(cpu_to_le16(key)) ? There is
> no iowrite16le()...

Yes.

> Is this equivalent, and not introducing regressions?
> 
> static inline u16 fw_cfg_sel_endianness(u16 key)
> +static void fw_cfg_sel_endianness(u16 key)
>  {
> -       return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);

For mmio on LE it does 1 swap. On BE 1 swap.
For non mmio on LE it does no swaps. On BE 1 swap.

Fair summary?

And is this actually the intended behaviour.

> +       if (fw_cfg_is_mmio)
> +               iowrite16be(key, fw_cfg_reg_ctrl);
> +       else
> +               iowrite16(key, fw_cfg_reg_ctrl);


this behaves differently. donnu if that's a bug or
a feature. You will have to find out.

>  }
> 
>  /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
> @@ -74,7 +77,7 @@ static inline void fw_cfg_read_blob(u16 key,
>         }
> 
>         mutex_lock(&fw_cfg_dev_lock);
> -       iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
> +       fw_cfg_sel_endianness(key);
> 
> >
> >
> >> --
> >> 2.16.1.73.g5832b7e9f2
