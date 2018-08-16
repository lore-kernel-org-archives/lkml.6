Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF6208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVBBMG9Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GNxE1uM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAF6208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbeHPRBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:01:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44106 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389549AbeHPRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534428167; x=1565964167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJt0m+tm0LLfjZHES9UiLU8IBS8r84iWgQajK/1DO/Q=;
  b=IVBBMG9ZB1wgNEFTWX9/vodQcXKVDuTl7afOH7Sud49pzhF1Kd6CGJjC
   8QWpR/j6hAR20il0rOpwFDAIKW6w+d/YYjlOlHfYnCTn+4qeMuvB1pDou
   kmfRqHMZVv2XXRDEEusONztpveBnfFpbjKEyWbgcgD/ZY+Ukg+L+d8Isw
   NFQZhLz+NmjLT9CPyWJg4JrDrSJqDLPbI97JoP7ZoXi5ghfgA/lyreS0J
   sQFGwfasjE8l7nJ954v1fFJUD+BAFeiPKBnjBd3bmatXWHlXhhIjMQ9pE
   96A0T3a9vS4X2FlpUjb0hgh0hvE+gPbFFQusK77GBXIjUDFR32tYG+LWR
   A==;
X-IronPort-AV: E=Sophos;i="5.53,247,1531756800"; 
   d="scan'208";a="191707126"
Received: from mail-sn1nam02lp0022.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.22])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 22:02:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7hdNq8b7VPt9ZCCpKZ5gjCedMHFEPGuF4sM0l7vsM8=;
 b=GNxE1uM+DYjCXcOQ1Uke1nTo6gtpceAPtpVc6kEM0zySULYlgcwfdxxQ2DfFCUy6Cr4Bu9lCM9qoF+7bgN09xmVbnIIVmafk+sE+oYpV+lpPxubYyAhsbOJ6SalC9+RC06Adf4KIAJ3qBA7HOS4SbAeV7LnR3BHda7OB/5adL0M=
Received: from SN1PR04MB1824.namprd04.prod.outlook.com (10.161.255.18) by
 SN1PR04MB1806.namprd04.prod.outlook.com (10.161.255.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 16 Aug 2018 14:02:42 +0000
Received: from SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5]) by SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5%6]) with mapi id 15.20.1059.017; Thu, 16 Aug 2018
 14:02:42 +0000
From:   Jeffrey Lien <Jeff.Lien@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: RE: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Topic: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Index: AQHUMN4sEhSi1wxjA0WmqPMOFuusJqS5bC4AgAkEGbA=
Date:   Thu, 16 Aug 2018 14:02:41 +0000
Message-ID: <SN1PR04MB1824A5944E0428AC84B62886EA3E0@SN1PR04MB1824.namprd04.prod.outlook.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <20180810201601.GA80850@gmail.com>
In-Reply-To: <20180810201601.GA80850@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR04MB1806;6:WGi6B13I2CHlx1ZbxMkaEQPwcbAuRVL8k1urKqlzp0nGHmVIdd5MUqk8+8DcOFt2A2TNZxZ1OC5/EtjXnANe8/9P8O5PEsreEy1tgcQXd6gIMlEPAWk/pcBYW0mCfrtHwaF53nhnJZdLn9Yqns5/UNUVnaUoBzYVBha9Kxkc1ubmTQZ5BFCoikiM0uss/GZbktAobwN/w3/2CYSTWqQt9i6UvvdPDzIS2uRxcktSDjA7ecFyxNfCHN+qPPPTT+IPzkNYS7DbJVWb5YNIq3VT7CC0pCDA/npAeGFh6zra1PJXsyteSaHwR12jTH5FNxov8Kkpj0NAQ3oEetsMJT1tOx+YOK1lMZWZzailUXBYC0UUbd92xzbo6fdVVPLSPM8wthIQvc/RquBYesQRgDsCj/09xZEQjAsLOPg+nVkEa2NxNQJ2lVsN4S/H2aeDRWJa1IpJnCJqP1645FAdTZNX7g==;5:4R0V5huXM3uo4VnzxHXgcAs3PAnguED3q0TrPPc9yWyl5nySQDaGIgNhjB9tIvFBg5+o2nuACzmeuG0Tsm5zCfAWRORBsVtFVIfp6AJeFG8cFKPLltAVnZCgcyRbVbwf+y1nj76doYegvtNq1T/uFj6wljDeipjkogAd21JCt7Y=;7:Mugsj+lCKFqYLUIStMKNAeG6Rv4g5EnFK+q1w17qXdykP/SnfnOwMKNWqlayD71+ptcevJ8aPYC0ep+782MYeCqq1IOwBUFbwXk7LIb7rBjRht6POXHaapbv17FpHCJENCn3hW10OGJRCRUil1laO3bPZfDlu+hZ8caJEHJ8BHKA6GGn9SmvcXLepc/Av1gegjOX/KzW+KHZEg0qD7XdgLayZzKNnziDmocXX5NGpZgPhATnO3Bn6hoRXd8H1dGu
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d101638b-77c6-4578-8a97-08d60380ef0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR04MB1806;
x-ms-traffictypediagnostic: SN1PR04MB1806:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN1PR04MB1806285C857D3E443E3E293CEA3E0@SN1PR04MB1806.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:SN1PR04MB1806;BCL:0;PCL:0;RULEID:;SRVR:SN1PR04MB1806;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39860400002)(13464003)(199004)(189003)(5660300001)(33656002)(76176011)(486006)(4326008)(68736007)(25786009)(72206003)(14454004)(81156014)(81166006)(561944003)(256004)(446003)(99286004)(476003)(11346002)(7696005)(6916009)(2900100001)(66066001)(54906003)(478600001)(316002)(8676002)(2906002)(7736002)(305945005)(53546011)(5250100002)(26005)(186003)(105586002)(6246003)(6436002)(6116002)(3846002)(55016002)(74316002)(53936002)(9686003)(106356001)(86362001)(6506007)(97736004)(102836004)(229853002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR04MB1806;H:SN1PR04MB1824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8nI6/Zjm2D7MxSe+/qYKHpINebhaSiVq4JlUhyGI2MukKgJ5FU3jqLtLjn6X3hCgsrK5d1E8yUAh0aDUooRjG9ymGy/kOnsK4d5g2fVdG01xocHJQ9SRBwPxEJqnpOs8/ydDcGPg2sK+DqHdNyFw2++JzG0LGMN9Bva8N9Ps/2L906mXPgDvQTTCWHdfIRWWbTPZ8irTCd/4wRZxu/KnMvidnyUWJzN2ughOQ+FulPD6xe0RpXabTfsTeSY15ASywdJdbPhNQsxXM4lTqUSbeYs1sWXZ6KBSf0VokPIxTx72EJsKyh9LvxeYPj4mK3cnsKkqN3AG/rvSO/rtRymwE0m8S2cwRCewtYgrERyt9c0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d101638b-77c6-4578-8a97-08d60380ef0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 14:02:41.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR04MB1806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,
We did not test the slice by 4 or 8 tables.  I'm not sure of  the value of =
doing that since the slice by 16 will provide the best performance gain.   =
If I'm missing anything here, please let me know.  =20

I'm working on a new version of the patch based on the feedback from others=
 and will also change the pointer variables to start with p and fix the ind=
enting you mentioned below in the new version of the patch. =20

Thanks

Jeff Lien

-----Original Message-----
From: Eric Biggers [mailto:ebiggers@kernel.org]=20
Sent: Friday, August 10, 2018 3:16 PM
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org; linux-block=
@vger.kernel.org; linux-scsi@vger.kernel.org; herbert@gondor.apana.org.au; =
tim.c.chen@linux.intel.com; martin.petersen@oracle.com; David Darrington <d=
avid.darrington@wdc.com>; Jeff Furlong <jeff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.

On Fri, Aug 10, 2018 at 02:12:11PM -0500, Jeff Lien wrote:
> This patch provides a performance improvement for the CRC16=20
> calculations done in read/write workloads using the T10 Type 1/2/3=20
> guard field.  For example, today with sequential write workloads (one=20
> thread/CPU of IO) we consume 100% of the CPU because of the CRC16=20
> computation bottleneck.  Today's block devices are considerably=20
> faster, but the CRC16 calculation prevents folks from utilizing the=20
> throughput of such devices.  To speed up this calculation and expose=20
> the block device throughput, we slice the old single byte for loop into a=
 16 byte for loop, with a larger CRC table to match.  The result has shown =
5x performance improvements on various big endian and little endian systems=
 running the 4.18.0 kernel version.
>=20
> FIO Sequential Write, 64K Block Size, Queue Depth 64
> BE Base Kernel:        bw=3D201.5 MiB/s
> BE Modified CRC Calc:  bw=3D968.1 MiB/s
> 4.80x performance improvement
>=20
> LE Base Kernel:        bw=3D357 MiB/s
> LE Modified CRC Calc:  bw=3D1964 MiB/s
> 5.51x performance improvement
>=20
> FIO Sequential Read, 64K Block Size, Queue Depth 64
> BE Base Kernel:        bw=3D611.2 MiB/s
> BE Modified CRC calc:  bw=3D684.9 MiB/s
> 1.12x performance improvement
>=20
> LE Base Kernel:        bw=3D797 MiB/s
> LE Modified CRC Calc:  bw=3D2730 MiB/s
> 3.42x performance improvement

Did you also test the slice-by-4 (requires 2048-byte table) and slice-by-8 =
(requires 4096-byte table) methods?  Your proposal is slice-by-16 (requires=
 8192-byte table); the original was slice-by-1 (requires 512-byte table).

>  __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer,=20
> size_t len)  {
> -	unsigned int i;
> +	const __u8 *i =3D (const __u8 *)buffer;
> +	const __u8 *i_end =3D i + len;
> +	const __u8 *i_last16 =3D i + (len / 16 * 16);

'i' is normally a loop counter, not a pointer.
Use 'p', 'p_end', and 'p_last16'.

> =20
> -	for (i =3D 0 ; i < len ; i++)
> -		crc =3D (crc << 8) ^ t10_dif_crc_table[((crc >> 8) ^ buffer[i]) & 0xff=
];
> +	for (; i < i_last16; i +=3D 16) {
> +		crc =3D t10_dif_crc_table[15][i[0] ^ (__u8)(crc >>  8)] ^
> +		t10_dif_crc_table[14][i[1] ^ (__u8)(crc >>  0)] ^
> +		t10_dif_crc_table[13][i[2]] ^
> +		t10_dif_crc_table[12][i[3]] ^
> +		t10_dif_crc_table[11][i[4]] ^
> +		t10_dif_crc_table[10][i[5]] ^
> +		t10_dif_crc_table[9][i[6]] ^
> +		t10_dif_crc_table[8][i[7]] ^
> +		t10_dif_crc_table[7][i[8]] ^
> +		t10_dif_crc_table[6][i[9]] ^
> +		t10_dif_crc_table[5][i[10]] ^
> +		t10_dif_crc_table[4][i[11]] ^
> +		t10_dif_crc_table[3][i[12]] ^
> +		t10_dif_crc_table[2][i[13]] ^
> +		t10_dif_crc_table[1][i[14]] ^
> +		t10_dif_crc_table[0][i[15]];
> +	}

Please indent this properly.

		crc =3D t10_dif_crc_table[15][i[0] ^ (__u8)(crc >>  8)] ^
		      t10_dif_crc_table[14][i[1] ^ (__u8)(crc >>  0)] ^
		      t10_dif_crc_table[13][i[2]] ^
		      t10_dif_crc_table[12][i[3]] ^
		      t10_dif_crc_table[11][i[4]] ^
		      ...

- Eric
