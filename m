Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1493CC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E352147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBNNzcf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E352147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJFOEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:04:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJFOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:04:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so5754416pfe.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yxuvBu+Fwt+lK+efudO8FJo6vyjQWM3N8/U9NFmxvos=;
        b=NBNNzcf+XT2vcflggfwGxwcUwEbcV+4BoJavPuiIXo92PniznQvrxXkzH2mi7Ok5sm
         ZsU/OCdsuCkHOwhUI/VGSbQ5R35qXCcRmM32NLxVnGTZx970MtD3IeYlUY0UNDQwPZVq
         vsLh01rG+tMjRWRLgKa/cFyR39gz878jTGLoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxuvBu+Fwt+lK+efudO8FJo6vyjQWM3N8/U9NFmxvos=;
        b=ACMNDL1+VbFavYoCmauefey5+WXo1B5EG62ot4T/bwEvwDq0qWIDbml8zl6fWwj1TT
         BvYZKeQEZq7RWq65SymUm+QIstF55G3WSmLXS42daA8U8NKQocWETPNp70GQntG93PoK
         d6ZqEVgoCa6v0vTpgEHOdfELXZqy/48ifbIiOqx4nePSKZ1Z/xrs8CXYRvnvP13uA8a6
         MlDnjFE2t91DgMaEU6nj211jP87bhnqw2IzXueW1EstJbmd+M6b9Nsi2LBQnxzprtGzm
         GnbJ5D8/2rmq5I5hCEZYEzV5FKFDk8wYyrk0wTH1S+nR4ZJFtkPmLvVBcA2fg8RXIxUD
         lb5A==
X-Gm-Message-State: ABuFfohiL3ID6tmNN8DMBNWHn42v5cRxfSR6pNZQS6qDFcVhnM0c9bMb
        U7uyzcv6YH0GiSdbDuoFQ14y7Q==
X-Google-Smtp-Source: ACcGV60dGSKOxXNr63g3bSD2U1+VM5YZuF2x7KTrzF1isi7pBVPzBtAzQZonbp4SGaT2JDqwz8iFZw==
X-Received: by 2002:a62:1407:: with SMTP id 7-v6mr15150079pfu.28.1538809356673;
        Sat, 06 Oct 2018 00:02:36 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g123-v6sm749112pfc.67.2018.10.06.00.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 00:02:35 -0700 (PDT)
Date:   Sat, 6 Oct 2018 00:05:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20181006070521.GM12063@builder>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Sep 08:08 PDT 2018, Arnd Bergmann wrote:

[..]
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a76b963a7e50..02aefb2b2d47 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -285,7 +285,7 @@ static const struct file_operations rpmsg_eptdev_fops = {
>  	.write = rpmsg_eptdev_write,
>  	.poll = rpmsg_eptdev_poll,
>  	.unlocked_ioctl = rpmsg_eptdev_ioctl,
> -	.compat_ioctl = rpmsg_eptdev_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  
>  static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> @@ -446,7 +446,7 @@ static const struct file_operations rpmsg_ctrldev_fops = {
>  	.open = rpmsg_ctrldev_open,
>  	.release = rpmsg_ctrldev_release,
>  	.unlocked_ioctl = rpmsg_ctrldev_ioctl,
> -	.compat_ioctl = rpmsg_ctrldev_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  

For rpmsg part

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
