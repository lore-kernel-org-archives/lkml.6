Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529420865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="GWW/nEnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A529420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392614AbeKVSPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:15:48 -0500
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:19582
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeKVSPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R48H6EmWn4gdeeJYzVR1DdFjt+T5ZFg6nnw7dNJhwVo=;
 b=GWW/nEnCfGAkmvkbNNKpgCueJzJH10N2aOEYXXWxmLFY/lHmZLjh6APteMfrvIOMiA3tm1HN7zmIL1y5vMpnLCVdjRZvQh4bDlMLJcMzlLKXtVjG6JhcOHAhV3EXgFvU/4i2MSGMp02bBY7Lf/k5V9x8qyLW+AcIuyLDboWPmgQ=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5293.namprd07.prod.outlook.com (52.135.105.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Thu, 22 Nov 2018 07:37:32 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.048; Thu, 22 Nov 2018
 07:37:32 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     John Garry <john.garry@huawei.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: WARN_ON after gic_reserve_range
Thread-Topic: WARN_ON after gic_reserve_range
Thread-Index: AQHUgO1U84iLvQ34EEO/s7o5keutZaVY636AgAACG4CAAnz4gA==
Date:   Thu, 22 Nov 2018 07:37:32 +0000
Message-ID: <20181122073725.GB5509@rric.localdomain>
References: <20181120162305.GA2088@hc>
 <2665ddbd-5912-12b9-f5bd-6ccaec0e6e2d@huawei.com>
 <61079d3d-6bb6-cd00-fbfa-d13c19706e0f@arm.com>
In-Reply-To: <61079d3d-6bb6-cd00-fbfa-d13c19706e0f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::24) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.179.144.92]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5293;6:talNpoG3jZbQAFOIWYHVtGeB46b4nQ2pXs2U3fyTYYltywIP1T6lB/3TE80sl8vcOGj266XdJQ4Ko5jdlEdgDPrpaNaf6B7HWteoYfaiROrQLwR3/RhG0d9800QAroIhs0R2xFfrJAgF+huQ729sEveM9jQA/sU612Td3ot/DE0XAgHYCoELgjcQCfCIfpNPSU2jsl5ayGJpuzYVeBLn/WpGpZxgtUmnEzgUQh3uIZ7rm6ZuWw5NbBZwVB4j5n1rRifDhixjPmZ2zgu8kqF4KgrCPADs0jmLphq4ZyXqGxao57uXpzrSa+vo7qZt9/3chwe/89Zxpw5AK9kdiKvsx2ALvLOeuoECGenkGa7R26fjs6o6qRjRyLPXsbPv3Ft5EKOZeZ/lceUO3j/42tV1qhq5ThwpOKAmgfkaP/gX7MXGhTBuL7Nb1sscvy1YuaXdvkXoTrf3SBko5UpC82Q/HA==;5:D5lwT1NN090toZ+R+XL0YAl93jlY05NVTAE5MLRFWEKt03zjIyKFdCVtr/XYP1dGq8xYO0jGG9LfDAJqxbR1XkdtKueTpF0w738O8gYO7q2IDIIuQdQU6ZPIt4UIVTf0fsrly+5gZkELifpWHD1xWh5Z6JjjvDg0AsxBRF2uPXc=;7:DMf0vjG+8ulem08kUMYezbsRkh5GYiUqnnGkn6/iRAco9+siSNiNaWk53NIJ1No1zpyrGKeTxMPIOqi53YjyHlTCcz1kR9p3N2jX0KWaZIf0MtKvBniLghCAUTGrpl3rYRXMYBaQgyT4ErCQFS+lEA==
x-ms-office365-filtering-correlation-id: 8d5a9473-2ab3-42b8-9e0f-08d6504d5cd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5293;
x-ms-traffictypediagnostic: SN6PR07MB5293:
x-microsoft-antispam-prvs: <SN6PR07MB52938C62F5D9D0E0CD509D6DF1DB0@SN6PR07MB5293.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5293;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5293;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(189003)(186003)(86362001)(8936002)(106356001)(97736004)(81166006)(81156014)(8676002)(105586002)(14454004)(33656002)(14444005)(256004)(66066001)(446003)(6116002)(7116003)(72206003)(25786009)(478600001)(45080400002)(316002)(54906003)(53936002)(6512007)(9686003)(68736007)(6246003)(52116002)(99286004)(2906002)(3846002)(1076002)(7736002)(305945005)(5660300001)(2900100001)(486006)(229853002)(71200400001)(71190400001)(6916009)(6436002)(476003)(11346002)(6506007)(6486002)(26005)(4326008)(33896004)(53546011)(386003)(76176011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5293;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qWah8jQDsFBE5PcPaOwpqk0D2/0liZwvnq09KeRn2706LoAkdAOVmcNkqaNI46eo37cZSA+WPx01Lf5rR9kWOsUZsJi+QriZj5XGjF7KHKukR8NreCGgPg1jpJOU+vWHjDtsqc+MrBK+l1Ggr8W+IxJGwl02Qx7P8c0egvjztvHrjYdpC9nToLTH5D8Zjaf6pox8Hva2XPGRKWDHHx2rgcuSSOM1PaNyJuzG1hcrz+Po3glqf1FsmjIGa1K4/4SIbU4zkoVNPmFBxxsbe4FLUwQfXtduM/ZJMqe8etEZAjhgLgHGgBuEWU6T/aN2oBA0rPt7VyZSv55e8+enyBdUdiYMnfiPPS/kOiCJC5w/SLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <341D5C9DFE64714FB99E51CC03F2E4A0@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5a9473-2ab3-42b8-9e0f-08d6504d5cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 07:37:32.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.18 17:37:37, Marc Zyngier wrote:
> On 20/11/2018 17:30, John Garry wrote:
> > I see it also:
> >
> > [    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
> > [    0.000000] Linux version 4.20.0-rc3
> > (johnpgarry@johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425
> > [linaro-7.3-2018.05-rc1 revision
> > 38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1))
> > #971 SMP PREEMPT Tue Nov 20 17:15:03 GMT 2018
> > [    0.000000] efi: Getting EFI parameters from FDT:
> > [    0.000000] efi: EFI v2.60 by EDK II
> > [    0.000000] efi:  SMBIOS=3D0x3f050000  SMBIOS 3.0=3D0x39b00000
> > ACPI=3D0x39bd0000  ACPI 2.0=3D
> >
> > ...
> >
> >
> > [    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs
> > @1fb9d80000 (flat, esz 8, psz 4K, shr 1)
> > [    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt
> > Collections @1fbb977000 (flat, esz 8, psz 4K, shr 1)
> > [    0.000000] WARNING: CPU: 0 PID: 0 at
> > drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x360/0x5f4
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3 #97=
1
> > [    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
> > [    0.000000] pc : its_init+0x360/0x5f4
> > [    0.000000] lr : its_init+0x35c/0x5f4
> > [    0.000000] sp : ffff000009183ca0
> > [    0.000000] x29: ffff000009183ca0 x28: ffff7dfffe67b3e4
> > [    0.000000] x27: 0000000000000001 x26: ffff801fbb928000
> > [    0.000000] x25: ffff000009325360 x24: ffff00000918c8c8
> > [    0.000000] x23: ffff801fbb802100 x22: ffff00000918c8c8
> > [    0.000000] x21: ffff000009189000 x20: ffff0000091b8000
> > [    0.000000] x19: ffff000009325000 x18: ffffffffffffffff
> > [    0.000000] x17: 0000000001f4d3b5 x16: 0000000000000000
> > [    0.000000] x15: ffff0000091896c8 x14: ffff801fbb97389b
> > [    0.000000] x13: ffff801fbb97389a x12: 2074707572726574
> > [    0.000000] x11: ffff000009183a00 x10: ffff000009183a00
> > [    0.000000] x9 : ffff7e007eeed400 x8 : ffff801fbbb60000
> > [    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : 0000801ff2d1c000
> > [    0.000000] x5 : ffff7e0000000000 x4 : ffff00000918c8c8
> > [    0.000000] x3 : ffff801fbbb50000 x2 : 0000000000000000
> > [    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed
> > [    0.000000] Call trace:
> > [    0.000000]  its_init+0x360/0x5f4
> > [    0.000000]  gic_init_bases+0x2d4/0x2f4
> > [    0.000000]  gic_acpi_init+0x154/0x278
> > [    0.000000]  acpi_match_madt+0x44/0x78
> > [    0.000000]  acpi_table_parse_entries_array+0x13c/0x214
> > [    0.000000]  acpi_table_parse_entries+0x40/0x60
> > [    0.000000]  acpi_table_parse_madt+0x24/0x2c
> > [    0.000000]  __acpi_probe_device_table+0x80/0xdc
> > [    0.000000]  irqchip_init+0x30/0x38
> > [    0.000000]  init_IRQ+0xfc/0x130
> > [    0.000000]  start_kernel+0x288/0x418
> > [    0.000000] ---[ end trace c841ef100bdd09a6 ]---
>=20
> Yes, anyone with GICv3 and EFI will see this.

My late its_init implementation might fix this, though it does not fix
4.20.

-Robert
