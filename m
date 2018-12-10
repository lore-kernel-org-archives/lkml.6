Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B00C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 05:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XTDVMsUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF3920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeLJFlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 00:41:23 -0500
Received: from mail-eopbgr800112.outbound.protection.outlook.com ([40.107.80.112]:12884
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbeLJFlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 00:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAWI1FpYwtIG6R/S0QTTn/2tMln292jGhSMIijMACew=;
 b=XTDVMsUaXz8tmOkQwDlnWEv8NfzqTAypeokh7lBTNjntxIKWo6kEhxnYQte1SO4tTQsCWyKqf/mVtNLFxO70Zvn/ZQwbKwQZlcIWqDCNWKv+mp4b98m3+EW45oSmXLOOviAHlJSqv+UwTKdWD8FiIw7iwRoW+wK2lzO5R7DvVXc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1344.namprd22.prod.outlook.com (10.174.162.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 05:41:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 05:41:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 0/7] mips: system call table generation support
Thread-Topic: [PATCH v4 0/7] mips: system call table generation support
Thread-Index: AQHUjSM+c2nyNaOEz0GtB/d8Jn1BsaV3ehYAgAABkwA=
Date:   Mon, 10 Dec 2018 05:41:17 +0000
Message-ID: <20181210054116.2hq5ykjfh5itcvqk@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOninHsCiB7puVOkU3i6W9gfhGqAA6EDT0kAEC9ZqMZPh7w@mail.gmail.com>
In-Reply-To: <CALxhOninHsCiB7puVOkU3i6W9gfhGqAA6EDT0kAEC9ZqMZPh7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1344;6:GIHvjJqbcwC0cT9Qs81A58si4s6xXGMpqW8zt+ZwDk12xCQMK5t01V2La/bXMrVxUtN52+Q9SZQdPG2cQWGpgFoS+o2WoiNHCDg2aqpJkk6RSlukpyPzakHLI8ISJNxYz+enaHuOFdQNVCmgei31y4dsP1DPjbtF5cZYwK1bEYCpITFtbh0qYnCrwXxHG1aQ9wAZbgjAO3GNoFCtIA9/FPke9RrESTte5bdvDDKDDpY6rWwPEpv1Cg++U7Q19gJBMRJgKHu742JBSmxUY1RhEPbocNkCH1NujK3AOFAMcbqHvmFiK9isATho3iS5otdQ4OmzoVdUvQAMyGyGi4BNHMkAVqF8AvsfHk0s1yKLaISas5RuuNbBJLSfxVQtaD20h44MNPSvvgSTuOLazlIwCOgbw3dW74Ou33ZItVcHy066XfHCXsrsTrhnVUw7FDR2YoJ06c4HAQcUG6HcKf8mHQ==;5:4ugLSrFmv9m6e2kfu931Jo+okPyF8pnvkg3CIBjK4Lbq0uaRoDnIYF/0hZqb4iv48j/p4U9ySmuzSqf9S+P+wDv3KLnKkIgUGbB6kvDfJmdYVClHhCuamLaxQaNhE1EHhzsHYjtoxIG+K2j7fuc+TTLc4qX4jcJ6Y2pbiX9xvuA=;7:JHNuBgEWyXi44pwiLHFFG3MnvkOpw3zB7BDqAl7SewfRnLq6gLYss0NF3VCnOYpNxuVoLHc5bSrm9cvigQyFIswjqPAbhjQtVtbEsKyD2fZ07msRd2z2lq9RHMS5AncPF8KJfoVlDKNqr99TjXmbeg==
x-ms-office365-filtering-correlation-id: 29b96c9f-67ef-4e0b-e289-08d65e621af8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1344;
x-ms-traffictypediagnostic: MWHPR2201MB1344:
x-microsoft-antispam-prvs: <MWHPR2201MB134427B4BB088D5A3985A769C1A50@MWHPR2201MB1344.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231472)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1344;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1344;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(39840400004)(366004)(396003)(346002)(189003)(199004)(105586002)(106356001)(97736004)(508600001)(33716001)(6506007)(256004)(9686003)(6246003)(7736002)(6512007)(46003)(53936002)(386003)(33896004)(186003)(102836004)(44832011)(42882007)(446003)(486006)(476003)(305945005)(39060400002)(229853002)(6436002)(6486002)(25786009)(7416002)(8676002)(81166006)(8936002)(81156014)(6916009)(558084003)(5660300001)(68736007)(4326008)(11346002)(316002)(54906003)(71190400001)(58126008)(14454004)(2906002)(1076002)(71200400001)(6116002)(76176011)(99286004)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1344;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gD7MhowUDHjIpKQbWBLLptPmhk6D47g6hBMmxEtqGpoGTM9x6aZdh/uddyTNm89kAdfyW4CzTjB6EfohhRWWmiNmYkoEUYdciIyeTtkMEePgQmPIn9UYrcQccEbObThMvQK4bBQ7OylPFnROLHyqBKHL6n6DJw9Hgy/+KMpByM+y0/+ezw6RzloiIzQl/oYDotRBpIcQ6EJQwDdtZFLKwNqKAbrMmQtgGghBbCNO69yNivC44YXWYR2avdmG7OG6Cb9NKldxLFWMoLof8vB7Juh6nhDBIY9VjqobQO44gWSDO+edXD1SXJ3OZD4aSRdA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAA0BC7F3E33AE4D860A6DBC5D3A44FA@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b96c9f-67ef-4e0b-e289-08d65e621af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 05:41:17.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Mon, Dec 10, 2018 at 11:05:38AM +0530, Firoz Khan wrote:
> Please review this patch series and queue it for linux-next.

It's been ~4 days, 2 of which were a weekend. I'll get to it, but
pinging so often won't help.

Thanks,
    Paul
