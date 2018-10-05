Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447EE2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LqFT+zsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447EE2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJEWO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:14:26 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:14208
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbeJEWOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hpThrub/x13ZWEos+//e3UjS9eJo5Hy5fbSbuWsts8=;
 b=LqFT+zsDytIOavH4uDQrKDuxXS4Ryx/xBr5GDsh6vy2fx5myP2iUMz0QMA/LO8b/fGYNyUKEwZ8Ti6gE/lXiGjOhIiLyCd3sBULLAT25Y0uqqvnCFcEUQSdOs/RnXv+dZh9+LBzeEJH85Zv43hYXmqMA5JRxSjkz9km6azLy0pk=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4269.namprd07.prod.outlook.com (52.135.89.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Fri, 5 Oct 2018 15:15:14 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::c008:dd27:9b88:4a5]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::c008:dd27:9b88:4a5%4]) with mapi id 15.20.1185.024; Fri, 5 Oct 2018
 15:15:14 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "shankerd@codeaurora.org" <shankerd@codeaurora.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
Thread-Topic: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
Thread-Index: AQHUSn5jXSWA5hACtkm/BATHVar8DKUPyVAAgADVpQCAABtrAIAAEysAgAAIvACAABEfgA==
Date:   Fri, 5 Oct 2018 15:15:14 +0000
Message-ID: <20181005151505.GO3795@rric.localdomain>
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
 <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
 <95733d12-ee1d-9874-16a7-c614cc0ce8cd@arm.com>
 <8ef6b381-e170-30de-ad0e-fae8ccf189e5@suse.com>
 <1d227152-2770-3e93-f78c-71e7a3b4fe76@arm.com>
 <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
In-Reply-To: <93532c6a-0a84-4063-3f9f-171490985cbb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0123.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::25) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.55.228.33]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4269;6:7dPktfKwyPxGfeKb1DJ2NI5G1XNnFQqK9WaqXVxV88i/EySsDpU0rMdL9ipw8aSvU0FpeSxkyP2vfJWoeYqw4rt195B/UzXHIftNm2rCL8NKJwjFUmfViUlyqxCZFP8N1VQLZqJTq/P3fZ8OOwsz8KjhE9xBBS0/nSYsQ5jj9U9rE/aZj5yojimlQ1yL1kw96opL2TPl9XFa2eCmN3XnUCCjSWsGgKhd2ufeeq2HQyBy2t69Vq5xNIFZDWs8YNuCLFxEhxWAa61cTnQ3foHUF3O0+9YdkTgoM1qicyrZFPvh0iwEvYSRrwt6EEpd/G+uD6ty7P+4tjyS9RyAy3aNkDJVd6fdxGCiLdgfNrg4Q8OmcqEl7wAKXUuJDlZtpdhwx/LrlVhCyaalFnspMFQ1HQZ1nyo+r8NMFqlO6OSe5D5rhp+B7okqmsPzKA+ojW2kthS6UEpqnfQ9XOgHs04r2w==;5:GKGJTdTfJmBtPYhLG4wCkLHjtxc9dKbiMlL0jVv+jjA78YQEccz3in9nYhZ3ykpkZTcpZDwMqlcw7tDc5vHozUdzgHPvsNzJA1QpkuyrZCOCKaGkjckfWL8CPcG8+j/WJJxbwZwFmcUSsMT6D+qxztgVbsRZx99d1LK6XX8lvwc=;7:/ChkbY3CEtIJhU+i/M7RHllkVcVfw5Cj/XVHahKSNFM6rtmKPi/vxsKHnPQ//FId5SuQJcRwq6V7tKEEgEy/D9CUQWPH6hik+lt7iC4oqlNvqPMijH2Y2z2YUacve/d9FMUm8GxA4hl44kJaLAwhGQ6e7/N94wx+WxMRZrZLxKX8++MjgcxsxIJwt2jf00OY5dbeWbNosLLW7iW8oQ3/d/BbAC/hTU2sMVXxpbmo5N/6W5bfMLI9/rM9cfbBfFsR
x-ms-office365-filtering-correlation-id: 1520067b-331a-44ab-c939-08d62ad559e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4269;
x-ms-traffictypediagnostic: SN6PR07MB4269:
x-microsoft-antispam-prvs: <SN6PR07MB426961A42A7585DA6448FDBEF1EB0@SN6PR07MB4269.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:SN6PR07MB4269;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4269;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(2900100001)(6506007)(53546011)(386003)(33656002)(33896004)(5660300001)(476003)(11346002)(14454004)(68736007)(478600001)(446003)(66066001)(3846002)(6116002)(316002)(72206003)(1076002)(93886005)(54906003)(5250100002)(186003)(7736002)(305945005)(52116002)(76176011)(97736004)(99286004)(7416002)(256004)(6512007)(9686003)(53936002)(2906002)(71190400001)(71200400001)(102836004)(229853002)(6436002)(39060400002)(86362001)(6246003)(4326008)(8936002)(6486002)(105586002)(25786009)(26005)(106356001)(486006)(6916009)(81156014)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4269;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nfZJ1Nnp6pdKXGmgvyHKDCecZna/yi5QrLt83OyuTEzuBMmAR5sQzFCtBKjvKsakO7BFtxzGFM7NmAYAd79WbUklXPxGY7C8v64TSYAH1LcKdB3ZLbP6ooStFfhRxkoLvr0UO8oZ1BQ0aSsAWVYDyi4yNqDK1sSdFq1DTofk7Id4BU65V7ywG6iO1/S/5bFV84XRFRr8CU/A9VpbspBDo7X8ucXxBLnPSRVUFSj3CsjzJ6QAeoVu62KoMjloIE/J2SFLB1N+PpE7ubflIboHCVPe4i+A1zjZXk+jA+OndHBK9fI1PKtoqsF+e7WW2QMS7vjBY+m3UpSZg72isXLGqgQnmz5Q55V5wEYZ78Xcs7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDB4EE467C7BAA4FBE2A225A33C4005C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1520067b-331a-44ab-c939-08d62ad559e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 15:15:14.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.18 16:13:48, Matthias Brugger wrote:
> On 05/10/2018 15:42, Marc Zyngier wrote:
> > On 05/10/18 13:33, Matthias Brugger wrote:

> >> With my distribution head on, I would prefer a solution that does not =
change
> >> FORCE_MAX_ZONEORDER. That's how I came to the idea providing a third s=
olution to
> >> the same problem :)
> >
> > Why is that a problem? What impact does this have on your favourite dis=
tro?
> >
>=20
> The impact is on changing FORCE_MAX_ZONEORDER on an already released kern=
el will
> break Kernel ABI and with that all external modules. I know that's nothin=
g
> upstream cares too much about, but the distros do :)

Wrt upstream, there is no way to do this change without patching the
kernel. Thus, it is impossible to run an unpatched 4k page size kernel
on ThunderX.

-Robert
