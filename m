Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519637511; cv=none;
        d=google.com; s=arc-20160816;
        b=ETA7Gfgx5sPNuezqShl5kP/ENaOwd1MUTy9HFi3Hd1j0nIWG5KuMPR7hnHlNXm2pFs
         sK8V6c/TqLOqKa5zbVZzOryhr1jesLu2JT1CT+R5gKv5qynHhXH6YFD8ZSovWsgdFrpB
         Yl4vUXhHmnV7+su3ezHQ7m8fmxRZRUIHkd8k90rqpVqhi1bry6XV5UQDwO/Qt679y1SW
         sTpYzJUUtp9BwOn9zKrnIeL4xbIVdvwhWNzXExgOFBnthiduldBForlDD7slNWZ3/0H6
         wfRrd7gFLDwmNS+LoKdXwpDaP8+8yQO2l2AC5nxB6YeRHumDK5beFYLO0XFnbq22jzXI
         XDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=y50iX3+O3Yraxh4GoV9sqYcUGQMxK0yx59dpWj08YhI=;
        b=lSywd68kiGvUlBnIwWOu0KSGyl/QSP+405Mb8NAXFJEsMpArnCDbiCgpO/8kOqZQ0m
         cE1vBymImtEcEAJuCy1koPhFXAxFbc4rj9ARi1oDKtjA15yl/pvxr9IyfOHym6eU0NwS
         yyD+hYvrtLUIEgi/7ruhZsolNLOjr76WyIbU7MyrOxKbZ4ASgTbQRoy92q63YKdxG/Yi
         hpaXqibAllyCubs3NcD16G8O0IIkC60Peg4/BGQgqjs4tcII45OlDBsrdBfvmbYcvDui
         hD+XjIpjbVvAQOZPI/vNrHeqVOEkrTXC1fqWjPp/4Y4DPqMg6QU2kUHgEIVG9LEpm6R7
         hdBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U4+sPzqv;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U4+sPzqv;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELsPi2YL7dUVhNu5XxYy1NqywRlnEFTMdP47pNZjyy0qO/2tG3tycYaUr7ZLFzcHXFnLmjUEkU18TQ2IYlFDD9g=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180226092129.t4uogg2q7jkeolbu@flea.lan>
References: <20180223131112.715992-1-arnd@arndb.de> <20180226092129.t4uogg2q7jkeolbu@flea.lan>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 10:31:51 +0100
X-Google-Sender-Auth: E3fiwUtgXjDE0B6pl-6otR93VDk
Message-ID: <CAK8P3a1w=hLzZLPe1TURPyyu5oxpG8yD0eb_8GrVviUODy0zqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: link in front-end code if needed
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
	Jernej Skrabec <jernej.skrabec@siol.net>, Icenowy Zheng <icenowy@aosc.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Liu <net147@gmail.com>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197807586940998?=
X-GMAIL-MSGID: =?utf-8?q?1593455423454367326?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:21 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
>> When the base sun4i DRM driver is built-in but the back-end is
>> a loadable module, we run into a link error:
>>
>> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
>> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'
>>
>> The dependency is a bit tricky, the best workaround I have come up
>> with is to use a Makefile hack to to interpret both
>> CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
>> as a directive to build the front-end the same way as the main module.
>>
>> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
>> index 582607c0c488..db14e023256b 100644
>> --- a/drivers/gpu/drm/sun4i/Makefile
>> +++ b/drivers/gpu/drm/sun4i/Makefile
>> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)             += sun4i-tcon.o
>>  obj-$(CONFIG_DRM_SUN4I)              += sun4i_tv.o
>>  obj-$(CONFIG_DRM_SUN4I)              += sun6i_drc.o
>>
>> -obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o sun4i-frontend.o
>> +obj-$(CONFIG_DRM_SUN4I_BACKEND)      += sun4i-backend.o
>> +ifdef CONFIG_DRM_SUN4I_BACKEND
>> +obj-$(CONFIG_DRM_SUN4I)              += sun4i-frontend.o
>> +endif
>
> Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
> and we would export the symbol?

Yes, I think that would work just as well. Something like

config DRM_SUN4I_FRONTEND
      tristate
      default DRM_SUN4I if CONFIG_DRM_SUN4I_BACKEND != n

should do the trick.

      Arnd
