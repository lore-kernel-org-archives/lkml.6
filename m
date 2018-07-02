Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E129C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14112250A3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T6ugVuy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14112250A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeGBORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:17:23 -0400
Received: from mail-hk2apc01on0111.outbound.protection.outlook.com ([104.47.124.111]:53440
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751443AbeGBORV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHoO5zQgmEW2+m957lZvYVglqGO13ocqh2JO1BVl1Gw=;
 b=T6ugVuy+C/q2epECdP31j9dRpm63B9ck26R3pvhh/VQ3U1MA6cZO0OJa1be+VjcF4Nz2WBNEPL6yNGfyHAr6aFsc7Eypa/Z4EdUTDnDwdCcIB2oZhZ82EMXzON65cJn8V+iYNap2EdL2uFqCvv1jRbRyGyTASJfJIedABcI/2u0=
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM (10.170.172.151) by
 KU1P153MB0133.APCP153.PROD.OUTLOOK.COM (10.170.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 14:17:13 +0000
Received: from KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e]) by KU1P153MB0150.APCP153.PROD.OUTLOOK.COM
 ([fe80::3117:172e:121:d0e%5]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 14:17:13 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 0/4] KVM/x86/hyper-V: Introduce PV guest address space mapping
 flush support  
Thread-Topic: [PATCH 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support  
Thread-Index: AQHUEg9fC6qx6UW5u0mOloIreXNs2A==
Date:   Mon, 2 Jul 2018 14:17:13 +0000
Message-ID: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0133;7:Hy83VrnyLVMGhJB8waIPHMYMbbtuX28MyjTVQCcRTMvLiFuxNgxgYTF+BL8ftXurED+OEnb7+ObBN6berFvG/McBinQIAesAHSwLOqv8Qfm5ix/EaEaLbrQ9FPQGdqy6oMDCdo4nGag63e5B6Qt5unKm5S6JpXbsjRCLrzFcMsmg4WvFEiiQFwzAavhz8/IJhyoRlPkoMBvK01j+c5EGc291XOfNOL5mvY6fniGNs2NCltmp0COQN1Lu1yvf/hDD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a8fba746-65a8-4e2e-0d36-08d5e02681f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:KU1P153MB0133;
x-ms-traffictypediagnostic: KU1P153MB0133:
x-microsoft-antispam-prvs: <KU1P153MB01333EA40A5747694731715392430@KU1P153MB0133.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KU1P153MB0133;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0133;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(1671002)(54906003)(476003)(486006)(59246006)(107886003)(36756003)(26005)(102836004)(22452003)(2616005)(316002)(97736004)(2900100001)(14454004)(6486002)(109986005)(86362001)(86612001)(68736007)(6512007)(4326008)(25786009)(6436002)(10090500001)(53936002)(66066001)(5660300001)(105586002)(106356001)(7416002)(8936002)(2906002)(305945005)(7736002)(99286004)(256004)(72206003)(6506007)(10290500003)(3846002)(8676002)(1076002)(81166006)(81156014)(478600001)(5250100002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0133;H:KU1P153MB0150.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8qxTOeluL1+yH2uw4ZYC3nESOeNx6TVLyLrBfGkvO+8JdD2PfP8xF+fbL5LhB9Dakrli3YO/wDoA88b2h8IdYhaf0uBLyXrP48kNhvs5IsAhxxEnP9nscQQp1nFuCLmcjBeGYFGf8vfzLvFMNCYHOu1m9tToZodTjb8SYB9QJ4n0UNMLFgfhxbncf0xXfhNCAHoKuYGP9z00lP0zuXTFnKEzT91eihiZBaqcPB752xEBsoatB3dF3DbPEQbullM+uZzqS0XHVVDJIPOEPwhgmPwDMtrmTTrvrTtO2PTrwN8xg9txEBaVtBXUm5kN7S9eyMMfmbMySuTq2+ONujxDhkmLFFefb51FF7wFkt5dA88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fba746-65a8-4e2e-0d36-08d5e02681f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 14:17:13.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0133
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V provides a para-virtualization hypercall HvFlushGuestPhysicalAddres=
sSpace
to flush nested VM address space mapping in l1 hypervisor and it's to reduc=
e overhead
of flushing ept tlb among vcpus. The tradition way is to send IPIs to all a=
ffected
vcpus and executes INVEPT on each vcpus. It will trigger several vmexits fo=
r IPI and
INVEPT emulation. The pv hypercall can help to flush specified ept table on=
 all vcpus
via one single hypercall.

Lan Tianyu (4):
  X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
    support
  KVM: Add tlb remote flush callback in kvm_x86_ops.
  KVM/VMX: Add identical ept table pointer check
  KVM/x86: Add tlb_remote_flush callback support for vmcs

 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/nested.c           | 64 ++++++++++++++++++++++++++++++++++=
++++
 arch/x86/include/asm/hyperv-tlfs.h |  8 +++++
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/include/asm/mshyperv.h    |  2 ++
 arch/x86/kvm/vmx.c                 | 56 +++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c                | 12 ++++++-
 7 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/hyperv/nested.c
--=20
2.14.3
