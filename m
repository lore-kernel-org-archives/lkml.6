Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C00C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DA821A64
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RToUIsgc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VmwtTG2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DA821A64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbeHGBS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:18:57 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64701 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbeHGBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533596857; x=1565132857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rkik8SdZO4vpiJ4aIlI6bE2VXCBGk+iBLgjPTfAx1i0=;
  b=RToUIsgccNkzoR3xz/uHo4u9qkGiv1mUDDceeRbcHiuWbUUksawXdG7Y
   NqTNucMuU2/29tvRW5JqZzMW4aFKZcKqOLu+twfHAlaINEPhWIqYPu3qL
   Jgdh1Ei3kWiFRgULMnTTWKYNJHE/PNr8tF4PXCCDYo7KXMW0zrfEXojbx
   L26YWT5EL29kIio1vCuHEq6jFwCfhTtq7PH3J/kXhEPHcxm9ttvl4ffek
   ehXv0xz6J1FhFeuyrVvd98OgoYikI3EAFAnKTnwQeklcDL8++WlgxGkx8
   mBkZyFaafcnxq+FjR8XNj8/UQvZ/+JvTkp1PDiAnwXe/BBzoXVsjWBKWu
   A==;
X-IronPort-AV: E=Sophos;i="5.51,452,1526313600"; 
   d="scan'208";a="88289515"
Received: from mail-sn1nam04lp0086.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.86])
  by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2018 07:07:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkik8SdZO4vpiJ4aIlI6bE2VXCBGk+iBLgjPTfAx1i0=;
 b=VmwtTG2pWUC87isAeGC3Be6pHVjKb0JL6qQ7CW2lA1P+qwRhfbeqidKdUPL6xah3wEM7b56vM/RID/rV+1UZ/eKBYgXgcX4kbxWgNhgTY40WS7q9y3VEySLnFzxFFtgfD/YuBqUIQHa58fCridPADxS1e6jE3T3wQQBi2n4/LOM=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0801.namprd04.prod.outlook.com (10.172.168.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 23:07:34 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 23:07:34 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
CC:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH] target: fix tcm_loop build errors when SCSI=m
Thread-Topic: [PATCH] target: fix tcm_loop build errors when SCSI=m
Thread-Index: AQHULajja7zbfS8h9USpWtOHZJHcQaSzWTGA
Date:   Mon, 6 Aug 2018 23:07:34 +0000
Message-ID: <d3349291f6d04e4b8717ea478fcfd2eaf70b39f6.camel@wdc.com>
References: <5b7b9c12-d202-ab0c-9598-267468bf10ad@infradead.org>
In-Reply-To: <5b7b9c12-d202-ab0c-9598-267468bf10ad@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0801;20:D25ZrW64TvijV90sLZdYqATKwqjE2fCwTnL1nm5B69xRySJBpESmTochn+Yku2wgiGXwROT4/lUMcb5GTqJSvrLFZ53wpG31tPEvp30wqDYESnOKSr1ebe3sejXJSXJlB/NnI14nO0lky2DFQRsiZpQOWEY6Wh8Ie/k2BP0NPQY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e55d4f0c-2ef0-4f5f-6b84-08d5fbf16504
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0801;
x-ms-traffictypediagnostic: MWHPR04MB0801:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB08014B778B6661EEA9D8A67498200@MWHPR04MB0801.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0801;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0801;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(31014005)(229853002)(256004)(6246003)(81156014)(4326008)(8676002)(14454004)(5660300001)(81166006)(2201001)(305945005)(6486002)(2906002)(6436002)(86362001)(478600001)(25786009)(7736002)(118296001)(6512007)(68736007)(72206003)(66066001)(8936002)(53936002)(36756003)(76176011)(446003)(316002)(97736004)(6116002)(3846002)(5250100002)(186003)(486006)(2501003)(2900100001)(2616005)(99286004)(476003)(6506007)(26005)(558084003)(105586002)(106356001)(54906003)(110136005)(102836004)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0801;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tQAL0BfCC8NLqt55nJiBfh28s7yZ3y7IzZwEYcak4ViTMXcg4RFpcmyS34TFR9BD45oNK/sBVtP6/ZMmmg0eEluRRPSF7zc+kw1hQOkiZ56oSosXxOlMKGJ9ceyxwvWIUIh2cbrD060+Yiw2A9DmUCjpHq6UMiSLVoOPR3/CQ3kGHNzvVp8MN0dfmGuFpwDSpPPAuvNe0sgDk1+MUSiLwDzZAY5Vz5BT6Z2yWmxL1JQX7iGYBNkx17r63rzpc2JVZXjHxhiqpLzH/zwfD3YUNog7gamW7mRzVr+sSvfUYvQPwOEFRkz0KwiRTSYftP3viXArtDnC6oPm5dE7I2hVwBtIf0zztke41g4D7/vbReQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <54E2F3FC2FA24C46ADB86ACE5025F979@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d4f0c-2ef0-4f5f-6b84-08d5fbf16504
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 23:07:34.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 10:13 -0700, Randy Dunlap wrote:
+AD4- Fix build errors when CONFIG+AF8-SCSI+AD0-m and CONFIG+AF8-LOOPBACK+A=
F8-TARGET+AD0-y
+AD4- by making LOOPBACK+AF8-TARGET depend on SCSI.

Is this a longstanding or a new issue? In the latter case, should a Fixes:
tag be added?

Thanks,

Bart.

