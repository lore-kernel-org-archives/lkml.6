Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26551C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38382081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AKDSqlrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38382081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeKDNCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:02:19 -0500
Received: from mail-dm3nam03on0115.outbound.protection.outlook.com ([104.47.41.115]:25528
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728653AbeKDNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i09BVb2hZSl+ReGYr3LTvRtGRnszgLdY6LAHFW20pk8=;
 b=AKDSqlrOpM768Uu6sjT1GG+WTb69lBr4tbpKLOIRa13X4kUmIxiDhnjz7dQgC/lQI5QrWyo1R+nvm/KgQrISt0YgpzGQXG5jzlwj92Ni9IGLWr0sUR4J6Dn2dWegYCkC4ETtiJPDu/O4WQIBrlrX35j2o70fPNHAkBHaiV0uTy4=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0864.namprd21.prod.outlook.com (10.173.51.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.3; Sun, 4 Nov 2018 03:48:51 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sun, 4 Nov 2018
 03:48:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Topic: [PATCH v2 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Index: AQHUc/FMFzp1UloJrUSoATd3OzmphQ==
Date:   Sun, 4 Nov 2018 03:48:50 +0000
Message-ID: <1541303219-11142-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.159.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0864;6:APwEdYbfrb3JVtIEftdJv3BH+uEGTEvKnNGXSfMz6APayhLf8FXcu7bbN+YCzS5ikzR0PlNtH9rONbBetxW413mXnFNclrcciImSxh7Xq/2EOHrn2hCRJ5hdCB6x69+RTsUkM1BKeC93lpuOSlPWjJkkgU9k5qLFfcJpSYV21kRvG8MDhFAxXcpnDpazkWs2J2XFzxsyGe31I7lJnNR8Ql/jadjATAMg/SaRSAN9zctsWy5PrPeZg21smwjICN8WSKhNhImj5MN03mqsNzEUZSagzvCZigmVgXLPh496ZFgTd5Fzl1ZTkTJz5cg7fnlGHUAnrGIyCYqpq93CqN9xDGCmBsLT35uys4iY44EmefsAxR1Jnt483BuLZO1BfUT/hYXWytX5m3UCb8/syKM5rKdUsTKLnMDxM+LINGcr5ZiVy9MfRiyxm+RIMNrNCmAs6JR/OAiKztfHTxJEgyGlQQ==;5:gSSeZMy2Dn/1UDh9bqxxkBsYp9Hq5Oc0jOPp8aOc9JN1joIlJ0Dv2mcUTa9uTzxh5+G0mwmsbGOYVF905RNIpD4GDvLlTA06H19nBwkZ9attZYaBz4WNkSiYzzUvOy83bly29muoDfTQpuB1GZsOT9/9NvdMIXLKNlL22nYnGyc=;7:mywKYQ0JcVILd3qwkrRQjX6LIgfV/PtfIjLF+o82Ikwk28IZpeBh9ue+iuF+ET+8zikRzO7yBINVDOzQN2vwsmO47hVgEDU3c3tGCXbi1KlTzM9YRYyqO9NQjPCuEgqSU/Rca7w9BVpP+qTCwGvPEQ==
x-ms-office365-filtering-correlation-id: a963c1bd-529d-4d7b-9739-08d642086ed7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0864;
x-ms-traffictypediagnostic: MWHPR21MB0864:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB086438AB3E48EF546026DC49D7C90@MWHPR21MB0864.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0864;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0864;
x-forefront-prvs: 084674B2CF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(6512007)(107886003)(66066001)(4326008)(53936002)(86612001)(25786009)(2906002)(5660300001)(7416002)(14444005)(1511001)(14454004)(6116002)(7736002)(110136005)(36756003)(305945005)(3846002)(105586002)(2501003)(106356001)(71190400001)(71200400001)(2900100001)(102836004)(486006)(476003)(2616005)(6506007)(26005)(22452003)(10090500001)(386003)(81166006)(81156014)(8676002)(8936002)(99286004)(256004)(6486002)(478600001)(86362001)(6436002)(97736004)(10290500003)(316002)(6636002)(52116002)(68736007)(186003)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0864;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oFVd8iEF58SZ0r1MsPURaBOI5k37DixwJNhkEolW4OX/fzsERh9fOsC/6etzM/Zub4dPkrbB3atHzu6a/OWCsBFgfGBIzfxMUpdrYYsw3XykMiSqULG3iR371XO2llDPJwziYZ90mavxrTs+6Eg5gdO4Yl0FIle9jsW3jEHZdGdWxGm1R5U6BfUiG28dyMIrY1P4+0YPHMh0q36EmTgkg7vFgqqa9qdAcySXcj4Ig3N1HlrL6goNUeHpEwU5vviYhQ3QrTzkGVY3Qh7uMWn9vlawvYENGBbeq2aILkD82l9AjduBYVzWrFVZCoFqkrH88rxIGe+d9APFKl5lFqfYUHpoyWt3nqZ6kOamndbPoWE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a963c1bd-529d-4d7b-9739-08d642086ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2018 03:48:50.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pit_shutdown() doesn't work on Hyper-V because of a quirk in the
PIT emulation. This problem exists in all versions of Hyper-V and
had not been noticed previously. When the counter register is set
to zero, the emulated PIT continues to interrupt @18.2 HZ.

Account for this quirk by adding a global variable in the i8253
code that controls whether the counter register is zero'ed. Then
in Hyper-V initialization code, override the default setting so
the counter register is not zero'ed.

Changes in v2:
* Instead of a function call to check if running on Hyper-V,
use a global variable to control whether the counter register
is zero'ed. [Juergen Gross & Thomas Gleixner]

Michael Kelley (2):
  i8253: Add support for PIT shutdown quirk
  x86/hyper-v: Enable PIT shutdown quirk

 arch/x86/kernel/cpu/mshyperv.c | 11 +++++++++++
 drivers/clocksource/i8253.c    | 14 ++++++++++++--
 include/linux/i8253.h          |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--=20
1.8.3.1

