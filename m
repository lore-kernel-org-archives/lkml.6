Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB3BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1570921736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ns0d41i2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WynHRRiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeHNSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:09:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43557 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534260113; x=1565796113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=44PcqxpkVBHeclsf1kdXiEEnyjCvMnPYbzJerak7rQ8=;
  b=ns0d41i28ze6z7Px1rD/7ekbAdAZhv6q9W4HJGPJmZAYrtcDqHQRHhYQ
   T+wQqk7EPU26nDO+NH238IH6WBBlSMvdQUEnpM/NDoZsLZEK0RGqBCyo+
   E3Sw8J540X8glpYzVHqAxraFnVX0UCaV/djpk5/oC++ncBUdLIHj6CwVK
   NPmaQojfb3j6o4IdKEs1zC43KyHuRekOrwAGafNSNLUmLUhiVJs+9QdTa
   kLUeaIDIjYTdhYE6Db3MwMJQbRfz2A4UHOprgpoi4uF3Eve9vYQQlTJp/
   9uFRm2e7+Jtf2XU/fa2w3H/VHgQvFrI/vJCtsvkOxM0snd3xEkdlb1Bij
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="91325429"
Received: from mail-dm3nam05lp0111.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.111])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:21:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44PcqxpkVBHeclsf1kdXiEEnyjCvMnPYbzJerak7rQ8=;
 b=WynHRRiKsRRpc0q5rDWiKhWwuItCgWLXa7rkau6Lmt7z1lcc7bEA/ZoNEMxQwxKbWnljR0ZYoNfkutetOmSpgctAHeiqDVGSNCVRMUTdm2rddHfLq91nnjTLinPITXiWXoYHij67mdPwQlQrE6e5mqvzIJLYfhXZ0LK6uGCdonI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1217.namprd04.prod.outlook.com (10.173.53.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Tue, 14 Aug 2018 15:21:21 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:21:21 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "ed.cashin@acm.org" <ed.cashin@acm.org>,
        "hare@suse.com" <hare@suse.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Thread-Topic: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Thread-Index: AQHUM6EQw6RfMpjmakGFUel2vF4gU6S/XaUA
Date:   Tue, 14 Aug 2018 15:21:21 +0000
Message-ID: <047cdc676b8068aa8599f9646cf52bc578facade.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-4-hare@suse.de>
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1217;20:PWh2wYCK0EHYB42l/3PFucPygNFyY+ROqWicww1pBTor1HeDQrXQJXPBJErjLKCpQ8doZnxKnwgCsSFGxGcQvilDpIBYxUWP+Sh4vrm02CDAmhXO1SZo4a+9fJ3Dmukdxm4JaR29Knkh/K7Zn7R3hNwD2ozW7uW/JNn88qjQaRA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8184a099-cc25-41f6-3da1-08d601f9974f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1217;
x-ms-traffictypediagnostic: MWHPR04MB1217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1217FB72833044B6F422562C98380@MWHPR04MB1217.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(213716511872227);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1217;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1217;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(118296001)(6486002)(97736004)(36756003)(106356001)(14454004)(5250100002)(478600001)(305945005)(7736002)(316002)(8936002)(72206003)(54906003)(6512007)(68736007)(105586002)(2900100001)(110136005)(5660300001)(6436002)(7416002)(8676002)(4326008)(66066001)(81166006)(25786009)(3846002)(2906002)(53936002)(6246003)(76176011)(81156014)(11346002)(2501003)(446003)(99286004)(2616005)(86362001)(558084003)(26005)(486006)(476003)(186003)(6506007)(102836004)(256004)(6116002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1217;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 56v60VEcFKrWsmd6Klf+IKliDbRzQVV99LmGFwE/uK2Q/En1vMlMph/EG/UX7ZlDFX2S/5FoePdhaLi7TwK8eV+QJG+OLbCofjNMfxn1gc9lRz9PAjejC2H7uB5+r6D8nLqdTU/3uFwZnpqfpkv3moV3lWAm7i/tOHLC+sQh7bSReLG7IPyEqqMKd93FrNt8xA8nFiFxomBFErjz+KPLpVaX0uAx9FTAEqG7pncfh8x0+rrUWHkncLYxlmOzSraZCBycV0DxpCmgcCtedtqyvPMEID7Dw7HvmhLSGVAqz9gy4nbInsQFhX4GPvnStIepZSycVEgrpC0Hd1RvWaR0arhWXtYnjPKDX9YLpqGndrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <099A810AD2E8E848ADBE3EC2BAA23E51@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8184a099-cc25-41f6-3da1-08d601f9974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:21:21.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Use device+AF8-add+AF8-disk+AF8-with+AF8-groups() to avoid a race con=
dition with
+AD4- udev during startup.
+AD4-=20
+AD4- Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4-
+AD4- Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-
+AD4- Cc: Ed L. Cachin +ADw-ed.cashin+AEA-acm.org+AD4-

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


