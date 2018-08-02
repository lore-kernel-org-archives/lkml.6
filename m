Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE04C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2811E2154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DJWO5uaA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DWsu9xA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2811E2154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeHBUjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:39:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43088 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeHBUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533235618; x=1564771618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0HwFrXbsfeeyTSfgCPGx+lAdDVnw/dXzudgcYudMW24=;
  b=DJWO5uaARxBhBkVEUfswtMpmXlcuxR9ESl43gRARvlZ0RR1WWQeOYunj
   frTLNlZyoo5rZATvPGBEi+bQtj6flY15vtq8HmOoxQglIFc9Tznw8E8YF
   OKhTT830k2Vpn45U+s83inAPDfxXbba/w+f3KwIT2e/Y27RMFZAfPDptT
   D5TBGHinWEfVrRmoSWK+QpcQH95oMihSH1boljU4Wb1qiekTgI7JAZJ98
   voPERNMi/dL1Yi6qXo7oP56y/ZW79wG6/4KFJxgfidd2mIEXgjIZWus0F
   TEND/D3Mr6yYmzFNm63pYN4z4zumEJI5HwDcvvbLz+isRSkTK+K+UWeTf
   A==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="89733749"
Received: from mail-sn1nam04lp0080.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.80])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 02:46:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HwFrXbsfeeyTSfgCPGx+lAdDVnw/dXzudgcYudMW24=;
 b=DWsu9xA7spCBHSnYffpFVwBnLQS55VjNW4c+ZsA9+gPz5lZD8USNz1yAPWkGsPSXYgXsWVCtdo0fdTndzgBSHUi+hxKaID+UBQalVm0JEWDSpCiwO/8mrRrHJHZ1eQzZvVi8CPC+E7grxelBUKBNsGFDFv3Ws6pXRc4mAXwbD4A=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1009.namprd04.prod.outlook.com (10.174.250.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 18:46:52 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 18:46:52 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "matthew.hart@linaro.org" <matthew.hart@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "hare@suse.com" <hare@suse.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH V2 2/2] blk-mq: fix blk_mq_tagset_busy_iter
Thread-Topic: [PATCH V2 2/2] blk-mq: fix blk_mq_tagset_busy_iter
Thread-Index: AQHUKolITcSShNgKmEKILzup7/U9YKSszUUA
Date:   Thu, 2 Aug 2018 18:46:52 +0000
Message-ID: <6f5d30bf747641778164335a64255bd7a027bc4c.camel@wdc.com>
References: <20180802174937.15444-1-ming.lei@redhat.com>
         <20180802174937.15444-3-ming.lei@redhat.com>
In-Reply-To: <20180802174937.15444-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1009;20:nmB26dn7dM0X5KdaTu+2IXjCoIGVNEQ3mdsaLDy1O7SRUKUbkBsvlPUxAC80nXhNN7Zy58p9iaOcRXe8AAx4JyBz9aG4lZOZsSSNLtcxFHgK8E981lmh4/DorZSlUs0zvaxM01KJe4ph8xQHSAbLxy4qEelIOW91d3cso1LhHXU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 82185b56-a10c-4bbc-c7e8-08d5f8a84fee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1009;
x-ms-traffictypediagnostic: MWHPR04MB1009:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1009FC9B2D452C9D1F55BD5A982C0@MWHPR04MB1009.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1009;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1009;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(476003)(99286004)(102836004)(86362001)(486006)(26005)(7736002)(305945005)(53936002)(68736007)(106356001)(105586002)(118296001)(4326008)(316002)(2900100001)(2616005)(25786009)(6506007)(6246003)(110136005)(54906003)(5250100002)(5660300001)(2501003)(8676002)(76176011)(6486002)(81156014)(6512007)(8936002)(36756003)(66066001)(229853002)(97736004)(81166006)(11346002)(446003)(14454004)(7416002)(256004)(2906002)(3846002)(72206003)(6436002)(478600001)(14444005)(6116002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1009;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OCKKhWUclnLn3ogj9uA0IA4Nb3aZi7wdnPvZZ2sqPDWHoIpC2EkGmCNPB3eaAI4uhs7Xm5ePDKSdu1q6nrY1vMBiax9dNNpVwbwdYasT6rScVzOJ6T3+Mr+l5kYNwZmhB62TaJizIHJpPrq9XNOCNqWt4z6GuaIs9kgzqsK5l6kiAXx+rSHRCaT5wfRddtqpT6jjlf5kFqLxIAg42Dggr+sKfl/uDjpYTQ9qvdn3mBaI8mM8H3UjU/ySeL36bGjaMN55JWEdAD94qrpwKrlEThHVAJvwrQTl8yI+u1G0NvSvGp/yV8Qt79vJHoBbO0TDooyYhcAyOeQiB0uVeq+pMhKMgB8DFJHuG+VXfpT1Ur8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <1FDE5ECA0F961745B8D4B6E4A69BFB6D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82185b56-a10c-4bbc-c7e8-08d5f8a84fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 18:46:52.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 01:49 +-0800, Ming Lei wrote:
+AD4- Commit d250bf4e776ff09d5(+ACI-blk-mq: only iterate over inflight requ=
ests
+AD4- in blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter+ACI-) uses 'blk+AF8-mq+AF8=
-rq+AF8-state(rq) +AD0APQ- MQ+AF8-RQ+AF8-IN+AF8-FLIGHT'
+AD4- to replace 'blk+AF8-mq+AF8-request+AF8-started(req)', this way is wro=
ng, and causes
+AD4- lots of test system hang during booting.
+AD4-=20
+AD4- Fix the issue by using blk+AF8-mq+AF8-request+AF8-started(req) inside=
 bt+AF8-tags+AF8-iter().

That's a good catch. Hence:

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


