Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC012208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Swo2HVTc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KC9Jh4Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC012208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHOVBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:01:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23354 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeHOVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534356478; x=1565892478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sp4P/zn5UHpOPxsAkJgBaZNv+R9aLDB7MRGMYHF3E4Y=;
  b=Swo2HVTcVK/JV88FcNua7X/7KmUS4GCleLusRRO8CQjyW1lOFZvYBNOS
   xYLjk/1EJQA6SXS78wVUc+EskFGHI4gDozkAxROcO8QOMWgQ253BmWFB9
   OeopRO1ww69MVSkskbr4BEzJnfBr29SgZ+as8iS48snpyBlLxhZp+cfIv
   VJbSXSa5PLPZ6+R39W9M80y528cm9g3MdUOx/LB/fHkSQp1lFZ/ifu6kA
   LLheIPKs2tuPlZEuSrV7yxXnQE5JwGH2RvB9O2A8+QBam/BDC7C7oVb8v
   OHEJuSdVA1pEuFZg5XvWQPW02LVJA6NvQdFb/js3xFgLBciUK52mPLSyQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,243,1531756800"; 
   d="scan'208";a="89154523"
Received: from mail-bl2nam02lp0081.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.81])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 02:07:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp4P/zn5UHpOPxsAkJgBaZNv+R9aLDB7MRGMYHF3E4Y=;
 b=KC9Jh4NxRpuYf+FFhICzUHp/7CEgBrxwFwh8E/Y0fjHvPgFmGNOgDhPrrN1WKUZNtwmudeC3AblXFAqS8vbyPGMTxiRXRlmIiENEEe7F+vDFbvonrOd6iVlo5j+p19J0Xl2oKV1guUvTNYnJ2WeWx81xeax0syV5j6iEZwtVNxs=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1104.namprd04.prod.outlook.com (10.174.250.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Wed, 15 Aug 2018 18:07:54 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Wed, 15 Aug 2018
 18:07:54 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "loberman@redhat.com" <loberman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: Zoned block device support for fio
Thread-Topic: Zoned block device support for fio
Thread-Index: AQHUMCRkJl/lXRtaYU2NZSq5SNPSmqTBJXyA
Date:   Wed, 15 Aug 2018 18:07:54 +0000
Message-ID: <c3dae05ba4895b58442b64640b8c7a16103fa214.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
         <1530899118.31977.1.camel@redhat.com>
         <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
         <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
         <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
         <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
         <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
         <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
         <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
         <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
         <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
         <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
In-Reply-To: <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1104;20:7MacrYjIzRUReSSlIg3h/qQJEueaMqUNu25ijG92oRGfu5MiJTay5gs4OcCWklaTsYCi1A8VxoUDeyYPCn6f5CJH8+YfpDD9g1DulykwX+moK8B6sBQ2Mca5PU9IKKjF04wxBtCTc04I2hl5mM9JKH8jIy3q4LYXhrGNgFEL3rY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 77cfdc93-52da-401f-06fa-08d602da05e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1104;
x-ms-traffictypediagnostic: MWHPR04MB1104:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1104D39240CC100F1D94328A983F0@MWHPR04MB1104.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1104;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1104;
x-forefront-prvs: 07658B8EA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(118296001)(53936002)(102836004)(229853002)(6116002)(7736002)(5660300001)(305945005)(68736007)(3846002)(2906002)(2616005)(446003)(6306002)(486006)(11346002)(476003)(6506007)(6486002)(6436002)(186003)(105586002)(106356001)(26005)(14454004)(966005)(316002)(66066001)(478600001)(72206003)(6246003)(81156014)(2501003)(97736004)(93886005)(110136005)(54906003)(36756003)(76176011)(25786009)(5250100002)(8936002)(81166006)(2201001)(8676002)(99286004)(4326008)(2900100001)(86362001)(6512007)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1104;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fBx2kzURXAo2pzaWBbhSIVeNELsCQGA1uPnEmV6LB3W18Z/bwWe2ORL9d7mye9IlXqkkx07VWZoyoReikJUFJ4hf0jk9w8Be4Ie7cSDAuaEVYQjC4gDmxziMxjKf+yVyWrzMa6d463aiYatGLI0NWVoKctheJajxyCxQaqL8WMZ07+Va2jWTtQTVff4A66aQ0Y+IV2o+apqef+sc33XWsttaPj/Tc6QIekX8Fii08dLXBcJj89kYqtbpf5QVTYlny644EolmQjy92a4SVIa3cnpesS7bXKuXwyFsJZGol3MhQOFgvDiup3wZFM4AfVPakk7TRtMfI3wm0RWwLWsdoDHm6s1H8YTmgLRLu2WFkng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <5F16F279B8BB43429FEBC8D19F391D46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cfdc93-52da-401f-06fa-08d602da05e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2018 18:07:54.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 15:03 -0600, Jens Axboe wrote:
+AD4- Yes exactly. Basically come up with something that just maps fio zone=
s on
+AD4- top of SMR zones. Then come up with something that allows you to have
+AD4- sequential writes IO within a zone, and something that allows you to =
decide
+AD4- how many zones to use, when to skip between zones, etc.

Hello Jens,

SMR support for fio has been reworked. The reworked patches are available a=
t
https://github.com/axboe/fio/pull/585. The following two test scripts allow=
 to
verify whether the fio behavior is identical for SMR and non-SMR storage me=
dia:
+ACo- t/zbd/run-tests-against-regular-nullb
+ACo- t/zbd/run-tests-against-zoned-nullb

Thanks,

Bart.

