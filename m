Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF732098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FOeCD5g7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dNhjYMLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF732098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeHBTQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:16:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1363 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeHBTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533230658; x=1564766658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wzfTvlk7capBMtVsoGqkN2qWdX6fEmSNCWhjRj2PFyo=;
  b=FOeCD5g7v4sfnmjtbOp10TzO267wAOOmAqD5A2t25/pX6eB84Zi5QhEL
   bVyHJ8EIBFXdXuvRGWLGL3jK/xlOOimmjhbqTcjCP8oaIjNSbuRerJoB0
   bqjC4v8YS8eAD35cWvKcEHiOTM0plLNojvQE+cA9seu+7yRTdS+FMp6Jq
   lIEoMKtqnD4bT1YtNaOhpwcZ9hgJxeQk3beaW5WP0R9S37Iael8tDotli
   34GY8jvgRU/QGvcIALUK9jbQx+XbyWTDGkjfX6u1OGGljgME6Cc4YSRUg
   wpIfx0SfUC+Rbttif8yes1OZkgUI/m/K6OtDMTQ7HMYTEX2NdDN1JV0fU
   g==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="86119467"
Received: from mail-co1nam05lp0088.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.88])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 01:24:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzfTvlk7capBMtVsoGqkN2qWdX6fEmSNCWhjRj2PFyo=;
 b=dNhjYMLsqfO1gyEzAF3oy9xGnJmkJAVKzkrOd4mUjCnAEXLbo46sYJTBkpO28jckSTvOGyYVIe9ytG0wjjAON6ygGgDrPniRFEGcBXeL6+d33tIlf6nLGH5kdxE8bLBPX0EmiDHkdekNhJ2EeDRw1skB7Ph3EeZum9l9IZve4y8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0815.namprd04.prod.outlook.com (10.172.168.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 17:24:15 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 17:24:15 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Thread-Topic: [RFC] blk-mq: clean up the hctx restart
Thread-Index: AQHUKIMWxQ9ytKciREKo5HIno+xAH6SoxRwAgAAGCQCAAA/RAIABT5wAgABwGYCAAgXLAIAAEpkAgAAC5gCAAAJgAIAAAekA
Date:   Thu, 2 Aug 2018 17:24:15 +0000
Message-ID: <4868e0b82ac6e87aede7fc52da67d3a7913d680b.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
         <20180731045805.GE15701@ming.t460p>
         <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
         <20180731061616.GF15701@ming.t460p>
         <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
         <20180801085841.GA27962@ming.t460p>
         <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
         <20180802165831.GB8928@ming.t460p>
         <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
         <20180802171723.GD8928@ming.t460p>
In-Reply-To: <20180802171723.GD8928@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0815;20:55hm2AwSyJD6AL1hM+MPOGzcTJyzBZ1Tk0i0DltmyXuZI8Cay8U3tnr2RLFzBM4jV6+CuiVNIHYMoqDKmQGmusJsiEUY5dxtXL/UDRWvxAmDl4QKHwxLEkYEKlskNSqgvs5RRz7HAaBL2EXLAnuZtdZkFzeBX/6pt53Uqbxirz4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 10f62837-61e6-4171-9896-08d5f89cc5b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0815;
x-ms-traffictypediagnostic: MWHPR04MB0815:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0815A5A23ABB46F5971322E8982C0@MWHPR04MB0815.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0815;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0815;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(2351001)(6506007)(26005)(186003)(5660300001)(7736002)(6916009)(6512007)(6486002)(68736007)(99286004)(102836004)(76176011)(97736004)(54906003)(53936002)(316002)(229853002)(2906002)(2501003)(11346002)(8676002)(8936002)(86362001)(476003)(486006)(305945005)(446003)(81166006)(81156014)(25786009)(4326008)(6246003)(2616005)(66066001)(118296001)(256004)(3846002)(72206003)(6116002)(106356001)(105586002)(5250100002)(14444005)(2900100001)(14454004)(36756003)(478600001)(6436002)(5640700003)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0815;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kT/zLFvcMviq/SEG+4ocUtFACWl0jwrq31rUi9ExiuT+NRbWDv5CYa66HHI3iK7hd3ShUB7ARtuuDBMzlYLPWofFUD2cFbXD5uR2lr1vlhhFxl/s9yyUgJgTVg+udzRko31xooUVT6qQ0wNP5kPI9bhpNO+2DA2OkHwVU2YJUGGdR8ce/7FLZkIvUXTdsuvMIMwY0wfvh6/mqxWJ+PDkjgzS5I5Bttx9aIIlLzR/tAwzk4ipA/RiryPYHNFY6lqU+vykYK3WKJjqDvvx1ARD0wbbdPrimqVZI6z5aYAC7Pi3AWySSClYJNvsBZC62p48UvNMpPF5jUmCS7m4LdiqngpDfFkP+Lx05tegAVNezIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <B1716A55720F404286D82EFC66C5BC36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f62837-61e6-4171-9896-08d5f89cc5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 17:24:15.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 01:17 +-0800, Ming Lei wrote:
+AD4- Not mentioning big CPU utilization is consumed unnecessarily for iter=
ating
+AD4- over all queues even though there is only one active queue, is this f=
air from
+AD4- system view?

I hope that someone will come up some day with a better solution than the
list+AF8-for+AF8-each+AF8-entry+AF8-rcu+AF8-rr() loop. But as long as such =
a solution has not yet
been found that loop should stay in order to preserve fair handling of larg=
e
numbers of LUNs.

Bart.
