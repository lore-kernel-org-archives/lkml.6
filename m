Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A591C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C396320877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j3tbSlv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C396320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeIYLX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:23:59 -0400
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:49328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbeIYLX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHz6ywJUakmO1w+5vS96ioWukq50f7LrRpFGsiOre34=;
 b=j3tbSlv2gEa2NrWjFeKC8cBsjUuOZUC9ewFdSfqlQwI3jQWNdUakcUnCJN8BDWZ3i0/M8wnHcsPiog+cezAE2HjRZnIPQ1iKH/hNmZWkx/SX4biExDKPxXHZadylY7JZyqS88bBHHeJVLYOhhwQd84QQTAy1ejU8Hn4h9UuB74A=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4891.namprd02.prod.outlook.com (20.176.111.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Tue, 25 Sep 2018 05:18:08 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::8cc4:fb25:d431:bd00%3]) with mapi id 15.20.1164.024; Tue, 25 Sep 2018
 05:18:04 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sdhci: arasan: Add runtime PM support
Thread-Topic: [PATCH] sdhci: arasan: Add runtime PM support
Thread-Index: AQHUT2DfrKnKsMKzpUmVgNOoErqLNqUAfzYQ
Date:   Tue, 25 Sep 2018 05:18:03 +0000
Message-ID: <DM6PR02MB52271FEA75D6AF49A345FC9BC1160@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4891;6:nXKx4WWowZDr0ZXBnFan8yVmGQZm6/vc/DZdPLMJXPgqDLDLNaN3PpXpJWzmo3K++J4QpQPRNx3bs8NLjKqhs18LsE/0dcrwbogVe+kV9UO26GMgJndArtjeOiju6PoW0cyMPaPr1I2lhPZr9D3XoU03gT7v571ISBBJGEQJ3vZbAkt2yhFrPsqh14Lh9vuz/Z0F6WGd25yR79N2c3v8NROSGyR7nui8PC1vd32c12k0y7Sf+RFdK1liI6vg9TccmjfOl5inMUs3k8SMFAls+CLumPlN1b0a5OwBiPhDcUOVvtx9bZMxhogfHVHy7Ul6g53p5AXyRcM9vqEK1hJzH7X83TZqqn9ga/niid7ykg+bJtL0MOp/p9OII8pxWWV7ELvpLAR3UdriNb4Hgebkg/jD2tob8/UE48ORbLF+6qy+3H0TcfRYdasmKHZQ9VJO7cw8OCCp8KQ6EmC4a5v6/A==;5:VfgVD7lOdDUeX7quDQ6D5RrqdJXortQy5xcz2kaIE3YLWmGCtMF0OdkoiR3K0PX9zCPTbri4mfLwRRMVamUADQ+maXuV/uXnPf7QcGj7xZuaSmX+2us3OtJY+CBHSWSwxKMCxoHjZBEQeiQtLak1jFOEn6bYr6ZAbKXgtZ6bzoQ=;7:HEvD5tuYKINeAIjTIuLO30UxxPnCsGD494ifPwdQoFNp0KSAP0eqo/ksuqCQwBndaECxjbTN+IGEbx1bYxS2+NAzxblMpdqptapSsjMlVLqA3xG2+PGDra9zQTtmAArqN0MalFNXeyeOo3QhRU/9oP1vB/Izj+OmC2qJ3Abb9I63sxBUyr/4CG8XgXIhyR9SZnqrX605+DdcKTLMJTr23HSZDQEDUA6SEsHQDi92SJBo3PFomhVJJZMwHiY39HgR
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8461b941-4d06-495d-d5a0-08d622a64531
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4891;
x-ms-traffictypediagnostic: DM6PR02MB4891:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB4891AD288E07EE99BE7B953BC1160@DM6PR02MB4891.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(228905959029699)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM6PR02MB4891;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4891;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(189003)(199004)(3846002)(25786009)(106356001)(6246003)(2501003)(71190400001)(71200400001)(74316002)(86362001)(575784001)(8676002)(5250100002)(53936002)(5660300001)(68736007)(97736004)(105586002)(9686003)(316002)(14454004)(305945005)(6506007)(102836004)(99286004)(55016002)(7736002)(81166006)(7696005)(6116002)(26005)(76176011)(81156014)(54906003)(110136005)(486006)(6436002)(256004)(14444005)(72206003)(476003)(478600001)(446003)(2900100001)(53546011)(2906002)(4326008)(229853002)(11346002)(33656002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4891;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BBxaC0WrdPhmAZFqqAo+vMD9zjiWp+nl0+E8Ftu/smW0nLeHl2kPOIKHL2U4RM+Qn3xmaYocD2MDzoTB1fdTBzLEGATSQK1R7IfqOLhc2x1eGHwpxVsdekDRhKRqtzqJjWdTZab3rmU5uvrnyqG759CreqGfuejUYRrZcFXOQuGOlpKsM7xBW9dPAO+bkFYi38XOU6dmEpNDztfWTTRS+zvaQlzkRn6vdz2nNEar+7dM8uvNzx6wB339I+u34OoHeTK6SMEo6WUqzdRoTzxnEcGx8MvyK09nc+k7TF0O6qBN3Aw9LilSfZOvcMMqLMUPpSel3aN5s6XNXfRvz2kF+Rcsyx4u02alBhC1Fz0sLZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8461b941-4d06-495d-d5a0-08d622a64531
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 05:18:03.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Tuesday, September 18, 2018 8:34 PM
> To: adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>;
> ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH] sdhci: arasan: Add runtime PM support
>=20
> Add runtime PM support in Arasan SDHCI driver.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 80
> +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-=
of-
> arasan.c
> index a40bcc2..370ada5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -30,6 +31,7 @@
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
>=20
> +#define SDHCI_ARASAN_AUTOSUSPEND_DELAY	2000 /* ms */
>  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>  #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
> @@ -363,6 +365,70 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_cqe_pdata =3D {
>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>=20
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (sdhci_arasan->has_cqe) {
> +		ret =3D cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret =3D clk_enable(sdhci_arasan->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable AHB clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SD clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D sdhci_runtime_resume_host(host);
> +	if (ret)
> +		goto out;
> +
> +	if (sdhci_arasan->has_cqe)
> +		return cqhci_resume(host->mmc);
> +
> +	return 0;
> +out:
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return ret;
> +}
> +#endif /* ! CONFIG_PM */
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver @@ -455,8 +521,1=
0
> @@ static int sdhci_arasan_resume(struct device *dev)  }  #endif /* !
> CONFIG_PM_SLEEP */
>=20
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops,
> sdhci_arasan_suspend,
> -			 sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend,
> sdhci_arasan_resume)
> +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +			   sdhci_arasan_runtime_resume, NULL) };
>=20
>  static const struct of_device_id sdhci_arasan_of_match[] =3D {
>  	/* SoC-specific compatible strings w/ soc_ctl_map */ @@ -821,6
> +889,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_host;
>=20
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +
> SDHCI_ARASAN_AUTOSUSPEND_DELAY);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_forbid(&pdev->dev);
> +
>  	return 0;
>=20
>  err_add_host:
> --
> 2.1.1

