Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B952075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="AuXY9a11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIHBes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:34:48 -0400
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:11779
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeIHBes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkcQDrlEjd3Fsf83bogHqPvcBHPzNDQAsNyT5QwUqyo=;
 b=AuXY9a11Vn86nRouFIpc4gXtPrr9LRSWsGnP9hXGf7b36FQy8JMXL9BNIET7FY3UPXsLDjN0ZpPHFiXhrM/XAskXfCKc0mJuUdjLX8u5ltsMXX1/aOjSeEt4Pxo7AJvhf8FcduAzQDnYGI0NjoO6dI+fPgpVXs5s/XS5ArYzWVY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4280.namprd05.prod.outlook.com (52.135.202.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.9; Fri, 7 Sep 2018 20:52:05 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4d7f:773c:89:28ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4d7f:773c:89:28ae%4]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 20:52:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for
 patching
Thread-Topic: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for
 patching
Thread-Index: AQHUQuMhpyA9WLrTWUCxwAeqHkTnV6Ti+q4AgAJYzYA=
Date:   Fri, 7 Sep 2018 20:52:04 +0000
Message-ID: <B41E8041-C4AD-4098-B0BA-665847F4A0F6@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-5-namit@vmware.com>
 <20180906090142.GG24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180906090142.GG24082@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4280;20:GXRVcAN2gV3i9AQlHNTsK04tDnsOzSvdztjISFXkt28NmsOa+/t4fVbPd0zSyk2eEX2XUxf60jdF3NDYX+N7U622tirditgr/yNqxL13msGkCqoEMNqcCVcNrKQgF5Rsdh413oIJ1hhRZ5BHHjrbnJE5MrK1rpEQnVP/QpMkqlY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3ccc8a4b-d7f4-4ef7-4dc6-08d61503c4ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4280;
x-ms-traffictypediagnostic: BYAPR05MB4280:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4280AF5C995884835F2CE7E9D0000@BYAPR05MB4280.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR05MB4280;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4280;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(99286004)(14454004)(76176011)(6486002)(33656002)(229853002)(2906002)(53936002)(6116002)(3846002)(6512007)(6246003)(6436002)(4326008)(25786009)(68736007)(82746002)(2900100001)(83716003)(5660300001)(6916009)(7416002)(66066001)(54906003)(316002)(8676002)(305945005)(105586002)(106356001)(7736002)(5250100002)(2616005)(478600001)(446003)(36756003)(26005)(11346002)(97736004)(86362001)(476003)(102836004)(256004)(486006)(8936002)(81156014)(81166006)(186003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4280;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /1FZwVabvivydKZ/We0KJJNTPIdL6Px/4fJMfGHyXBPptPY6RlajiHBImb4i1qOBO0T8Rm752DnEjPeZ4NLfK34OtM3vUZqmOE5SFYJYazHDZaoDZ7OnBLpv54Rt7vOk9gQSEzmhHeKCOiAEmhPTunRif1trw51mLYr8yWcNv292clO4iscZ3/w2Ez5wy8Exf2HxQObdEziA2kpgnmubvURniITYl2/Y1bFHLx9Ot3s/DaH40Wrm3/dFZ1ZaW45T8oAREwMIbKuUDpZkD7IqnV8eVEe73Va7UuvBuj1n5/vCSuxlzbmy3suD2hGrcaYpBkHCh0dz2xfZPUBrPfAbeyWw+bN7+JOz5eJ8W/LgWdc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <099BF27455C18C4AB822FFF2F7FD03DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccc8a4b-d7f4-4ef7-4dc6-08d61503c4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 20:52:04.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 2:01 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 02, 2018 at 10:32:22AM -0700, Nadav Amit wrote:
>> +void __init poking_init(void)
>> +{
>> +	unsigned long poking_addr;
>> +
>> +	poking_mm =3D copy_init_mm();
>> +	if (!poking_mm) {
>> +		pr_err("x86/mm: error setting a separate poking address space");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Randomize the poking address, but make sure that the following page
>> +	 * will be mapped at the same PMD. We need 2 pages, so find space for =
3,
>> +	 * and adjust the address if the PMD ends after the first one.
>> +	 */
>> +	poking_addr =3D TASK_UNMAPPED_BASE +
>> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
>> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
>> +
>> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) =3D=3D 0)
>> +		poking_addr +=3D PAGE_SIZE;
>> +}
>=20
> This fails to compile for me.. I don't have kaslr_get_random_long().

Will be fixed in v3. Thanks.
