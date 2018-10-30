Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6A4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA5D2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA5D2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJ3Q2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:28:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49285 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3Q2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:28:34 -0400
Received: from 79.184.254.164.ipv4.supernova.orange.pl (79.184.254.164) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 0ca77da22243f3c6; Tue, 30 Oct 2018 08:36:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: manual merge of the pm tree with the i2c tree
Date:   Tue, 30 Oct 2018 08:32:44 +0100
Message-ID: <2537174.pOy5YHgAEX@aspire.rjw.lan>
In-Reply-To: <20181029130925.60ea7830@canb.auug.org.au>
References: <20181029130925.60ea7830@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 29, 2018 3:09:25 AM CET Stephen Rothwell wrote:
> 
> --Sig_/Yi5UDAd5LU=QdOHo+ui7Syk
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,
> 
> Today's linux-next merge of the pm tree got conflicts in:
> 
>   drivers/i2c/busses/i2c-designware-baytrail.c
>   drivers/i2c/busses/i2c-designware-core.h
> 
> between commit:
> 
>   9cbeeca05049 ("i2c: designware: Remove Cherry Trail PMIC I2C bus pm_disab=
> led workaround")
> 
> from the i2c tree and commit:
> 
>   8afb46804dfa ("i2c: designware: Cleanup bus lock handling")
> 
> from the pm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> --=20
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/i2c/busses/i2c-designware-baytrail.c
> index 9ca1feaba98f,971b5cde7a93..000000000000
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@@ -162,18 -36,9 +36,9 @@@ int i2c_dw_probe_lock_support(struct dw
>   		return -EPROBE_DEFER;
>  =20
>   	dev_info(dev->dev, "I2C bus managed by PUNIT\n");
> - 	dev->acquire_lock =3D baytrail_i2c_acquire;
> - 	dev->release_lock =3D baytrail_i2c_release;
> + 	dev->acquire_lock =3D iosf_mbi_block_punit_i2c_access;
> + 	dev->release_lock =3D iosf_mbi_unblock_punit_i2c_access;
>  -	dev->pm_disabled =3D true;
>  +	dev->shared_with_punit =3D true;
>  =20
> - 	pm_qos_add_request(&dev->pm_qos, PM_QOS_CPU_DMA_LATENCY,
> - 			   PM_QOS_DEFAULT_VALUE);
> -=20
>   	return 0;
>   }
> -=20
> - void i2c_dw_remove_lock_support(struct dw_i2c_dev *dev)
> - {
> - 	if (dev->acquire_lock)
> - 		pm_qos_remove_request(&dev->pm_qos);
> - }
> diff --cc drivers/i2c/busses/i2c-designware-core.h
> index 9ec8394f4787,152bf56d8404..000000000000
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@@ -209,10 -208,9 +208,9 @@@
>    * @fp_lcnt: fast plus LCNT value
>    * @hs_hcnt: high speed HCNT value
>    * @hs_lcnt: high speed LCNT value
> -  * @pm_qos: pm_qos_request used while holding a hardware lock on the bus
>    * @acquire_lock: function to acquire a hardware lock on the bus
>    * @release_lock: function to release a hardware lock on the bus
>  - * @pm_disabled: true if power-management should be disabled for this i2c=
> -bus
>  + * @shared_with_punit: true if this bus is shared with the SoCs PUNIT
>    * @disable: function to disable the controller
>    * @disable_int: function to disable all interrupts
>    * @init: function to initialize the I2C hardware
> @@@ -263,10 -260,9 +261,9 @@@ struct dw_i2c_dev=20
>   	u16			fp_lcnt;
>   	u16			hs_hcnt;
>   	u16			hs_lcnt;
> - 	struct pm_qos_request	pm_qos;
> - 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
> - 	void			(*release_lock)(struct dw_i2c_dev *dev);
> + 	int			(*acquire_lock)(void);
> + 	void			(*release_lock)(void);
>  -	bool			pm_disabled;
>  +	bool			shared_with_punit;
>   	void			(*disable)(struct dw_i2c_dev *dev);
>   	void			(*disable_int)(struct dw_i2c_dev *dev);
>   	int			(*init)(struct dw_i2c_dev *dev);
> 
> --Sig_/Yi5UDAd5LU=QdOHo+ui7Syk
> Content-Type: application/pgp-signature
> Content-Description: OpenPGP digital signature
> 
> 
> --Sig_/Yi5UDAd5LU=QdOHo+ui7Syk--
> 

The fix looks good to me, thanks!

Cheers,
Rafael


