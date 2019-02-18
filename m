Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63968C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15504217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cPbuUpcB";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="V0NhN1pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfBRLIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:08:48 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40890 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfBRLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:08:48 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IB4pJ2022712;
        Mon, 18 Feb 2019 03:08:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=cxg51Hu5t8kJNfn2axqRCCKIVavffFVk7npLRZStn8A=;
 b=cPbuUpcBfX3iLS14mKZKOJ4ytHsOrjiOCO84D6z1eGBmIw2PYY2BH6MdviW005+fu4E6
 bes+4bMQ64Qktegb2qtF6CICKz/D+hGq1IK7SWC/wXV3bK+Dx5lWTxMGGkx3QJ2Ex7rK
 qPtrx8xxsypnPh5qeg4R5uHxN4yAwDPf1uR7yb69L+81IzvImcKi7AZLVM5F90tuOZ7B
 UiuG643XODhi400BKG2sU6erl0b82SI5Ih7D1y8+PTGFPR8R38RkCyZJKppDd+wa2XSE
 YZWgBL6Eh6147g2O84s+Egok9rkn/s92ReZFYH+Y8Ie+qwYXCgXpKeguPUJA2SLsEB8L nw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw7x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 03:08:37 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 03:08:35 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 03:08:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxg51Hu5t8kJNfn2axqRCCKIVavffFVk7npLRZStn8A=;
 b=V0NhN1pidTpJslqpwT1aHEabXROQfgGF8AJ44+aZ9ZEurVEGvM68a13jX9+JTgoufBvFXCawwuO0xTS526VSMpr3NNkwGIftpjTRz8nkmtRSkXJ8KARTaAyV/vBNiCamcyWxrbYI1cZ5EWG8xZ+QzLr8MPdaHPeBbXIoOqOTTec=
Received: from DM5PR18MB1067.namprd18.prod.outlook.com (10.168.118.137) by
 DM5PR18MB0955.namprd18.prod.outlook.com (10.168.117.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 11:08:34 +0000
Received: from DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa]) by DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa%12]) with mapi id 15.20.1622.018; Mon, 18 Feb
 2019 11:08:34 +0000
From:   Stefan Chulski <stefanc@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
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
Thread-Index: AQHUx3bFS7RNBEaHv0ChYqzQ9pH1J6XlX+OAgAABPACAAAEokA==
Date:   Mon, 18 Feb 2019 11:08:34 +0000
Message-ID: <DM5PR18MB1067E1DD47E7094E02043A58B0630@DM5PR18MB1067.namprd18.prod.outlook.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
 <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
 <20190218102630.GA3784@kwain>
 <20190218104302.bp6ccmpkt26dflyx@shell.armlinux.org.uk>
 <20190218104757.be63b5ft5jpongn3@shell.armlinux.org.uk>
 <20190218105222.GD3784@kwain>
In-Reply-To: <20190218105222.GD3784@kwain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f9901d0-29dc-479a-86ec-08d695916c8b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB0955;
x-ms-traffictypediagnostic: DM5PR18MB0955:
x-microsoft-exchange-diagnostics: 1;DM5PR18MB0955;20:0sbyWYCfBprKiUFCL+8xJwAtz6achl24TUGmAMB+f7jMJsuTXESfHwWmAI2Gv1QI5krVUzSIkoH++u34cNRgacwuhMo9nY54QbyqmibKV96Xqvr/sAB91AG02plYF5ZWoU1K7nGCyg6KugNyhh8eGAjhHWRz9OyG1Qp+fyIXhkA=
x-microsoft-antispam-prvs: <DM5PR18MB09554AD55FFF98D3487DB8F3B0630@DM5PR18MB0955.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(39850400004)(376002)(13464003)(189003)(199004)(76176011)(2906002)(97736004)(102836004)(6506007)(305945005)(33656002)(7416002)(7696005)(74316002)(53546011)(3846002)(6116002)(7736002)(25786009)(81166006)(93886005)(9686003)(4326008)(316002)(110136005)(6246003)(54906003)(186003)(55016002)(26005)(86362001)(14454004)(5660300002)(486006)(11346002)(446003)(476003)(99286004)(8936002)(81156014)(256004)(53936002)(8676002)(105586002)(478600001)(71200400001)(66066001)(106356001)(229853002)(71190400001)(68736007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB0955;H:DM5PR18MB1067.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F6sKg3ouyO3tRPbOQ/kCF8b76qpkWx/GOuGcBqVEmQhXfQXO2TmOeAu4epz0+MxpyxptZCUsH9vWKodaTQ8NtyzwHzdgO4/BUE/Z60AWRQzJ2dpu6msSQ1G+0B/nPibCjLpXKJkX3ayGMOO+27ON6C9ymXy1cgHarKdwk5eLZFun5QDf//LzbRZvON0iu/1++G6zQZW4HsCatQkXdr2FwhD/BBolsP2IR+17PdtLMhPZqlCW0AVt5NfplVUo4f0nkjoH1qTkeKT7Bb4VvNjOXT2ROJpK3Hvy/5EfyKpGR7jJ/csAgXLmp0lBMg77SKnV55NLwgmZMxrVgnFaZmDU0hWPAtN4SRqU50dQvDVxudd7zxw2Jx7FbvD8HMkoTAwaHgWeDr6apoew3bga/1b5yY7uyjvJA7myzzUqr6i/4zQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9901d0-29dc-479a-86ec-08d695916c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:08:34.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB0955
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Sent: Monday, February 18, 2019 12:52 PM
> To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Cc: Antoine Tenart <antoine.tenart@bootlin.com>; davem@davemloft.net;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> thomas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com;
> gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai
> <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Yan
> Markman <ymarkman@marvell.com>; mw@semihalf.com
> Subject: [EXT] Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS whil=
e
> reconfiguring the serdes lanes
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Russell,
>=20
> On Mon, Feb 18, 2019 at 10:47:57AM +0000, Russell King - ARM Linux admin
> wrote:
> >
> > Another case that needs to be considered: if the XPCS should be placed
> > into reset while reconfiguring the serdes lanes, is the same treatment
> > needed for the GMAC?
>=20
> That's something I wanted to check as well. I don't know for the GMAC, wh=
ile
> I'm sure the documentation explicitly state to put the XPCS in reset when
> reconfiguring the lanes.

HW recommendation upon Serdes reconfiguration are the following:

1. Disable port(CTRL0_REG - in XLG/GMAC)=20
2. Put port in reset (both XLG/GMAC)
3. For KR - put in reset MPCS (MAC control clock, RX SD clock, TX SD clock)=
, XPSC is RXAUI/XAUI clock domain
4. Power down Serdes lane

Do reconfiguration of Serdes.

5. Enable Serdes lane
6. Disable MPCS reset for KR
7. Disable port reset (both XLG/GMAC)
8. Enable port  (both XLG/GMAC)

Stefan,
Best Regards.
