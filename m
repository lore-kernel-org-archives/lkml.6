Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524AE208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p/uhHREH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SbA7pq+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524AE208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeGaWAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:00:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbeGaWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533068315; x=1564604315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hxfxe9cHgBKq4EK6sDIacGgOuQdc7gT5yAlSbu8F7oo=;
  b=p/uhHREHG8cH/FIkUrm8poq/IyCGF/1uHV9kJqJ9KTMpqZtOklUrEsaq
   h9DMd9IN2NfUXj1PLgYxZF/NcA+/kqHcY6Hq3cTsDFXpjASQzxUO7KyGJ
   NTLSJsHN3kU7Z6upT5UKK63ocDBd5evGdssn87NBvCnMQePAPX19Ndu2s
   vFGPk2GbeUDL1NU3Ozv7cXbELEfDB52Ry56IPptIkI9uasZ3GroqVICkI
   8En2KXoMHqvLUwDHVrRjCUkJwwabU+UsrM7zBx6rlurcwTzynu011Ni01
   5Z7qTu96Er+c/JJLZPAXHltX+wTijqeO1kvtrsmBU22vIaRVcPDNpMxBB
   g==;
X-IronPort-AV: E=Sophos;i="5.51,428,1526313600"; 
   d="scan'208";a="189457647"
Received: from mail-co1nam03lp0017.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.17])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2018 04:18:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVt4hJXdWtHASq2XSxpzagz/cYlbr3JeAs3eJIXi9hk=;
 b=SbA7pq+6ephm0I218QlSz/QJArzMpCzZ6WlsXYhGS+znbyKyLPXgNgwtEh6Rgk27pEB9AIL1AY4V2hadxXBy57myYsiRWlZwuAgjJBrTgP/XE8hf7PEqEq9wdXLLglrvI9uRnGzAuM7HyYq+hR4ZuJn3bXkCLpa22IK1UJKY6sk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0657.namprd04.prod.outlook.com (10.172.166.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Tue, 31 Jul 2018 20:18:30 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%4]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 20:18:30 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "david.kershner@unisys.com" <david.kershner@unisys.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jgross@suse.com" <jgross@suse.com>,
        "cyrille.pitchen@free-electrons.com" 
        <cyrille.pitchen@free-electrons.com>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi passthrough
 request users
Thread-Topic: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi
 passthrough request users
Thread-Index: AQHUKQf8q9qBS8n6RUKN2MmwqU0cx6SpwGaAgAADIoCAAAGwAA==
Date:   Tue, 31 Jul 2018 20:18:30 +0000
Message-ID: <6c04fc087bae896bf00b94184def3d7697a22d6c.camel@wdc.com>
References: <20180731195155.46664-1-keescook@chromium.org>
         <20180731195155.46664-4-keescook@chromium.org>
         <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
         <20180731201225.GA1989@infradead.org>
In-Reply-To: <20180731201225.GA1989@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0657;20:OFHP15Rs17oTnp23PVJQu8/UAMvP5uN6ZggiK1luc2/hSEs/J0FlPD5krccVIoGmaXo5yp6tZw5YyhR7E0w8aRyHFPBbgxwIaDiuzYFnj8ItfBthhlTx6dfv3SPxkoSEsZ4z5nBAUtR38nkYuS+S/+khPbhGHp5kC6aoO4a6aQs=
x-ms-office365-filtering-correlation-id: 41677d09-7461-45a4-bf5f-08d5f722c892
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0657;
x-ms-traffictypediagnostic: MWHPR04MB0657:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0657F7DF268132A4E4458A33982E0@MWHPR04MB0657.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0657;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0657;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(68736007)(2501003)(36756003)(14454004)(6116002)(7736002)(3846002)(2906002)(6246003)(72206003)(5660300001)(106356001)(6486002)(6436002)(305945005)(11346002)(229853002)(6512007)(446003)(316002)(186003)(256004)(4326008)(5640700003)(5250100002)(2900100001)(105586002)(476003)(99286004)(478600001)(6506007)(93886005)(76176011)(486006)(2616005)(6916009)(7416002)(25786009)(86362001)(8676002)(8936002)(54906003)(81166006)(81156014)(26005)(102836004)(53936002)(66066001)(1730700003)(97736004)(2351001)(118296001)(26730200005)(19860200003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0657;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: znGkOU015ru1AmMFi+A/ZNhbeZeWakxX7qHAItvWm9EzMvcPWxZjOtgYkN+V4hCnQHciOcFZ6gYxqgEyvkFjYvJrDHQGpa8hViG5af+61zDEMgt6CBiIP9KsBoEESDHKrWKvtYVGPQsjlVP9nHOa4FZqT71JktlRJTGOCNhpVhAKstj8n1B2iIQX3V9Z+OPMSdYu4/28NNQUSm3xOIbD1elS8FzyU/wYam2uRGzUbl9SkEoqSwjgOp2UPXGnSO5g6jnXInJH+DZOSEFTPJuyZC8BNUHphfpXaFMOwRKJ8cXbEdSR9B1Z7fbxVVPD68WlLUy/P4HN6y4jqfXoFyZcFuxxYMVDAUXvUYqp4CbH24s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <0AF1FA13400D144B90C65F56A5693E36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41677d09-7461-45a4-bf5f-08d5f722c892
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 20:18:30.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 13:12 -0700, hch+AEA-infradead.org wrote:
+AD4- It shouldn't.  All these are built into scsi+AF8-mod.o, which is only=
 built
+AD4- when CONFIG+AF8-SCSI is set.  Under what circumstances do you see the=
m built?

Although I think you are right, I still prefer that the scsi+AF8-common.c f=
ile
would be moved to a new directory. That will prevent confusion later on for
people who want to add additional code. This patch makes it nontrivial to
figure out which code is built when SCSI target functionality is enabled bu=
t
SCSI initiator functionality is not selected. I think moving scsi+AF8-commo=
n.c
into a new directory would make it much easier to figure out which code is
built depending on the kernel configuration.

Bart.

