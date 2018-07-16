Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F95ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7049E20856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RKHobW1T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Nxl+lT9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7049E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeGPO2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:28:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42430 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeGPO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531749636; x=1563285636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sJdI7ZNPlcA5kcy7Cr4phmQbRtZSJbMH6yXbpF7AtRw=;
  b=RKHobW1Tgu8jt3M/HKHMe3tXTP8qfyAL19d1CWdqJtTuRGYzj8xJ8Pt9
   1hkrdq9lgslVG97XGb0e5eIY546hIBuHGt433LZXihns+3vzgfsHbfnft
   S35zkWR4ErH7gM+6tnloz/EmbK5x6E+BW1Etya9B+o1oh/J+TBMz409BG
   zL9OBJB+oYl2NonFCy//PxTXyNxc2z3faPrl5mWEq08tUHiFkT0Nt7EYr
   5voZKvoB/Iu3YRJBDneJyITWtSfuxxANTB1iAEa+9rkr2/3xxCuTEDYXD
   tIwPizNsduRHjZ/beCViHazydq03V7M7/XDt/yhfB7V8B0jMJTaZZLs1t
   A==;
X-IronPort-AV: E=Sophos;i="5.51,361,1526313600"; 
   d="scan'208";a="187643272"
Received: from mail-bn3nam04lp0118.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.118])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2018 22:00:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJdI7ZNPlcA5kcy7Cr4phmQbRtZSJbMH6yXbpF7AtRw=;
 b=Nxl+lT9g0alo3g1Kjz/HdtS0vmpJ+HpyYxK79RlQ8WKj2HguhtojLGehiEHIyJy6AN4BQ1onrIdXeKbgmQKdMrTEMVfu4mv3XKRFk0gSREAoxxWoGtFiFkY1UvV3J3TlWushAXZAbffFQ1JbG9rqnE2GnTLi8Gx5RWs9pqjzfBA=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0350.namprd04.prod.outlook.com (10.169.202.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 14:00:27 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Mon, 16 Jul 2018
 14:00:27 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
        "jack@suse.com" <jack@suse.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>
Subject: Re: [4.18.0-rc4][bisected a063057d][mpt3sas] WARNING: CPU: 87 PID:
 18868 at block/blk-core.c:781 blk_cleanup_queue+0x20c/0x220
Thread-Topic: [4.18.0-rc4][bisected a063057d][mpt3sas] WARNING: CPU: 87 PID:
 18868 at block/blk-core.c:781 blk_cleanup_queue+0x20c/0x220
Thread-Index: AQHUHOJzHDvzoLVAN0ew4J73cfwNVqSR4OwA
Date:   Mon, 16 Jul 2018 14:00:27 +0000
Message-ID: <453e3f042dfbb4c848cb434db888f9051c58686a.camel@wdc.com>
References: <1531731189.15016.15.camel@abdul.in.ibm.com>
In-Reply-To: <1531731189.15016.15.camel@abdul.in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0350;7:1BhxAqEtxWIdEpsgLEW2mMUcXHy9q2dMs3ivL6DILIf0o7edQXkCuqQOUu6+9KW8GaGPn1bamqSsJXk/jEALZDMFE3YaWy/si+O0tEkW6wogmbJVqnvYb6hA1MOZ6purslnljflVe2abil312pwyuXE3JukN6fKpaOZxWH/PGKeSQiTX4Xko7qbvpAhswQT73p8oH63l8Ayvnef3/USrQ1kUMgbf76y/X+g1lhLdIIC9c89OuyVfKBggth9zkhT9;20:z257f+p77mTREVMYhX4VIeHtmwIbwcAl3MXB/A2ZobqSpXfpNy4W2Z4+znCz4kJukZCcCldzcBapR3tfGISteHPCwrVGHTW0i/InK/ZCRkxd0pj99C9AfmYiExJWOdggLHLN/HMbeS+lCPegGxVbR1CRmzfJO1Mc3LRGL6mFp6U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 787a15ef-2515-4566-95c9-08d5eb247c46
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0350;
x-ms-traffictypediagnostic: MWHPR04MB0350:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB03501120D7A90ACAE11F6E83985D0@MWHPR04MB0350.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(278021516957215);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0350;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0350;
x-forefront-prvs: 073515755F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(476003)(97736004)(256004)(36756003)(68736007)(229853002)(446003)(105586002)(6306002)(6512007)(2906002)(25786009)(14444005)(14454004)(72206003)(478600001)(486006)(2616005)(106356001)(8936002)(99286004)(118296001)(81166006)(81156014)(11346002)(305945005)(8676002)(86362001)(7736002)(53936002)(6246003)(110136005)(5660300001)(316002)(3846002)(2501003)(6116002)(2900100001)(54906003)(5250100002)(4326008)(6486002)(186003)(26005)(102836004)(76176011)(66066001)(6436002)(6506007)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0350;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZugFeo0PmgcLUZYgi43Brfh33y2+29PX2OrKYqEjK1CwaqR1A3+bQRm9HR2WmBe5peLaoUxX077XFtZRZliS8aorgtNCU8hemdjbj3wJVGmWFZP9da27yGyPAIXbvscn5BJXPVW/fAYbknOQATQOSNU9bJALkJAOBl2elfh61Oub9D/TC/wXGjTJPO6XJfqsKLoSve7SQyJn4KNshE0ohTGyhFHULkhVvtsPfnEnav4JKUvDZmdUzf9io5oI/talnMmqoVJupHZnlwdhAvVtdEfIpm4eKg796lAAAqKfj/Yz4lN9MZ8JE40VamWbZxXGnWQWa/ZQeFzXJwtH/hoGmnCWV4fxmB5/vNxJi7Ue2wc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <3063EAC5A5FA7149A3E23C37E83455EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a15ef-2515-4566-95c9-08d5eb247c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2018 14:00:27.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 14:23 +-0530, Abdul Haleem wrote:
+AD4- mpt3sas module unload triggered a warning at block/blk-core.c:781 on =
a
+AD4- powerpc bare-metal running mainline kernel
+AD4-=20
+AD4- WARN+AF8-ON+AF8-ONCE() was introduced with commit a063057 : block: Fi=
x a race
+AD4- between request queue removal and the block cgroup controller

Please check whether the following patch series fixes this regression: +AFs=
-PATCH
v3 0/2+AF0- Ensure that a request queue is dissociated from the cgroup cont=
roller
(https://www.mail-archive.com/linux-block+AEA-vger.kernel.org/msg21897.html=
).

Thanks,

Bart.





