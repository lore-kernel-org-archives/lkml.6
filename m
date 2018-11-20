Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FDC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B01D204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Kkr3tZUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B01D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKUCxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:53:11 -0500
Received: from mail-eopbgr740088.outbound.protection.outlook.com ([40.107.74.88]:24892
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbeKUCxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=674uKD9NixW09bNo2RKimL8EU/e+BoGCs5qo87cqmmk=;
 b=Kkr3tZUCLasX6Ko34RXuu6IgP0aYQwfIuJgKY0FiTSEdIB+pBa6tljG0XaWnLlSSohyfTjbsU+kKV1dJIC3XVAy9RyK4ijXsZVbn3tymw0uA+Jdi+O3thn4p/8hk7096GdPkCpegNX9LnummTFi6TtZTb9f59Y4FtyTeppacB3k=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB5479.namprd07.prod.outlook.com (20.177.229.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 16:23:11 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917%5]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 16:23:11 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: WARN_ON after gic_reserve_range
Thread-Topic: WARN_ON after gic_reserve_range
Thread-Index: AQHUgO1U84iLvQ34EEO/s7o5keutZQ==
Date:   Tue, 20 Nov 2018 16:23:11 +0000
Message-ID: <20181120162305.GA2088@hc>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0064.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::24) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.67.135.23]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5479;6:h4pfS+wKk8PmQ6Ki8rFAs9zfy9+kXTzN0DqEInPR30yBFdo2NsdJC93f2yDZbIATw3dKJwSEP/jTE4w27gxRCslnDk9k6X9eyL9zbLgKR/9XRYHfE/7B9ucE0sp/SE9fhDucvVofI7Zn8Nzn6RiLpXn8Z98xPbZun6c24kjL3v/5v3UMLmc0ircmfxX9+fB06AzkjuGUHo+fzDm7q0m6Z7kyLrw//+TWkNAm58MueKRI34jivp0Qk1IVAZxh7aJahF58uLpH1Otk+f8QbM1/KZkhiyczA1LlM34SBtT075QLCMTSRsjIOm71j5LOYBLFEF0+060SQ+oG9tJ6xnih/zttV+Mrp9//vVt5QOjexycxS+5RA3wF7eu5uf7N2QrxvrdBwhM5ResN6/RLY5LPchotN7p6hVAbMN9sDiH6OvmKbuIgWWUlFlCScDZ4kgRzjvWN1Yqq6z00fAMjBFChoQ==;5:lOVj26TlUAXaF1GcK0VrVyZ5vVNmDpm2g7AXeBE5OKi8VkoGh8pP46A4Vv0t1yjTrIVFeArRlLJd2pgsTmH9GZuChltiC/xhwwh4gCiyopkIBYvaJe/qCK9yADhUED1octr4S7daBeUoXg4Lkim8xNI2LqX/DA7rSdH9u20NUaE=;7:4825N1lhD5u0TZf2L69ohBk1t7ReN9kqmiIa9pTmqmysIhvOBMAM8q38gFU3w9HWtt6M6AF+f5IWhG+7lOLzPy6FgSdJEGjD2vbSWF4q0e8vBoAQ/h8DOQjlR36mdJAMqjiBvTfNS8aD3Ru0HNJJRw==
x-ms-office365-filtering-correlation-id: 29ab668d-70ba-4f85-f93a-08d64f0476cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5479;
x-ms-traffictypediagnostic: BYAPR07MB5479:
x-microsoft-antispam-prvs: <BYAPR07MB54798D2C7A1C0B9F9152402291D90@BYAPR07MB5479.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5479;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5479;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(8676002)(81156014)(256004)(486006)(33656002)(476003)(81166006)(99286004)(305945005)(7736002)(44832011)(2906002)(7116003)(6506007)(575784001)(86362001)(1076002)(105586002)(71190400001)(71200400001)(33716001)(33896004)(106356001)(14444005)(66066001)(386003)(8936002)(52116002)(6116002)(3846002)(186003)(102836004)(26005)(14454004)(68736007)(53936002)(478600001)(2900100001)(5660300001)(6916009)(97736004)(6512007)(72206003)(9686003)(6436002)(54906003)(316002)(25786009)(45080400002)(6486002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5479;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YYp+8vtNc5mn8cixrIvLAbrzegPv8k9k7KxA4qOjs/1OdYXpbCN30xaacltim88lU8PDIR8WV0XoW8YPzK62msNAPO2nSAtvT5AhDHmZtnYEXbjvkSUE3eIffMh1siPq+EXw+oSnjCg5cgRS/48UG7Z9XFYWxUvd4bfS6dwZRl2LD21tBGZfQ11YgX9jX7iEAHAofTIql6rzUiuUdyirNgXrVNJ7Ej7Qp1RfvmBgvdUdLVXjYAUqUSH1jmxJmFdZIBjjl7Chm5CEN4bZ6kaB6K8mXyj53Zn/5MyVsUiQP+LJHjQYFtbdMdp2ij7upIo3K3mBwHfPqnJRV62yP4bNuNvvqKrF7Q4+L0PCgHynaiA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <482CC775DAFBA34EB6FC7B0320D5BE6F@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ab668d-70ba-4f85-f93a-08d64f0476cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:23:11.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

with 4.20-rc3 I see two WARN_ON's firing on a ThunderX2 system that come fr=
om
commit 3fb68faee867 (irqchip/gic-v3-its: Register LPI tables with EFI confi=
g table).

Global efi_memreserve_root is NULL as it will only be set when early initca=
lls are
running, but from the backtrace the WARN_ON's are running even earlier (ini=
t_IRQ).

Am I the only one seeing this?

[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1=
696 its_init+0x36c/0x608
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3-jang+ #=
69
[    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
[    0.000000] pc : its_init+0x36c/0x608
[    0.000000] lr : its_init+0x368/0x608
[    0.000000] sp : ffff000008e53c60
[    0.000000] x29: ffff000008e53c60 x28: ffff7dfffe6807a4=20
[    0.000000] x27: 0000000000000001 x26: ffff80267b4c2100=20
[    0.000000] x25: ffff000008ffe930 x24: ffff000008e5d9c8=20
[    0.000000] x23: ffff80267bc10300 x22: ffff000008e5d9c8=20
[    0.000000] x21: ffff000008e59000 x20: ffff000008f12000=20
[    0.000000] x19: ffff000008ffe000 x18: ffffffffffffffff=20
[    0.000000] x17: 0000000000000009 x16: 0000000000000000=20
[    0.000000] x15: ffff000008e59648 x14: ffff000088fa616f=20
[    0.000000] x13: ffff000008fa617d x12: ffff000008e7e000=20
[    0.000000] x11: ffff000008e53900 x10: ffff000008e59eb0=20
[    0.000000] x9 : ffff000008e3e018 x8 : ffff00000875ac58=20
[    0.000000] x7 : 206f6e203a746e65 x6 : 000000000000018c=20
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000=20
[    0.000000] x3 : 0000000000000001 x2 : 4f419eae5e0eb800=20
[    0.000000] x1 : 0000000000000000 x0 : 00000000ffffffed=20
[    0.000000] Call trace:
[    0.000000]  its_init+0x36c/0x608
[    0.000000]  gic_init_bases+0x288/0x300
[    0.000000]  gic_acpi_init+0x124/0x248
[    0.000000]  acpi_match_madt+0x4c/0x88
[    0.000000]  acpi_table_parse_entries_array+0x134/0x220
[    0.000000]  acpi_table_parse_entries+0x70/0x98
[    0.000000]  acpi_table_parse_madt+0x40/0x50
[    0.000000]  __acpi_probe_device_table+0x88/0xe4
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0xcc/0x100
[    0.000000]  start_kernel+0x2fc/0x490
[    0.000000] ---[ end trace 41868d15bb5cf8f6 ]---

--Jan
