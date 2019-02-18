Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E98C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFECA217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g/NtkkCv";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="AZWyLxSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfBRLdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:33:53 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:44456 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728853AbfBRLdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:33:50 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IBPHx1007091;
        Mon, 18 Feb 2019 03:33:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=xQ5RzwR9irnmMT/V+ndq6zAnR/TeDb422eELnr2y2S8=;
 b=g/NtkkCvdMXYtLzITM3XqwPkdHpDRzVvxBVyP9ONg6ofS1DzdDEwd1CO3P+zC3zsQ/VY
 tlMHpTUTkT7fh6c30hYfDIXOMAxTMHaTTr+rL46C/IEJNAPAmMbEDWpl0+aIzKi+9WTZ
 /+8gSdew5iaxdIju0otoFBPHv9UyEMR1VZVIMUGh2DYiXM1HX14IBJkLaYcOhvBtkaUU
 UGnjQ1YmWLuSlGTz1C/wQXS0UXnbjPYbmGoy4muUUj5FXgnMmWgLVpC8SC+xWEvWu+ys
 jZ8CiW+15rHevIOfYuYLqwMLqLw+wblXv7wH/RsA1lxpfG5af1llZbJitvqMZO3UpzC/ 9w== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw9ua-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 03:33:40 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 03:33:36 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 03:33:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ5RzwR9irnmMT/V+ndq6zAnR/TeDb422eELnr2y2S8=;
 b=AZWyLxSZ6GaRnfB2TmW6bgblXvP1HCre90JwnmMZbMRCTEXfvo5T3WllbEe2FVdvN/GFhavFqfO6GsU7qL/D0s1KPHv96Tj18LI5xxeQ1tvaq3pWBBT3cZk8CPXeZvryGpW04nG14iEufG7N2bYwMy4ly68MF5yPGvAZSdKnt+I=
Received: from DM5PR18MB1067.namprd18.prod.outlook.com (10.168.118.137) by
 DM5PR18MB1291.namprd18.prod.outlook.com (10.173.213.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 11:33:30 +0000
Received: from DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa]) by DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa%12]) with mapi id 15.20.1622.018; Mon, 18 Feb
 2019 11:33:30 +0000
From:   Stefan Chulski <stefanc@marvell.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while
 reconfiguring the serdes lanes
Thread-Topic: [EXT] Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS
 while reconfiguring the serdes lanes
Thread-Index: AQHUx3bFS7RNBEaHv0ChYqzQ9pH1J6XlX+OAgAABPACAAAEokIAACN+AgAAAb0A=
Date:   Mon, 18 Feb 2019 11:33:30 +0000
Message-ID: <DM5PR18MB106791EDF70EB40CD48BF7D8B0630@DM5PR18MB1067.namprd18.prod.outlook.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
 <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
 <20190218102630.GA3784@kwain>
 <20190218104302.bp6ccmpkt26dflyx@shell.armlinux.org.uk>
 <20190218104757.be63b5ft5jpongn3@shell.armlinux.org.uk>
 <20190218105222.GD3784@kwain>
 <DM5PR18MB1067E1DD47E7094E02043A58B0630@DM5PR18MB1067.namprd18.prod.outlook.com>
 <20190218112815.ec3pyuvzpphdance@shell.armlinux.org.uk>
In-Reply-To: <20190218112815.ec3pyuvzpphdance@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b998e9c-df81-42f4-ed4e-08d69594e86e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1291;
x-ms-traffictypediagnostic: DM5PR18MB1291:
x-microsoft-exchange-diagnostics: 1;DM5PR18MB1291;20:RKT/jRTv/Tl3qMNMChJxAcccAYwpBUuUbvDa1Nrl2OQPl1+57jx9d+BRWfLMXfi1qFNC5AzOsXIiLpyl7IIokx3aCXWGvOePCngQ2HgMZXKFOplZ9MAmNWICiDe0PXsrTQ/xmrQtW3rT4iD7RgvRDLcE5HGanmh7FOVVd27fOk4=
x-microsoft-antispam-prvs: <DM5PR18MB12919E6C3B225A3B70460210B0630@DM5PR18MB1291.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39850400004)(189003)(199004)(13464003)(486006)(229853002)(3846002)(6116002)(66066001)(26005)(86362001)(186003)(68736007)(105586002)(316002)(11346002)(446003)(33656002)(476003)(54906003)(93886005)(106356001)(6916009)(4326008)(99286004)(305945005)(81156014)(81166006)(7416002)(8936002)(256004)(53546011)(76176011)(74316002)(7736002)(6506007)(102836004)(6436002)(25786009)(2906002)(7696005)(478600001)(97736004)(5660300002)(53936002)(9686003)(14454004)(6246003)(71200400001)(71190400001)(8676002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1291;H:DM5PR18MB1067.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SRoGWEj5aD8q2/R5tIxXC3FNq7qBRdoxADa4uP0QJ8oRd8THMlUq8KEmSbc+/rt/yTiuX8E97yZ7xR7uK/scD7mJertRGxBQPvxsCoPwtPX4EApqvIbyMGsuKTbccTeQH9ltAyMX1eAKPhnf3Dis2XSt1TvCYery4go/5684SCWV3hqvna4LJ6yJil1+3kI/6T0uhZpAY6vkMtT1km3v8+SxZpB16JPgr+GKHNWIeHMXv6TJ+q8f6V4oUXcBN/qk3VjrVnxo8EkJSzBDGHkQZHXT7KKNlSIdY1s2/Klul7Tw+aIln1Zi3IvFMDNk7ADxxPGIOzPKbt3cxWu5CXOU2tVzcZcW4L8mzsOSWjoHf6L5/xvBUnJQwCKEzTru9Mw5W18Z/eSMwyA5LmVCNtEzrFG9EpNKc/9t/fek+qTTqCU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b998e9c-df81-42f4-ed4e-08d69594e86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:33:30.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1291
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=729 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Monday, February 18, 2019 1:28 PM
> To: Stefan Chulski <stefanc@marvell.com>
> Cc: Antoine Tenart <antoine.tenart@bootlin.com>; davem@davemloft.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> thomas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com;
> gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai
> <nadavh@marvell.com>; Yan Markman <ymarkman@marvell.com>;
> mw@semihalf.com
> Subject: Re: [EXT] Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS
> while reconfiguring the serdes lanes
>=20
> Hi Stefan,
>=20
> On Mon, Feb 18, 2019 at 11:08:34AM +0000, Stefan Chulski wrote:
> > HW recommendation upon Serdes reconfiguration are the following:
> >
> > 1. Disable port(CTRL0_REG - in XLG/GMAC) 2. Put port in reset (both
> > XLG/GMAC) 3. For KR - put in reset MPCS (MAC control clock, RX SD
> > clock, TX SD clock), XPSC is RXAUI/XAUI clock domain 4. Power down
> > Serdes lane
> >
> > Do reconfiguration of Serdes.
> >
> > 5. Enable Serdes lane
> > 6. Disable MPCS reset for KR
> > 7. Disable port reset (both XLG/GMAC)
> > 8. Enable port  (both XLG/GMAC)
>=20
> For clarity, presumably either the XLG or the GMAC should be released fro=
m
> reset and enabled at any one time depending on the configured mode, but
> never both together?

Yes.
Only one of them the XLG or the GMAC ,depending on the configured mode.

Best Regards.
