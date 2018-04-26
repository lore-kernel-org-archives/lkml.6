Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeDZHo2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:44:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38227 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbeDZHoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:44:22 -0400
X-Google-Smtp-Source: AB8JxZooYxHlQWJdja0OblqcOege9L1AONoyTPmbUpQifPGZ2uGUvbWSkYpc3FBUTZstNBd1S+4Raw==
Date: Thu, 26 Apr 2018 08:44:18 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Kyle Spiers <ksspiers@google.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rave-sp: Remove VLA
Message-ID: <20180426074418.lcj6y726ypzlizfr@dell>
References: <20180423200255.154645-1-ksspiers@google.com>
 <20180424054315.2yjpnht5pu62i54q@dell>
 <CAGXu5jL5j6ZknsKN8ve+4qgSQLKsssUTto_UXORABgfHop=-7w@mail.gmail.com>
 <20180425103128.tp4wcvyp7rcm4jge@dell>
 <CAM9OsyKauRJCWfJ360+SAiUAOE1+aBZ1hp_AMDgmzkQ-MYrqxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9OsyKauRJCWfJ360+SAiUAOE1+aBZ1hp_AMDgmzkQ-MYrqxA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 25, 2018 at 3:31 AM Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Tue, 24 Apr 2018, Kees Cook wrote:
> 
> > > On Mon, Apr 23, 2018 at 10:43 PM, Lee Jones <lee.jones@linaro.org>
> wrote:
> > > > On Mon, 23 Apr 2018, Kyle Spiers wrote:
> > > >
> > > >> As part of the effort to remove VLAs from the kernel[1], this creates
> > > >> constants for the checksum lengths of CCITT and 8B2C and changes
> > > >> crc_calculated to be the maximum size of a checksum.
> > > >>
> > > >> https://lkml.org/lkml/2018/3/7/621
> > > >>
> > > >> Signed-off-by: Kyle Spiers <ksspiers@google.com>
> > > >> ---
> > > >>  drivers/mfd/rave-sp.c | 11 +++++++++--
> > > >>  1 file changed, 9 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> > > >> index 5c858e784a89..99fa482419f9 100644
> > > >> --- a/drivers/mfd/rave-sp.c
> > > >> +++ b/drivers/mfd/rave-sp.c
> > > >> @@ -45,7 +45,9 @@
> > > >>  #define RAVE_SP_DLE                  0x10
> > > >>
> > > >>  #define RAVE_SP_MAX_DATA_SIZE                64
> > > >> -#define RAVE_SP_CHECKSUM_SIZE                2  /* Worst case
> scenario on RDU2 */
> > > >> +#define RAVE_SP_CHECKSUM_8B2C                1
> > > >> +#define RAVE_SP_CHECKSUM_CCITT               2
> > > >> +#define RAVE_SP_CHECKSUM_SIZE                RAVE_SP_CHECKSUM_CCITT
> > > >>  /*
> > > >>   * We don't store STX, ETX and unescaped bytes, so Rx is only
> > > >>   * DATA + CSUM
> > > >> @@ -415,7 +417,12 @@ static void rave_sp_receive_frame(struct
> rave_sp *sp,
> > > >>       const size_t payload_length  = length - checksum_length;
> > > >>       const u8 *crc_reported       = &data[payload_length];
> > > >>       struct device *dev           = &sp->serdev->dev;
> > > >> -     u8 crc_calculated[checksum_length];
> > > >> +     u8 crc_calculated[RAVE_SP_CHECKSUM_SIZE];
> > > >> +
> > > >> +     if (unlikely(length > sizeof(crc_calculated))) {
> > > >
> > > > Forgive me if I have this wrong (it's still very early here), but this
> > > > doesn't leave any room for the payload?
> > > >
> > > >     <--       length         -->
> > > >     <ck len><- payload length ->
> > > >     [CK][CK][D][A][T][A] .. [64]
> > > >
> > > > It is my hope that length would always be larger than the size of the
> > > > checksum, or else there would never be any data?
> > > >
> > > > Should this not be:
> > > >
> > > >     if (unlikely(length > RAVE_SP_MAX_DATA_SIZE))
> > >
> > > Oh, whoops, no, this should be:
> > >
> > > +     if (unlikely(checksum_lengh > sizeof(crc_calculated))) {
> > >
> > > (To validate the VLA max size.)
> 
> > That doesn't match the OP's error message though:
> 
> >    dev_warn(dev, "Dropping oversized frame\n");
> 
> > Which I assume is designed to complement the existing warning:
> 
> >    if (unlikely(length <= checksum_length))
> >            dev_warn(dev, "Dropping short frame\n");

[MOVING - Please don't top post - reply in-line] 

> The error message is also wrong. Would "Checksum length too large" be fine?

"Checksum too long, dropping" ?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
