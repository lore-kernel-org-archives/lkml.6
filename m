Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB54C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8243820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ocwGo2Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8243820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbeHALza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:55:30 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:8025
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388918AbeHALz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiHRM5IoFKFrR6Z7NtGgd4iDnggWgXa5cIUW4QMbW9I=;
 b=ocwGo2Lj0E6Zin1I1zTDd1U+xDf4LcvLtrwiMUYkhJ9JxZ1kPJ3ufaZJ9wYlbwgZuzaLFJ39zoIix5pINi7Y+8tHwdJDgZoBFQibiOLz5US3NZkaqZT2OvHoDhDZ+J/OgXZz7SKSQe/i98qKrg4NIdnSOqsEtxx6UNkoWoH3idw=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2422.eurprd04.prod.outlook.com (10.168.55.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 10:10:24 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b%6]) with mapi id 15.20.1017.010; Wed, 1 Aug 2018
 10:10:24 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Richard Cochran <richardcochran@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Topic: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Index: AQHUJ+4m7ji74zU7lkWu9l5BQ4RFQqSn0+6AgAJ4fICAACG/gIAAQVRw
Date:   Wed, 1 Aug 2018 10:10:24 +0000
Message-ID: <DB6PR0401MB2536CE4BCEE872F2C4D63710F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <20180801061515.krn52iaq2kqdi3wo@localhost>
In-Reply-To: <20180801061515.krn52iaq2kqdi3wo@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2422;6:WrxszgwQXG8UjyD3H+aNh239XHK6ALZGEfwo/HW7yCzO6OI14WgmzQzFF2F/Ttg09u1yYyJSG1mV+0YPWTUKb8X3/+nZbkvaKXHoKiIKKtGS/BU5bvjFUXVZ/Bs9/s8Mj2F4YK+EwU0m5PA4zeNN7mZ7OfxrHqjvw5vxl9/yU4hnZ/Iiyj4bB1YaRRlBF+EC4vJ6i/dNDDJUhtJ+uBL+7ooWmOJ+tsmqNfBOI+B8Fu61lyq24Kea7sbGryd2KPmjTxmM0JALAgV+8llFUAYE6w2s91VOA0MuwUrzSHjTf+siKivz63+aoWuTmk8IXMvqEUV/Br/Doo9YxRrhAFs4Rc6WqH+kzB5iX1kP1UGLLVXuBF7lM2a2pW2XR9MpFcclHQDiC2LWe9fVGyNcKMVYN09pM5AD2+W0iEkj1F2EiD2Yx1TKCJPnge2SK2a5GWRj2mYDqHRo1uNIa6qq2lAWVQ==;5:XRCoEPPOuWLEirGJAIeonzlQjQi1N2HsUZJHZDHTQbdn8UarWfNOaUEvez9Ln/uXXqzrskzjVu0wLqt7/vocTddzfMMFsk+xEFbrfYOiv4NfVUxUGzNJg/55gdb04D8VQVcY9yJNCEmDvdE/QmU2oen184i4zdxOkutLORbc0lM=;7:2BcOvo2Q2wJ2NLnQ1pARsKVW1gXMKc6WtOOFKpI4wMLmHkPe9H6Eio5exiAkuvLGlGzdEX8OtrHZzexFU/nk1kswN8SitEyZ5u0+zYl8HBRCCKNXG0ogN5JoxupyoRKXU+1bxfq96IYBpDyvngtWpqIRjV5o7gDsIgwRwi1oVcUqKUtY/uTkO1irygQ3kYs8R+OmZzAExo/rsnG69CENzqLOfTK8kjgdGba4MrG1HNGwexXRDR1LSJnBGKZJfMLN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: afe132a4-2434-49c9-fe79-08d5f796ff4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
x-ms-traffictypediagnostic: DB6PR0401MB2422:
x-microsoft-antispam-prvs: <DB6PR0401MB2422B1D3B6584CD1BF2B6514F82D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(13464003)(86362001)(105586002)(7736002)(305945005)(66066001)(6916009)(81166006)(81156014)(8676002)(2906002)(486006)(25786009)(256004)(476003)(316002)(97736004)(106356001)(478600001)(14454004)(1411001)(5250100002)(9686003)(53546011)(53936002)(39060400002)(33656002)(4326008)(99286004)(54906003)(8936002)(7696005)(74316002)(76176011)(3846002)(26005)(2900100001)(6116002)(93886005)(68736007)(186003)(102836004)(6506007)(229853002)(5660300001)(6246003)(6436002)(11346002)(55016002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BVRTPIy5bbAVlIZ/OG8KTS5yqRqNmZTvSQa7Ku6C8nic36zVR1TGLUVAWmYldIiFfAZq61Xie2LXM4TPA+70Fahc70v2+7J2dpz6RIWwm+Je6qnzs7l7hOe1YuNJCBpaEUcnoh5gThONIngOdBisMkQKpn0RhYCdJf1IRyuMyTmbbi1SgpFHCzAeil9OcBBVp9ukwb8st6YCSs7/AIlaSXMioYjzGRSiFOBFitzkpoNHbasME39J4e9wt/vrT21KpckHe7Kw5WJJV+AyQqTpbWxvJBpFHqdjsokE7C93NhhfxVH/K6qrogCuYPKdOt715uiweXscwAog7QVF9wNmd80ebM5MIgmfMRu7V/TDe2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe132a4-2434-49c9-fe79-08d5f796ff4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 10:10:24.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran@gmail.com]
> Sent: Wednesday, August 1, 2018 2:15 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
>=20
> On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:
>=20
> > Could I add a function to calculate a set of default register values
> > to initialize ptp timer when dts method failed to get required
> > properties in driver?
>=20
> Yes, it would be ideal if the driver can pick correct values automaticall=
y.
>=20
> However, the frequency on the FIPER outputs can't be configured
> automatically, and we don't have an API for the user to choose this.

[Y.b. Lu] Thanks a lot. Just let me send out the v2 patch for your reviewin=
g.

>=20
> > I think this will be useful. The ptp timer on new platforms (you may
> > see two dts patches in this patchset. Many platforms will be
> > affected.) will work without these dts properties. If user want
> > specific setting, they can set dts properties.
>=20
> Sure.
>=20
> Thanks,
> Richard
