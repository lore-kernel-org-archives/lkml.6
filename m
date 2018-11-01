Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB21C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF9E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ke5kA9Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeKBCep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:34:45 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:6426
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeKBCep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt58J2v4pW4uBGK+6l/4GTZb8/pbgqr815eYG7EsxCk=;
 b=Ke5kA9CmEw/Ktz/FoQ5TLMCqnxKkvhh80aDqywiXIgm5FKovgFn9pf6v57EVPrBkNhKylfYz2cLl1Sv2TgRRN9nLMeTnSevCJlfgOeECSBUUxlbEsg5O7xKBRo8xbTSz7wB2drkT/R5ELDzsLkbSNpKT4n8bo7Wn1TYqmzH75HQ=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0174.namprd21.prod.outlook.com (10.173.52.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.25; Thu, 1 Nov 2018 17:30:47 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1294.009; Thu, 1 Nov 2018
 17:30:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Topic: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Index: AQHUcgifYe6LR7d4Q0+wCx1mDqTimw==
Date:   Thu, 1 Nov 2018 17:30:46 +0000
Message-ID: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:300:12b::12) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.159.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0174;6:mA7RAm/9LorcZaHhslbVX3adiomdKFw7Okh86X7D3PKV3Nd9t2cH/YrtRoCrlVDFKnlwuLou7cjUi2LhfAGEt9AU2YrUS1mtRh504NINIYrNrV82tyeeGr87i6HIqG8imQ2GGSabEmfos33TiwSwtHmtjB2B09GbGK1ZwzyLe3EaSsfF3arLH5nvacXK0fWL/ceseAe/7bN+P8dFe83HQZ2y89urdd22fw4LMXCQtoVGFeXAsXGSVix7FZum119weDFI6IiAq8JHmIXUPCbeZoYZ18Twm4JE5iKkGpiBL9+bqiJdfBjtyYXvwyGK71beZn5TSqIqMLFPCUgBdQdAHeMUDHPa5dVQvjJkaMYgplB3e4c6npGMOWKcH5LmhweRKHjYps0h4ynODFlq5Y87zkb6gRLDUAxNhiE3fS7LyNPzbiheSo+48QbNR7BrCTr2eQ8qn8DzNCyYUi68oQ4UVw==;5:ZDr+9lLC3hSfFuoM2FGbFOB1aS4qlWWabsfjBI9OqWts6AYFzsm20P2ub9gMmEKG8obuo84WiX+ypbj8C8M9kxi+UMFsTgpmB7vWQCMJR/9rHHWUAVoo/royiYCJVHx3Ct351hH26kPK4Lcz4tLYFSJp7iTSzLe07z52wL70ibA=;7:SUn2tgYHBA0HrjGoaTHAqO7pWfssuVundeSBsC0q9DmMulrwEkCQFTjF9ocoLFbn443Gk1Ah8LA6Yk5FaPEdgNDlDwsLUlML6wOZMiAyhTgBrYyImLIkmxuGnl46NcLfM43BNYzv5za+2Jt4GFuBNw==
x-ms-office365-filtering-correlation-id: 92125705-5458-4acd-f3dd-08d6401fc242
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0174;
x-ms-traffictypediagnostic: MWHPR21MB0174:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0174379410C92EB830DA8212D7CE0@MWHPR21MB0174.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0174;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0174;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(476003)(8676002)(6636002)(5250100002)(486006)(6436002)(22452003)(53936002)(6512007)(316002)(25786009)(186003)(14454004)(26005)(68736007)(4326008)(2616005)(6486002)(256004)(71200400001)(81166006)(81156014)(10090500001)(8936002)(2501003)(107886003)(36756003)(10290500003)(110136005)(478600001)(71190400001)(2900100001)(86612001)(2201001)(6116002)(106356001)(3846002)(52116002)(99286004)(97736004)(5660300001)(86362001)(66066001)(386003)(6506007)(102836004)(2906002)(1511001)(7416002)(7736002)(105586002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0174;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WFj1wKo0/RRsxgiYyZJOAUQNZAApu+5nU4wVyLFqOMGyBWaS9DyT40rQHYCi1wZ60YPRQebu+vvKKZvPNyTJhfrf8YKVncENKyaV9rokRvJEzm9l8jYIeDgleMG+IYc8sYCRyei8srtQsx9l6KDItKvxdh3m8+Z6RknLIXnNsBmPbKoOsuwWlyh3inCek8W3bzCWaMhy4QTo5Gaz8IdH2EG5NDUY/u/TPOcRWc6dtPE0b7hgcnv/4mfk91t2NEBlzgYtazs0mfkIdeFk1hQ4J3AltaETDsQhEAtAZkiw/2v2RRtzTAx6Y/BAAPpUgy2nSKfV36+zb3wK5QstMd9sG31K1eV1jvYFzCeHwsb+FKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92125705-5458-4acd-f3dd-08d6401fc242
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 17:30:46.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pit_shutdown() doesn't work on Hyper-V because of a quirk in the
PIT emulation. This problem exists in all versions of Hyper-V and
had not been noticed previously. When the counter register is set
to zero, the emulated PIT continues to interrupt @18.2 HZ.

So add a test for running on Hyper-V, and use that test to skip
setting the counter register when running on Hyper-V.

This patch replaces a previously proposed patch with a different
approach. This new approach follows comments from Thomas Gleixner.

Michael Kelley (2):
  include/linux/hypervisor.h: Add test for running on Hyper-V
  i8253: Fix PIT shutdown quirk on Hyper-V

 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/hypervisor.h  | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

--=20
1.8.3.1

