Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEDHeN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:34:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56012 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeEDHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:34:11 -0400
X-Google-Smtp-Source: AB8JxZrmCyAdY9pnj6qLfgu3VyiEx843hQz1shPv6i+sfrAUjsOCW5y3h9Wr2OQlaPPN14HIx5Sumg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2] Input: i8042 - Fix KBD port cannot wake up system from
 suspend-to-idle
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180419084951.25130-1-kai.heng.feng@canonical.com>
Date: Fri, 4 May 2018 15:34:04 +0800
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <58201402-7316-4F7A-8D28-DAD694017536@canonical.com>
References: <20180419084951.25130-1-kai.heng.feng@canonical.com>
To: dmitry.torokhov@gmail.com
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> On Apr 19, 2018, at 4:49 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>
> From: Kai Heng Feng <kai.heng.feng@canonical.com>
>
> Commit f13b2065de81 ("Input: i8042 - allow KBD and AUX ports to wake up
> from suspend-to-idle") make system in s2idle can be woken up by i8042
> keyboard, but it's disabled by default.
>
> In commit 3e6e15a862a0 ("Input: enable remote wakeup for PNP i8042
> keyboard ports") states that "Keyboard ports are always supposed to be
> wakeup-enabled", it should be enabled by default. Keyboard wakeup from
> s2idles is also the default behavior for other x86 OSes.
>
> In addition to PNP port, enable keyboard wakeup from serio port by
> default for x86 systems.

Is there any improvement that I can make to let this patch gets merged?

Kai-Heng

>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> Keep the PNP wakeup part.
> Only enable for x86 systems.
> Update commit message.
>
>  drivers/input/serio/i8042.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 824f4c1c1f31..0b6878e8037b 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -1400,6 +1400,12 @@ static void __init i8042_register_ports(void)
>  				i8042_ports[i].irq);
>  			serio_register_port(serio);
>  			device_set_wakeup_capable(&serio->dev, true);
> +
> +#ifdef CONFIG_X86
> +			/* Keyboard ports are always supposed to be wakeup-enabled */
> +			if (i == I8042_KBD_PORT_NO)
> +				device_wakeup_enable(&serio->dev);
> +#endif
>  		}
>  	}
>  }
> -- 
> 2.17.0
