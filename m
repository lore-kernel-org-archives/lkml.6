Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5296F20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBKH0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:26:21 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:38889 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfBKH0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:26:21 -0500
Received: from erd987 (erd987.prtnl [192.168.237.3])
        by sparta (Postfix) with ESMTP id 2CA3F44A00D2;
        Mon, 11 Feb 2019 08:27:36 +0100 (CET)
Date:   Mon, 11 Feb 2019 08:26:19 +0100
From:   Robin van der Gracht <robin@protonic.nl>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: ht16k33: fix potential user-after-free on
 module unload
Message-ID: <20190211082619.14d3f6f1@erd987>
In-Reply-To: <20190209001522.GA11769@gmail.com>
References: <20190209001522.GA11769@gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2019 01:15:22 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On module unload/remove, we need to ensure that work does not run
> after we have freed resources. Concretely, cancel_delayed_work()
> may return while the callback function is still running.
> 
> From kernel/workqueue.c:
> 
>     The work callback function may still be running on return,
>     unless it returns true and the work doesn't re-arm itself.
>     Explicitly flush or use cancel_delayed_work_sync() to wait on it.
> 
> Link: https://lore.kernel.org/lkml/20190204220952.30761-1-TheSven73@googlemail.com/
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index a43276c76fc6..21393ec3b9a4 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -509,7 +509,7 @@ static int ht16k33_remove(struct i2c_client *client)
>  	struct ht16k33_priv *priv = i2c_get_clientdata(client);
>  	struct ht16k33_fbdev *fbdev = &priv->fbdev;
>  
> -	cancel_delayed_work(&fbdev->work);
> +	cancel_delayed_work_sync(&fbdev->work);
>  	unregister_framebuffer(fbdev->info);
>  	framebuffer_release(fbdev->info);
>  	free_page((unsigned long) fbdev->buffer);

Looks good

Acked-by: Robin van der Gracht <robin@protonic.nl>
