Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E60420811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="OpAGewTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfBERzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:55:03 -0500
Received: from mail-eopbgr780089.outbound.protection.outlook.com ([40.107.78.89]:55589
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfBERzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvX0SvjzS9cg6KCABhOsPWSCOuOybvRlHZr0Cemjf4M=;
 b=OpAGewTadxIiu2tMElin5owl7CWsCVVrijVMnRG6Pthy8Zdi1OfGb8jRXisJK8MdhqZFGho3dHnHLTlJBmPRrn8ZxrZhf3Ol53iQFg0sFuknEJUGQRj+E27JmJYsrepyunMK+Dkti5KARvgxwX65eZuQYgRlzJpxYwnGf5wNiR8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6296.namprd05.prod.outlook.com (20.178.51.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.15; Tue, 5 Feb 2019 17:54:57 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1601.016; Tue, 5 Feb 2019
 17:54:57 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Thread-Topic: [PATCH v2 06/20] x86/alternative: use temporary mm for text
 poking
Thread-Index: AQHUt2sRlZaCHhQDiEGNmzE5nFIfqqXRA/aAgAAZ9ACAABHSgIAAWTuA
Date:   Tue, 5 Feb 2019 17:54:56 +0000
Message-ID: <6D321F51-6B19-46F6-91AC-74248A542BA0@vmware.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-7-rick.p.edgecombe@intel.com>
 <20190205095853.GJ21801@zn.tnic>
 <20190205113146.GP17528@hirez.programming.kicks-ass.net>
 <20190205123533.GN21801@zn.tnic>
In-Reply-To: <20190205123533.GN21801@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6296;20:QxqDJfbj9XKfepbpbqVmkv5766jXl1JorpcDc6xl1KJTVSUXIhn8Yppt06+640zAjKe19ZUYjxzlT4M0m9fIzrT19NXajABrJO1ZdDj+E2tBtRdgF4MdWJDksNZuGxoMluWmebwHQGTI/5LvMPDyWX2bkhPN5tJcnu8luW5HTyM=
x-ms-office365-filtering-correlation-id: 233f17a2-c471-4c41-7414-08d68b930a6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6296;
x-ms-traffictypediagnostic: BYAPR05MB6296:
x-microsoft-antispam-prvs: <BYAPR05MB629637D5EFD114B23FBDE163D06E0@BYAPR05MB6296.namprd05.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(81156014)(105586002)(81166006)(93886005)(8936002)(106356001)(2906002)(83716004)(7736002)(86362001)(305945005)(66066001)(14454004)(76176011)(33656002)(71190400001)(97736004)(7416002)(8676002)(316002)(186003)(4744005)(54906003)(26005)(71200400001)(6436002)(36756003)(102836004)(446003)(478600001)(6916009)(99286004)(82746002)(476003)(256004)(68736007)(4326008)(6512007)(2616005)(11346002)(6506007)(53546011)(229853002)(6116002)(3846002)(6486002)(53936002)(6246003)(486006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6296;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ul9qel0S4EZTHba0GgO2eznZQaY624VlPUugjgCH3NFi1b4exP8NOmkXrIxJZBzWQ/9PO790babvf+zx0YTNmHw23UGyw+mITeq8dcEnV5+WT1i9k92R332oCrqA6Z8JAnwzltUXeqkJcatAvWsRexKqhuZHdeCsagmB0PBY7TzMef7OAIl8fLzvwsHHguiU5yeqHfAa2iELj+whTRRM1Q8CXeQbWt8QFB9a2cHOmgTFxjVn3xkqKtGVfQMrXAMNpVAtDbObNsQZnoK2nHGtGARUrWZoGqMzAKQbFIxf5JIb1ZR7/HV7NgpPJ9EEmbA7y7Zd4I/poK/y8+sK/8alNNmUlobAlWEwuYz4Sx5l8KKbdDUXjG84E1cep7hBpaKFiBrw/Bwevt7zMPU34CU4iPzUYAUAlTWAJLxE753GYJY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6D00271B554CB47B00297C100C54604@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f17a2-c471-4c41-7414-08d68b930a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:54:56.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 5, 2019, at 4:35 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Tue, Feb 05, 2019 at 12:31:46PM +0100, Peter Zijlstra wrote:
>> ...
>>=20
>> So while in general I agree with BUG_ON() being undesirable, I think
>> liberal sprinking in text_poke() is fine; you really _REALLY_ want this
>> to work or fail loudly. Text corruption is just painful.
>=20
> Ok. It would be good to have the gist of this sentiment in a comment
> above it so that it is absolutely clear why we're doing it.

I added a short comment for v3 above each BUG_ON().

> And since text_poke() can't fail, then it doesn't need a retval too.
> AFAICT, nothing is actually using it.

As Peter said, this is addressed in a separate patch (one patch per logical
change).

