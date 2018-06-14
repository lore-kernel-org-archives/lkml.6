Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB560C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6DA2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S0gfg9ak";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BHBXWu7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6DA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965137AbeFNOsj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:48:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59429 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964938AbeFNOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528987714; x=1560523714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LF4P+vLMfX6w4zFeZ8KyxHkycNlYesdhjEFgBljfV7s=;
  b=S0gfg9akysIlpKuUmklPViFuB5zFyegtjzKK4k9s4HUS8xhXFVr0Iryr
   SoESeLhHzyRygHooh3mnNFrxUO5ZMzvFqSBKBIE2Q27kUh+H7+hmiuSHy
   H3F2C0gelZZhnQBk8NV/CVZlFdDbWczS7usDbSznpkVumCLs/Z+nlsLRR
   iK7EshTXGv/cupoRykRX0aSyT2kgXBdevUAvBD6kJsm7Eo5I69fuNU8dz
   IqB+0GNilhcfZZnS8L7NllesxN3LLPqsajUrMNupZ89dGrf1Qleswkrff
   qgJoBQ29rCU2/0w/UMBEKgNseC4XoBFzJdFcX+JCJJFSu5WTBGjfGhgK5
   A==;
X-IronPort-AV: E=Sophos;i="5.51,222,1526313600"; 
   d="scan'208";a="82563750"
Received: from mail-co1nam04lp0054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2018 22:48:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiLSulKTkABl97nJfYELj2xjTMJ5zll9JLzDuHCgpTw=;
 b=BHBXWu7BxU0ndQOhLcoEnokrTZRQeRKGpyDl/212rKZz0tsOcUAkNsyA0BeE602gs1lYW7oVVNPZ6plMl0oL38GpYXv2f9Neg9nvxBdR2/ILCgpYqcxD2t6MK/MOJNvy99OBLtw8zciC3/5AuXu6U+AZ+qsY8H0QAdw56CVq8/A=
Received: from DM5PR04MB1085.namprd04.prod.outlook.com (10.174.242.35) by
 DM5PR04MB0458.namprd04.prod.outlook.com (10.173.169.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Thu, 14 Jun 2018 14:48:31 +0000
Received: from DM5PR04MB1085.namprd04.prod.outlook.com
 ([fe80::dc62:a071:6f11:b2b]) by DM5PR04MB1085.namprd04.prod.outlook.com
 ([fe80::dc62:a071:6f11:b2b%3]) with mapi id 15.20.0820.015; Thu, 14 Jun 2018
 14:48:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH resend] scsi: ufs: ufshcd_dump_regs to use memcpy_fromio
Thread-Topic: [PATCH resend] scsi: ufs: ufshcd_dump_regs to use memcpy_fromio
Thread-Index: AQHUA7fRqO2gDjlBOUK3bq+8qjLxhaRf1OMA
Date:   Thu, 14 Jun 2018 14:48:31 +0000
Message-ID: <DM5PR04MB10851A8650A68E5FD1229227FC7D0@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <20180614081409.29780-1-tomas.winkler@intel.com>
In-Reply-To: <20180614081409.29780-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0458;7:agBzTq4Bn0mRcGA+UZxpXfPWS5h4KdvlJpdLCDvYJaM+mbzHtHUl9JTzIlgunqJ+pMf2vIonim4JBU2FlYyGFhn+7Lb2zuukIHliLUn/lsZtmmbsAMtlb/9b3cRMUB/uUsSeHdZP1lUwmjD2xoVGTBCniSaq5jRzPuiKNg99AziDPaUkLWfZrF3Iqpbd8Tj+1CgzKsK/YBzDt6YQvko646g4DDefOKM8zZjSVe3gewPxqU8va2A5YmTAVaYgFqsP;20:MA/n+pkSYI1d+4Nex5Yp5MlwMauzOereZCi0Mf7MxN/s76IdIziAJgp0jPpwVucr0TzcAPAd3dtsU9YVF6raRhhTYHdVx5Uws2xPEWEXHrs9WLvawVkWjdZGiaOk+od/fyQXR73aQsD3k1wuuI3XUqYryTuUjZbkWYcgMdZNGeo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 854116f3-532c-437c-2ea2-08d5d205e5c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0458;
x-ms-traffictypediagnostic: DM5PR04MB0458:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB045832B462B041FEB12DA290FC7D0@DM5PR04MB0458.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0458;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0458;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(13464003)(5660300001)(3660700001)(4326008)(74316002)(72206003)(7736002)(2900100001)(25786009)(81166006)(478600001)(55016002)(66066001)(9686003)(14454004)(6506007)(59450400001)(102836004)(26005)(53546011)(7696005)(76176011)(8936002)(39060400002)(53936002)(6246003)(186003)(5250100002)(7416002)(3280700002)(8676002)(81156014)(305945005)(6436002)(86362001)(6116002)(3846002)(33656002)(229853002)(476003)(446003)(316002)(97736004)(110136005)(99286004)(54906003)(575784001)(68736007)(11346002)(486006)(105586002)(106356001)(2906002)(21314002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0458;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8W0V7U46mgOp3005s1iW6LeycA6ntTrL6E6vEORGyD74MjrYANlkGLCy3fHq/3suwdXveh3P9ijyu4XAnyv3aJJGtXjNf7LqQ46hhYlhrMAhY8ppU7u4uJkoCY7OUUV+/IWnjIG2csIo9e1c2A/k80RV4SWwH7VOqjNMvpa7Afp1rq+R9jZfTb4d/qnrpV2E
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854116f3-532c-437c-2ea2-08d5d205e5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 14:48:31.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tomas Winkler <tomas.winkler@intel.com>
> Sent: Thursday, June 14, 2018 11:14 AM
> To: James E . J . Bottomley <jejb@linux.vnet.ibm.com>; Martin K . Peterse=
n
> <martin.petersen@oracle.com>; Vinayak Holikatti
> <vinholikatti@gmail.com>; Adrian Hunter <adrian.hunter@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>; Vivek Gautam
> <vivek.gautam@codeaurora.org>; Subhash Jadavani
> <subhashj@codeaurora.org>; Alex Lemberg <Alex.Lemberg@wdc.com>; Avri
> Altman <Avri.Altman@wdc.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Tomas Winkler <tomas.winkler@intel.com>
> Subject: [PATCH resend] scsi: ufs: ufshcd_dump_regs to use memcpy_fromio
>=20
> ufshcd_dump_regs should use memcpy_fromio to read host registers instead
> of directly accessing using memcpy.
> The same function is utilized in ufs-qcom.
>=20
> Elminite compilation warning
> drivers/scsi/ufs/ufshcd.c:356:9: warning: incorrect type in argument 6
> (different address spaces)
> drivers/scsi/ufs/ufshcd.c:356:9:    expected void const *buf
> drivers/scsi/ufs/ufshcd.c:356:9:    got void [noderef] <asn:2>*mmio_base
>=20
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/scsi/ufs/ufs-qcom.c | 21 ++++++---------------
>  drivers/scsi/ufs/ufshcd.c   | 35 ++++++++++++++++++++++++-----------
>  drivers/scsi/ufs/ufshcd.h   |  3 +++
>  3 files changed, 33 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c in=
dex
> 2b38db2eeafa..77ac98ea80d4 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -50,19 +50,10 @@ static void ufs_qcom_get_default_testbus_cfg(struct
> ufs_qcom_host *host);  static int
> ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
>  						       u32 clk_cycles);
>=20
> -static void ufs_qcom_dump_regs(struct ufs_hba *hba, int offset, int len,
> -		char *prefix)
> -{
> -	print_hex_dump(KERN_ERR, prefix,
> -			len > 4 ? DUMP_PREFIX_OFFSET :
> DUMP_PREFIX_NONE,
> -			16, 4, (void __force *)hba->mmio_base + offset,
> -			len * 4, false);
> -}
> -
>  static void ufs_qcom_dump_regs_wrapper(struct ufs_hba *hba, int offset,
> int len,
> -		char *prefix, void *priv)
> +				       const char *prefix, void *priv)
>  {
> -	ufs_qcom_dump_regs(hba, offset, len, prefix);
> +	ufshcd_dump_regs(hba, offset, len * 4, prefix);
>  }
>=20
>  static int ufs_qcom_get_connected_tx_lanes(struct ufs_hba *hba, u32
> *tx_lanes) @@ -1431,7 +1422,7 @@ static int
> ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>=20
>  static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
>  		void *priv, void (*print_fn)(struct ufs_hba *hba,
> -		int offset, int num_regs, char *str, void *priv))
> +		int offset, int num_regs, const char *str, void *priv))
>  {
>  	u32 reg;
>  	struct ufs_qcom_host *host;
> @@ -1613,7 +1604,7 @@ int ufs_qcom_testbus_config(struct
> ufs_qcom_host *host)
>=20
>  static void ufs_qcom_testbus_read(struct ufs_hba *hba)  {
> -	ufs_qcom_dump_regs(hba, UFS_TEST_BUS, 1, "UFS_TEST_BUS ");
> +	ufshcd_dump_regs(hba, UFS_TEST_BUS, 4, "UFS_TEST_BUS ");
>  }
>=20
>  static void ufs_qcom_print_unipro_testbus(struct ufs_hba *hba) @@ -
> 1639,8 +1630,8 @@ static void ufs_qcom_print_unipro_testbus(struct
> ufs_hba *hba)
>=20
>  static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)  {
> -	ufs_qcom_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16,
> -			"HCI Vendor Specific Registers ");
> +	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
> +			 "HCI Vendor Specific Registers ");
>=20
>  	/* sleep a bit intermittently as we are dumping too much data */
>  	ufs_qcom_print_hw_debug_reg_all(hba, NULL,
> ufs_qcom_dump_regs_wrapper); diff --git a/drivers/scsi/ufs/ufshcd.c
> b/drivers/scsi/ufs/ufshcd.c index d0a1674915a1..972fa85e2b24 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -99,8 +99,29 @@
>  		_ret;                                                   \
>  	})
>=20
> -#define ufshcd_hex_dump(prefix_str, buf, len) \ -
> print_hex_dump(KERN_ERR, prefix_str, DUMP_PREFIX_OFFSET, 16, 4, buf,
> len, false)
> +#define ufshcd_hex_dump(prefix_str, buf, len) do {                      =
 \
> +	size_t __len =3D (len);                                            \
> +	print_hex_dump(KERN_ERR, prefix_str,                             \
> +		       __len > 4 ? DUMP_PREFIX_OFFSET :
> DUMP_PREFIX_NONE,\
> +		       16, 4, buf, __len, false);                        \
> +} while (0)
> +
> +int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
> +		     const char *prefix)
> +{
> +	u8 *regs;
> +
> +	regs =3D kzalloc(len, GFP_KERNEL);
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(regs, hba->mmio_base + offset, len);
> +	ufshcd_hex_dump(prefix, regs, len);
> +	kfree(regs);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
>=20
>  enum {
>  	UFSHCD_MAX_CHANNEL	=3D 0,
> @@ -376,15 +397,7 @@ static void ufshcd_print_uic_err_hist(struct ufs_hba
> *hba,
>=20
>  static void ufshcd_print_host_regs(struct ufs_hba *hba)  {
> -	/*
> -	 * hex_dump reads its data without the readl macro. This might
> -	 * cause inconsistency issues on some platform, as the printed
> -	 * values may be from cache and not the most recent value.
> -	 * To know whether you are looking at an un-cached version verify
> -	 * that IORESOURCE_MEM flag is on when xxx_get_resource() is
> invoked
> -	 * during platform/pci probe function.
> -	 */
> -	ufshcd_hex_dump("host regs: ", hba->mmio_base,
> UFSHCI_REG_SPACE_SIZE);
> +	ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
>  	dev_err(hba->dev, "hba->ufs_version =3D 0x%x, hba->capabilities =3D
> 0x%x\n",
>  		hba->ufs_version, hba->capabilities);
>  	dev_err(hba->dev,
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h index
> 8110dcd04d22..aad959ba3d9b 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -1022,4 +1022,7 @@ static inline u8 ufshcd_scsi_to_upiu_lun(unsigned
> int scsi_lun)
>  		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;  }
>=20
> +int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
> +		     const char *prefix);
> +
>  #endif /* End of Header */
> --
> 2.14.4

