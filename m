Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D52C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED96219EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HViDfPrw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="buiCv0D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED96219EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeHFLgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:36:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40690 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeHFLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533547710; x=1565083710;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aPIkiOOR21/kbY52nuHdibGeScaJrIbScuDqGeEdNUc=;
  b=HViDfPrwZMK7fmS3KK+cc2fy7JyPkL+34h8TZ35Mdj9oF4Dwuz4plsxj
   49xpWXlcGEcy8Fyw//airMTmqAcs5pbN7c4W+Q3+i6kGHdHJyO3ZBTxUr
   Q+cedaC2IDNYUMAFq1c1IsuxxaRKd8th0aIEZ3IFYA2ACtu28QBN0RURm
   TjKXd82C8vX2aznwMROYQDthkHBS+TY3InCAFbcTo/6nlfHw+3Bve3Z+B
   c7lAFhVOxBwGlo2xwFQKKQpx/103Irm4BJKLCeb1kx9UwghNo25Q5Dq7B
   eEsSO/NqNWHWrImobrxVZhU0eK5KuLztOvr9BV6+YIrqzngO2CYxvx9Fy
   g==;
X-IronPort-AV: E=Sophos;i="5.51,452,1526313600"; 
   d="scan'208";a="88191894"
Received: from mail-dm3nam03lp0022.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.22])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2018 17:28:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij1/quqqsaQZ/x6F6WFrnPKbaCK2YXy/bHVKZmBRBEg=;
 b=buiCv0D7srA7D/mg3b/mqPOLWxVvkPUmKPAbxQFPQHpnKL3rkx9aBfrNAvMSCZpsQmlNDPfY4g8LvdRlqjKJDTtmQ/W/Q8lTTWgJ19Qb1LfRuJLovzhe7QDCzUrQxaRxCqoDAU/68qoNlZj4zAV3qU8qj2AZht4lbDXQfzZm2kc=
Received: from MWHPR04MB1137.namprd04.prod.outlook.com (10.173.51.151) by
 MWHPR04MB1087.namprd04.prod.outlook.com (10.174.250.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:28:26 +0000
Received: from MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::89ab:145b:a6ac:9ea7]) by MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::89ab:145b:a6ac:9ea7%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 09:28:26 +0000
From:   Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To:     Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: RE: [PATCH v3] scsi: ufs: Make sysfs attributes writable
Thread-Topic: [PATCH v3] scsi: ufs: Make sysfs attributes writable
Thread-Index: AQHUJFQrFvO3HAFYNECaR08kj3uJ46SyhIzA
Date:   Mon, 6 Aug 2018 09:28:26 +0000
Message-ID: <MWHPR04MB11374B145CB323EC8C3339DB9A200@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180725201452.81235-1-evgreen@chromium.org>
In-Reply-To: <20180725201452.81235-1-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1087;20:FUOhsYA1tXhl7RNNCKtHadobBa3p8ObZFN4txsJFMAy2si15F4WSySI9HRZHJTpaIiY1R+BT61B3mfM+OHHPRxi319ySU7fIYUbILurUWCyiuOoKjTs4H6qLeowILkuEQOSG6Ill+EVE9L4DTOMwdCrtqw41+fmjRde4YPmznmo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: ac4d3238-662c-40bd-4e0a-08d5fb7ef68b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1087;
x-ms-traffictypediagnostic: MWHPR04MB1087:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB10878F4302380F73510E0E769A200@MWHPR04MB1087.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1087;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1087;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(50944005)(189003)(199004)(13464003)(51444003)(6636002)(6506007)(11346002)(2906002)(53936002)(9686003)(86362001)(575784001)(6306002)(99286004)(2900100001)(2201001)(110136005)(6436002)(476003)(486006)(316002)(14444005)(68736007)(186003)(26005)(55016002)(74316002)(6246003)(446003)(39060400002)(256004)(53546011)(97736004)(6116002)(106356001)(3846002)(478600001)(229853002)(66066001)(7736002)(305945005)(25786009)(8936002)(2501003)(5250100002)(33656002)(102836004)(8676002)(81166006)(81156014)(14454004)(966005)(7696005)(105586002)(5660300001)(76176011)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1087;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uAbOigicWVQsfg37IPXmDct2AjtH/BYgh1NCQN0lBrE34nC0h21erhXtAHEIiSqmyx6i03Ay4mDmUyQbHObWiKvk2VvW2c2pVpYtRm7DXcxjS60RpWmDI6rYuxyhD+R5BPqB9L24iBiiTlf9xgsoN5aWvQ5OFdY3qQQRMgYklUcs1/CoNUmrvlKwSb459gRx8TOSVu9DLk5Q0HwCgXN3aPUPZvpTwU2BOCfMNjqDSaJFw/oUh5G2VuV/Ash2NxZxR9lRqdEaotlO1jJvYhaLuw2rsXmmTpApnPKAof1zVcabPQCAUO+9TFPJLhV6Ut3bekIutOBe7rjGdU7RRyMjxNVmX78T3SKxJJpgsR7qTwk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4d3238-662c-40bd-4e0a-08d5fb7ef68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 09:28:26.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

> -----Original Message-----
> From: Evan Green <evgreen@chromium.org>
> Sent: Wednesday, July 25, 2018 11:15 PM
> To: Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jej=
b@linux.vnet.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.=
com>; Adrian Hunter <adrian.hunter@intel.com>; linux-
> kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Bart Van Assche <Bart=
.VanAssche@wdc.com>
> Cc: Evan Green <evgreen@chromium.org>
> Subject: [PATCH v3] scsi: ufs: Make sysfs attributes writable
>=20
> This change makes the UFS controller's sysfs attributes writable, which
> will enable users to modify attributes. This can be useful during factory
> provisioning for setting up critical attributes like the reference clock
> frequency.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> Configfs was determined to be the preferred mechanism for writing the
> config descriptor, but attributes also need to be written during setup,
> and are already present in sysfs. Making these attributes writable is
> also helpful for debugging and experimentation.
>=20
> Changes since v2:
> 	- Removed the configuration descriptor changes from the series,
> since configfs was the preferred way to write to that, leaving only
> this change.
>=20
> Changes since v1:
> 	- Reworked the interface to show each unit of the config
> descriptor as a separate directory, rather than the previous method I
> had of a file for selecting the unit, and then a common set of files
> that interacted with whichever unit was selected. I did some kobject
> magic to accomplish this. I noticed from Greg KH's reply to Sayali's
> patches [1] that configfs might be the preferred method. Let me know
> if I should abandon this series in favor of Sayali's, with the
> possible exception of "Make sysfs attributes writable".
> 	- Squashed documentation changes into their respective code
> changes.
> 	- I decided to keep the config descriptor attributes as their
> own files, rather than hiding writes behind device descriptor and unit
> descriptor, as I think that's more future proof and true to the UFS spec.
>=20
> [1] https://lkml.org/lkml/2018/6/8/210
>=20
>  Documentation/ABI/testing/sysfs-driver-ufs | 17 +--------
>  drivers/scsi/ufs/ufs-sysfs.c               | 58 ++++++++++++++++++++----=
------
>  2 files changed, 40 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/A=
BI/testing/sysfs-driver-ufs
> index 016724ec26d5..44f3b9691e59 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -685,7 +685,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the boot lun enabled UFS device attribut=
e.
>  		The full information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/current_power_mode
>  Date:		February 2018
> @@ -693,7 +692,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the current power mode UFS device attrib=
ute.
>  		The full information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/active_icc_level
>  Date:		February 2018
> @@ -701,7 +699,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the active icc level UFS device attribut=
e.
>  		The full information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ooo_data_enabled
>  Date:		February 2018
> @@ -709,7 +706,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the out of order data transfer enabled U=
FS
>  		device attribute. The full information about the attribute
>  		could be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/bkops_status
>  Date:		February 2018
> @@ -717,7 +713,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the background operations status UFS dev=
ice
>  		attribute. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/purge_status
>  Date:		February 2018
> @@ -725,7 +720,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the purge operation status UFS device
>  		attribute. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_in_size
>  Date:		February 2018
> @@ -733,7 +727,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file shows the maximum data size in a DATA IN
>  		UPIU. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_out_size
>  Date:		February 2018
> @@ -741,7 +734,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file shows the maximum number of bytes that can be
>  		requested with a READY TO TRANSFER UPIU. The full information
>  		about the attribute could be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/reference_clock_fre=
quency
>  Date:		February 2018
> @@ -749,14 +741,13 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc=
.com>
>  Description:	This file provides the reference clock frequency UFS device
>  		attribute. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/configuration_descr=
iptor_lock
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file shows whether the configuration descriptor is loc=
ked.
>  		The full information about the attribute could be found at
> -		UFS specifications 2.1. The file is read only.
> +		UFS specifications 2.1.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_number_of_rtt
>  Date:		February 2018
> @@ -765,7 +756,6 @@ Description:	This file provides the maximum current n=
umber of
>  		outstanding RTTs in device that is allowed. The full
>  		information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_con=
trol
>  Date:		February 2018
> @@ -773,7 +763,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the exception event control UFS device
>  		attribute. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_sta=
tus
>  Date:		February 2018
> @@ -781,7 +770,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.c=
om>
>  Description:	This file provides the exception event status UFS device
>  		attribute. The full information about the attribute could
>  		be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ffu_status
>  Date:		February 2018
> @@ -789,14 +777,12 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc=
.com>
>  Description:	This file provides the ffu status UFS device attribute.
>  		The full information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_state
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>  Description:	This file show the PSA feature status. The full information
>  		about the attribute could be found at UFS specifications 2.1.
> -		The file is read only.
>=20
>  What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_data_size
>  Date:		February 2018
> @@ -805,7 +791,6 @@ Description:	This file shows the amount of data that =
the host plans to
>  		load to all logical units in pre-soldering state.
>  		The full information about the attribute could be found at
>  		UFS specifications 2.1.
> -		The file is read only.
>=20
>=20
>  What:		/sys/class/scsi_device/*/device/dyn_cap_needed
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> index 8d9332bb7d0c..5e286b9d1aea 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -655,7 +655,7 @@ static const struct attribute_group ufs_sysfs_flags_g=
roup =3D {
>  	.attrs =3D ufs_sysfs_device_flags,
>  };
>=20
> -#define UFS_ATTRIBUTE(_name, _uname)					\
> +#define UFS_ATTRIBUTE_SHOW(_name, _uname)				\
>  static ssize_t _name##_show(struct device *dev,				\
>  	struct device_attribute *attr, char *buf)			\
>  {									\
> @@ -665,25 +665,45 @@ static ssize_t _name##_show(struct device *dev,				=
\
>  		QUERY_ATTR_IDN##_uname, 0, 0, &value))			\
>  		return -EINVAL;						\
>  	return sprintf(buf, "0x%08X\n", value);				\
> -}									\
> -static DEVICE_ATTR_RO(_name)
> +}
>=20
> -UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
> -UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
> -UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
> -UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
> -UFS_ATTRIBUTE(bkops_status, _BKOPS_STATUS);
> -UFS_ATTRIBUTE(purge_status, _PURGE_STATUS);
> -UFS_ATTRIBUTE(max_data_in_size, _MAX_DATA_IN);
> -UFS_ATTRIBUTE(max_data_out_size, _MAX_DATA_OUT);
> -UFS_ATTRIBUTE(reference_clock_frequency, _REF_CLK_FREQ);
> -UFS_ATTRIBUTE(configuration_descriptor_lock, _CONF_DESC_LOCK);
> -UFS_ATTRIBUTE(max_number_of_rtt, _MAX_NUM_OF_RTT);
> -UFS_ATTRIBUTE(exception_event_control, _EE_CONTROL);
> -UFS_ATTRIBUTE(exception_event_status, _EE_STATUS);
> -UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
> -UFS_ATTRIBUTE(psa_state, _PSA_STATE);
> -UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
> +#define UFS_ATTRIBUTE_RO(_name, _uname)					\
> +UFS_ATTRIBUTE_SHOW(_name, _uname)					\
> +DEVICE_ATTR_RO(_name)
It should be static here.

> +
> +#define UFS_ATTRIBUTE_RW(_name, _uname)					\
> +UFS_ATTRIBUTE_SHOW(_name, _uname)					\
> +static ssize_t _name##_store(struct device *dev,			\
> +		struct device_attribute *attr, const char *buf,		\
> +		size_t count)						\
> +{									\
> +	struct ufs_hba *hba =3D dev_get_drvdata(dev);			\
> +	u32 value;							\
> +	if (kstrtou32(buf, 0, &value))					\
> +		return -EINVAL;						\
> +	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,	\
> +		QUERY_ATTR_IDN##_uname, 0, 0, &value))			\
> +		return -EINVAL;						\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(_name)
> +
> +UFS_ATTRIBUTE_RW(boot_lun_enabled, _BOOT_LU_EN);
> +UFS_ATTRIBUTE_RO(current_power_mode, _POWER_MODE);
> +UFS_ATTRIBUTE_RW(active_icc_level, _ACTIVE_ICC_LVL);
> +UFS_ATTRIBUTE_RW(ooo_data_enabled, _OOO_DATA_EN);
I would prefer to leave "write once" attributes as read-only.

> +UFS_ATTRIBUTE_RO(bkops_status, _BKOPS_STATUS);
> +UFS_ATTRIBUTE_RO(purge_status, _PURGE_STATUS);
> +UFS_ATTRIBUTE_RW(max_data_in_size, _MAX_DATA_IN);
> +UFS_ATTRIBUTE_RW(max_data_out_size, _MAX_DATA_OUT);
> +UFS_ATTRIBUTE_RW(reference_clock_frequency, _REF_CLK_FREQ);
> +UFS_ATTRIBUTE_RW(configuration_descriptor_lock, _CONF_DESC_LOCK);
Same here, "write once" attribute.

> +UFS_ATTRIBUTE_RW(max_number_of_rtt, _MAX_NUM_OF_RTT);
> +UFS_ATTRIBUTE_RW(exception_event_control, _EE_CONTROL);
> +UFS_ATTRIBUTE_RW(exception_event_status, _EE_STATUS);
This one is read only attribute.

> +UFS_ATTRIBUTE_RO(ffu_status, _FFU_STATUS);
> +UFS_ATTRIBUTE_RO(psa_state, _PSA_STATE);
> +UFS_ATTRIBUTE_RO(psa_data_size, _PSA_DATA_SIZE);
>=20
>  static struct attribute *ufs_sysfs_attributes[] =3D {
>  	&dev_attr_boot_lun_enabled.attr,
> --
> 2.16.4

I would add some write option to some flags as well. For example, enabling/
disabling the background operations could be very useful.

Regards
Stanislav
