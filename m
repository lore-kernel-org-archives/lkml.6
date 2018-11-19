Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189532075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yJc96Y50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189532075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeKTGg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:36:56 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:26350
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728600AbeKTGg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D80EUmGZ8IuUfVMCEYHsGj0cxxGuj5p2c1wJIPPVKE=;
 b=yJc96Y50pls/yaAYhrVamV7ZPeWdSzKOsmplGvg8qicG3PYsgwnKz7BCfWRz9RC6ATHfzRGwMvOf89nPemNDSIEXSZ2NnsM/dff5xHQ/o9cs0W7sLRMjYnMNaVQ7fhM1yAwBI8omkC+lFvDQXwhW5xI9XRB3fGhiLbtJr46W+NA=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1884.namprd12.prod.outlook.com (10.175.88.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 20:11:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 20:11:37 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files to
 more generic names
Thread-Topic: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files to
 more generic names
Thread-Index: AQHUfe6NWz4xLUMToUORxfHJiImFOaVVlD6AgAHnz4CAABA3gA==
Date:   Mon, 19 Nov 2018 20:11:36 +0000
Message-ID: <61f6e553-a72f-bfae-0887-44f066006118@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-2-babu.moger@amd.com> <20181118140735.GC19380@zn.tnic>
 <alpine.DEB.2.21.1811192012460.1669@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811192012460.1669@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0002.namprd07.prod.outlook.com
 (2603:10b6:803:28::12) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1884;20:0cq4hU52Dd7ogxVI1uqhwyry9z80ICTqezcwobknBD1x02+0s56Pao4jTcfnQsLX5Is/XLAAyaVV8KXj9boku4b8+YfW1UyqLfOu3MDBPUAisFQxpQTlI3+O1Cciab+b+JOwF8HbK47egZqIForbsxxVpbIz1LbD/b6fZMwA68Gc+G8VsonWahj3QHERYUzC0trN1o8eQIzmnCRrn3zQBmvG87BWt3fFlqBHx72WqfQQVkTgQ2ZkpJQovJTftKAD
x-ms-office365-filtering-correlation-id: 91876d20-b668-43d0-787f-08d64e5b357b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1884;
x-ms-traffictypediagnostic: DM5PR12MB1884:
x-microsoft-antispam-prvs: <DM5PR12MB18849208443D1C2E376EACC295D80@DM5PR12MB1884.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1884;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1884;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(13464003)(189003)(199004)(66066001)(71200400001)(97736004)(99286004)(71190400001)(3846002)(6116002)(81166006)(81156014)(6512007)(76176011)(53546011)(6506007)(14444005)(53936002)(52116002)(102836004)(256004)(386003)(316002)(54906003)(14454004)(25786009)(8936002)(186003)(26005)(6246003)(110136005)(2906002)(8676002)(4326008)(478600001)(93886005)(31686004)(106356001)(105586002)(36756003)(5660300001)(72206003)(229853002)(7416002)(7406005)(11346002)(2616005)(7736002)(446003)(305945005)(6486002)(31696002)(86362001)(486006)(68736007)(2900100001)(476003)(6436002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1884;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tiTwI4U78eH+ZElwHxG0dCsk2RyV/s80QsYmXG9+ojYlRV5dhzlCb37b8Rm+plURrGozEltqrZKfQR5Sf04RnGHrPSgO7b2NEnsGc3eMV01C6MG+MQh9kLLL/CtFpoiEPCx0P8Go0NuEXmBKFhgeCg6cqLeymKlW3njeQQ9+pLVXbYpJ/uUPTk7k/4zCWLyNForaDBymzlmg1lkF4V3fFHNdo28W9jSo9EI5WSLqaafR6AF37aXkVMRJu0Ayp48WKBT4H8eQcIsam+DXguWZlsE72HRYpkocvz9MQ2VcJWDJmKbGDF9iUvHam90xPnZv9WvOJ7AB3ldIQQnG/ZHUIooSH1Ew8mP4clL61Ipaq0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6DB41E456A8E9349A3EA42A11DAA84A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91876d20-b668-43d0-787f-08d64e5b357b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 20:11:36.9372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris/Thomas,

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Monday, November 19, 2018 1:14 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Moger, Babu <Babu.Moger@amd.com>; mingo@redhat.com;
> corbet@lwn.net; fenghua.yu@intel.com; reinette.chatre@intel.com;
> peterz@infradead.org; gregkh@linuxfoundation.org;
> davem@davemloft.net; akpm@linux-foundation.org; hpa@zytor.com;
> x86@kernel.org; mchehab+samsung@kernel.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; pombredanne@nexb.com;
> rafael@kernel.org; kirill.shutemov@linux.intel.com; tony.luck@intel.com;
> qianyue.zj@alibaba-inc.com; xiaochen.shen@intel.com;
> pbonzini@redhat.com; Singh, Brijesh <brijesh.singh@amd.com>; Hurwitz,
> Sherry <sherry.hurwitz@amd.com>; dwmw2@infradead.org; Lendacky,
> Thomas <Thomas.Lendacky@amd.com>; luto@kernel.org; joro@8bytes.org;
> jannh@google.com; vkuznets@redhat.com; rian@alum.mit.edu;
> jpoimboe@redhat.com; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Subject: Re: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files =
to
> more generic names
>=20
> On Sun, 18 Nov 2018, Borislav Petkov wrote:
> >
> > Now, it looks to me like the whole resctrl thing begs for its own dir:
> >
> >  arch/x86/kernel/cpu/resctrl/core.c
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> >  arch/x86/kernel/cpu/resctrl/internal.h
> >  arch/x86/kernel/cpu/resctrl/monitor.c
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >
> > This way, the whole RDT machinery will be confined to its own directory=
.
>=20
> Fine with that.

Ok. Sure.  Will change it. How does this look like?

arch/x86/kernel/cpu/resctrl/res.c
arch/x86/kernel/cpu/resctrl/ctrlmondata.c
arch/x86/kernel/cpu/resctrl/res.h
arch/x86/kernel/cpu/resctrl/monitor.c
arch/x86/kernel/cpu/resctrl/pseudo_lock.c
arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
arch/x86/kernel/cpu/resctrl/rdtgroup.c

Changed core.c and internel.h to res.c and res.h respectively. Both of
these files are about resource definitions and initialization.

>=20
> Thanks,
>=20
> 	tglx
