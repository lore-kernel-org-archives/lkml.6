Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552CCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9C320823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="G4VeVDUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9C320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeKTJBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:01:19 -0500
Received: from mail-eopbgr740128.outbound.protection.outlook.com ([40.107.74.128]:5984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730458AbeKTJBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeabsPwcl602CqMrbzDy0tqPAkTOfvUu5prgQhswAmE=;
 b=G4VeVDUx2Ldt/4+iQUedyLPIKoCKod3EXr/7kL16UrYh401EVuWh5LvIcar4+Hn3pcyiGklm9ZjtwQIRP4hdBZ+1bXsYwBO1o12ez58MU7OdPWhb31n57KVeFkw6quxyVR0P1LdFiE75Vcoeg9dtukdSQAHOGE8IqsrdKYRVEgU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1263.namprd22.prod.outlook.com (10.174.162.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 22:35:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 22:35:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
Thread-Topic: [PATCH v2 4/5] mips: add system call table generation support
Thread-Index: AQHUfKqTsLovwmqgL0iEZ+Fxq0+0M6VXtv0A
Date:   Mon, 19 Nov 2018 22:35:25 +0000
Message-ID: <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:300:16::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1263;6:Q+bDItm706ix8NGdJckzdfToxuFKDLcHn1aueGjxUoNzRMHneCO6ffOtbqvL2bjfjXk9P0Nkp6IJxw0H5tSWY117KqG5Sb658jr5L8htsMovkkfAkrKVstGL+7bqMQl7q4gy8QQJ9lr95vnFxoa4DoWYgjc3S/l0F0RZtHlkNXKQyCvGmLXvFlpvUGda/PcIrkKa1GxoSlDlBEwYzTkHKTEzEFrLqLUqIiWhUC2ug3ByTURc9OeO4MpEv9xAvFe0nCIgQUOzVv78rFeYCh2PZ+0SY3Dxx9zKf76rhJS/XNuMBeZUksopf6O7YdJOQwPJg/ROQ0+HdhnbQ0M5kzmcnwFdxJtEXgU2rh8gNd8rBW9f2jY/swXpJhAYyt5Ifbd0iKrradPEs+sFYLtuJ7B9krmmGkoyYARtcZ+upEzy9b4mszhmxOIT+PFV13vN9nvD8V8wgzIhsOw2ry36gL/MGA==;5:zLG9JO5iZTvyeV5rF5FSSQmTYZ9YUbHOwb7lhRUu0aqDnJsi9Vl4IDrr+F27ZAPtCOMMNu2mIQi5Daq7u2LaA1AObqXcbIojV+2DBf9xGRDg8E1Zz5np7LmWzb1MIGMdtP+VtBphRNghjH/gqb3DdLOulNahcGjGUkS66rpoW4k=;7:hUzxV9iCYR8dAPmfRtxPNxVIbdPCr62LTWnUZSq3A7MUNpHgOBTNbNrM2SEMxox+EgvK4ILT46YxfoYvwDkqSITC6LWm0mLWOAVPG0pC2BZo7fjcUbHokH5LKii4SNk8EorGEdhmA0dA6PmVgYp9HA==
x-ms-office365-filtering-correlation-id: acc00010-fcea-4c73-b2d8-08d64e6f4c5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1263;
x-ms-traffictypediagnostic: MWHPR2201MB1263:
x-microsoft-antispam-prvs: <MWHPR2201MB1263A24AF51BCD28989F79FCC1D80@MWHPR2201MB1263.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231441)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1263;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1263;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39840400004)(346002)(136003)(396003)(376002)(189003)(199004)(97736004)(229853002)(53936002)(8936002)(8676002)(7736002)(256004)(105586002)(508600001)(305945005)(81166006)(81156014)(66066001)(68736007)(54906003)(4326008)(25786009)(71200400001)(316002)(39060400002)(6486002)(7416002)(58126008)(71190400001)(6512007)(106356001)(5660300001)(9686003)(6916009)(44832011)(11346002)(386003)(6506007)(42882007)(33716001)(6116002)(446003)(33896004)(3846002)(14454004)(6246003)(102836004)(476003)(6436002)(2906002)(2900100001)(99286004)(486006)(1076002)(26005)(76176011)(186003)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1263;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ItZSU0Au79Ut/af45KQTwuotIfqRLFDtz6A9SAfgr+CeEEZUm3bAoG5ze2eyFiihYauWbaxUyjrgiehDwaqV8RJse3kUZGljtfUI5gs8sm6ZvTOBgbd6noDGF6kw4qjQdBLi8WSc4JUErtt4wmoqx7G3YmP4Dw9ZiKbXnQCWDoOay4Se4nHcAAdE3ODF9uxYkIv+KflLwk+CcYzl1N8lzs0RHaH7/n410xtzL0Z11KPR4Hd7p3d8XK90ll46I/kCSztDWixQjuVWnWd5bbS3T3FQ8vLsMumsyknHp/2aYxULUt1nqlP5B+gBOVN0Bl81ekqtA5lBoW9AnnzgrLTGDlgSgCESighfPIvecqfaMno=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2E211591DB73D41806327B2F9F1BA57@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc00010-fcea-4c73-b2d8-08d64e6f4c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 22:35:25.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Nov 15, 2018 at 11:44:20AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscal=
ls/Makefile
> new file mode 100644
> index 0000000..dc6bbb1
> --- /dev/null
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +kapi :=3D arch/$(SRCARCH)/include/generated/asm
> +uapi :=3D arch/$(SRCARCH)/include/generated/uapi/asm
> +
> +_dummy :=3D $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
> +	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> +
> +syscallo32 :=3D $(srctree)/$(src)/syscall_o32.tbl
> +syscall64 :=3D $(srctree)/$(src)/syscall_64.tbl
> +syscalln32 :=3D $(srctree)/$(src)/syscall_n32.tbl
> +syshdr :=3D $(srctree)/$(src)/syscallhdr.sh
> +systbl :=3D $(srctree)/$(src)/syscalltbl.sh

Could we go with 'n64' instead of just '64'?

When we get nanoMIPS support we'll be introducing the p32 ABI, and
there's a reasonable chance that the equivalent p64 ABI may come along
in the future. Using 'n64' now would avoid confusion in that case where
we may have 2 different 64-bit ABIs.

Thanks,
    Paul
