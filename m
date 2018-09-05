Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D4A20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ba0ht2RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D4A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIEXmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:42:21 -0400
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:29935
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727755AbeIEXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8UYRaUw52fYO/CH05q7/shcUPfsH389zxE6z8DdJTY=;
 b=ba0ht2ROoeRGGAJPmphNKo0L98HGPGKwEeT+BRzMPAPAPOeQOVHxjBobyoINwraeyR8agEeUM2zA6g/RTAnJbkzdPUD5GG6A/nBO3uo81+VPMuwDczVj1t1HeJXysBukh8NIRG85QWD9eqGDt9qdbBD2MiYaYXWB67Oj8nVSq1k=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3925.namprd05.prod.outlook.com (52.135.195.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.12; Wed, 5 Sep 2018 19:10:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 19:10:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Topic: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Index: AQHUQuMbzkVQDn+XA0OpXaFEC8rBZ6TiDnqAgAABqICAAAJhAA==
Date:   Wed, 5 Sep 2018 19:10:46 +0000
Message-ID: <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
In-Reply-To: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3925;20:L2qcDPqgCDnz7v5a3iNVsDXzSPZ7OObpINWiR4dFTWLZpU8whBo3RbvSVDuk4AncRQxQQDOyWNTzYaZlMMWtbFyqzAmV68lag0+zUFl2QborkNAldXbHrb8+y+6ATl8Vvm//h6C/KmjIrIqBjwnU8Ruc0LfN9aSjpfcDZNZqkE4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e2ef9fd-3157-4dc8-d1b3-08d6136348dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3925;
x-ms-traffictypediagnostic: BYAPR05MB3925:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB39254CE9F287873402A024D7D0020@BYAPR05MB3925.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR05MB3925;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3925;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(316002)(6116002)(6916009)(102836004)(5250100002)(6506007)(6246003)(54906003)(66066001)(8676002)(105586002)(3846002)(26005)(305945005)(2900100001)(478600001)(2906002)(7736002)(256004)(99286004)(106356001)(4326008)(33656002)(76176011)(68736007)(25786009)(14444005)(53936002)(186003)(5660300001)(11346002)(8936002)(6486002)(36756003)(446003)(486006)(82746002)(14454004)(97736004)(476003)(2616005)(83716003)(229853002)(81156014)(6436002)(6512007)(86362001)(7416002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3925;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aHYEnvEfPYYiGdYW+Gc8cC35OMs98/5C9aahkgJsyrGt4BdfNTeVMn3eY30WNt75NsC/2rDyrnkfctmbctSwNVKcHk1f5/fTgADqBb1XgGeCAi4vArZE/L6mamvgldeLbjfPIVYYyAVvQ34b3Tov+1K3U5ulPH+2AUWCQlKz815fGDcmtjSM6udWPxn3Nim6GetAWdzvkV/jkRuiZQFgt56BQ48OV7pmh7XMBnN2MFYVgja69zJ5ShJtcxg7sGA5w+RGqUHVtnnFRdxVhnHejIomzyFAm6rSjxowo083jgllgvnYrbWj/43OPm+ba+IEy80TKydsp9qper+er9WoVvfMnlJVDYarwQbM6OQy+ZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6D032E7CC8E8F479471B6AA24CFAC2E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2ef9fd-3157-4dc8-d1b3-08d6136348dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 19:10:46.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:02 PM, Nadav Amit <namit@vmware.com> wrote:

> at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
>>> This patch-set addresses some issues that were raised in a recent
>>> correspondence and might affect the security and the correctness of cod=
e
>>> patching. (Note that patching performance is not addressed by this
>>> patch-set).
>>>=20
>>> The main issue that the patches deal with is the fact that the fixmap
>>> PTEs that are used for patching are available for access from other
>>> cores and might be exploited. They are not even flushed from the TLB in
>>> remote cores, so the risk is even higher. Address this issue by
>>> introducing a temporary mm that is only used during patching.
>>> Unfortunately, due to init ordering, fixmap is still used during
>>> boot-time patching. Future patches can eliminate the need for it.
>>=20
>> Remind me; why are we doing it like this instead of fixing fixmap?
>> Because while this fixes the text_poke crud, it does leave fixmap
>> broken.
>=20
> Do you have other fixmap mappings in mind that are modified after boot?

Oh.. I misunderstood you. You mean: why not to make the fixmap mappings tha=
t
are used for text_poke() as private ones.

Well, the main reason is that it can require synchronizations of the
different page-tables whenever a module is loaded/unloaded. The fixmap
region shares a PGD and PUD with the modules area in x86-64.

In contrast, the proposed solution uses a different PGD, so no
synchronization between page-tables is needed when modules are loaded.
Remember that module memory is allocated even when BPF programs are
installed, which can be rather common scenario.

