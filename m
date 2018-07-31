Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF54C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712B620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="URzU77u6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eKM3b9CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712B620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeGaVnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:43:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48156 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbeGaVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533067287; x=1564603287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b1Dwz7p4yG2v77t0rEONpBrKOwkCmHDuBfhTb820LfU=;
  b=URzU77u6/gmhGKnTOQHg6VbWZCssv6/WBmRCF0S3q+Kh7NHDquKtjdNP
   4JkcVCW0iUEG78um4m46G/Yjg9TTPSORA8mLlVFC46uzFI4tOtDiErkUw
   G6s4J2NXQSfwlX5QTcxv0TK634+T4uXoCW5CF6AfkUV4bz1sTvE4eM6Zw
   RETvP6VUq0pYl8ZdKXL+C7NwjEGLceD/OZqEjQRifJHfPZ4qYEmAEBfTO
   vaiIwE41vpuDOBW9tBy0hXv6uqtMh0PnqOb69d7Nb3SdFiSdxnhNHMSUA
   yP9Jw3xVOQ17nIAsdz8zgzaSPfUkVPPWak8gPb1gngv432wb2Hl9nDvOI
   g==;
X-IronPort-AV: E=Sophos;i="5.51,428,1526313600"; 
   d="scan'208";a="87124428"
Received: from mail-by2nam05lp0245.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([216.32.181.245])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2018 04:01:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3DGUitK5tnWF0ecbC5sA7FBVmTmvbi2Um9G6a03nnI=;
 b=eKM3b9CKJmQHKN+jQ3Zfjv/WNAsK3P8pbDFLJ+nwJdSErRzLjedF86Qu5S6k7Q7TWXCZsOHFnDOYp6tYCmRiVoKdINnrbHPJU5Y3kHnXA62mAjmV9baqk1kQTaMoNhx/Q6WaKzf1P1owALKeNbLCVru4BFnivcnNI9Xo++PKUAs=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0367.namprd04.prod.outlook.com (10.173.48.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 20:01:17 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%4]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 20:01:17 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "david.kershner@unisys.com" <david.kershner@unisys.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "cyrille.pitchen@free-electrons.com" 
        <cyrille.pitchen@free-electrons.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi passthrough
 request users
Thread-Topic: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi
 passthrough request users
Thread-Index: AQHUKQf8q9qBS8n6RUKN2MmwqU0cx6SpwGaA
Date:   Tue, 31 Jul 2018 20:01:16 +0000
Message-ID: <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
References: <20180731195155.46664-1-keescook@chromium.org>
         <20180731195155.46664-4-keescook@chromium.org>
In-Reply-To: <20180731195155.46664-4-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0367;20:PiEnxrgbmCWl2ana1Z8RRDfwy6qt/BorsJxdAvSn1q4CrW0mpOQdKDXMi2+AmA+mcFLd7sl0WrAEDfBl/nsE7W6X4g+o0bE00oIdHOvb+P1JlDYZcAsNCM9WPWGWYchDtanWx0EK+kJf35O+sL/OqZzf5Wx6Vrr7CTbj5vVYAPg=
x-ms-office365-filtering-correlation-id: e8c425a4-7788-4c3b-d87a-08d5f720605a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0367;
x-ms-traffictypediagnostic: MWHPR04MB0367:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0367C07FE78A4CF5AF4A9A88982E0@MWHPR04MB0367.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0367;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0367;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(189003)(199004)(7416002)(105586002)(5660300001)(97736004)(4326008)(2906002)(66066001)(8676002)(25786009)(6246003)(316002)(6436002)(53936002)(6512007)(229853002)(6116002)(2501003)(6486002)(2616005)(5250100002)(26005)(76176011)(256004)(68736007)(99286004)(102836004)(11346002)(446003)(81156014)(36756003)(6506007)(8936002)(81166006)(110136005)(186003)(118296001)(476003)(3846002)(72206003)(54906003)(86362001)(486006)(7736002)(106356001)(305945005)(14454004)(2900100001)(478600001)(26730200005)(19860200003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0367;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZDUDwxAV/7GWJouzsOhkAKrORfWrtaqCBZpqxrFpGfLfZRV2yjv47AXnmVuA709pxLY2QH0GJitLvf857z5YvkU49N8vsdaR8iekr9yifyGi4W3Mxu3bwYFODlQtYtQYNzNmlxdkzxOWNAmzTMYxL5RagrOQGdorKynh0YXHuqjKZESqrThiWdzMLGScwYTYDxld4WqaN/9MkJjtZxu0w2oGW8EKsUBjGxvQYw2dKG/EFoT7e/nrFGI5cuSz9eXCCtAP2D1m+mL0RFcd7RpVPTXqAq6CdtS6EbHZhIPqAx6LouHJ/c7W7Pbe+7vVluf/xuLAuT66hlL7FyJJ6ZeMMcwZrRf+X6YURS46/zos3vQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <8F9E7D0EF0A4754382FB1A62F847D9D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c425a4-7788-4c3b-d87a-08d5f720605a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 20:01:16.6840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 12:51 -0700, Kees Cook wrote:
+AD4- diff --git a/drivers/Makefile b/drivers/Makefile
+AD4- index 24cd47014657..a6abd7a856c6 100644
+AD4- --- a/drivers/Makefile
+AD4- +-+-+- b/drivers/Makefile
+AD4- +AEAAQA- -76,7 +-76,7 +AEAAQA- obj-+ACQ-(CONFIG+AF8-DMA+AF8-SHARED+AF=
8-BUFFER) +-+AD0- dma-buf/
+AD4-  obj-+ACQ-(CONFIG+AF8-NUBUS)		+-+AD0- nubus/
+AD4-  obj-y				+-+AD0- macintosh/
+AD4-  obj-+ACQ-(CONFIG+AF8-IDE)		+-+AD0- ide/
+AD4- -obj-+ACQ-(CONFIG+AF8-SCSI)		+-+AD0- scsi/
+AD4- +-obj-y				+-+AD0- scsi/
+AD4-  obj-y				+-+AD0- nvme/
+AD4-  obj-+ACQ-(CONFIG+AF8-ATA)		+-+AD0- ata/
+AD4-  obj-+ACQ-(CONFIG+AF8-TARGET+AF8-CORE)	+-+AD0- target/

The above change not only selects scsi+AF8-common.o but also the following =
object
files: scsi.o hosts.o scsi+AF8-ioctl.o scsicam.o scsi+AF8-error.o scsi+AF8-=
lib.o scsi+AF8-scan.o
scsi+AF8-sysfs.o scsi+AF8-devinfo.o scsi+AF8-trace.o scsi+AF8-logging.o. Th=
at is a change that
has not been mentioned in the patch description. That makes me wonder wheth=
er
this is an intended change? Wouldn't a cleaner solution have been to move
scsi+AF8-common.c into a new directory?

Bart.

