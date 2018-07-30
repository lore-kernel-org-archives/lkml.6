Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D58FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431EA20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nIfdPOTr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YbYEzjwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431EA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeG3GpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:45:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33277 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeG3GpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532927522; x=1564463522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vbsdYfxlymlnCATrhiXiTaSuIcmoxnKh8TnGn1SYgk0=;
  b=nIfdPOTrBqN3yoQQg3mqJdbvy05r5hwArSBN9n8jSoqUjjGdWavQUnP9
   rsVUVkxccEp+jdVFGAQ9F/NS1FdNS/luCPLJcF7ruuR448gf313ynjGLJ
   pSpelLLbl1tPpA50eP+rMjWbeCL3dBHSfwr59rN1Gu1VCns2q1VdGjxSQ
   DDkyAvajZWIBtAGtqmmy7vcT2ihm/+W8JSYPG9FEWOLpSwOrJhMSJ3wjt
   XqYncuboK3J3XguRpJhJFgl7ey6OUkVsnaNerkMIQs3p3gyRj18mY/B3h
   9te0MPNQZIRChETmPH+GRkq5+pqTJ9VK1Q3+JfrTTl0f6I24ny+LcE1w8
   g==;
X-IronPort-AV: E=Sophos;i="5.51,421,1526313600"; 
   d="scan'208";a="86208345"
Received: from mail-sn1nam01lp0120.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.120])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2018 13:12:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbsdYfxlymlnCATrhiXiTaSuIcmoxnKh8TnGn1SYgk0=;
 b=YbYEzjwqB4ZoXwj/5IgeUAhXKwcEhqEPWUOeIlqPbpvidVx9fzclnYIVcKulzxogJptCZmS4VjdWakp2Wg9wwyrNgeuQl9NtTqOi0ALdE7mdF/hsmoE9l5QWdPsS+2joJP9ThLyF+oyjMownXS+satAm1eF11B7VWHEdvcXyLAI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0944.namprd04.prod.outlook.com (10.174.174.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Mon, 30 Jul 2018 05:11:59 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%4]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 05:11:59 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jin.xiao@intel.com" <jin.xiao@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
Subject: Re: [PATCH] blk_init_allocated_queue() set q->fq as NULL in the fail
 case
Thread-Topic: [PATCH] blk_init_allocated_queue() set q->fq as NULL in the fail
 case
Thread-Index: AQHUJ6lDD0/GLapQ9EymDs3n7eJ506SnOFqA
Date:   Mon, 30 Jul 2018 05:11:58 +0000
Message-ID: <901c4465be0d37b3b8d8e751dc15607c70fab19b.camel@wdc.com>
References: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
In-Reply-To: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0944;7:wE8BnKAtocsGp7y1QkNVRSYJXHExB6RUuC3kmZFDgD6kxFAPG+My8XbcYJHFQjxleZqV1ovRcKCJZzthmI7kwkV2J1tOUrtPGqbYBSnMQnQxCDpansi6CkaFTwXXWKrhqqK2oS+12r2ik4nOoys8UjsJRUxXJhp9vpcoH9KpTVDH28PJ+iRFmo9f6InthVqHfNUaa//xo/XbKioUv9Tta1zyY7Jdzwb86+cBfmEpBwpeJC5kxRSKUcpT0ZdCImNG;20:ief79x66Sd0AqiBAmIml1juw+oVd6JXFU89xEUQiWxyw+c8etOKKJtWyRixVNw5y3s4/4GabDNSm8wuYGsm4AzcPUMWJHbACWkG20FghcwWm0APwNw9z8YwN3tyw7zvtcjOMQr3KASoX/Je+Rc8HGPG5sDk9JYcOcp15paNAc4U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5cc24d56-a796-4948-5041-08d5f5dafa29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0944;
x-ms-traffictypediagnostic: MWHPR04MB0944:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0944948BF56FB6AAC8C1EAE5982F0@MWHPR04MB0944.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0944;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0944;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(2616005)(11346002)(446003)(486006)(476003)(4326008)(316002)(72206003)(106356001)(105586002)(25786009)(36756003)(14454004)(8676002)(81166006)(8936002)(81156014)(68736007)(5660300001)(76176011)(66066001)(26005)(6116002)(6512007)(6436002)(6486002)(3846002)(186003)(118296001)(2900100001)(6506007)(305945005)(7736002)(229853002)(5250100002)(6246003)(99286004)(478600001)(97736004)(102836004)(256004)(2906002)(2501003)(2201001)(53936002)(110136005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0944;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C9LflX09lbdnnkbY6N/Xd8K//PiD9esrpxn2CiUQ7W+azED2BWl7TezDF799xXJ3WyYy5KBl2idPtcu5F05qtgIsrnExB1TulTutxMfBEoYlYi1NSn5bRLgFqxQgtNhoyEXxIqaS+bxT252oo1eAf8dzST23hH4kMAcbGOFp1YvbDiT2Vln8Dq56lL8QZHwaGR3spf66RllopKpNu+jd26s7AnXQZRoFIoLaM3P35BvM5OBPg4MweHgQziv+14C3n0XcLLqhCaYHUQj7G9/P5gYKnr4i+i9VoVU5nkzqyP53i2TkAwTaEuoEIs8uc7kp5fNYJ/El7S3jZc7rO0q4jyVAtkLmWBcxlxa3g1Ih5jQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <8C63CCFA90421B4389E7E855423D6E0C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc24d56-a796-4948-5041-08d5f5dafa29
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 05:11:59.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 10:03 +-0800, xiao jin wrote:
+AD4- We find the memory use-after-free issue in +AF8AXw-blk+AF8-drain+AF8-=
queue()
+AD4- on the kernel 4.14. After read the latest kernel 4.18-rc6 we
+AD4- think it has the same problem.
+AD4-=20
+AD4- Memory is allocated for q-+AD4-fq in the blk+AF8-init+AF8-allocated+A=
F8-queue().
+AD4- If the elevator init function called with error return, it will
+AD4- run into the fail case to free the q-+AD4-fq.
+AD4-=20
+AD4- Then the +AF8AXw-blk+AF8-drain+AF8-queue() uses the same memory after=
 the free
+AD4- of the q-+AD4-fq, it will lead to the unpredictable event.
+AD4-=20
+AD4- The patch is to set q-+AD4-fq as NULL in the fail case of
+AD4- blk+AF8-init+AF8-allocated+AF8-queue().

Please add +ACI-Fixes:+ACI- and +ACI-Cc: stable+ACI- tags to this patch.

Thanks,

Bart.

