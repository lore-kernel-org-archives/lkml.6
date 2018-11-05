Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073AEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C103920862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="IgLZ6tfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C103920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbeKFDZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:25:36 -0500
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:10752
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387640AbeKFDZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wrFNQTX85OiT8J1W98MYQKCkA9qcJhRzgPJqOGG/UM=;
 b=IgLZ6tfAO+XDGtaEqwvvY70QpLRk0OGCWRD3a1IVN1ZhkfXyH6H2zG+jK9bSmxT9b3va1xA54wak99XwDzmRHmqDOiYkO91biR63dp51Qza7iJ0n3axowjxWOAbr9cukth5X4EB02FnxaeQJHo/L5SfEynvBdHl0p+Wa/4zeAc8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5848.namprd05.prod.outlook.com (20.178.49.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.15; Mon, 5 Nov 2018 18:04:42 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:04:42 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Thread-Topic: [PATCH v3 6/7] x86/alternatives: use temporary mm for text
 poking
Thread-Index: AQHUcwQ5CMopNGTk70+f2dIwnm2sU6VBMXWAgABMjQA=
Date:   Mon, 5 Nov 2018 18:04:42 +0000
Message-ID: <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
 <20181105133041.GC22467@hirez.programming.kicks-ass.net>
In-Reply-To: <20181105133041.GC22467@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5848;20:H5tK3DtZZiQLKsULxMwRmqGtJHDvD7MuuKmRtu2Qad/QHAEHiK4tF1ezJkPE+8Rhtpczj4iVeN/1B6qheH/P2qBFs0np7ponUUh+JU4KCWVPIBiO7eJ4GcAuIth5uhoHgrgFmeqQ6rXgorNxdODi4I+fmS/WTBW8c8eAKCyVHH4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3e11b123-9c96-4ae2-d8a7-08d64349298d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5848;
x-ms-traffictypediagnostic: BYAPR05MB5848:
x-microsoft-antispam-prvs: <BYAPR05MB58488DFE7CDEDB1067686CA3D0CA0@BYAPR05MB5848.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5848;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5848;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(7736002)(53546011)(8676002)(36756003)(6436002)(8936002)(2906002)(97736004)(305945005)(6246003)(81166006)(316002)(81156014)(256004)(99286004)(14444005)(3846002)(76176011)(6486002)(6506007)(86362001)(6512007)(102836004)(26005)(7416002)(53936002)(6116002)(478600001)(83716004)(71190400001)(71200400001)(82746002)(476003)(486006)(2616005)(68736007)(446003)(5660300001)(6916009)(11346002)(54906003)(66066001)(14454004)(186003)(4326008)(33656002)(25786009)(229853002)(2900100001)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5848;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IOhL5QhbQOvE6vgM2X4/WTcEOfBrCGjy8Gpq9T/wI1HYutaCHHodr/6Z5aGmvEly+8pRvdA+ruV76mpN2hysWaZnN1UEHDguWERIs5yCdC9egzYhv5Ymfn+FJobMaOs1TTeQNRIToEIfHm+qoMIk0osJ7fv50+sQT+RrMTmPhsUqnIZCNsNQJ5C03ap1EMzWj2k55Nf6unPgwS1EDndJaj5m9JC882LIplQ7NvDDM2uO26hPfMe0FaLcZmdYMKcEcsE0dNuhGeI0/8em4uRvexfXxZNpmBerqIs0pVxSWQfW+XR1b2LfEzOIrkDQyR3EQg04IrCGaTZSr7W5erLSRyap3b926XMQb5XghgfvXGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AE980EF71EDCD45975C6490CD42D3E0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e11b123-9c96-4ae2-d8a7-08d64349298d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:04:42.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
Sent: November 5, 2018 at 1:30:41 PM GMT
> To: Nadav Amit <namit@vmware.com>
> Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@ker=
nel.org, H. Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.d=
e>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.co=
m>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, D=
ave Hansen <dave.hansen@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
> Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text p=
oking
>=20
>=20
> On Fri, Nov 02, 2018 at 04:29:45PM -0700, Nadav Amit wrote:
>> +	unuse_temporary_mm(prev);
>> +
>> +	pte_unmap_unlock(ptep, ptl);
>=20
> That; that does kunmap_atomic() on 32bit.
>=20
> I've been thinking that the whole kmap_atomic thing on x86_32 is
> terminally broken, and with that most of x86_32 is.
>=20
> kmap_atomic does the per-cpu fixmap pte fun-and-games we're here saying
> is broken. Yes, only the one CPU will (explicitly) use those fixmap PTEs
> and thus the local invalidate _should_ work. However nothing prohibits
> speculation on another CPU from using our fixmap addresses. Which can
> lead to the remote CPU populating its TLBs for our fixmap entry.
>=20
> And, as we've found, there are AMD parts that #MC when there are
> mis-matched TLB entries.
>=20
> So what do we do? mark x86_32 SMP broken?

pte_unmap() seems to only use kunmap_atomic() when CONFIG_HIGHPTE is set, n=
o?

Do most distributions run with CONFIG_HIGHPTE?

