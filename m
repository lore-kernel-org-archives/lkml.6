Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F147C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999ED20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DofiiuTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999ED20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeHTGEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:04:37 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:26799 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbeHTGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:04:37 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 20 Aug 2018 11:50:49 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id C218E764C1;
        Mon, 20 Aug 2018 11:50:49 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,263,1531753200"; 
   d="scan'208";a="290037190"
Received: from mail-ty1jpn01lp0183.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.183])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2018 11:50:49 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTTGLJod6K5zgbC/ZIHuKtC61vp4jKpftJi4uzv1Alc=;
 b=DofiiuTczdVLJP6/2lAqgiCoVY8jNPbWpXMkSH5rR6ClUchtD8c11KbqcnpmoA8WmyyXAidr73Nr3WdZ+b2EXGyoKj3RERohimmKJS7hXSnSTpkvMNwPlKdAWL1wpRF9C5SAX/kFEz3kRY0/OPwxFiihV6g9m+EFxJ5TQzEJvVo=
Received: from OSBPR01MB1800.jpnprd01.prod.outlook.com (52.134.228.17) by
 OSBPR01MB2005.jpnprd01.prod.outlook.com (52.134.240.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 02:50:45 +0000
Received: from OSBPR01MB1800.jpnprd01.prod.outlook.com
 ([fe80::383c:2b9c:c4ec:6f4a]) by OSBPR01MB1800.jpnprd01.prod.outlook.com
 ([fe80::383c:2b9c:c4ec:6f4a%2]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 02:50:45 +0000
From:   Gaku Inami <gaku.inami.xh@renesas.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Topic: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Index: AQHUE4BSoJBEcmk4OU6wtQp/2SaPHaTIOT+Q
Date:   Mon, 20 Aug 2018 02:50:45 +0000
Message-ID: <OSBPR01MB180028F1E2D456EAF37FDF49A2320@OSBPR01MB1800.jpnprd01.prod.outlook.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Accept-Language: en-GB, ja-JP, en-AS, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com; 
x-originating-ip: [211.11.155.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2005;20:9xLkJNfGn7VxO5F6/qWMlG34txr7GMlje9Zt+bF9n+2pvL9EPzMpg3JAxO6Y+FsnNjHLJDj+VroQ4Dl8hFjleH5fiNkRDmyJxzzbtOFd4akWl9r065PuVxX3VcVwSGYE4ShYHK/gogJxkmSsRJZgHhTjvYau7lxnLyhTaKg6TIQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 14130fb2-ea21-4c65-8ff8-08d60647ba42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2005;
x-ms-traffictypediagnostic: OSBPR01MB2005:
x-microsoft-antispam-prvs: <OSBPR01MB200552BAFEBEAB9093DA1466A2320@OSBPR01MB2005.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:OSBPR01MB2005;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2005;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(13464003)(446003)(4326008)(66066001)(86362001)(11346002)(316002)(7696005)(25786009)(33656002)(6116002)(102836004)(3846002)(6246003)(105586002)(106356001)(186003)(2201001)(26005)(53546011)(54906003)(97736004)(14454004)(81166006)(81156014)(2906002)(8676002)(6506007)(110136005)(76176011)(74316002)(6436002)(8936002)(68736007)(305945005)(7736002)(2900100001)(2501003)(486006)(53936002)(5250100002)(9686003)(55016002)(256004)(478600001)(476003)(229853002)(99286004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2005;H:OSBPR01MB1800.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TFNmWf1as5wDhDedrOvQwM045iYVy89PXfjnO+XLswpQkggW34mockQxOIF7EtkYPOH8TwwnvUkmtEcnzqmuRDxaS2WCOTnDj/iTig+IngXvBDhWXM4tJydlmyijXNmWGk+RYj6k5POqLZuD4ROGWCazUw+NDslEUeSjSFkujeuPPRpSLaemZHLfB7v0R84d4kCuoMLr4tHQr20czrbBfLzgz0htIWkEpHndp7dg0c3VPmrXQ4UTwVFuKArgEP/zvMrDaJBOpomqDpcsIrMiE2afSycXKaH606xnEoIdVcR/fPNrpYx4OtOnvOjDL/JtABpffgJljiHMmHc+Vsur67OPbWFG1zEL77hLQZr2/Ao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14130fb2-ea21-4c65-8ff8-08d60647ba42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 02:50:45.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> Sent: Wednesday, July 4, 2018 7:18 PM
> To: peterz@infradead.org; mingo@redhat.com
> Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot=
@linaro.org; Gaku Inami
> <gaku.inami.xh@renesas.com>; linux-kernel@vger.kernel.org; Morten Rasmuss=
en <morten.rasmussen@arm.com>
> Subject: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric=
 capacity systems

[snip]

> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
>=20
> Test case:
> Big cpus are always kept busy. Pin a shorter running sysbench tasks to
> big cpus, while creating a longer running set of unpinned sysbench
> tasks.

I have tested v4 patches on Renesas SoC again. It looks fine.

You can add:

Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

The patches have been tested on:
   3. Renesas R-Car H3 : 4+4 Cortex A57/A53

Results:
Single runs with completion time of each task
R-Car H3 (tip)
    total time:                          0.9488s
    total time:                          0.9766s
    total time:                          1.3243s
    total time:                          1.6740s

R-Car H3 (misfit)
    total time:                          0.9313s
    total time:                          0.9214s
    total time:                          0.9493s
    total time:                          0.9606s

10 run summary (tracking longest running task for each run)
	R-Car H3
	avg	max
tip     1.6744  1.6780
misfit  0.9616  1.0290

Also, I confirmed that these patches bring performance improvement
to some benchmarks(UnixBench, LMbench). So they have very useful
for Renesas SoC.

[snip]

Regards,
Inami
