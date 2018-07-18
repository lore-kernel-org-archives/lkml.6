Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28676ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CDD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g1p3ZgYd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ls431dRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CDD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeGRSps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:45:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54992 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeGRSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531937206; x=1563473206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qHBhS5wZmDur5bTK6QoGtiMOSQNiHmoGxnsXAyjfJ5c=;
  b=g1p3ZgYd8yocA1P4MVQ5fxqys2r1cL4dNnHvIoZW7USJ0AHG/h9ADz6K
   ufJUUfV5UWRWproo6iwt7IvaskVS0or17GItrFfUsns9cfIaw3zn5118s
   d/va4tgWXEQ3U/2pb0sH8kb6DCyInxK+tmlyrWo/QnYxhb80LO4w1w6A5
   Kb91dJpUpxZYtub4VzastrrBv5zA6Fhxlvm1RUvTbI+in/ywe0DlsqJAz
   AgfwncoKSq08E8ZEZ4DqqQbBSB7HmBJS8EF4WH40N9Tgi+fRtlmp1aYfd
   spBrwIoTrJIFGJDaopJ2rpRVaP4KbcPXzPU3ircEWWB8OSsTll90OTy5H
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,371,1526313600"; 
   d="scan'208";a="84327637"
Received: from mail-by2nam05lp0240.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([216.32.181.240])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2018 02:06:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UeYLsSOoF43G0pnTW5xYmM+Xlyc55r+t25wz5IycjU=;
 b=ls431dRRfXD4QZRiGpewjmvjbnQ/msUFH6zDsV02ZEbKy4i8/kewlJIXQY+NjP+SvAAIW128Is6Ds9LDZwHpUoWsjpPfmrltLzt9F+P2jTePG+Ji1HqhevLTx//b+NijwXSe2KgbqUBdMU8bwvZzWoQmCnLtqHGZa3wtju8JvNs=
Received: from CY4PR04MB1191.namprd04.prod.outlook.com (10.173.192.16) by
 CY4PR04MB1238.namprd04.prod.outlook.com (10.171.249.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Wed, 18 Jul 2018 18:06:42 +0000
Received: from CY4PR04MB1191.namprd04.prod.outlook.com
 ([fe80::648d:84ce:4614:6e77]) by CY4PR04MB1191.namprd04.prod.outlook.com
 ([fe80::648d:84ce:4614:6e77%4]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 18:06:42 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "raghuhack78@gmail.com" <raghuhack78@gmail.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Thread-Topic: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Thread-Index: AQHUHrluVYEZORqrg0SUT3rNWDEVNKSVRrWA
Date:   Wed, 18 Jul 2018 18:06:42 +0000
Message-ID: <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
In-Reply-To: <20180718155855.4949-1-raghuhack78@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR04MB1238;7:1dk9ifct8+4UVsRHCMgBcriyJMofi5KL5bXZf8VmTtgELktkx+7yxzxqF6Rid2sn453EFXweeSpH4L/UHjCT+MGbco5uRR5Ciug/wbPeM2O2CFFKkk3Blh6nGTNXRx7RB1Ei6zSsq2DS+14Xtzgu8xgUMUVLlp2VoX+GA8MKeJs7qLHfmLLwZqpgxFblDplVtkmGPZMVtaqyS8ozyjbOnX0waDE9VzwQZEhRukMEqVlnEb/ECjv+9D89Rnm/8sus;20:FDDz3l/Aj09cbCN3VuKrWnB2OJ5oH4mvQee9j5MQxsbtyxgYR1iZz8HBrSaTZja8lRqvh1abfhyaz232lj69Ybz196obvczdb+208kKJdOVS9hk0aWeikuldPQYgdxIqNniXbf3Pv3oQT590vIAcxMNo2ul9WoYnMEqrbB1lLRs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1867f0f4-162e-4455-aba2-08d5ecd937aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB1238;
x-ms-traffictypediagnostic: CY4PR04MB1238:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY4PR04MB1238272E6AC5E2026829571998530@CY4PR04MB1238.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB1238;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB1238;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(66066001)(6116002)(68736007)(81166006)(81156014)(7736002)(106356001)(5660300001)(2906002)(486006)(476003)(305945005)(105586002)(3846002)(8676002)(11346002)(14444005)(36756003)(26005)(256004)(316002)(2616005)(102836004)(97736004)(5250100002)(186003)(14454004)(110136005)(446003)(6506007)(2201001)(6486002)(4326008)(478600001)(39060400002)(72206003)(6436002)(6306002)(229853002)(2501003)(2900100001)(99286004)(118296001)(53936002)(6512007)(86362001)(8936002)(76176011)(6246003)(25786009)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB1238;H:CY4PR04MB1191.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5vRGersMgOAQp91zyMyNRaFYtYIywzhR65YbdQvRvp6crQL3LDHNlcgFlrCwJMSPhzcf5NqruEJN8LAcCqghDUe2K6nEFW5gXJLo9qnc5ZPMPmi4kDLVcQXS5WVwWFn4TF05MyRV3MN9QJJooPMH7jWUiKNW2DCCUHypjxx46Rbb0PFWzpWFNmMdbGjGle2do/4zkQ2DZvN0jDLm8ie+tloPoXzJrQK8KzUH3h9WFr8yvhqZfXaHIENscygd1AQLTjHrdpcSx+o3VYv94oM/Z70NVFHza2upZUphrCXaD9h0rpecFTPpP02EMCIwxRNa14SE0aGqL+8WTO6qYOhIMi0uuWb1yK7tr58pl5IFe14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <F06FC9C4DC26D24ABB443A424240EB80@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1867f0f4-162e-4455-aba2-08d5ecd937aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 18:06:42.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 21:28 +-0530, RAGHU Halharvi wrote:
+AD4- +ACo- Fix all pointer declaration which causes
+AD4-    +ACI-ERROR: +ACI-foo+ACo- bar+ACI- should be +ACI-foo +ACo-bar+ACI=
AIg-

Hello Raghu,

If you would not be aware of this, checkpatch is a tool that is intended to
verify patches before submission and not to verify code that is already
upstream. A detailed explanation of why patches like this one should not be
submitted is available in +ACI-A quick guide to why stand-alone checkpatch
patches suck+ACI-
(https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012=
296.html).

Thanks,

Bart.=
