Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeFDVxp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:53:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43052 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:53:43 -0400
X-Google-Smtp-Source: ADUXVKJYsK2MrzyBskJqiPoR95Riv7NA2Qf3mk68UGDrchJhZk56VUrRA10VGc0wDIGGnqLsdn2vtQ==
Date: Mon, 4 Jun 2018 14:53:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chenhong3@huawei.com, ravisadineni@google.com, dtor@google.com,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: Re: [PATCH V2] i8042: Increment wakeup_count for the respective port.
Message-ID: <20180604215339.GG164893@dtor-ws>
References: <20180601180053.120202-1-ravisadineni@chromium.org>
 <20180602010708.152025-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602010708.152025-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:07:08PM -0700, Ravi Chandra Sadineni wrote:
> Call pm_wakeup_event on every irq. This should help us in identifying if
> keyboard was a potential wake reason for the last resume.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> V2: Increment the wakeup count only when there is a irq and not when the
> method is called internally.
> 
> drivers/input/serio/i8042.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 824f4c1c1f310..2bd6f2633e29a 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>  	port = &i8042_ports[port_no];
>  	serio = port->exists ? port->serio : NULL;
>  
> +	if (irq && serio && device_may_wakeup(&serio->dev))
> +		pm_wakeup_event(&serio->dev, 0);

The constant checks for device_may_wakeup() before calling
pm_wakeup_event()needed to avoid warnings in wakeup_source_activate()
(?) are annoying. Rafael, can we move the check into
pm_wakeup_dev_event()?

I am also confused when pm_wakeup_event() vs pm_wakeup_hard_event() vs
pm_wakeup_dev_event() should be used, if any. Is there any guidance?

> +
>  	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
>  		   port_no, irq,
>  		   dfl & SERIO_PARITY ? ", bad parity" : "",
> -- 
> 2.17.1.1185.g55be947832-goog
> 

Thanks.

-- 
Dmitry
