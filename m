Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E594C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA912084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="g0vybmhB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="g4hOxE1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfBYITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:19:11 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41868 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbfBYITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:19:10 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1P8Egs4019666;
        Mon, 25 Feb 2019 00:19:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=y9rqVKk2ZIbYkMjzRkaMSWhkeiKt3plTpgqiIWkrdS4=;
 b=g0vybmhBwq/1Ne+LZGr77wK5dvcQ8CGEuEA7TkrQTjWyuO6srwP0hiNVUqrn3/PzRGZo
 ZpoNp9JMBEDnWY/iPxiGqcfr9iasYdtJdSxtLvGvVpnRozPv4b0YGQvVfv60wOCMnom+
 V0ADMTCFrRpSuzEFzT+BCRmkJd6Jwzzk060JfeFqAfoXW2Ud+JOupqCLKPtytUF96s67
 BjU0R5VZp1cW10E3N9y8WrcUf4/IBpHcShPSn8DCLdnxCWbqqOIHXNQbCDGr0lhlYuwp
 qP6BVCmcQ0wPruU+jH4fcPlcuN88UxC7FxfZDyGa+OW2uxVNMZw5xNOTZ5bNKgX403mh PQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qu2n1ekfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 00:19:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9rqVKk2ZIbYkMjzRkaMSWhkeiKt3plTpgqiIWkrdS4=;
 b=g4hOxE1P1RgzOeMFHDFW/r7iikshCA2R2TeHhrA9c67G/AI7psSQf4iBNGWrpVKnOiDicxTmRZ5I4JKeIA9zyqh+w7ib1Ok034wrIyU9v2YHLrsZjfV/lFjr8R8xbgoZT5DNmPveg2vF2ECZdwY0gBJV+JjwWwlwFX7GEl9kuQQ=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2725.namprd07.prod.outlook.com (10.166.200.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 08:18:58 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Mon, 25 Feb 2019
 08:18:57 +0000
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
Thread-Index: AQHUyur7TcFel7TGu0Sk9cKMaw0yw6XsWPMAgACSKrCAAJZkAIACrOPw
Date:   Mon, 25 Feb 2019 08:18:57 +0000
Message-ID: <CO2PR07MB24695EDFACCBD9589EADF533C17A0@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201242.GA20889@lvlogina.cadence.com>
 <20190222214140.GO5894@lunn.ch>
 <CO2PR07MB2469D90FD13642D668F8D281C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
 <20190223152304.GD10693@lunn.ch>
In-Reply-To: <20190223152304.GD10693@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mZDI2M2NmZC0zOGQ1LTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcZmQyNjNjZmYtMzhkNS0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIxMDk4IiB0PSIxMzE5NTU1NjMzNDc5OTc3MzMiIGg9IlQ4MWpqUkZDNHVlN0JyOEVqS3lEUkJTUmtKST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac9d1fa-8f74-4829-cb49-08d69af9e3db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2725;
x-ms-traffictypediagnostic: CO2PR07MB2725:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2725;20:6PEiVwwf83kzMvwM6Da5DtgXkXuKaoqdT+tEfKaBQ0g94HPg0Kt8iuwwxW8sZ/aJKlVA5G3GUfHL4DEycIa92OUqWs624K8ACxokjxGyDbVa5qtGbnK8sRUSku0yimEQlikEYd8ojCHQOhDzrAZwClt8X2ws9LpXkjOrGfViWT4Bmqp8gFEQoBwDGPEoilqLfd9t/CkWmdbcmeo0nlFdiBg9OWbebt07vypUn6QR8rawqf9nNQgBPXLPSLLkd4Cg
x-microsoft-antispam-prvs: <CO2PR07MB2725A756CC5B16DEE38693B1C17A0@CO2PR07MB2725.namprd07.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(396003)(366004)(346002)(136003)(36092001)(199004)(189003)(26005)(476003)(8936002)(102836004)(446003)(11346002)(486006)(8676002)(186003)(81166006)(81156014)(99286004)(7696005)(316002)(14454004)(71200400001)(71190400001)(86362001)(2906002)(76176011)(6506007)(55236004)(305945005)(93886005)(7736002)(6246003)(74316002)(25786009)(33656002)(107886003)(54906003)(478600001)(68736007)(4326008)(9686003)(106356001)(4744005)(78486014)(256004)(6436002)(5660300002)(3846002)(53936002)(66066001)(52536013)(6116002)(229853002)(105586002)(55016002)(6916009)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2725;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ALZ5r05mb7/aa447yaVnedzprtKYp9frC9R6wblBpSQyV7JmdtqezWhsSX05aCbfKvlVAyroPXj7HIytKVmUbtfRg+ucLTr+jjuHPkgp+WL3Hk6EWnjHgq6umUW9mA89qASBcinsVC7ctrFyEXtFwp+HQ2VezrEj6A63btjjBkN5pQbyf/TsBvU9Q7fACA6RDAsNYPh27QNkbsUvQuHOTYxitnzVK1/HJsVJbGgdJN5Eda7AYPh2z59+ChUa61DIkyKrUc7bjON80qzJIuqFKSWEV3+atJPHyo4jT26fhlJEzMzOimy4bFKc/JgrISsefRuza0HjXmI2tVWz+6T2qyNsrxJWU1ph+ifT09kpm2P1jY9jGvkiAe142o1GOcLJ8mNfp7/WCKW9RNuPKOZDUMb/H619/1hFCDyt/V3mH/k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac9d1fa-8f74-4829-cb49-08d69af9e3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 08:18:57.7688
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
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
>> >> This patch modify MDIO read/write functions to support
>> >> communication with C45 PHY in Cadence ethernet controller driver.
>> >
>> >Hi Parshuram
>> >
>> >Are all versions of the MDIO controller capable of doing C45?
>> >
>> >    Andrew
>> Now driver support c22 and c45 PHY.
>> Are you suggesting to add check for C45 PHY using is_c45 in phydev ?
>
>You are unconditionally supporting C45. Are there versions of the hardware=
 which
>don't actually support C45? You have this endless loop:
There is controller which don't support C45. I will add check for that usin=
g is_c45.
>
>+       /* wait for end of transfer */
>+       while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
>+               cpu_relax();
>
>If there is hardware which does not support C45, will this loop forever?
>
>	Andrew
Yes, this bit is supposed to be set. I will add timeout here.

Regards,
Parshuram Thombare
