Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6456B2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="VPCbTtu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6456B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbeGCC2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:28:35 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:22614 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753706AbeGCC2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:28:33 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 03 Jul 2018 11:28:31 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 4E0F87A230;
        Tue,  3 Jul 2018 11:28:31 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,301,1526310000"; 
   d="scan'208";a="284269425"
Received: from mail-os2jpn01lp0151.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.151])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2018 11:28:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbynaOARoGmZWXd2oEF/9KGeFquOkOQQRttx5gLPAHI=;
 b=VPCbTtu20HhNld20AaJLBIz94vrhvBfPZfW3u9sT31NJS0N60gCq4WmVaWOELp813d4zujPT9gd2yApnAP4t/RYkJZNK6RqXoFtgJC3rCZSGTxPBXTGuUylMkr8fXLVqyplmmYXBYpuY3LnL/dCE+2dbIkcUZO/8zDcjdfz+rGk=
Received: from OSBPR01MB1800.jpnprd01.prod.outlook.com (52.134.228.17) by
 OSBPR01MB2533.jpnprd01.prod.outlook.com (20.176.240.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Tue, 3 Jul 2018 02:28:28 +0000
Received: from OSBPR01MB1800.jpnprd01.prod.outlook.com
 ([fe80::9907:cd69:23c8:c04e]) by OSBPR01MB1800.jpnprd01.prod.outlook.com
 ([fe80::9907:cd69:23c8:c04e%5]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 02:28:28 +0000
From:   Gaku Inami <gaku.inami.xh@renesas.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 0/9] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Topic: [PATCHv3 0/9] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Index: AQHUCHYDiDNMfPBCqUmh7fDIUWP/uqR82TBw
Date:   Tue, 3 Jul 2018 02:28:28 +0000
Message-ID: <OSBPR01MB1800D74A13DD2B4E69491D09A2420@OSBPR01MB1800.jpnprd01.prod.outlook.com>
References: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1529485549-5191-1-git-send-email-morten.rasmussen@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com; 
x-originating-ip: [211.11.155.152]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2533;7:R0H/DUna1GCDHIVDjcUMDcYTjLjVjKwO3VjS8ztvtbLlCO3pi4ibv8ahGecIFXOdRjZYBmxhy5MF3outFBezqeafre/JQAdJqXWxwjgUKL7CNENs/0DZ3IcgwuF3g+CQk2CeFRSsBvOT4uNsxIJVjsWYRqf7+Y4Dh2M7UMmGeUT/aXHXyRvMDHCXGlq+RWKtrRq7uz4dwyqT/eysgTR61SFh3ql3HiG44BtNYy8JLhqvv3pzpoP2eC500SloMfT9;20:JoknTZ3FtcOWC8pofK8dSGMHbzvLqiRXVZ+G46MIIX4enS09rY6KdEnGfkp8Djx8Ywik4QVf0wshBJJhrAdcR1R3r8PTLwWxo7u+JtZu4aG11gW26PL2R+rAIF87Dip9r8swU1YytK2m4AqXVbRacS2fpWm6AnWDD62U0Dvpbdg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e37fbf6f-983a-426b-55c1-08d5e08ca94f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2533;
x-ms-traffictypediagnostic: OSBPR01MB2533:
x-microsoft-antispam-prvs: <OSBPR01MB2533714322BDD8F9316AAD73A2420@OSBPR01MB2533.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2533;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2533;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(366004)(346002)(39860400002)(13464003)(189003)(199004)(2900100001)(66066001)(55016002)(486006)(99286004)(186003)(26005)(316002)(446003)(5250100002)(110136005)(53936002)(2501003)(68736007)(86362001)(76176011)(11346002)(53546011)(74316002)(6506007)(6436002)(102836004)(476003)(305945005)(9686003)(229853002)(7696005)(54906003)(256004)(2201001)(106356001)(5660300001)(2906002)(105586002)(7736002)(33656002)(97736004)(4326008)(6246003)(14454004)(3846002)(478600001)(8936002)(81166006)(8676002)(6116002)(25786009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2533;H:OSBPR01MB1800.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xERBnS5kU4odydzA0wUwzA59Qw78vQL8S/U4cpfcXXf0QJGbn1yI513N3xNVHRx5zhMN4efEs4jfYzlKi9efwjKwiIHCMJSG4jREIbJahGgO4BeGMx8jeWfC7Odx+O1Arj+aQ9p+MokLkS2PtCB5mWZ8nJltr00243mFqo+sxDsvt+SBD5RVYXFR5hzU1OO7MaH+K20CxAZVJZjQhobTXBu04z4UBcQPAsuBHWIJk2cWltxX9NqTXClt6lNwuwlz6EimyvXJLmkmvLpnh+EP6OTQp5r99Muy5VHEuxdVRyd8O8fAHdsyOqwDGO61+oZGxy7hTmjtBaV+OESsfhtj2GAOW8pa72lSb5M+iIfoKN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37fbf6f-983a-426b-55c1-08d5e08ca94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 02:28:28.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> Sent: Wednesday, June 20, 2018 6:06 PM
> To: peterz@infradead.org; mingo@redhat.com
> Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot=
@linaro.org; Gaku Inami
> <gaku.inami.xh@renesas.com>; linux-kernel@vger.kernel.org; Morten Rasmuss=
en <morten.rasmussen@arm.com>
> Subject: [PATCHv3 0/9] sched/fair: Migrate 'misfit' tasks on asymmetric c=
apacity systems
[snip]
>=20
> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
>=20
> Test case:
> Big cpus are always kept busy. Pin a shorter running sysbench tasks to
> big cpus, while creating a longer running set of unpinned sysbench
> tasks.

I have tested v3 patches on Renesas SoC again. It looks fine.

You can add:

Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

The patches have been tested on:
   3. Renesas R-Car H3 : 4+4 Cortex A57/A53

Results:
Single runs with completion time of each task
R-Car H3 (tip)
    total time:                          0.9391s
    total time:                          0.9865s
    total time:                          1.3691s
    total time:                          1.6740s

R-Car H3 (misfit)
    total time:                          0.9368s
    total time:                          0.9475s
    total time:                          0.9471s
    total time:                          0.9505s

10 run summary (tracking longest running task for each run)
	R-Car H3
	avg	max
tip     1.6742  1.6750
misfit  0.9784  0.9905

Regards,
Inami

[snip]
