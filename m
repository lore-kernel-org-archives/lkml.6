Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34021565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="p2/B9lBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C34021565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeI0CvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:51:07 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com ([40.107.68.132]:43465
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbeI0CvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmPesnn08rhG10R77SbvUV44FkfEAZggdL4vDU6Obf8=;
 b=p2/B9lBXPMhZRf4fKzRJuRsVxDOsBF8nPzpSp0c4fYYNdYKFIOuccCRLq2O+mbsyApSQTUL99DpFSeRIuBx7bacii4chLbz2t7/jHQv7B8MOat/s+KDqcaqiQUmUkkzZKhEBPZfTB/xFqSwL70/bpPeYpxDX/tNGdaK1w2DZ9IA=
Received: from DM6PR08MB4939.namprd08.prod.outlook.com (20.176.115.212) by
 DM6PR08MB4778.namprd08.prod.outlook.com (20.176.115.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 26 Sep 2018 20:36:20 +0000
Received: from DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d]) by DM6PR08MB4939.namprd08.prod.outlook.com
 ([fe80::7591:512a:df59:3d3d%3]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 20:36:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
Thread-Topic: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
Thread-Index: AQHUVPrPNYZ9JDT4CEqqYSbscSo9JKUDBzEA
Date:   Wed, 26 Sep 2018 20:36:20 +0000
Message-ID: <20180926203618.bnmo5ys4ay24tbrr@pburton-laptop>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:903:13f::12) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB4778;6:sBY0fb0bPLPCwe1ArugTC+h7JHL+ZS/0cTXsYh4SM3KPFPPGFJMi/Yx9VXwZ8pG0rl2SXeQe6oLKlABO7/Z5fGobOmgAi2KVTllWrBBeS4fZStZIwyg6oas8XpjXZYzMPPLU7ypUmC/onNgNkk5MNHLot1uLVgGmeXjsuXz+i+Ewu/HJxvH187AiciORpu1SwbbSgYoKqgKoaQ0yl/LQNNVoztU4XCMDsJPy+RyUAblPk2mK6eRNAiACpcEEQJ/3pwtxyHdV8qpAPnF4Oz8foswGCo7toeas/Mlctlw6rWQcaY7PF7IJE3sz5+LM+TuzDC6mgD08wRvBkyQS/aQ0DdSX6556esgSZGsRlAb8szv0U4zinPBi86IYHuDMiwJVoizn4h8fjX+Ce8zwl5kz85thF8xjYkaoXc4SXxlmU1l98Q4RiKWctLhJiz0Suix0otnIHkGWiubcCUfwC0N9SQ==;5:qyEyZE6BOfqgfYoZ59vhVuZp3PcJNt4l3ETiYGRWJ/8yPYODdRlKFAWtoYlTK4D4unfNNhYukWxafqC6TfX6FDnpuEv8r45gxdsiYtHZMmxDpIqCZj2FklOWhmJeJRZWpR6jQHw3DjxAZRx3p9eSRgEu+Ib45DTp1/RrinVvNTE=;7:j0Kt+LYuvHXoviE4LaQyWfgMfL3e3ciBijArg1J43h/WXzMoDGdDCL2m8ljQI/6fiiOImVserBZI70IkBJDVPXtofwJM7h9mjM4mzs+eBYEw3daG5kOEX41wqX1ly3X7A7IzqGtElHZjqTktW1lMK/x0HXYsY16y51zulEyE0LURiOFbUGuh8uykIrjuPOmtMyN6tyjmGhdjvc2ShY1n9nn4k3JUHf9vLxC8nF8wRyKIWj2wbqgzoHne4+VsHWfu
x-ms-office365-filtering-correlation-id: 0a2fdfaf-4f47-4c9b-f92e-08d623efb773
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4778;
x-ms-traffictypediagnostic: DM6PR08MB4778:
x-microsoft-antispam-prvs: <DM6PR08MB47787F7FF224A4527C89E106C1150@DM6PR08MB4778.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(149066)(150057)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:DM6PR08MB4778;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4778;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(39850400004)(396003)(346002)(366004)(199004)(189003)(25786009)(229853002)(2906002)(386003)(97736004)(39060400002)(53936002)(9686003)(6436002)(6486002)(6506007)(42882007)(2900100001)(4326008)(71190400001)(5660300001)(5250100002)(68736007)(6116002)(6916009)(1076002)(3846002)(14454004)(71200400001)(6246003)(316002)(34290500001)(508600001)(305945005)(7736002)(44832011)(476003)(486006)(106356001)(81166006)(33716001)(11346002)(105586002)(8676002)(446003)(81156014)(102836004)(186003)(66066001)(256004)(54906003)(76176011)(58126008)(8936002)(52116002)(33896004)(99286004)(6512007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4778;H:DM6PR08MB4939.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lTl8IqZhMwa7+PD0tqgTqVUL+pFNWF5rel5a1z8xMaqLHnLkbRk/lIKE/jrUfJBU0oGoeUKeJfUqlKPJQJiWHOlC1l5MpO/pxafYy29W98U2OjcCHnRtbpllZVLO5K/JZwm/6EmvGnVikNv5rnWf2Zvj9D7q158Jf4WOvP2iQu8hf206zKN0nIO2e6L5Er+7nr4vJdiDjr3S9s7J1xc7KLE3TUjnuWXVpnAeDVvSBMSPiT1vw3Utm1y7J2c3JnhRwXsPMCO0urmqjtGiZ8qC/0W+bymVnotXL2jktnNIXyJoe/8+wJ/bBhgMoiYlG/1KikWvD3fusT9ra3rmsBhaMA6NTd7ydP2c3r6dPK6/DeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CCE8EA02E16AA46ACB96346DF4E06F1@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2fdfaf-4f47-4c9b-f92e-08d623efb773
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 20:36:20.7404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On Tue, Sep 25, 2018 at 09:08:21PM +0300, Yasha Cherikovsky wrote:
> Hi,
>=20
> This patch series simplifies and cleans up the handling of
> CONFIG_MIPS_ELF_APPENDED_DTB in the MIPS tree.
>=20
> Specifically, it makes sure that the dtb appears in 'fw_passed_dtb'
> also under CONFIG_MIPS_ELF_APPENDED_DTB=3Dy.
>=20
> This allows to remove special platform code that handled the ELF
> appended dtb case, and replace it with the generic appended dtb
> case (fw_passed_dtb).
>=20
> There's also a bonus: platforms that already handle 'fw_passed_dtb',
> gain now automatic support for detecting a DT blob under
> CONFIG_MIPS_ELF_APPENDED_DTB=3Dy.

Thanks - applied to mips-next for 4.20.

Paul
