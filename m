Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBWCpz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:45:55 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39422 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBWCpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:45:54 -0500
X-Google-Smtp-Source: AH8x225uXxH9jyPvIs5gNkPrPWfJIkl7P071wH/Tbnb51CtbQKdDSnN+vweowAw3qV5lONGAKezSXw==
Date: Fri, 23 Feb 2018 10:43:20 +0800
From: Peng Fan <van.freenix@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: jens.wiklander@linaro.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tee: correct max value for id allocation
Message-ID: <20180223024320.GA321@shlinux2>
References: <20180115092735.20969-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115092735.20969-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Any comments on this patch?

Thanks,
Peng
On Mon, Jan 15, 2018 at 05:27:35PM +0800, Peng Fan wrote:
>The privileged dev id range is [TEE_NUM_DEVICES / 2, TEE_NUM_DEVICES).
>The non-privileged dev id range is [0, TEE_NUM_DEVICES / 2).
>
>So when finding a slot for them, need to use different max value.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>Cc: Jens Wiklander <jens.wiklander@linaro.org>
>---
> drivers/tee/tee_core.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>index 3d49ac2e3c84..d1f4ecdbc8cc 100644
>--- a/drivers/tee/tee_core.c
>+++ b/drivers/tee/tee_core.c
>@@ -701,7 +701,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
> {
> 	struct tee_device *teedev;
> 	void *ret;
>-	int rc;
>+	int rc, max_id;
> 	int offs = 0;
> 
> 	if (!teedesc || !teedesc->name || !teedesc->ops ||
>@@ -715,16 +715,20 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
> 		goto err;
> 	}
> 
>-	if (teedesc->flags & TEE_DESC_PRIVILEGED)
>+	max_id = TEE_NUM_DEVICES / 2;
>+
>+	if (teedesc->flags & TEE_DESC_PRIVILEGED) {
> 		offs = TEE_NUM_DEVICES / 2;
>+		max_id = TEE_NUM_DEVICES;
>+	}
> 
> 	spin_lock(&driver_lock);
>-	teedev->id = find_next_zero_bit(dev_mask, TEE_NUM_DEVICES, offs);
>-	if (teedev->id < TEE_NUM_DEVICES)
>+	teedev->id = find_next_zero_bit(dev_mask, max_id, offs);
>+	if (teedev->id < max_id)
> 		set_bit(teedev->id, dev_mask);
> 	spin_unlock(&driver_lock);
> 
>-	if (teedev->id >= TEE_NUM_DEVICES) {
>+	if (teedev->id >= max_id) {
> 		ret = ERR_PTR(-ENOMEM);
> 		goto err;
> 	}
>-- 
>2.14.1
>

-- 
