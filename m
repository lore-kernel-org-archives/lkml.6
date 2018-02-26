Return-Path: <wens213@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519642571; cv=none;
        d=google.com; s=arc-20160816;
        b=MEo/x5MYxl9MJqLHtaRQqaQKxwWaAeliIMlspIgt905Ax2Sc0Ex9ElXB4iVE4M8okN
         GgbZJnMga4F+L6/hPq0zpyurzR0ICWG9Ql/uOPY3/Dqsngx1GO2dCB6Lm/n1hznCVcsP
         AbkL8mYMhPXTEUB8ZfxPl9KBxefNx/TmfPsT/fBKuoqiRqmuz1wqaqORXyKfEjHV3pDg
         xG0M4GbatBr21veQa85g3md8uqNwnPuDyHNwsm2yPtb1NaV2RfcayKEwy5JusmUxvjat
         Zn7BV+aBaCfDnpQZt771icP7Sviqttn9A1pgSbYOt3OKox3uLRlsG3m7JaYXFsI2YqsL
         u6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=c1utdkuMGpeBBJUiolJzXdcYE2q2Qe1AR3rg5RHbH+A=;
        b=pbdvY1WJ5g3JQu27/qWRhYDc2JuPzXsQIjFz6u77qajDSJ1mj34xjTjTOYCIs9UuZh
         pRnuwAgrF33jWQt4/Wlgu0PXJnAzd0bl97A3/32+Ce/xkbtyl8YSEj/pAzmdzbQcTWMl
         nwn8GwGFaDjkVKms7ggjPe4avcCZnppy188prO91yOtEwbT75q9ejI0y2oxXXarSunaG
         OpssipPlKWXzhxRThTaNA1NJUANJH//1PipP1qYmFPFUtJpv1XnssRpzQf1jVBfj/fM8
         /FRm//dwl7DIDD0cl+OQQfeyelZtWU9zv61o8gzylJroddNr66IUlFx8PI6aUfVLHx9W
         3Klg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wens213@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wens213@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wens213@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wens213@gmail.com
X-Google-Smtp-Source: AH8x224JcIry8a39nmNBCwyVib9ZkE6oVl6S0uMkRb07SAMfP9cs94cciuDquf5ZEzqh/06ei+2hfw==
MIME-Version: 1.0
In-Reply-To: <20180226105359.k5a3rz2wow4gweba@flea.lan>
References: <20180223131112.715992-1-arnd@arndb.de> <20180226092129.t4uogg2q7jkeolbu@flea.lan>
 <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com> <20180226105359.k5a3rz2wow4gweba@flea.lan>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 26 Feb 2018 18:55:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v64RKGMMMF+KZdfVq6BgheAYSJYmb=kg_a0hSp153hNT2Q@mail.gmail.com>
Message-ID: <CAGb2v64RKGMMMF+KZdfVq6BgheAYSJYmb=kg_a0hSp153hNT2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: link in front-end code if needed
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>, Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Liu <net147@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593460729224146475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 6:53 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Mon, Feb 26, 2018 at 10:31:51AM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2018 at 10:21 AM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > Hi,
>> >
>> > On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
>> >> When the base sun4i DRM driver is built-in but the back-end is
>> >> a loadable module, we run into a link error:
>> >>
>> >> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
>> >> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'
>> >>
>> >> The dependency is a bit tricky, the best workaround I have come up
>> >> with is to use a Makefile hack to to interpret both
>> >> CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
>> >> as a directive to build the front-end the same way as the main module.
>> >>
>> >> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >> ---
>> >>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
>> >>  1 file changed, 4 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
>> >> index 582607c0c488..db14e023256b 100644
>> >> --- a/drivers/gpu/drm/sun4i/Makefile
>> >> +++ b/drivers/gpu/drm/sun4i/Makefile
>> >> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)             += sun4i-tcon.o
>> >>  obj-$(CONFIG_DRM_SUN4I)              += sun4i_tv.o
>> >>  obj-$(CONFIG_DRM_SUN4I)              += sun6i_drc.o
>> >>
>> >> -obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o sun4i-frontend.o
>> >> +obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o
>> >> +ifdef CONFIG_DRM_SUN4I_BACKEND
>> >> +obj-$(CONFIG_DRM_SUN4I)              += sun4i-frontend.o
>> >> +endif
>> >
>> > Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
>> > and we would export the symbol?
>>
>> Yes, I think that would work just as well. Something like
>>
>> config DRM_SUN4I_FRONTEND
>>       tristate
>>       default DRM_SUN4I if CONFIG_DRM_SUN4I_BACKEND != n
>>
>> should do the trick.
>
> I had more something like this in mind:
> https://pastebin.com/raw/XydvzAtz

This doesn't solve the issue at hand, which is sun4i-drv (CONFIG_DRM_SUN4I)
requires something in sun4i-backend (CONFIG_DRM_SUN4I_BACKEND), and if
sun4i-drv is built-in, then anything it uses must also be built-in.

ChenYu
