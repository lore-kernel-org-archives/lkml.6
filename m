Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeCILFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:05:21 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44923 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeCILFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:05:19 -0500
X-Google-Smtp-Source: AG47ELvLpHs9K9QBcVEACvrBRCNydRKjZ9u5mr/tEJlsDRMs3lYqzVsazaNfdrpr90gwfY2HDpTmjA==
Date: Fri, 9 Mar 2018 16:35:10 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] iio: potentiometer: ds1803: Remove VLA usage
Message-ID: <20180309110510.GB7786@himanshu-Vostro-3559>
References: <1520534733-1743-1-git-send-email-himanshujha199640@gmail.com>
 <CAGXu5jJzLczSzfJtWbhTUqAYXRG_-zKf2x8cz8jrAxu+XjkYdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJzLczSzfJtWbhTUqAYXRG_-zKf2x8cz8jrAxu+XjkYdQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:39:15AM -0800, Kees Cook wrote:
> On Thu, Mar 8, 2018 at 10:45 AM, Himanshu Jha
> <himanshujha199640@gmail.com> wrote:
> > In preparation to enabling -Wvla, remove VLA usage and replace it
> > with fixed a fixed length array and therefore, prevent potential
> > stack overflow attacks.
> >
> > Fixed as a part of the discussion to remove all VLAs from the kernel:
> > https://lkml.org/lkml/2018/3/7/621
> >
> > Cc: keescook@chromium.org
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >  drivers/iio/potentiometer/ds1803.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> > index 9b0ff4a..6bf12c9 100644
> > --- a/drivers/iio/potentiometer/ds1803.c
> > +++ b/drivers/iio/potentiometer/ds1803.c
> > @@ -64,7 +64,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
> >         struct ds1803_data *data = iio_priv(indio_dev);
> >         int pot = chan->channel;
> >         int ret;
> > -       u8 result[indio_dev->num_channels];
> > +       u8 result[ARRAY_SIZE(ds1803_channels)];
> 
> It seems like num_channels is always ARRAY_SIZE(ds1803_channels).
> Could the entire field be dropped?

If you're asking to remove num_channels then certainly it is not
possible
since it is a member of industrial I/O device struct and it is not just
a member of regular struct local to this file.

We certainly know that there are only two channels BTW and it can be
tranformed to simply:

        u8 result[2];

But then I might have to add an additional comment explaining the magic
number 2.

-- 
Thanks
Himanshu Jha
