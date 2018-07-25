Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32BAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB5320833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="o4BslouZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KLA00tM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB5320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeGYTZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:25:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45766 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbeGYTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532542923; x=1564078923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K8MbWoLWqIDG6vwJHvXcFxNWI83uHWt88nSOabb8vQU=;
  b=o4BslouZNmVBx96fN0xdBDBMyks4afGCVymaiXcGVnKinYChuQLMfITF
   ErgahSQnPj/JOn9ssCn62xjs+YGCSaYaGl84vs0zr7GhUWCHtgvjFHd5T
   37oZ7tWBzV3jZTclXt0LYQrlX3wAujchELsOYz6OMJSjiRmWbHl0VHzwu
   bcEi8Gr9HQgw1iPJ7eqKqtLKqVUe05dok8urI5rpXE9ayoMn3SJg1dyVl
   itLM9zBHFinWhzjbGmurI0EGVIHpUkFkhDJH5Tf+pz5vonxXHSpAuYFrr
   PCwRDwX6Zm557a+FBoOIHuTQlc/CwonkZZ2AIkfEMnvjc0S83Wh9JuvK0
   w==;
X-IronPort-AV: E=Sophos;i="5.51,401,1526313600"; 
   d="scan'208";a="182126521"
Received: from mail-bl2nam02lp0080.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.80])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2018 02:22:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFJxO/BQ4d9uWZERaRt9R+9TkFXX4TmyD/GFRMUm/hE=;
 b=KLA00tM5M4tzNJM4qJjlsqK+ce9+1qPENpr2VGkVgGXbL0rveyGjrDx3TCZzwjvVzr4Y9L6xEPdb0cksW/O1lUpzqvip5FTcy4Ed5lRRJXDFM0NSt78KFklm4JKnvdek6ef9Knxb6Rn6beUWALXT2e7hoc+jN5V0X2JOtLaCpyk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0944.namprd04.prod.outlook.com (10.174.174.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Wed, 25 Jul 2018 18:13:02 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%3]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 18:13:02 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ps@pks.im" <ps@pks.im>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Topic: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Index: AQHUGq56yXYBAcJcykKCTi0snJ4SPaSgUOAA
Date:   Wed, 25 Jul 2018 18:13:02 +0000
Message-ID: <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
In-Reply-To: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0944;7:svgipxt4+eN1hUGDHBRYKTJbFEF9sffxERoLau18t+APNMoPCtRVmIj3ehpP3puHls2soZ+9S31qk0Xg/bjf3XSNa/otNrMKfcIugyos8kDQhdNq869uw9/qsi6ny/4Syk+D8dHr8TVfAiMehLB1Klcb/27xT3agfn+b+r28ZoHpV/39ee17lVoUfQRf+8MiKy5Q1QpTJehAZ1EIuk8ubDZXrSIkQ9t1ICmfN8vyYLIHzpXMUo+un7bIeNgJB3GQ;20:jgm8kQsvDmMP3pMtYYhKNXrKZLU0Kdgh5VNNCEPBvOjji+GX4VzlmQDUdA+HuBr4Zx5In9SUVOAY8K+GxFVu41PanyhiXfQ8oCvfaxXRRK2RWJvO5X58WZuv3JK8DzlDdl6YuhSTjqWl2ic6lzzWZuxavLYq86AF29s1EE+iSQE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cacea4e1-ac55-4fa2-6248-08d5f25a42bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0944;
x-ms-traffictypediagnostic: MWHPR04MB0944:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0944672EE600455ABC98A74398540@MWHPR04MB0944.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0944;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0944;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(51234002)(199004)(6512007)(81156014)(8676002)(81166006)(2906002)(14454004)(72206003)(4326008)(76176011)(54906003)(229853002)(5250100002)(14444005)(6246003)(2900100001)(66066001)(86362001)(486006)(53936002)(68736007)(316002)(110136005)(2616005)(7736002)(186003)(26005)(6506007)(105586002)(118296001)(97736004)(11346002)(6486002)(25786009)(478600001)(8936002)(6116002)(2501003)(99286004)(6436002)(102836004)(476003)(106356001)(3846002)(305945005)(256004)(36756003)(5660300001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0944;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QN/iCR6TOdl0Gg/GKeQf1IID0TdKy0SmQBoywFjrobdUzG7ZMNzsUcBSNrBXYUimW0YiV/Z7vV9NVKqMFhtAqkHkBUy5P/VVyg/EzlEU3rZ6ejobeNMASdyhZVOBL69dhNNbp58Wb4pc/lh9STZRpeYRLdY6640gB/tJTWL8kIs0Fjfxtg+L+EWG5mnHbhzno0EHazz4oUYcza6hOWwLSL5hYBPr1slvJ0lIfOpNe6riSiQfyG56NcMSsxHcW0irkZ7X2HXmRud7jHAKfM9WOKtTe72kbG1BRFlGTNnwXJo7SQIT+rfvjvPM9fCWf1nVOIpv+lZx8YcrS/RunrPCy8qqnIeaNwD+rkSSxNr9CZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <EE6549A875588F4488F95DD0808F11EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacea4e1-ac55-4fa2-6248-08d5f25a42bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 18:13:02.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 15:29 +-0200, Patrick Steinhardt wrote:
+AD4- When power management for SCSI is enabled and if a device uses blk-mq=
,
+AD4- it is possible to trigger a +AGA-NULL+AGA- pointer exception when res=
uming that
+AD4- device. The NPE is triggered when trying to dereference the +AGA-requ=
est+AF8-fn+AGA-
+AD4- function pointer of the device's +AGA-request+AF8-queue+AGA-:
+AD4-=20
+AD4-     +AF8AXw-blk+AF8-run+AF8-queue+AF8-uncond:470
+AD4-     +AF8AXw-blk+AF8-run+AF8-queue:490
+AD4-     blk+AF8-post+AF8-runtime+AF8-resume:3889
+AD4-     sdev+AF8-runtime+AF8-resume:263
+AD4-     scsi+AF8-runtime+AF8-resume:275
+AD4-=20
+AD4- When the SCSI device is being allocated by +AGA-scsi+AF8-alloc+AF8-sd=
ev+AGA-, the
+AD4- device's request queue will either be initialized via
+AD4- +AGA-scsi+AF8-mq+AF8-alloc+AF8-queue+AGA- or +AGA-scsi+AF8-old+AF8-al=
loc+AF8-queue+AGA-. But the +AGA-request+AF8-fn+AGA-
+AD4- member of the request queue is in fact only being set in
+AD4- +AGA-scsi+AF8-old+AF8-alloc+AF8-queue+AGA-, which will then later cau=
se the mentioned NPE.
+AD4-=20
+AD4- Fix the issue by checking whether the +AGA-request+AF8-fn+AGA- is set=
 in
+AD4- +AGAAXwBf-blk+AF8-run+AF8-queue+AF8-uncond+AGA-. In case it is unset,=
 we'll silently return and
+AD4- not try to invoke the callback, thus fixing the NPE.

Which kernel version are you using? Can you check whether the following two
commits are in your kernel tree?

+ACo- 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference in runtime PM+A=
CIAOw- December
  2015).
+ACo- 765e40b675a9 (+ACI-block: disable runtime-pm for blk-mq+ACIAOw- July =
2017).

Thanks,

Bart.
