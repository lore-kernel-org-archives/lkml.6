Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F5D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLvA6LMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfBZTiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:38:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35767 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBZTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:38:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so4638617pgd.2;
        Tue, 26 Feb 2019 11:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Za1rHEA44G+ourb0ou/9m8sx/WvRkTCqjyf4XothILY=;
        b=XLvA6LMU5FI5gZRBcQF+jskEeZ1gsPsBMJKj5O+MDPpaypxb7xSt7fPb2YbaJYiBOK
         Tk71aYzf4rcxxP0HWwO+tmXX/57A2O7PqUkymIX9d3zZPWYMb/ZyMcGe7mwbwS3faKVr
         M0aRytIfExuI+Jj7uODUmFUQVQMcPgsMsXeybyDteaLJ/F/GHkK1AQ67mGnFbDyp5sQ+
         SstYbtfggTk6kxRWCL075lrD+gFearu6bGehYm9ibc20T7utJ67HnBXDcZmbjB9n7BX2
         1mnYm/HFfqvhFXFE0RfRXBfygRafAj89UP119w8L9QWTxNtlbFdopc9xXEbl3L/ohZLF
         lzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Za1rHEA44G+ourb0ou/9m8sx/WvRkTCqjyf4XothILY=;
        b=nwuE66eIZTrUMzVhPnvjpBQsZKs7RsRthPE+TG91+huA+RI/6euEnUT/Pt2/vbqjkw
         q63JpilDbALiS3zpH6YPU1I/9rlxkWPvxyy4gjTN63j7eImYzTp3MMPT/v6aeDzfODNZ
         pt6d608CdAopv+LTzn0mgBvuWkvcAtlnQSGCrUL6ZKw/MXGvgYURnfvN+vlItp9BZpBW
         oE5rU8BkxNJBMxDJ2y+eAn21ZFOxr+1wXnmdEm2V7DAAvGjT8AXcPuafGYLt0RtuSBp6
         eOQ2/8vvt3+n5fayie22DEn3xeKfmdG3kg1s/uA5VX9luizailp7oWp4TITuYZ/HRBUy
         ZfDg==
X-Gm-Message-State: AHQUAuakJDy5Ti3zqs9WbgU4yP5XemVh+PmeoC/HRrOuzZLlBjls9j5C
        iMh7KcFM+EENGyKZ7pK4ed4=
X-Google-Smtp-Source: AHgI3IaZlhvL4eF79Az8z35iGaSft5nb6MMWEoJKAuQHY5SMNFj2LDeyAkapwf1f7kArD9Aw4F6coQ==
X-Received: by 2002:a63:a5b:: with SMTP id z27mr25481256pgk.78.1551209888169;
        Tue, 26 Feb 2019 11:38:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e22sm696716pfi.126.2019.02.26.11.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:38:06 -0800 (PST)
Date:   Tue, 26 Feb 2019 11:38:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] hwmon: (emc1403) Add support for EMC1444
Message-ID: <20190226193805.GA17740@roeck-us.net>
References: <d15100263e8c5f697fde75dc54cae61f17ac15f3.1551195079.git.sramani@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15100263e8c5f697fde75dc54cae61f17ac15f3.1551195079.git.sramani@mellanox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:40:05AM -0500, Shravan Kumar Ramani wrote:
> EMC1444 is compatible with EMC1404. Add it to device ID table.
> 

Is that some super-secretive chip ? The Microchip website completely fails
to provide information about it. It lists a chip with that name under
"Microcontrollers and Processors", but with no documentation whatsoever.
And it seems like similar secretive chips such as emc1442 may exist as well.
I am hesitant to approve this without datasheet. The chips in this series
have a lot of registers, and I don't really trust the vendor to be
consistent across chip generations - even more so if they think that
they need to keep datasheets (and even basic information about the chip)
under wrap.

Until more information is available, I would suggest to instantiate
the chip as emc1424.

Guenter

> Reviewed-by: David Thompson <dthompson@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/hwmon/emc1403.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index bdab47a..88f6a40 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -453,6 +453,7 @@ static const struct i2c_device_id emc1403_idtable[] = {
>  	{ "emc1422", emc1402 },
>  	{ "emc1423", emc1403 },
>  	{ "emc1424", emc1404 },
> +	{ "emc1444", emc1404 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
> -- 
> 2.1.2
> 
