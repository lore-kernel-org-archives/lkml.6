Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD15C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FD9206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tNvwLvJv";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VbGVXBjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfBWGY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:24:26 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39376 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfBWGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:24:26 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1N6Iqd8022621;
        Fri, 22 Feb 2019 22:24:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=z6VvB0laxcoKoOuDEEur5pbxbDH2ex/O3ifpeCjERYY=;
 b=tNvwLvJvYuNsZr7eZiVanDENHNJwRyE6mlTjMvN4WBRFKhIxbIlDHqnJcK20jIqTgWMB
 upNyekZHFesgVvqT4BN+C45w6QT40IkR7VDyr111z9cUrIxlFmqfvBIGzd1BXOd1dsjB
 yjiq7YfsXUXE5Xt0UiZkNG2byGoOj66hapHSq2cO2L4CMPFDQhdnW1EY1NHTe1yUX5xA
 dECLTotcF+CQvfX4Rss0r06RKX8ZNVIjCOZqzA8GVQJIpHwnVhrkTSU+Xo/XAbOk0JWW
 qgvpNnhKiCiariFN1x/7jspcmNkGBFJWMaYao3N0rXPOXXEyIYpCQU8BtUPd5CmH8ALX 9w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qspmmt587-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 22:24:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6VvB0laxcoKoOuDEEur5pbxbDH2ex/O3ifpeCjERYY=;
 b=VbGVXBjZaY64pNY6xrqvOmxSopb8Vs9a5jdvmnWcvIf6ERpqobfY6iIvfX/PV4V9pYN+g3MXna63Cr2us6OiiVqJzYfSAbCWQeP1PcsMUsYBYzhIF97WPSGa0cw1ppuLB8Gyd0NC09djlJFMwiwzYosFTZ+17iFG+zE8eq6JhBw=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB2581.namprd07.prod.outlook.com (10.166.201.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.19; Sat, 23 Feb 2019 06:24:10 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::2dd8:8928:51ed:e54c%9]) with mapi id 15.20.1643.018; Sat, 23 Feb 2019
 06:24:10 +0000
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
Subject: RE: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
Thread-Topic: [PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
Thread-Index: AQHUyurwpLGiBC19RUK68gwMa78o/6XsWHSAgACRoqA=
Date:   Sat, 23 Feb 2019 06:24:10 +0000
Message-ID: <CO2PR07MB246952FB454FDD08FA41F624C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20190222201225.GA15633@lvlogina.cadence.com>
 <20190222213953.GN5894@lunn.ch>
In-Reply-To: <20190222213953.GN5894@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05ZWFjMjQzYi0zNzMzLTExZTktODRlMi0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcOWVhYzI0M2QtMzczMy0xMWU5LTg0ZTItMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIxMTk5IiB0PSIxMzE5NTM3NjY0NjY3Nzc0NjkiIGg9Im1HNXhJTTB5QmRYTW0ybURNYllWd2RLQy9FYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8955a6f-1071-4d9a-de54-08d6995785f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2581;
x-ms-traffictypediagnostic: CO2PR07MB2581:
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2581;20:AS4ZU+gXl45r4eSytosFabSOhAXsDRHIQAyqI6iefYar1ojZJZt422swMJhVTDZKu5qTTLOLzkkvXCjQC1Q3I3jaFQX5gmZWTsMeZ0Q5JSEH2Jtn2UzNg1XUJrT2sap878oKutNzP9iwn6EHjwP4fmLi6gTp03aDvOGb3xDkPIAH7Fg17yXSHeh408Mtiqdwz9ImWiqMQ9roE6rSSSAjbyFFCnbSEeBqEbhaWZ4QC2elXL4G/Pbq0wpPHypj/k5+
x-microsoft-antispam-prvs: <CO2PR07MB2581D5060A808BA19F61CC92C1780@CO2PR07MB2581.namprd07.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(36092001)(102836004)(6916009)(6506007)(26005)(76176011)(6436002)(52536013)(8936002)(5660300002)(81156014)(8676002)(81166006)(97736004)(105586002)(7696005)(106356001)(99286004)(316002)(11346002)(446003)(54906003)(7736002)(486006)(68736007)(476003)(86362001)(186003)(229853002)(74316002)(25786009)(305945005)(2906002)(71190400001)(4326008)(71200400001)(33656002)(55016002)(53936002)(107886003)(6246003)(478600001)(66066001)(256004)(6116002)(9686003)(3846002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2581;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RiF9GUhI94OObeG5j6HrKXtXYljsDsDsVU5BLKjoODsp+5p0SHrph8OSPuGVXQdlMmVvjASPqK+RZZCEijhG5JweU7lC6SxeWQPZs3PQzJo4LBh4GU8gRv+B7najTi2mko/Y1te521m7UE5MFhZgsF8vWiisJbLUoXb6XKkjv4NbMmCv8PXW3uKyk0aTMvnDSMxxGyQ98FE0CRYkbHRSnT6mz1QDgGytlw0UMsYhHhM674mkdjajCxroZ/Zbqma2GFUpe320kgI5EnP6fGXEGPQ5eRYeS41Vk44nhtSA52KIi6MHhMV94UxI5UDQa54+FSmETcLb9R1fUZvwnTZiNiTFDt+0T09HjLWyZrpiIyxXvSKcJ5bmvM4Tekl3GRDzeM88t5mbjsPMzh5PX9jq6Gmk0zFTGWFqnPXB58mlyIs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8955a6f-1071-4d9a-de54-08d6995785f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 06:24:10.6705
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
 mlxlogscore=880 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902230044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	/* mask with MAC supported features */
>> -	if (macb_is_gem(bp) && bp->caps &
>MACB_CAPS_GIGABIT_MODE_AVAILABLE)
>> -		phy_set_max_speed(phydev, SPEED_1000);
>> -	else
>> -		phy_set_max_speed(phydev, SPEED_100);
>> +	if (macb_is_gem(bp)) {
>> +		linkmode_copy(phydev->supported, PHY_GBIT_FEATURES);
>> +		if (bp->caps & MACB_CAPS_TWO_PT_FIVE_GIG_SPEED)
>> +
>	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +					 phydev->supported);
>> +	} else {
>> +		linkmode_copy(phydev->supported, PHY_BASIC_FEATURES);
>> +	}
>> +
>> +	linkmode_copy(phydev->advertising, phydev->supported);
>
>This is not correct. Just because the MAC can do 2.5G does not mean the PH=
Y
>can. So you should not be adding links modes. Also, somebody might be usin=
g a
>PHY that can do 2.5G with a MAC which can only do 1G.
>
>The correct thing to do is call phy_set_max_speed() with the maximum speed=
 the
>MAC can do.
Hi Andrew,

Ok, I think this should have been logical AND. I will modify to use phy_set=
_max_speed()=20
instead of directly copying linkmodes.

Regards,
Parshuram Thombare
