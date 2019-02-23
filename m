Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6388E20578
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ievfqkLC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fNVi58GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfBWG1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:27:16 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36812 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfBWG1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:27:16 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1N6REGd018692;
        Fri, 22 Feb 2019 22:27:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0XZxgIn4c76HHSePKyKTZwk7gppOqlBxudCtQzvzS60=;
 b=ievfqkLCoHHzVQqhE7gByqaEEMWdz68HQwQv2VJTmneXt1jAhTXjPsgobCgKHgzYEX69
 +QoPlQr63IAM4TCUPHDGc5cxmsFKzV7fm6zbctZWdCE33k8XQLx1zoNs3SmTvaUrBWK4
 SV4xA7KX9ROxE2Lr4S0JxyolBoO8o/NnPt3ji4LfCKXXRw/5rYMqqfetUDp/TqhpeToi
 z5LY8fky84IqSshtB63yH7f8kC2CszGY+Y64H3fCbBzWPugazqyWnioSnMmzBuuOKT3r
 vurvKG/+dxJUw4RaTjueWoqNxyxrHYRUWH3Ygrswo4c7sG//drSMZJvGjxUUNMHZsVbI Yg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qsqnjsqys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 22:27:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XZxgIn4c76HHSePKyKTZwk7gppOqlBxudCtQzvzS60=;
 b=fNVi58GDpwjBmxuNGC3TtUBQwbPM6W1ePC/kgRAnXfmwuju31MLlSitCFd+xXfx1SrvpmlVCOU57XSj1BryIbX624035uYQptQke817GpsTKP9yQ95H6jisX6p1bFvIAjKIZXyraD9m97XpNx9infROf0XFOV4iHafDYiaT3unQ=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2581.namprd07.prod.outlook.com (10.166.201.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.19; Sat, 23 Feb 2019 06:27:11 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Sat, 23 Feb 2019
 06:27:11 +0000
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
Thread-Index: AQHUyur7TcFel7TGu0Sk9cKMaw0yw6XsWPMAgACSKrA=
Date:   Sat, 23 Feb 2019 06:27:11 +0000
Message-ID: <CO2PR07MB2469D90FD13642D668F8D281C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201242.GA20889@lvlogina.cadence.com>
 <20190222214140.GO5894@lunn.ch>
In-Reply-To: <20190222214140.GO5894@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wYTk5MjgwNC0zNzM0LTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcMGE5OTI4MDYtMzczNC0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIxMTI5IiB0PSIxMzE5NTM3NjgyNzczODIwMTciIGg9IitMcjU0d3czTFc3VVhuM3dEKzdLM0NvY2xwVT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4566b940-18d9-42cd-b845-08d69957f1d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2581;
x-ms-traffictypediagnostic: CO2PR07MB2581:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2581;20:dG0zK0d03SeEbuPArHENDuI1ohqMH3jKyyZr9fU7suTcJ5ODDcMNZvwe+gPho0KYC+1+NorvlJJg6sC/L1m1sOB39KVsLSIrT6lg2UZcSOvoaHCOYiTMQeM3PTxkcaS9QveEXos96UK9nbAR1ArJZ4cjSOWea1hds+LYii4JlwntJ5uIjDZDy9K+h77DEk4iYm67+Cqflw4OWubBIXQKhW8L5d0wuEDfnr28g23SysFjks9UTi8JhZJRsoqqJij7
x-microsoft-antispam-prvs: <CO2PR07MB25810355AE242FA165C383B2C1780@CO2PR07MB2581.namprd07.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(13464003)(36092001)(102836004)(6916009)(6506007)(26005)(76176011)(6436002)(52536013)(8936002)(5660300002)(81156014)(8676002)(81166006)(97736004)(105586002)(7696005)(106356001)(99286004)(316002)(11346002)(446003)(54906003)(7736002)(486006)(68736007)(476003)(86362001)(186003)(229853002)(74316002)(25786009)(305945005)(2906002)(71190400001)(4326008)(71200400001)(33656002)(55016002)(53936002)(4744005)(107886003)(6246003)(478600001)(66066001)(256004)(6116002)(9686003)(3846002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2581;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YqOYZYk9kPywoDEKyR5jFScOhe7vh7UMWnNj20nl1x/Ez2yqRKAABzo3I1ulbz6EKlTVAhl3NEqMENNoMVtvaiHO3uqZPJyqVR64XvBl4tvzaqSwTsehMxnaJAuOWuS0x7OMy0n2iQ7e4kHfOy02AmlmL9tkFzGfjMF1nDmJAABR8OeOKa8eyXR7z0YMeGH0huar5eBPozeC1/iQJFsAfqBYZ7+tCcC+dxKhyfmkacwWQl5ACgQZrzQy4C5OLRZkqQfDGUAD7rJeKw0RDOEStxL1R/bjTyegQOyVU+aBd/klpFdjkaLnjDV12oFWWiopDriLHX4ywL5hxpIXPmIuR5aTMl7gMzzGEhEGUMRoNZFr9cOFZrxhqTFtn0cSGPtS6TSukEB/YkRgyHKPxZKUpGkZXJQ7oKWThhwSn6dkHtE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4566b940-18d9-42cd-b845-08d69957f1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 06:27:11.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2581
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902230045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Regards,
Parshuram Thombare

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Saturday, February 23, 2019 3:12 AM
>To: Parshuram Raju Thombare <pthombar@cadence.com>
>Cc: nicolas.ferre@microchip.com; davem@davemloft.net;
>netdev@vger.kernel.org; f.fainelli@gmail.com; hkallweit1@gmail.com; linux-
>kernel@vger.kernel.org; Rafal Ciepiela <rafalc@cadence.com>; Piotr Sroka
><piotrs@cadence.com>; Jan Kotas <jank@cadence.com>
>Subject: Re: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO read/w=
rite
>functions.
>
>EXTERNAL MAIL
>
>
>On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
>> This patch modify MDIO read/write functions to support communication
>> with C45 PHY in Cadence ethernet controller driver.
>
>Hi Parshuram
>
>Are all versions of the MDIO controller capable of doing C45?
>
>    Andrew
Now driver support c22 and c45 PHY.=20
Are you suggesting to add check for C45 PHY using is_c45 in phydev ?

Regards,
Parshuram Thombare
