Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63718206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TDN8PN7p";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cW6XcCin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBWG0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:26:52 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36762 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfBWG0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:26:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1N6HTSd009463;
        Fri, 22 Feb 2019 22:24:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=yPIco4rHfQmP14yNryrYVj6sWo9lcbzFC6pswTmyhPU=;
 b=TDN8PN7pwGZftrRl9q9Au8l7aTCHEaLtVNz/mp+sjaGJFraUGb4PtR2Yne/EJj06digM
 FYzacYZhww4tc0xi81ja7f9xHOujEYIj0r7GaJz/LdJ8WDHLMrhQaudUP9UNUQEe6KUH
 rfySUC6t9R5d/lGbxRHt7xIKTnhZuzlkNiAAim7FcPLL2if18lfIbD++hbYMhKn49DXL
 /UxOf8kJNhJoEGk8FoKdqwt2ikEUt/z/RBbb2Q5VH/IH4xYrfrnd1sCgQ6qUnppGynl5
 EN1F6FaHCQ4vly96VMo7EwBlhYJ3GyTyUS+95GCa7PdvLOCXQkcy0gyQPWglVGacNobQ Dw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qsqnjsqny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 22:24:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPIco4rHfQmP14yNryrYVj6sWo9lcbzFC6pswTmyhPU=;
 b=cW6XcCinXqHVvYlJQuxi9OEvef86YZm4pewDy9YEOvBSlB/IMy6/j5Az76bQR9Z11Bc7/ZVtU4Q1nEvEL1zUc0KUoWTJwHLAhIz/yerl3DuOW5yRiRGQF7Yf9+t+kXGLKsPd65v4aLT1tCDqb+dAfuMUzQpw36lor7X6V5m6xM0=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2581.namprd07.prod.outlook.com (10.166.201.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.19; Sat, 23 Feb 2019 06:24:46 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Sat, 23 Feb 2019
 06:24:46 +0000
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
Subject: RE: [PATCH 3/3] net: ethernet: add support for high speed mac and
 usxgmii pcs
Thread-Topic: [PATCH 3/3] net: ethernet: add support for high speed mac and
 usxgmii pcs
Thread-Index: AQHUyusMNTc17fToFkyDOwF9rbzbhKXsWZ8AgACRU+A=
Date:   Sat, 23 Feb 2019 06:24:46 +0000
Message-ID: <CO2PR07MB246952476A8F08C9EC245BC5C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201309.GA23470@lvlogina.cadence.com>
 <20190222214404.GP5894@lunn.ch>
In-Reply-To: <20190222214404.GP5894@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNGJhYzZkZS0zNzMzLTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcYjRiYWM2ZTAtMzczMy0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSI5OTEiIHQ9IjEzMTk1Mzc2NjgzNjcxMDU3OSIgaD0idHRER01vMjRLTmhXVENYQ1NlWkxrb0NqU1FvPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 049af0f1-1a94-4493-f70c-08d699579b48
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2581;
x-ms-traffictypediagnostic: CO2PR07MB2581:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2581;20:RxJ7tf1cRN3LwDpq9F3Pu3UnTKcap3ACtZhj3mBjy2vZ2oxXFumbWaYApGTlOzI7uA+P5l08GuFhMrYEaAE6mJlf+NH3DwuKrwcPgHMrH4gJDaitJzFCfoZN/NTXjJfdR03Q9o/8+HXPwkRMlE9hKIVAOfYa7r7mSUQXrByg7VAFLiNw+sIyl4QQTAi/s0rqKZPj5XZ8WR6ckXpth/rZoK/Q0mcZPiJexsQt5FsgjHijD1Tp6hnx6i2z1yhlulke
x-microsoft-antispam-prvs: <CO2PR07MB258150E0F469AAA2E6080DFFC1780@CO2PR07MB2581.namprd07.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(36092001)(102836004)(6916009)(6506007)(26005)(76176011)(6436002)(52536013)(8936002)(5660300002)(81156014)(8676002)(81166006)(97736004)(105586002)(7696005)(106356001)(99286004)(316002)(11346002)(446003)(54906003)(7736002)(486006)(68736007)(476003)(86362001)(186003)(229853002)(74316002)(25786009)(305945005)(2906002)(71190400001)(4326008)(71200400001)(33656002)(55016002)(53936002)(4744005)(107886003)(6246003)(478600001)(66066001)(256004)(6116002)(9686003)(3846002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2581;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YdvaPI/EYUQ46sxpyF2CGv9c86/pE1a+R34xH7O2kRObfI0Ghui5UhEkFKRGoOCoFz0r9kK1+6zydE0zQ7/qsPT2ot6BcUgJsFcwD9jm/zFVm7+BCATCbhh4PW3n5WxELWQkNUMtxbY54fHg0nxnApOPzXTMWvfFgnighKS+8Zvb0xDZifyGQaak5fsLlu2Hp8V0lHvzoiTW9Zez2962eJwxbV5xjUXjhplC7z691nFAu6Cz53VpPaMxIcXYg+fhl16gX2/0mxtR0MDF8F/lqIKs8TPgsxR7TRvdeay+HRspMAvLygEYA6EaJq6dAkCZwjFb6UGKGjeBRL3nTvvJAnp3Z7OyCyznFar7dix2gbbizRt6n6e6Cnv41oQhqLgR/XRX39dbfp8OUGVL4WPdt7vfG1frnXwhpKgWwtOEn2c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049af0f1-1a94-4493-f70c-08d699579b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 06:24:46.4177
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
 mlxlogscore=581 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902230044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	if (macb_is_gem(bp)) {
>> -		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
>> -		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
>> -
>	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> -					 phydev->supported);
>> +		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
>> +			linkmode_copy(phydev->supported,
>PHY_10GBIT_FEATURES);
>> +		} else {
>> +			u32 bitmask =3D
>ETHTOOL_LINK_MODE_2500baseT_Full_BIT;
>> +
>> +			linkmode_copy(phydev->supported,
>PHY_GBIT_FEATURES);
>> +			if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
>> +				linkmode_set_bit(bitmask, phydev->supported);
>> +		}
>
>Same issue again. Somebody could be using a 10G MAC with a 2.5G PHY.
>
>     Andrew
Hi Andrew,

Ok, I think this should have been logical AND. I will modify to use phy_set=
_max_speed()=20
instead of directly copying linkmodes.

Regards,
Parshuram Thombare
