Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629E120989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="F8CFrRC+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X3iwGths"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBYIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:20:05 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42332 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbfBYIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:20:04 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1P8F5KK019819;
        Mon, 25 Feb 2019 00:19:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=6UKqE5YxDcjWK3uqmJa2AGuSqLG5W1Oxm1IuptOUVsE=;
 b=F8CFrRC+/jvQDCgxdimYrkulXqtHiXjCVqgmC54thdDqsJCyLzDSxROqM55L1qMn7chQ
 KH4BvMkw6HDZw4ILYH8DLLJxxGf5PVl5wgT6upHMWYE2XHUgRNlb1gGw8VS6A8DOPYel
 82QwnUYwFD1xaRB5P5EEM/8D/AajpZDvJ1YplBB1LUJTFZsZ/QTdDdbbPoLVoQn4WVaT
 nWbC9UfbCNFeskJvErzT23mtsAxvrim9i68NSLYae2A7lSlJYN68fkGcAyL8rqojCbW+
 +Eo7F4xXkZB3K+hzCpzHS5ekWv9VI+IXOXH13v++x30bBhJzZlDKvnEK8b3XEWkZGvzI WQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qu2n1ekjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 00:19:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UKqE5YxDcjWK3uqmJa2AGuSqLG5W1Oxm1IuptOUVsE=;
 b=X3iwGthsM8nFmFO39eyHuK0mvPxQdHnc3v9TnfCm6Jxqgp7uRg63eBqzI8nc3xeykaMUo80UbdqU/e5NTinxuFp3zbG3x9ck0YXp3wYmNT90NIYpnTDs7K2OCWj0JCg7dVZ4OZd+xhCYl0khZ11I/AnzHzHZwEO0y9fAb4Zsgb0=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2725.namprd07.prod.outlook.com (10.166.200.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 08:19:56 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Mon, 25 Feb 2019
 08:19:56 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: RE: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO read/write
 functions.
Thread-Topic: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Thread-Index: AQHUyur7TcFel7TGu0Sk9cKMaw0yw6XtgjsAgAKtf5A=
Date:   Mon, 25 Feb 2019 08:19:56 +0000
Message-ID: <CO2PR07MB24694139FA51343C9F39F9A8C17A0@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201242.GA20889@lvlogina.cadence.com>
 <20190223152540.GE10693@lunn.ch>
In-Reply-To: <20190223152540.GE10693@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0yMDI3M2RlNi0zOGQ2LTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcMjAyNzNkZTgtMzhkNi0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIyOTM2IiB0PSIxMzE5NTU1NjM5MzUyNzYwMTUiIGg9ImpVbmROL1QxNjdNeDNJYWxlZCtobEsvMmpXWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad1e0bd9-1e3b-4d5b-5d0c-08d69afa06b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2725;
x-ms-traffictypediagnostic: CO2PR07MB2725:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2725;20:N073CKGqdoUrRpKR90LxzDBYqhHfQcAGtpWuo1cHF+2nY0s5RUESv4jcCr0btessAqrd1ZYzX0fe+tYRnEC98+JLUWMepi2dXqHQf678HddKqWVUFRFP2yn/bCUUS3kHMEwRaj+PRMjT2CGyywB35EHuLOdTb3y8/gMaNH3+MBzk9xppkyTVvoJJXOsAw7hlSLwPiisNj3zxdqWh6GxJaE8LPAN1gXrtztvw6QFX5HLig7frIiwZ8HEkPVuz1LVL
x-microsoft-antispam-prvs: <CO2PR07MB272585D1FFD9121AD2AF9F18C17A0@CO2PR07MB2725.namprd07.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(346002)(136003)(36092001)(199004)(189003)(26005)(476003)(8936002)(102836004)(446003)(11346002)(486006)(8676002)(186003)(81166006)(81156014)(99286004)(7696005)(316002)(14454004)(71200400001)(71190400001)(86362001)(2906002)(76176011)(6506007)(55236004)(305945005)(7736002)(6246003)(74316002)(25786009)(33656002)(107886003)(54906003)(478600001)(68736007)(4326008)(9686003)(106356001)(78486014)(256004)(6436002)(5660300002)(3846002)(53936002)(66066001)(52536013)(6116002)(229853002)(105586002)(55016002)(6916009)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2725;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eoccntv6dAm5ySMdPpmekj97K62tNa2ukQOB+vq3Xu79qPWw14/enD9igkFFmeOaOe3X5Ef58m6Pb/7lu89pmK10/68eRZOlpvk+Dnr31kr4HDhr4j5xMkg4coGug+9ZTo6NNvf4UFRaCFaDs2kr4T4VxVOFshVW3t+isqdkQmahyGooZNAVzqyEAn6/zn7Qnx0en69ZWIFbIKsT9hwiXS6rQCWI5NrmRP1PbXByKrnoXE+Y4liXWNH/GKOLuUgkKwRAaug27d1Iuhy7Jls6wuqSEESOcrV7KFDAMyPWtMPGFHyWr+5+mq/dX22yvzsYeHUIY586esWezY3Vub8YZiUcDttgvKqrIre8A5MzvXt847Cp0cm/M60nONwmoi8RWGvkN03KKpJajUYBO4gbgvejCz2HNkYzkLESpg2HAhM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e0bd9-1e3b-4d5b-5d0c-08d69afa06b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 08:19:56.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2725
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
>> This patch modify MDIO read/write functions to support communication
>> with C45 PHY in Cadence ethernet controller driver.
>>
>> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   15 +++++--
>>  drivers/net/ethernet/cadence/macb_main.c |   61
>++++++++++++++++++++++++-----
>>  2 files changed, 61 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h
>> b/drivers/net/ethernet/cadence/macb.h
>> index bed4ded..59c23e0 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -636,10 +636,17 @@
>>  #define GEM_CLK_DIV96				5
>>
>>  /* Constants for MAN register */
>> -#define MACB_MAN_SOF				1
>> -#define MACB_MAN_WRITE				1
>> -#define MACB_MAN_READ				2
>> -#define MACB_MAN_CODE				2
>> +#define MACB_MAN_C22_SOF                        1
>> +#define MACB_MAN_C22_WRITE                      1
>> +#define MACB_MAN_C22_READ                       2
>> +#define MACB_MAN_C22_CODE                       2
>> +
>> +#define MACB_MAN_C45_SOF                        0
>> +#define MACB_MAN_C45_ADDR                       0
>> +#define MACB_MAN_C45_WRITE                      1
>> +#define MACB_MAN_C45_POST_READ_INCR             2
>> +#define MACB_MAN_C45_READ                       3
>> +#define MACB_MAN_C45_CODE                       2
>>
>>  /* Capability mask bits */
>>  #define MACB_CAPS_ISR_CLEAR_ON_WRITE		0x00000001
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 4f4f8e5..2494abf 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -323,11 +323,30 @@ static int macb_mdio_read(struct mii_bus *bus, int
>mii_id, int regnum)
>>  	struct macb *bp =3D bus->priv;
>>  	int value;
>>
>> -	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
>> -			      | MACB_BF(RW, MACB_MAN_READ)
>> -			      | MACB_BF(PHYA, mii_id)
>> -			      | MACB_BF(REGA, regnum)
>> -			      | MACB_BF(CODE, MACB_MAN_CODE)));
>> +	if (regnum & MII_ADDR_C45) {
>> +		macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C45_SOF)
>> +				| MACB_BF(RW, MACB_MAN_C45_ADDR)
>> +				| MACB_BF(PHYA, mii_id)
>> +				| MACB_BF(REGA, (regnum >> 16) & 0x1F)
>> +				| MACB_BF(DATA, regnum & 0xFFFF)
>> +				| MACB_BF(CODE, MACB_MAN_C45_CODE)));
>> +
>> +	/* wait for end of transfer */
>> +	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
>> +		cpu_relax();
>
>You need a timeout here, and anywhere you wait for the hardware to complet=
e.
>Try to make use of readx_poll_timeout() variants.
>
>	  Andrew
Yes, I will add timeout here.

Regards,
Parshuram Thombare
