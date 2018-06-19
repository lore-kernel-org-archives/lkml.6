Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76820875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="H+uMQZgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A76820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965149AbeFSHM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:12:26 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com ([104.47.32.86]:44400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755546AbeFSHMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPNFOI6UuFDWGIpQUjEXr4HWUnGeWbt8JQ5BlAmhIU0=;
 b=H+uMQZgQEVUahNfr/wX1mFSv0Bxf9yo1+Rgtz1bKhxY20lsYKoTzHrUDYAH4GNxpHTxIHDPgqJ/63C/Sl6TtAwGD1UQVGefjs/eMZnwKcfPyyZgQURXZzB3237b+JsIEG3gxAxcmYDuTJUVJvoOKa6pCiIkI7PKnbkjh5EPZew4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4149.namprd05.prod.outlook.com (52.135.199.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Tue, 19 Jun 2018 07:12:21 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%3]) with mapi id 15.20.0884.010; Tue, 19 Jun 2018
 07:12:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
Thread-Topic: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
Thread-Index: AQHUAoBcWQHwkR0gx0yiggpe5MmWsaRedzMAgABM9ACABN6MAIADkgSA
Date:   Tue, 19 Jun 2018 07:12:20 +0000
Message-ID: <062A4564-15F4-41B2-8808-475F3F4CB119@vmware.com>
References: <20180612115050.185112-1-namit@vmware.com>
 <20180612115050.185112-2-namit@vmware.com>
 <CAK7LNATmjTi4Odp5AfbVHCemn7S_tB9nKvgNOf5sp8BiVJma7Q@mail.gmail.com>
 <D9AF0864-EE2A-4C2E-A5A4-C002DEB95B2B@vmware.com>
 <CAK7LNASdmie+Y4haU5bCMb8s4RztHzOcFXUxGxjcCqsbwPN7uw@mail.gmail.com>
In-Reply-To: <CAK7LNASdmie+Y4haU5bCMb8s4RztHzOcFXUxGxjcCqsbwPN7uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4149;7:Z+5fkuTwJKMkopyslpT+47jTJdJI33zbHvxmnIilTA9lH1Y9k8uw2JonhsojmCIH2Qe+jEtyXbJ5vYFeV8VBUAZTnH6A4DvR0PNkoiQXPaOMPOh8zvMDhXlnrgfajZxTeu+xmXKaGSy+t8R20l2hvQqY/rbJGKCcbWxnh5yf/CHXKSwUJNWe5fqUv7kVzSg70IpZtZC0RxALJEhLK5J6JOdf5128Bgk1ApT2azLGi0/PhR1I6nnf/gyG6lp90hy7;20:DiXEdHkGzfNGfhnYzvYuuqEETfY+COgbZ6JVT0j+ZuccQtc0iedGnnAjfbi1RWzBP6S+pQEnjlsfNai4faABM/8ygzjbcvrm6fdHfDbzlzjNG1S5JvWMxhVQyupdAxG4bMzhNO8N0tvnnKoFfF6fWcImphJa16PXkUXAisqlJB0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 125b97bd-ace8-4c3d-db45-08d5d5b40003
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4149;
x-ms-traffictypediagnostic: BYAPR05MB4149:
x-microsoft-antispam-prvs: <BYAPR05MB4149696DBC874E5656694FA6D0700@BYAPR05MB4149.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4149;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4149;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(366004)(189003)(199004)(25786009)(54906003)(5660300001)(33656002)(99286004)(229853002)(6486002)(6512007)(93886005)(478600001)(6436002)(558084003)(305945005)(14454004)(68736007)(316002)(8676002)(7736002)(82746002)(81156014)(81166006)(6116002)(3846002)(2906002)(6916009)(105586002)(3280700002)(8936002)(6246003)(3660700001)(2900100001)(102836004)(186003)(26005)(486006)(106356001)(11346002)(476003)(2616005)(446003)(4326008)(83716003)(6506007)(5250100002)(36756003)(97736004)(76176011)(86362001)(66066001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4149;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f1afGLWk/eU7KeBh6Ttuw2UlwUk0TXdIyy9PgB62gKXdF7usMEkETvIHzbPpAJy4JRhZD5TEDsigRHy+Zmzwt3lgnfU6bdne/emNzM1djb8It67mq5yJR0mCF4hzaPZkqqy8OZYF6QgDiv/zYjIt/yNXgFll4w5EUrhWM9yNAR/4einI/op1qCjejr0xDjp2qdeWtgMQkaTL6eQzj5omCeMVQKJ/+w+ahd8C5ZliJFzLQt/favJwuEYT63/+EQYBUQZbG7Qw/tBGKWPO2GlFSeulHw5g7YZNSnwWGNGXGU8rloLsrsTtbqKPl56BJ+CT6SGpO0yJFT9RQXC0FTN9kA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66A520A173241D45A4B814AEC190EE83@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b97bd-ace8-4c3d-db45-08d5d5b40003
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 07:12:20.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 5:40 PM, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> In the meanwhile, CFLAGS_REMOVE_ will do
> as a workaround.

Thanks! I appreciate your help.

I will submit tomorrow an updated version.

Regards,
Nadav
