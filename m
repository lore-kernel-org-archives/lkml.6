Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82265C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8342087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="JMHq0P1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8342087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeJIUne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:43:34 -0400
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:54352
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbeJIUne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrIOXDzCkE8Jj/RlHIuuYGPtLh/eaARxvmvm5jzWwt4=;
 b=JMHq0P1IomOpEDnwKV93vOEUKCiDwBftABu9xHwEdohEuD8PypNQ5kyuk4n0q+x+ZibLd0GSzNFlErzi1iAd9a6XN0W6Y5k7XZwE1Wuer3OCYKGHMWAaenrNVXNiE1Dtu3ItSEwf4tnOe2gIZhDL4lg/pOgJ/UYtykCR2Lkiro0=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB4821.namprd07.prod.outlook.com (20.176.250.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 9 Oct 2018 13:26:34 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::8057:24ac:d594:6f3d]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::8057:24ac:d594:6f3d%5]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 13:26:34 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: KASAN: use-after-scope in ext4_group_desc_csum
Thread-Topic: KASAN: use-after-scope in ext4_group_desc_csum
Thread-Index: AQHUXJR/cP5Refn5uUq4/pFkL4/NFg==
Date:   Tue, 9 Oct 2018 13:26:34 +0000
Message-ID: <20181009132625.GC21519@hc>
References: <20181005101629.GA21469@hc>
 <CACT4Y+ZQr4DZtTLUxAe4HrC6=fQBQCJcs4U5xVjqsz8wu8uH8g@mail.gmail.com>
 <20181005130506.GA5972@hc>
 <CACT4Y+bY=Ota1E_tf_QgsT9d2YdQ7xXE0k=Q1VPJga=Ge+1UpA@mail.gmail.com>
In-Reply-To: <CACT4Y+bY=Ota1E_tf_QgsT9d2YdQ7xXE0k=Q1VPJga=Ge+1UpA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.66.109.80]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4821;6:4ojvOLa3hITGg52I4mBfOG11hxX5jvQkAcz5Bco15FbD8rjhgfcCjeuBJw5eQzQTWH4y9a4XH8dCKM6OIzdpkYAPDz3h2Yf7WlSSINlfRezv86QnJdc1ZvElOmPWbirjLnb2ClIbfIl1Vv3UhUxaMtHrT7I9TuGGSOj7tlqEFzPAK+1bMcbw20wxy5H4ar7Kk1bGlJiTDLQ5ZGs6Nl+EC5j/3nNmQszS22t41//1LEy9Jtb0TWDWxY3WX2abw96ODVMurL7CBs7Jdz+Q8d862ZlLWFyuMVCKM181jWjM58560dS6FLPkNdZYq7x1r0+ieJ22UHfUssTnmwoNqCZ7DPWUdgZ53V4PrMznKjAeYlaEGZonRLYg4BZDkX4RuhqCBSbu9WecVCpTI3NLdPAv+6Gq/6gcZ12Q++oFnZvC92yzP/obujDMmmf63E33tW/ju0y/S/Bi+O9uTzBF1Yzoug==;5:+OnYIcDzkXc65llDnlzphgPs9ikToKHKIJUKwBMkottMWsiK+64v2cmgcxo8B1n/glBhzSy1w9U4lsOUCC+5uROPJ/BoNZl5uxeC0FM4mItts+bzTXLKHocWVIitDXKpVSLCrAckmVV9LhNYWwf1/ZwwHLcTJejzewjEyhoEzRc=;7:Uo9OjKuWniFQpFmdIDQCfZpTngCSsnFpVYUB3ScMrfVrAEOjdGkDlYJXgB5gAo3PTKYDB+IGA/ntunyHdYp5uxnd9J4S4EgxT2QY+ag9Hr7qRZSbl3ei8Hsugbro5NwUugTt73GnO2yO299YYs+8/nhtnoUZOzH9ZL9M7Drrme1C9IOIto5ugT7gZR6sDS7H0ZAU28rjn3yFn8famdU1/33JJXfKmVKi0NrJj/LYx09XPs0n6BxL0MjMSuY7rm3F
x-ms-office365-filtering-correlation-id: 95860660-b992-4775-c54b-08d62dead4e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4821;
x-ms-traffictypediagnostic: BYAPR07MB4821:
x-microsoft-antispam-prvs: <BYAPR07MB482126C4F405B55C9FB15D3591E70@BYAPR07MB4821.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR07MB4821;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4821;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(6116002)(81166006)(386003)(966005)(1076002)(256004)(5660300001)(106356001)(25786009)(14444005)(6506007)(14454004)(186003)(66066001)(53936002)(4326008)(52116002)(105586002)(26005)(6306002)(9686003)(8936002)(33896004)(68736007)(86362001)(81156014)(6512007)(76176011)(2900100001)(99286004)(446003)(6436002)(2906002)(6246003)(33656002)(8676002)(102836004)(305945005)(71200400001)(15760500003)(316002)(33716001)(71190400001)(476003)(44832011)(478600001)(54906003)(5250100002)(11346002)(6486002)(7736002)(229853002)(72206003)(3846002)(97736004)(6916009)(486006)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4821;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Pk/7lqto0x20MXolQXTNDzDzGgv1rj+cu6x1Hj/mtA9ymzD5KM3BPh9QbhkrLL+RlCkWhshzmC4zva7s9db60fKTrfj/chm33+ZbDTCkC/LO9PhMAGf2QsHCL9nB4kDjYWkX9USRE+F1XpSoMyOMeqRkU34z0F1X31KyNxywPsKuw6QfCX9JbXJ5Z+I4gEK94I4D6jC31L+WmPTQk19NN/iIn6UZrnNSI4pWJvTocTjeSrLKMAX9g18cNiqPRHQXbT18XuL/z2DaVmU3dKBl6/3lxZjliVLj/LaQrx3+WRile0Phv1AchAbQ9ja7flq6KuLsc/BG67plosg0JGHrAP2N/OHU84a7ZkGyReTZFQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8DE22F174853542BCDF666DF230FC50@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95860660-b992-4775-c54b-08d62dead4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 13:26:34.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 05:32:07PM +0200, Dmitry Vyukov wrote:
[...]

> This all makes me think that somebody else has left these 0xf8 in
> shadow before ext4_map_blocks started executing.
> Unfortunately debugging garbage in stack shadow is not completely
> trivial and there is no common recipe. I don't have setup to run arm64
> kernel at the moment. I would try to locate that garbage in stack
> shadow earlier, e.g. calling another function before ext4_map_blocks,
> implementing that function in mm/kasan/kasan.c (non-instrumented
> itself) and then try to scan stack and verify presence of 0xf8
> garbage. If this works out, then try to catch garbage earlier and/or
> try to figure out what function left that garbage (that's possible by
> locating 0x41b58ab3 magic:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D198435).

Thanks a lot for your analysis! I'll try to debug this further but as
you pointed out it might be difficult to catch who writes beforehand to
that location.

--Jan
