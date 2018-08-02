Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8926C2154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vd8IkvcM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BQ44mPx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8926C2154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbeHBUiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:38:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1851 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533236070; x=1564772070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T+c42iGU/Oj4hWe3AXFEopyQoLJd5gy+SK9xhGQB1cE=;
  b=Vd8IkvcMwCKWLMZeOWlQay5FQClIXWQzk6Xd1xudxOt4h+LXxTlbaSZN
   VGb2AoEUHbJKl07AyPvgdfetMH908D3Yo9ngrviWiUJqOR/AhSzS8y27j
   qGll0Mo5pwAIbIqDjLYo/QP3G296nvNCKRG5fl6qax1Ob62HjwMdc7Pv3
   pcd+WurbKEd9p3QCJu/LtOmuWRduMCxpT4Xu5PF5PoutShFfb5SddzhwU
   KnjxjU029zyamPQIGGWXg7y6OwHf1twLoQQ5/KiroDQLbi73j+FMNHIfu
   uGI+v/yzN6YzQoYfrk2tXYlbKt3xmai5f2KJtUsh9Ai3l5WxFghH9OhuM
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="183381640"
Received: from mail-sn1nam04lp0085.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.85])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 02:54:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+c42iGU/Oj4hWe3AXFEopyQoLJd5gy+SK9xhGQB1cE=;
 b=BQ44mPx0DMQb+R9WqRQ//drjRMeoWJ8x6fN85N5lBVbXGD1NrNz2sykebNMkFkvYv8JQmZMXaWTV8j43CtfyhFcEBulC8r0DptQ4p/GncqTwAwpOIg3w1UaTpALXE5og9XvAXQ9xxglsS+qiXcV7Afu22YAXZrXUwJO2009wEms=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1009.namprd04.prod.outlook.com (10.174.250.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 18:45:37 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 18:45:37 +0000
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
Subject: Re: [PATCH V2 1/2] blk-mq: move blk_mq_request_started() into header
 file
Thread-Topic: [PATCH V2 1/2] blk-mq: move blk_mq_request_started() into header
 file
Thread-Index: AQHUKok+UeB3WbxKSE6hz8WltiosLqSszOyA
Date:   Thu, 2 Aug 2018 18:45:36 +0000
Message-ID: <7777b8256817f09aee22703d760ec3b0daf4fc6a.camel@wdc.com>
References: <20180802174937.15444-1-ming.lei@redhat.com>
         <20180802174937.15444-2-ming.lei@redhat.com>
In-Reply-To: <20180802174937.15444-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1009;20:D7+x2BG7/Mzj9LLD9vpeR5P/HdyDSvohp4tAVKisPFK28tD2s+wSFA34cv8plkrSukSEr6TIClC4IZWYngyB5U/eEG6UbFHrEKlouJDlWb6Y06gsBNpwLA06N6P8U/5wp10rAhlJ3H1pyEW/zicv7OV+IN6zqBA1O46iG5wFpwU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0314d26-318c-41ff-0fe9-08d5f8a8231e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1009;
x-ms-traffictypediagnostic: MWHPR04MB1009:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1009A7C5EEEE2DC98E43E07F982C0@MWHPR04MB1009.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1009;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1009;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(476003)(99286004)(102836004)(86362001)(486006)(26005)(7736002)(305945005)(53936002)(68736007)(106356001)(105586002)(118296001)(4326008)(316002)(2900100001)(2616005)(25786009)(6506007)(6246003)(110136005)(54906003)(5250100002)(5660300001)(2501003)(8676002)(76176011)(6486002)(81156014)(6512007)(8936002)(36756003)(66066001)(229853002)(97736004)(81166006)(11346002)(446003)(14454004)(7416002)(256004)(2906002)(3846002)(72206003)(6436002)(478600001)(6116002)(558084003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1009;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TJY6/OZ8QcYY8S3WDnYvVOjMSYUSPFpLsxKCMWHNR3mxUqlh/FcnezrS/EFkNIDF3vb+liqwiIbXSlHsXIPVopN7S/OiV+EexE0SKNPvv+JztxwXQgimpb8gHQPXVynOH4kv9j4KWksCD4Ja/ZFceGmEwXc0ezP6VtxrWBSshrg4ZhSSTRxmhUuXNIEi8Pv2ygJv1zRNbZxiQsA2LUEZWxfc2yd4G6KmklVX8620IjLNo/8r+86bWiAohkcXepTbSO6keZ8gWGFsEewcfF+fjok1QSAHkof5FKevmOaWIRbacG1F9G8OjxDAIq+IbGYxQZ0kGLRXbTh0efCwkiaky+RbQ9PTRR+2OiJCLpGUDMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <404359A14BFD5F449D4401CE8665ED46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0314d26-318c-41ff-0fe9-08d5f8a8231e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 18:45:36.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 01:49 +-0800, Ming Lei wrote:
+AD4- Define it as static inline given it might be called in fast path.

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


