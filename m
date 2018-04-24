Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524587074; cv=none;
        d=google.com; s=arc-20160816;
        b=A6eQUj2BuKwD+cfnbnYDIo5LRqW5Os/TLfXqquSXGrUeMO5a1SzGQYucPPxP6BsrFu
         LpcWgAhkyutOZfBKXJOwJix3UmHnby6r//Fhtw1/yfYMdIZl457h7rnykh/5rmtN0ycK
         A5UyJBl0lWnYwD+7SGVleG4oyX1l5P8gEkgWqLWYbrbUZll2PSOT/c/z/5XdODMsPtqO
         z1c9tM3vHtau2Z9HZSfAdKc7Dbx6XknQ+DEKhf3VQBf7xgZyC4QISKOAT+Q0G4DI2HUZ
         V/W7m4ymZG+y2SGLIXTodF8PvEQdR4y9UKgCCG8KC9uUu96uqByeXSSWkY9goqKESEC0
         cfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aLbYM1iTOq8yESyp7OYNq+RNrJFqmgTC3MtRcn3OQpU=;
        b=OiOixpvuTUtvuF+zRlE8JAVe5DDumzi9AUKINIgf7RRCcs+vKFWqRNou4Lo/GUVGny
         86SZk6cmtIVLGYFe+pr5yFYABsP1wFHJMNPW+QmDZk0Wk5uZkbVITbswDul9Q8LGPuBg
         mzx7HqIoorlA5D+j6Rfhz0Ie/3xqz12McYXbkkpYoFHvFUJHIo+VeafKgwQD973irWg7
         4+Jr7AM7SXJwL1EAQ1Ng+ZeKEwWn0F+862jGXoHNvKRFQHjcTSNmutrJyrATt8pGrX03
         uU6+1U18ytsqvY6pb+RnoD6QzigMrpqa4WHVEgnSbRIV1EdNUF+RSbouXeN5RXj2Vwy1
         mgqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A7dKUyRz;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A7dKUyRz;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp9q58RabYpcmg+JURSy6Uy7c8druF93Z+/yLNwAZI7Y00bQikIbE2L4jjdEINbMH3dIKY37siPnRYoQTkzNwQ=
MIME-Version: 1.0
In-Reply-To: <20180424074459.7215-1-k.marinushkin@gmail.com>
References: <20180424071618.GB17825@kroah.com> <20180424074459.7215-1-k.marinushkin@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Apr 2018 19:24:33 +0300
Message-ID: <CAHp75VecPW_v0r+L01jWubASMAQ4iCoUX4G3pcyfzn9Gf21CtQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, devel@driverdev.osuosl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598645415771287281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:44 AM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.


> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org

AFAIR I gave you a tag and you again missed it.
Before sending anything just check twice if all prerequisites are fulfilled.

And yes, kbuild bot is right. You need to return known value.

-- 
With Best Regards,
Andy Shevchenko
