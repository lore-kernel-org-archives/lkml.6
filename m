Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FC1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3B521731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RVN58Le2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PUbqAle+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B521731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbeHNScm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:32:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47485 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534261501; x=1565797501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CiBA3ZnAFgwZTvlrf55mDw9MBD2VGGkNevGJEX9OtH4=;
  b=RVN58Le2x/mYjIIaUFEAgRDg0Jmdq8IIWy+urvOY4P8qMcj6nNYSWbPN
   kwR64CmzVIxoMl9bnuGDZHTxvDjSLvzdM+KUCeTS8i5eJEmLKU7z+IQ9t
   63/iHh9c3nPnw+itAsPwtk6B6U+RxDXEkXbWVRYJpr71jAAgQvdT5ejv5
   uIblcnj+u4tTO2E0hIGwoZa6D/R6E+1udSPUGNX3sMbBhRbcfU4MCcSu9
   tVIhZ2oZaEkbUHRD4jQYi9tlekhtgKBM4nRzKt5hVbghtcivdnfVLfFk3
   BsERMOBBfmAN+vaTICiD1wGmYjlMcQtD6Sk0Lg+gp3J1l3ojdti8MJcdb
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="89053483"
Received: from mail-by2nam01lp0178.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.178])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:45:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiBA3ZnAFgwZTvlrf55mDw9MBD2VGGkNevGJEX9OtH4=;
 b=PUbqAle+3njoboJoMNkFUiU0I+nwljdvp6AxDTODWHdfy4FlvPvpPUTvrGll2EMHLssrEpW329SinmFRykdWJT53OQRdt+S+NGf3+ApsfAjn7SQbawg1R1L6KW5dsffLzqDHoWr2OAiwJwbY+aK8aE4Ir6j+LpoQVNnDvGhzMws=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0446.namprd04.prod.outlook.com (10.173.48.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Tue, 14 Aug 2018 15:44:57 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:44:57 +0000
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
Thread-Index: AQHUM6ES3j1v2YHkvU2ZLaLIQP27MKS/XWuAgAAFQgCAAAGQAA==
Date:   Tue, 14 Aug 2018 15:44:57 +0000
Message-ID: <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-3-hare@suse.de>
         <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
         <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
In-Reply-To: <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0446;20:cc1YKqXmQ38yuS96UeMO/gNVgmirfHOJHUCJ4PQasFKYU8zVQCdbWTrgiSADSxSFyHwFLEHpDyYHJ+QWTmehShz5jaAQ7z8h7QWgfROWBU+YrQdvmWnQwj8OrnDURiYqN5V5gLYaZSgYy89SypkwJZLTWThBRVnIca9Qn4kMQS8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 81c67651-c08d-4c38-d3f5-08d601fce360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0446;
x-ms-traffictypediagnostic: MWHPR04MB0446:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0446EC291DA07EDE4360C79298380@MWHPR04MB0446.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0446;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0446;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(102836004)(118296001)(72206003)(8936002)(8676002)(6436002)(110136005)(81166006)(2900100001)(6486002)(54906003)(36756003)(316002)(6246003)(229853002)(68736007)(81156014)(26005)(53936002)(14454004)(99286004)(7736002)(186003)(2906002)(2501003)(86362001)(305945005)(6506007)(97736004)(106356001)(25786009)(105586002)(486006)(93886005)(5250100002)(6116002)(3846002)(5660300001)(256004)(4326008)(476003)(2616005)(478600001)(6512007)(66066001)(76176011)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0446;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7b12urTuVB3JKklA7DQy7D/XbOT+UU8ApmLeKyrjymIs8M84QD8gxcgO4dEM9fe29vIw7lfN08DaMUKjuU+9zN/vshX3VBi8PxXxlfzLoTaTDsBR/MGGhA0db7eeh9jqqgk5FbyjPUTBDQtfLGTr75pUifdtwsVMiLsvdu+AV18XOoswmRQTnxrh4B3fOXEnrhdtL5pmR59Ar1AgtF2rnhRdzgIObpt9333BOOtbEfRBkzTZTybsEjgdoA+jhMcNIk2B5cf3+tfri7hRyHMOVHm/ZxI4A3ZCwzvG9ZuvSqnw7AarhzsxRit1/SPd/P7VBJmqPamjUAr+A/BooeZ0nRL3u4IL25bmpeM60OAlgPk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <80F8B67C91C83B4286B77667A349B502@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c67651-c08d-4c38-d3f5-08d601fce360
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:44:57.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 17:39 +-0200, Hannes Reinecke wrote:
+AD4- While I have considered having nvme+AF8-nvm+AF8-register+AF8-sysfs() =
returning a
+AD4- pointer I would then have to remove the 'static' declaration from the
+AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20.
+AD4- Which I didn't really like, either.

Hmm ... I don't see why the static declaration would have to be removed fro=
m
nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20 if nvme+AF8-nvm+AF8-register+AF8-s=
ysfs() would return a pointer?
Am I perhaps missing something?

Thanks,

Bart.

