Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D32C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBBC20C0D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mcgIQTA8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b3Kp5Hvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBBC20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbeHNSJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:09:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45571 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534260093; x=1565796093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r0OGpG8lxscJmR7zPs1TMQ7hvDd+vAkBGhGeqEiYgjw=;
  b=mcgIQTA894k0ABxy8QzAvj6wdi6SsxcqE6nKZidb4AKLOzVVabpETXSX
   2t1Yq+KIRY7rp0MhQCqxWl8QUcWLHJrAwH6f6CSeYcBLdxszsGmX5V2PK
   zViEQ94XujD73vgpVAPQyMKxwdN3w4H8P5NQF0o0jma1TIXC4Myh+qyJe
   382pEC4HI0LaOJa3StPZvV9q3gcYTuNUUgIWKSW18M9cpe5Jl7eh+8m1O
   dQBa88dzy1jPehpr4umplLXQgry3e3AtkucDqvU/W56QjdTqsPTy5XHwD
   O5j3/TX66EPK4YUSCossx+gTkmlroYhc58KmkyV/2ToglFbZn2HHMYcA6
   w==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="89048047"
Received: from mail-bn3nam04lp0117.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.117])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:20:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JaG/dtoU40qoO/FkkfIjG251JhsFRyBEihyxkqrX3g=;
 b=b3Kp5Hvsq++ve7JaJbp3hDzfmGA+IArsyMA2wxtEKMs4XYK+7VNdnO8j7xDaYJozHdpDcs0nu4XNrI9PsmS4GjjFWXNmwdoWceQRr7beVE2n4RAz2ekfJP9LcJ87pC2Yoi2HugNRezmjFqf1SnANbBfGeP/IwqhrAvZxfyjQ+S0=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0494.namprd04.prod.outlook.com (10.173.49.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Tue, 14 Aug 2018 15:20:33 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:20:33 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Thread-Topic: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Thread-Index: AQHUM6ES3j1v2YHkvU2ZLaLIQP27MKS/XWuA
Date:   Tue, 14 Aug 2018 15:20:33 +0000
Message-ID: <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-3-hare@suse.de>
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0494;20:0m9q3AXmoYDx0LabHjn29RPuM1Ze5D20or+thLBvzL91dm79q6+u9TEoSidas5QgxZZD2uMblc9LA6hKmM7DooPzTcJLtxc3i5roI/0DFCfFwl6snjlLoDcxOXYtDUlKoUo1O8qLX2TMZbl18FlbXNGwvtAIQ2ZDVfgVvCxlP68=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b4eed62f-95a6-4da0-932d-08d601f97a8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0494;
x-ms-traffictypediagnostic: MWHPR04MB0494:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0494D8DF0AC8B313B768A5F598380@MWHPR04MB0494.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0494;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0494;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(81166006)(6506007)(6486002)(8676002)(478600001)(106356001)(102836004)(6436002)(66066001)(2501003)(54906003)(110136005)(3846002)(86362001)(8936002)(5250100002)(81156014)(68736007)(105586002)(2900100001)(118296001)(99286004)(25786009)(446003)(6116002)(76176011)(97736004)(2616005)(229853002)(476003)(11346002)(7736002)(305945005)(26005)(316002)(53936002)(14454004)(6512007)(256004)(186003)(6246003)(5660300001)(486006)(4326008)(36756003)(72206003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0494;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 6jsJblm3sXCe1ZkiMQ9SoxzySVdv1I6fwxsGkaZoWCPzEBN/Ojm9ZxMq8Q0BEYc2tDmnSMT3P6UMk9M7+z0alAC5vdSRRt7o2gJNaq4szOHrHMKfT7MZ4YGJR+o2QFJ0YO1rY9rDoeejmFVpUqYK4GRpqQ23f16nAMjx7YNW6UD2LA2UCfhwYeTzARVD8ZcBXm3aZWvug5ctpx+DAsRDeufHa6wKFKxv98kJYHFkCIpQs8ZqURXldzlIZz6vcB0cgq1wHrdGuJWyHORje7t/FBewKYhs4ByfFNcqePohhB9Y1SqGAwsR2x8ZypiwrN4Q7j2MLEhVgPA5k/PVOcZajfXxN/IcWR6TRNUokuHkm4o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <5A54610DA131A247A51F840B314FD428@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eed62f-95a6-4da0-932d-08d601f97a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:20:33.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- +-const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+A=
F8-groups+AFsAXQ- +AD0- +AHs-
+AD4- +-	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- +-	NULL, /+ACo- Will be filled in by lightnvm if present +ACo-/
+AD4- +-	NULL,
+AD4- +-+AH0AOw-
+AFs- ... +AF0-
+AD4- -void nvme+AF8-nvm+AF8-unregister+AF8-sysfs(struct nvme+AF8-ns +ACo-n=
s)
+AD4- -+AHs-
+AD4- -	struct nvm+AF8-dev +ACo-ndev +AD0- ns-+AD4-ndev+ADs-
+AD4- -	struct nvm+AF8-geo +ACo-geo +AD0- +ACY-ndev-+AD4-geo+ADs-
+AD4- +-		return+ADs-
+AD4- =20
+AD4-  	switch (geo-+AD4-major+AF8-ver+AF8-id) +AHs-
+AD4-  	case 1:
+AD4- -		sysfs+AF8-remove+AF8-group(+ACY-disk+AF8-to+AF8-dev(ns-+AD4-disk)-=
+AD4-kobj,
+AD4- -					+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-12)+ADs-
+AD4- +-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+=
AF8-dev+AF8-attr+AF8-group+AF8-12+ADs-
+AD4-  		break+ADs-
+AD4-  	case 2:
+AD4- -		sysfs+AF8-remove+AF8-group(+ACY-disk+AF8-to+AF8-dev(ns-+AD4-disk)-=
+AD4-kobj,
+AD4- -					+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-20)+ADs-
+AD4- +-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+=
AF8-dev+AF8-attr+AF8-group+AF8-20+ADs-

This patch introduces a really ugly dependency between the NVMe core code a=
nd
the lightnvm code, namely that the lightnvm code has to know at which posit=
ion
in the nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups it can fill in its attribute =
group pointer. Have
you considered to make nvme+AF8-nvm+AF8-register+AF8-sysfs() return an attr=
ibute group
pointer such that the nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups can be changed=
 from a global into
a static array?

Thanks,

Bart.

