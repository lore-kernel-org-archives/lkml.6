Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091FDC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9380421733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Caz0B0tE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QknfPVUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9380421733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbeHNSEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:04:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43157 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534259834; x=1565795834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oUEn9/0NQJ2NJoZazDPDad+sZPOtokestGpTorxDDts=;
  b=Caz0B0tE4xaVASbyWA5FXTp0ViuQ3WhPjoZJ1k68/k/vWfuptJNMlt0j
   c7izQDgG7+kw1QXbY7vYfywj52h/gI8I8qza6EF36GiXUbocwRv3ha2FF
   hTgCAc7TOn7m1ki0nJcTrCrbDs/2niXCCGxIUvO1hVtJHMiix3BYX6ouf
   WNOJcCL6RWH8wuzWklg1SIIqXThZVVh/BSp5MvZvbERwYF7xqOncJatxK
   HbeHlMPOq2/9yn6NSqNxbFuudAOAiIow85CK0q1OaxhNhuk5YFbJVhuQj
   /O2MA3dSG6xBXpAcXPh7icMud95Z0BrS7tCE8WRoSsJ0rFVoe0OpaEsAu
   w==;
X-IronPort-AV: E=Sophos;i="5.53,238,1531756800"; 
   d="scan'208";a="91324269"
Received: from mail-by2nam05lp0248.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([216.32.181.248])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 23:17:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74euITe8nVCEsPujlI3ZHzoUAXj43tNlhlES4gjwk2I=;
 b=QknfPVUHeM1KRc6LqZ4CcZor2s/IIHiWG2tWnIhqE1Sk54v2ktFOvK7nuaDuDkaum077OzNN9fSPRUfUD958IZcUZYAEeRYidli8FwzTI36u98+v+6nYqNIU47NFnHI9FG9H4/AFdKcdDKsVk2S+jxcry2qjFE/YAMYWPynUKpo=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1200.namprd04.prod.outlook.com (10.173.51.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Tue, 14 Aug 2018 15:17:11 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Tue, 14 Aug 2018
 15:17:11 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.wilck@suse.com" <martin.wilck@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "hare@suse.com" <hare@suse.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 1/5] block: genhd: add 'groups' argument to
 device_add_disk
Thread-Topic: [PATCH 1/5] block: genhd: add 'groups' argument to
 device_add_disk
Thread-Index: AQHUM6EQMxiNQwza40etQY6gZ0WgVKS/XHsA
Date:   Tue, 14 Aug 2018 15:17:11 +0000
Message-ID: <712eaa404a1a76193b1a304443dcbae339e53ab5.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-2-hare@suse.de>
In-Reply-To: <20180814073305.87255-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1200;20:WsVBYMU+y1mYEmhNmo2vm9I1lOPBwbueFQoykou4fACAWM1oW4sJmbHlpr+uQKgYrsGt+K5j43cZ/syCHyD+5DsrscmkrH/z3dBe/HH26e+vqXquwUY3VJnQbra6S9jXtc+XzRz0gFrnaCSygK7FUd6+eHsB0fmQSkzitqPOeZU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 44c37d07-c51e-4348-10f6-08d601f90270
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1200;
x-ms-traffictypediagnostic: MWHPR04MB1200:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB120021B39B9F47A894605C7E98380@MWHPR04MB1200.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1200;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1200;
x-forefront-prvs: 0764C4A8CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(6246003)(2906002)(6512007)(7416002)(8676002)(81166006)(81156014)(4326008)(5660300001)(305945005)(7736002)(68736007)(229853002)(25786009)(2501003)(6436002)(6486002)(97736004)(8936002)(86362001)(478600001)(6116002)(72206003)(3846002)(53936002)(5250100002)(106356001)(2900100001)(105586002)(6506007)(14454004)(186003)(54906003)(110136005)(316002)(26005)(102836004)(36756003)(446003)(11346002)(476003)(66066001)(99286004)(2616005)(76176011)(118296001)(486006)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1200;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dhuNSZJTyi7nalrw56khMoBtz7FrIsecDS3QJxiHIC4/PTQx1OZIrYhyHN6T/NoCrIESPk5zGXqFGEXiNoaoCzMcRY3g0roCTsZK2juy5T5sS9AbguKe/8KM3c7gmLXJVXKCh0iQm+bYLGMP9qDZbNUbAby+JCPuVN9OP8iMmNeSQ9KTY2/bb5lDr8r51bS94htZa6O1gSmHAm90tXwZEaw7SqnIXsriNwa40s+cPwy1QQBaPNYNL9c4wOgghWjr03iv8pa8jnUeILfxxvY4ce2P1i6aRs4x9ZHswHe9kB+hbB4++h+p1gx9OxzzHweHttXEicB/D4KhbOYy5oMd1KAzlmjI6nR0OI7sRQ4erE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <3214CBA1E2AFFE4AA0B3CF71E622E3FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c37d07-c51e-4348-10f6-08d601f90270
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:17:11.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- Update device+AF8-add+AF8-disk() to take an 'groups' argument so that
+AD4- individual drivers can register a device with additional sysfs
+AD4- attributes.
+AD4- This avoids race condition the driver would otherwise have if these
             +AF4- +ACI-a+ACI- is missing?
+AD4- groups were to be created with sysfs+AF8-add+AF8-groups().

Anyway:

Reviewed-by: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4-


