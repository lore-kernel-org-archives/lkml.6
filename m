Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97E8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1F204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eMhG7fkJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C1AwNbd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA1F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbeHNSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:12:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43776 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534260277; x=1565796277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=akboYYYz7BE722onqzuNjh/sqy1buCGr4E7KRirlmUs=;
  b=eMhG7fkJh040zuL/kzjVuzI4T7R0eYPPInZaY1XaTtYlazcLlo4v2ird
   03f/u5ogNYIB9omNrIwkIMuaW4Bu5mXsOtzDg1PkPEvA+w3ZVyqIpgIr/
   IVB/UDxC362sdB1Ma4SYjeH5fLw+8SVppcKroQNZtAOWANHTyGBOsn3S7
   gA+eUxMYiO97lO9FhF04LjnchudKJXobgfRLuBaCcXUOlvvW1XyElna7l
   rzE8fu5Qko9dQJg9u4wlaIsIHh/TPmMG17MlgBiiLKIHyu4sem4PAm5ea
   FN1Z54CsY+YcFIzj30jcS3eKfyAqaYGmsFdldagdd4illUwkjnVWMbX3i
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="91325941"
Received: from mail-sn1nam01lp0114.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.114])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:24:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akboYYYz7BE722onqzuNjh/sqy1buCGr4E7KRirlmUs=;
 b=C1AwNbd2bFPSTJ4oi+IhariAYaWRgJHSj/o7Ij75+QZnACzBUN/CClYl0tISdihPDidOanhGloU3ckhUzQwjo36utt1hApFbrqTriIvEBx6BFWGMi5alvnLf+ouS+7tiJwx3uTyCgpx7uXrGBoAQV6rARvrDam8l88HB3ZtaUB4=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0544.namprd04.prod.outlook.com (10.173.49.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Tue, 14 Aug 2018 15:24:34 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:24:34 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] virtio-blk: modernize sysfs attribute creation
Thread-Topic: [PATCH 5/5] virtio-blk: modernize sysfs attribute creation
Thread-Index: AQHUM6EQ5hw++VTdqk64t4Ix7odRf6S/XouA
Date:   Tue, 14 Aug 2018 15:24:34 +0000
Message-ID: <0e99ae23c2bea89e597dd3e8b20489054f461ff5.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-6-hare@suse.de>
In-Reply-To: <20180814073305.87255-6-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0544;20:VSRSZVBkgA0/ftUAg4qjWwiTcPQ77NO5Sh3fXGIOyrVbTmItsgzInY3CzJSOo8K83DmWid8CNz2oJev2QwR+eqm6W6g2Tb9fEgIObFOHpVyFUFPw93S3lDDHhhNg1zqzd81fYRxFbOxLOvU2xc69UUHFvGu//5HNTB3j/baQLTQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f376fcd9-20a7-4924-f34f-08d601fa0a43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0544;
x-ms-traffictypediagnostic: MWHPR04MB0544:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0544ABB909C9E56D2AA7F43198380@MWHPR04MB0544.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0544;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0544;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(66066001)(97736004)(76176011)(110136005)(54906003)(25786009)(6436002)(99286004)(7736002)(8676002)(6486002)(53936002)(305945005)(6246003)(229853002)(316002)(4326008)(256004)(106356001)(2900100001)(105586002)(81156014)(6512007)(118296001)(5660300001)(81166006)(2616005)(5250100002)(2501003)(102836004)(186003)(446003)(476003)(11346002)(478600001)(26005)(6506007)(72206003)(6116002)(3846002)(2906002)(486006)(14454004)(86362001)(8936002)(68736007)(558084003)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0544;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: y12AiZPX7qShcvg7odDQ4cDuw9d4m81+wXlruXGH7hNic+jzE7xbFbh+DhQSDP+veyAp8h4inpWWkoGQMGwiUVrSi201XjXSRuYfHI6CdKGGlAlkZsabFKcZAVsX92klqO8oLiKcwrADc8HCDIbQXLA3ne4B4AwSc6AKSkChWlb4mwJfxsFuGeCOtdclkUJn6tn6STiJdpvHhvyhMYm3dpyqRyA6htbCqUwLNsFUemxf1mT42Y/AMS+y8eg1wnGx4aO+Fr85oeiQLcF4aFZ1j9jIqMpYsKisl5oc00eJqGaGD8l4KiuhdRdPvq8OlL4d+gq4meLJoE0f3Wx/Kd1Y5uWyVeKpKUl3yZf4fltfsIM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <4642E7118B5F1749BAFE9B54EC2DED01@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376fcd9-20a7-4924-f34f-08d601fa0a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:24:34.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Use new-style DEVICE+AF8-ATTR+AF8-RO/DEVICE+AF8-ATTR+AF8-RW to create=
 the sysfs attributes
+AD4- and register the disk with default sysfs attribute groups.

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


