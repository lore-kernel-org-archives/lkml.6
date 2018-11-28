Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5F52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gnFGTHTC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R/zjxiGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5F52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeK1RQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:16:13 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24362 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeK1RQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543385744; x=1574921744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ddPYgzGF6fo4NrQ0Fnz0hC9s1zTP4p6Yf9hINoY8DI0=;
  b=gnFGTHTCl2EwEwYYJR6fT1jPQ2QIFw7kmwqeXv0BLWDIVw5cMhBYiSBW
   5W0XkB0ly6j2nsA31zih5MdUcntSJUYPqsY0voYzYV1JLh2Y8xEtyMTAX
   leME0GC3xxSC2gY9AwpJmDlmvGTBmCfohI40K8u0nCHzbXCvl3RIreqfy
   lD7xRjxOobDgenPLcJwATaZD35tT34vORpbiv5bVtP+3zboAo+zgrTa7R
   w8z3nJjmLEwbeSuqkjy4N9v2GCI3uF9q0GGw6SHp/NfygzZTIt5yRe4ZE
   fBlo/QWN8Kgh7W2sVBgEgtItNg43zsvlvTVi8Tiwrq8JQQ7vRdB0W/oRA
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,289,1539619200"; 
   d="scan'208";a="97010559"
Received: from mail-sn1nam02lp0021.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.21])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2018 14:15:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHyfRYSTa2ICQWO7RLZEpar01E+r9Jd35O3B2vvKDbk=;
 b=R/zjxiGYx2qUrOUaXc7sQYw2m8KsGiU0JAM3Um96Xzr6sgiVRPa18PKumAS3mZE1jNkxdyQ229yhcp+0ID8Mg7gf91wjlHyoPhfIB27gwXYP6vYQSCfT/NaywnkfZmX71o2b/rY+YxRtHV7ccUtN7VEIbHpwS5xl0+9qRSUgp2I=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3952.namprd04.prod.outlook.com (52.135.82.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 06:15:41 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1%3]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 06:15:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: RE: [PATCH 40/41] scsi: ufs: ufshcd: mark expected switch
 fall-throughs
Thread-Topic: [PATCH 40/41] scsi: ufs: ufshcd: mark expected switch
 fall-throughs
Thread-Index: AQHUhtOsykeuJ9/KFkq+7D0/NPkLHqVktZhQ
Date:   Wed, 28 Nov 2018 06:15:41 +0000
Message-ID: <SN6PR04MB4925E511F16036DF52A6FFA7FCD10@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <f4ee30ab52b0fadd2242dd189fe03b60ecba1f47.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <f4ee30ab52b0fadd2242dd189fe03b60ecba1f47.1543374820.git.gustavo@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB3952;6:dAdQlBePFWSK+qztEdpPuPg8yunuZ/bd11psYd+qGJ8egoJHHWphzTtohjGp96jNe6cu8Y7AkWYunrjRqbHQ29FtodxMTjy0/8UE9TMA0LBfm8K6yqtVwKYeZ76WlyV/x9S6dukSLg0PHTb0WQRcqeAV59+R+M/jhGYgFP7UVWM8BckIVc88xEZyNG7GeL3fmimUlAoSrguTjraoiKPgZaKr7wCXg+tVedjJ33IKPpWZyGzn/GYumt+QRpdKXjGBw+U3aAdeNixhPL/KlyGgVcMJiXqR9s2uzrghtHptTDQaHnunHw6/L4BPvn07lIQH1TBRiN3DucRwHtQ3Joh5aqEqCZ+9B/iV4dj12Xc+hYGpVNdyoVgqjyVSAW9vgUV/7gb/VIe4oUshDZZiR2JyVCfgYxgPR3RTIJaEEW1OFPyANztgxtQWwkSpp5Ea2cxussuMknClGeyIm9Qj+yxtCw==;5:RHSMJWgUHUkmHh4mjEYUlFKjm1YvpAn7ZXsh9aLuE80VOetrczo/0Pv5+lS7Ns/Q/lbBwG8kKd53BUPLpTGbxxOmxiEc8dcsXYK0siPeKEVzMggzcA6lPXMClcVE8PxUt627cVCbDo58OWXcF/UzZq4FHRcM7aPDUli0z51fWHQ=;7:xkXjZNfTeumgeQbdxIjB3agOcaoCZvTnYmO9ZRi84km5ewvwPUmyMIO+drA75uTvIBD+pqyjtqGHGyAxSzFCGpBZcXkg+p5leeKGiudnmOj4KdBBopoUClUDP27Rr0ssORmxXvNe/kdR/XQEJlUCSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 94625574-cae6-422e-f9fe-08d654f8ec63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3952;
x-ms-traffictypediagnostic: SN6PR04MB3952:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3952905CF85E0CCE1C1F343AFCD10@SN6PR04MB3952.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR04MB3952;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB3952;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(199004)(189003)(26005)(186003)(3846002)(6116002)(14454004)(99286004)(316002)(8676002)(55016002)(9686003)(6306002)(6506007)(53546011)(102836004)(86362001)(66066001)(476003)(33656002)(6436002)(110136005)(54906003)(7696005)(76176011)(486006)(446003)(68736007)(11346002)(25786009)(229853002)(966005)(105586002)(72206003)(106356001)(256004)(71200400001)(71190400001)(305945005)(7736002)(8936002)(2906002)(6246003)(97736004)(478600001)(53936002)(39060400002)(4326008)(81156014)(5660300001)(81166006)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3952;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nckFuxAmgGOFN1DT9Mf3RVrDJ10O9X1u/XZ3mtDbpo67Fg7E3hu5xvSSWNAFi5099Y747YyuZ+yWxNWwapHq159z1ON4mozWIHyzExqPF978h3UJwaqI8c7i59640j2GdG72Qf60VuUHBUgVic19KiWRnlp/0fwBPpKM877xlYRraf7hBf1j9ToTygxFerVVHgwod67okV91uI6Pl28fA/eqrODDBWf/qBWy0oZAG0FLJmy6A/2rJIHMtVULR1mVRw3yL9Q9CzGMROD1C9mUEJmQZRH6U6Yjf0E6CuGVRAhPUuDHCXcoG3NSdR4EYfH9F+NXL15FtuXXQz0XPziCaLWJ5ggQwejue+J81s3HF58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94625574-cae6-422e-f9fe-08d654f8ec63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 06:15:41.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Already submitted by Tomas:
https://www.spinics.net/lists/linux-scsi/msg125659.html

Thanks,
Avri

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org>
> On Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, November 28, 2018 6:34 AM
> To: Vinayak Holikatti <vinholikatti@gmail.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH 40/41] scsi: ufs: ufshcd: mark expected switch fall-throu=
ghs
>=20
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 1087954 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 003d489f1b4b..be207197b63f 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1551,6 +1551,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
>  		 * currently running. Hence, fall through to cancel gating
>  		 * work and to enable clocks.
>  		 */
> +		/* fall through */
>  	case CLKS_OFF:
>  		ufshcd_scsi_block_requests(hba);
>  		hba->clk_gating.state =3D REQ_CLKS_ON;
> @@ -1562,6 +1563,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
>  		 * fall through to check if we should wait for this
>  		 * work to be done or not.
>  		 */
> +		/* fall through */
>  	case REQ_CLKS_ON:
>  		if (async) {
>  			rc =3D -EAGAIN;
> @@ -4620,6 +4622,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp,
> int scsi_status)
>  	switch (scsi_status) {
>  	case SAM_STAT_CHECK_CONDITION:
>  		ufshcd_copy_sense_data(lrbp);
> +		/* fall through */
>  	case SAM_STAT_GOOD:
>  		result |=3D DID_OK << 16 |
>  			  COMMAND_COMPLETE << 8 |
> --
> 2.17.1

