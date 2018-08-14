Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAAEC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC98721734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RnTOCze+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DmvoV24k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC98721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbeHNSKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:10:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534260193; x=1565796193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qQ2m49PsYOfzE6Ydx/Q/fb0COLprHRjeO8uKKmkhffY=;
  b=RnTOCze+Fp33s/NBYCT5rkGSwEmle1wh9v/MFYyrKEUqH+8CqkcqC4QV
   bwMczk6/8VTPlVqe6qx102rqpsTg+BWe6PFNnk7aIsiAMkPNvrkKR7deo
   C1s2IiAuF/KbuSkVdplabJZ6k93PeUOZDAqxBMIcXPVaLkH+4P5/hHf9i
   8gqqFisR9hggv7KaMeCm0f6oGr0RcQfy108wxYC6v0tUE+63w55H9mr9I
   upovDjObh89soqHPVcgAY3EO1bWhxZPh018u8jjzWYxIYFfxUnE74eZBS
   bRaqytdfjnatnjsarK+ayD134chcOfcMWjp94Bihzni8Eqi4aiCuDESds
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="89048312"
Received: from mail-bl2nam02lp0081.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.81])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:23:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h60PvS95nHyodO6as5P8oWOij67wFQYkR2s1BoaQu+o=;
 b=DmvoV24kkf33GX4nVBovBqUgN2T6DOXctUtysJKudwpTmN9yyh6Da3Oeaz2yKtNvRvwrnzXoZvxQfbdq08y868amsiPZXIKuQ8EZVCpqXZX67ARoJ9RgLiQoDBB3rVRoq5yIexxA5dCSgWhG/MLaAzVoByJAnAegjGLffUAYidM=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0673.namprd04.prod.outlook.com (10.172.166.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Tue, 14 Aug 2018 15:23:06 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:23:06 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "ngupta@vflare.org" <ngupta@vflare.org>, "hch@lst.de" <hch@lst.de>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 4/5] zram: register default groups with device_add_disk()
Thread-Topic: [PATCH 4/5] zram: register default groups with device_add_disk()
Thread-Index: AQHUM6EQEtBNNhDtyUWk9vMBIpOUcqS/XiKA
Date:   Tue, 14 Aug 2018 15:23:06 +0000
Message-ID: <3f8e9adbb899d40dde900e4b5d57cafe663f808b.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-5-hare@suse.de>
In-Reply-To: <20180814073305.87255-5-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0673;20:OPNKTcvFyZPDfwKB+iDGjMuzxeSWiZJqBV8HjOFsBG5LZd7Iwc1X4PUC6l3gOPK5UvbzicAcC13wK9qd71D/33VcRoa6zaKeXkxIZ03yi7CzSikAqQPniIQ5uGRA47wlkXz87ifRuG7Y1HCLkSrOUzmrzm7/+bIEBdBp0PqL2Pk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2bea8b31-46a3-475f-dba1-08d601f9d60b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0673;
x-ms-traffictypediagnostic: MWHPR04MB0673:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0673D37E35D508A9B5F5D1BD98380@MWHPR04MB0673.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0673;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0673;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(86362001)(2616005)(11346002)(99286004)(186003)(110136005)(54906003)(486006)(476003)(446003)(76176011)(106356001)(256004)(105586002)(26005)(102836004)(6506007)(2501003)(6512007)(5250100002)(7736002)(53936002)(66066001)(8676002)(305945005)(81156014)(2900100001)(6436002)(25786009)(4326008)(229853002)(14454004)(478600001)(72206003)(6486002)(2906002)(5660300001)(316002)(8936002)(81166006)(97736004)(7416002)(36756003)(68736007)(3846002)(6116002)(118296001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0673;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5QHDr2BrGCdi0d+SE/orcD5KIgcSk9idRauZTteQgP7JANe4mg0QSpMiGm+2Okglc1Y2LlcOHGd42bfb6uPG2BGmCfbaSZQ1jIl7kbiBWVbhyrE8ZsfQwTqis0F/PnD0UHAxCDsO2fqdGG6a1M1MCEvHGdIxzsdjhfovxhG5zftCrSyFL/Ysov7i8OGqYq/HUcOgwY1yYM3QjzeS7G1SNa6hGyMCSY352zCkgikN0nDNcTuQrnbPhLEsVYSiwmQ8TYdiyA/dSBOzVxRsFIt26bkcPC11BoY3PudgYtXU1/AGTaxA+eqj4YoeV3HVFWPOgUTRxL4qcgbRWRc+b5aLZR8GzqQZWwHMBG12bMs8TVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <915BB0F9B8176C43AD6135DEA258A547@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea8b31-46a3-475f-dba1-08d601f9d60b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:23:06.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Register default sysfs groups during device+AF8-add-disk() to avoid a
                                       +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4=
AXgBeAF4AXg-
                                       device+AF8-add+AF8-disk()?
+AD4- race condition with udev during startup.
+AD4-=20
+AD4- Signed-off-by: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4-
+AD4- Cc: Minchan Kim +ADw-minchan+AEA-kernel.org+AD4-
+AD4- Cc: Nitin Gupta +ADw-ngupta+AEA-vflare.org+AD4-
+AD4- Reviewed-by: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4-

Anyway:

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


