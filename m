Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776132064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PjzaiXFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776132064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJZXrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:47:53 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:18752
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbeJZXrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9r6xkfaUwf/fQ7GDQl20rA1qMm6RMTwD5LYt1r88DE=;
 b=PjzaiXFDwGafw+ER+SpP5hZcb+eHk6wYnM+YcQDqMsbHLw4nQLWkpwdHWOs19dbUKb4715tY0k47Ax2dV1Lez4BAMZPSmabV1EiCqbu+pGuCmFj2GYDeFLwAy1qwcIdSqaQArD6C36aOKoPMsgWKpjAqAbQSxvlyvMAnUQvIppE=
Received: from DB7PR05MB4986.eurprd05.prod.outlook.com (20.176.236.154) by
 DB7PR05MB4332.eurprd05.prod.outlook.com (52.134.108.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 15:10:23 +0000
Received: from DB7PR05MB4986.eurprd05.prod.outlook.com
 ([fe80::9120:bb95:b4f2:6e30]) by DB7PR05MB4986.eurprd05.prod.outlook.com
 ([fe80::9120:bb95:b4f2:6e30%3]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 15:10:23 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "privat@egil-hjelmeland.no" <privat@egil-hjelmeland.no>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "tristram.ha@microchip.com" <tristram.ha@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] net: dsa: Make switches VLAN aware when enslaved into
 a bridge
Thread-Topic: [PATCH RFC] net: dsa: Make switches VLAN aware when enslaved
 into a bridge
Thread-Index: AQHUa9D2Fufiq22imkKTXfT5RGF3l6UxpGKA
Date:   Fri, 26 Oct 2018 15:10:23 +0000
Message-ID: <20181026151019.GA15354@splinter.mtl.com>
References: <20181024193657.24012-1-f.fainelli@gmail.com>
In-Reply-To: <20181024193657.24012-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::32) To DB7PR05MB4986.eurprd05.prod.outlook.com
 (2603:10a6:10:22::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.181.19.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR05MB4332;6:AgJ+saVj6zhp3CNXrSYOPlfeiDzxw4lQKKGOYINskDgWyGpWAN1/27mnmYKJP82pjhs8cp2awZ72mMTJA9NnW/n2s5dWBrCCO4rYsPwzHBcDOhI58Widg2WfEjyiYXaa+HXMcbCItlLQfexm3dXhlLbAN013jnxp9xyH3imUHj9Y1M5rq02cMZKivEU1dz898KjGtfcFjJp8TJAE56XqwCDHa3BdbHJFpR85q0U4RCU8D0alZ7SltbjPLlxbY8ARBBzNg/ccuQpN//1Kd5CqTV0hJFovNW/cQ+0u3jAY3gW885IYkF3Ov27YpkXyDPPX8Cnud64OrkcLFf0UYUybnXwNbKyiuzYhrenBgaCzSN/GpBtufWyImSpbGLnGthpDR3ZRlpN/g8na9vAG4NIPZrKo/5C21sKIz58jLWmV5L8mzHbekIXqu7RRJYL2s5Hr8eR0VsIgWXafMeehtNZbkg==;5:wP1qyt8JKQFJhIQjJu6bL7iTGGI3cBfM2IttX04qZOtXXjiSjc81XS2VVIJMNlRQs6oCUPrSTds4DCRoCjPBfMhsWieS5KgstN/pYG0inczIGW6sT3ftgiAidfGOw+N2p2IzxnHH1I4VBDydKxEJ8SlZduIb2Yz/xBww4F6WY/c=;7:IQ00uYxUpTrkLFdwDIb3zW2aXvTJh+cg9CgIRaTd+kKUEdZB/F8jyNzxQ4x9sORAYjGKFhFsjlfg/WhjtFQ449/5QfRNZW9UKsGyDkZSDtbicLY0IjyDIxiJN6FCqqvfG8a5hYluKoiXe95Lh7Oej8hBPwtBecLzKlGukudTMArWBWDQulLMh96w70DUKrNX9z5YXN1uI8MeAPmMxB/IJrNLWO87jjYU0W1vlkxzji1ClsOo6ikqj5wsGKnCcZBi
x-ms-office365-filtering-correlation-id: d3fce30f-59f6-4c23-40d8-08d63b5526fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4332;
x-ms-traffictypediagnostic: DB7PR05MB4332:
x-microsoft-antispam-prvs: <DB7PR05MB4332A6BB57D2B1CFC829418ABFF00@DB7PR05MB4332.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR05MB4332;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4332;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(14454004)(476003)(486006)(71200400001)(71190400001)(54906003)(33656002)(316002)(68736007)(6916009)(8676002)(229853002)(81166006)(186003)(4326008)(8936002)(39060400002)(7736002)(305945005)(25786009)(53936002)(6246003)(11346002)(446003)(14444005)(66066001)(478600001)(9686003)(86362001)(6512007)(99286004)(6436002)(256004)(102836004)(26005)(6486002)(33896004)(52116002)(3846002)(6116002)(2906002)(81156014)(105586002)(1076002)(76176011)(386003)(6506007)(97736004)(5250100002)(106356001)(2900100001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4332;H:DB7PR05MB4986.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k2SneUYYxe36zsszx2iOSh7dUGsieStHcndK7VYFuym8iCmn8wQbP6wbsGZwvnJjZ0yBoSuA1wjbgGTR6Cf213is/znZEVe4BrOKGafAOabqsRE388GPvxsL9YZYe4ag1OBMWm6SJ4OvD8N3hYvoIbp2mwqWWv8Jmw6DaYnFiB/U5L7cDPntEREGJSqPyMxc+j37G7S9ojTBX/EZF9olzTiwQG6ZtbtcmcJB9mh7hb9TM0hGsFDX9Ln/hY//sOtu+X6TPaFja6ahIB1wp2izhC1S9yft5GahRJZgDouA0dcPLmSBogxBeIF9Lzo6RxWA+cFCOPFDxr42IkLdhdLwSuQpLI46N9yi+gVknqVIhps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23BE8DB74B73854381D5AC14A16BE1B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fce30f-59f6-4c23-40d8-08d63b5526fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 15:10:23.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:36:57PM -0700, Florian Fainelli wrote:
> Commit 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is
> disabled") changed the behavior of DSA switches when the switch ports
> are enslaved into the bridge and only pushed the VLAN configuration down
> to the switch if the bridge is configured with VLAN filtering enabled.

This is what mlxsw is doing.

> This is unfortunately wrong, because what vlan_filtering configures is a
> policy on the acceptance of VLAN tagged frames with an unknown VID.
>=20
> vlan_filtering=3D0 means a frame with a VLAN tag that is not part of the
> VLAN table should be allowed to ingress the switch, and vlan_fltering=3D1
> would reject that frame.

While you correctly describe the logic, this is not how VLAN-unaware
bridges are actually used. The expectation is that packets will be
untagged when entering the bridge. Either because they are truly
untagged or because they were untagged by a VLAN netdev.

For a long time we rejected the enslavement of physical ports to
VLAN-unaware bridges and only allowed VLAN netdevs to be enslaved. In
order to support the logic you described, we would need to map all 4K
VLANs on each port to 4K different FIDs. In addition, each FDB entry
would need to be programmed 4K times, each time with a different FID.
This is because FDB lookup is performed using {MAC, FID} and not only
MAC. I can go into more details about why we cannot map different VLANs
on a port to the same FID, but I do not think it is pertinent to our
discussion.

Eventually, users started complaining about this constraint and we
relaxed it in commit 65b53bfd497b ("mlxsw: spectrum_switchdev: Allow
port enslavement to a VLAN-unaware bridge").

P.S. Corrected Petr's mail address.
