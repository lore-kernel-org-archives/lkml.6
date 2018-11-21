Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F8A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CIyIkrPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F8A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeKVF7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:59:05 -0500
Received: from mail-eopbgr810100.outbound.protection.outlook.com ([40.107.81.100]:64342
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730624AbeKVF7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjZzS6ospqoyPmETGhDmgGm8eo8we3Wqu+sf4Q0NYHY=;
 b=CIyIkrPlrJgSe4Rd6H1AAqCK3sKX5H/BoBrbW/Sv0mxMly9rhVDeKHHIr8e9Hn2LDQUGtiX8jYjd4qiAxXTmoyW1nmmoXsUKFf2jTRsVSsPCMEAPP5JIurHbqJCS3l+5eO81A2BktAXD9Yl37Rl7hK2pjVWoLGurwU+eHI6j2k8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1392.namprd22.prod.outlook.com (10.172.63.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 19:23:28 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 19:23:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: fix mips_get_syscall_arg o32 check
Thread-Topic: [PATCH] mips: fix mips_get_syscall_arg o32 check
Thread-Index: AQHUgc52QNF7mHHAKU+2VcJb+xKVPqVam7UA
Date:   Wed, 21 Nov 2018 19:23:28 +0000
Message-ID: <MWHPR2201MB1277D0B64034597F9714C089C1DA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181121191438.GB10301@altlinux.org>
In-Reply-To: <20181121191438.GB10301@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:300:ad::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1392;6:wpD9lvS8k45ydhUx56rfgqowYd6TXD+K6xwPf8LNk0PtD42x6NAI++6Gwo90RTpQLMRFWowINExhFC6itnPi+eDsNJ36vDHQ8BWLBxN90JBPz4f/vp4GeqbLop5P4cYKf01kL1Av9aAKMNPkJFuFXlc2qatdjuU6CTQeMKQZ9YJIpHAjEbOmwJdSkVBg0U/HuzAYyK6Yghn/A7iQGAtN4iYnfuD6bWMgjqfLrpT5kre+rRXqwQvtzPINkpnklBzXY4HkGxE0Cga+Xehd63Tl/I6DtJc2AQIuwZKCKxXxQMzfbhOvaeiGO6d8AlLSilWlUYkbpv8pybwcowbh5B1qakNAARn4aQbtwNXdSvvrKfmDVw+9tJee4dnSDFsZrKJwhJav0HCz4xVhPd+9A9+rw6WlXGgXHG1Le5yqPBPChzMOpXsAZ3ypQQOYoRt8wItkMz4lAIGJfMpHFSGWkgOe5Q==;5:yQY5dUQY1JBQfarWtV5ebxRqVmqaeFbGjZcsEZuz2zcuGSyWHQQIrjutlCAEop8JZkauurNxfLscbafMloIDYHDQhLBOLtoO1WAt6MWeBkFaMnftlTiZoZjXVe2G0cxk7ZwYYcabi6JOB5FEkzNkpnK909L3A9Oy4kDy0PD8EYU=;7:+m/PfqYCqIM6Of8IBfcIVYNpirQQOcmvsT1GqRCcYAqU8xawP1lJewOIrmPXF+o3m8D19ACy+I0fOPP48okgEUgxLodBzFo3oIG5++WteuwLgscomD3Uy1zaV2lrvPqM5bOs7w/zFOT/L75NPIeGSA==
x-ms-office365-filtering-correlation-id: e806bdf7-d4fe-40a3-ebd8-08d64fe6d084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1392;
x-ms-traffictypediagnostic: MWHPR2201MB1392:
x-microsoft-antispam-prvs: <MWHPR2201MB13927288AD498F06DD8DECE0C1DA0@MWHPR2201MB1392.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1392;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1392;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39850400004)(346002)(136003)(376002)(396003)(199004)(189003)(76176011)(256004)(52116002)(6436002)(42882007)(7696005)(71200400001)(71190400001)(5660300001)(44832011)(68736007)(99286004)(486006)(66066001)(575784001)(26005)(6506007)(102836004)(7736002)(186003)(386003)(305945005)(54906003)(74316002)(6916009)(476003)(229853002)(97736004)(2900100001)(9686003)(3846002)(6116002)(508600001)(8936002)(6246003)(53936002)(55016002)(14454004)(81166006)(81156014)(106356001)(105586002)(446003)(33656002)(8676002)(11346002)(316002)(25786009)(4326008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1392;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ySNBboqUmMjRg5xnc1xl07Gd3pHigX1Euby/bQsORW7M5fd/h+wpr30es7r4QaNCoKrNMhyJBO/MCxw7iTUaLWofaEe5++MfaUVPP5pTB7d4V/NOxaiBaT2oj2oOKVcgm9SfsX2ZES5kWfBlaYoZPlQ044+oStjS7bptS0n7qwImHMbYK+RW6gtjfgCrqoSE4cKhVs2Mv0lZ96AbPma+bQj3nFLRahH3T5Dwn61DfxDpqU4YYqoamTDJNiLMOcOobSosnAz8NyUsoXRle8VDxXUbtW2bWfxBzZNg9rXP2+BMbJdXpxL9ehrofwh4erHpFlvn2zyZvn2rgn0tPNfAcA+qRfcPNApxoSq3xaYE2fQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e806bdf7-d4fe-40a3-ebd8-08d64fe6d084
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 19:23:28.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Dmitry V. Levin wrote:
> When checking for TIF_32BIT_REGS flag, mips_get_syscall_arg() should
> use the task specified as its argument instead of the current task.
>=20
> This potentially affects all syscall_get_arguments() users
> who specify tasks different from the current.
>=20
> Fixes: c0ff3c53d4f99 ("MIPS: Enable HAVE_ARCH_TRACEHOOK.")
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
