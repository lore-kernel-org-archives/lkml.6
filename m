Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A60C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28229215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VBG+/p7h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ojLYNCOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28229215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeHHBG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:06:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29660 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHBG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533682191; x=1565218191;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VkJrJYwmICHWtct/hwFZzgLw5k2hzHOo8OxApPi2Xik=;
  b=VBG+/p7hKFBAIdpabwnJLrSuvGpmHC/yZ/ywfoRjc9CB/EVDLVnkLH32
   EgmCc5Wz9fY52KLnPQP20k4Ot+WaVe6kRhSY1J1kXoWONKymElSniAozE
   jE3P/Kr9o+h5cMSJdzfiK3DtkVu/AWz6U5L0Vcy/yfrL5WKNvUp+TmQio
   9aY94dn8TAJvQVjfjjzRxi8mOY27QJ6Pw4Vy54yoHG8jf9vWkeHn+JEE9
   rSZykj10VXd+9dEmJkgl3U5XIq9K7Nh0a0Udlx3pk+aBFgmcxBra7GiQ3
   KkUTaqFuJ08US2ycQxBXhkm8rbQYe9uVjNRrXfVRNluFNOx5BPFki8wKy
   w==;
X-IronPort-AV: E=Sophos;i="5.51,456,1526313600"; 
   d="scan'208";a="90676194"
Received: from mail-dm3nam03lp0024.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.24])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2018 06:49:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0gyEj+ccVIBqch3XkvCXLQMho8AtCn35UUMVThYa0Y=;
 b=ojLYNCOPO6gf4pwDm+rZGQ8qKA33FJuNbxdIL2tSSzOUkn5ZIs42wBE68lSI9LKfBWH6ZdMi/Xc1j7CUZ0A8eb2UzyYDdqhXJzMRVU+gOhoq8046bDu9RwepOQ7XWgPwfloeqkE7Cgj88HafRLZLek/k97J96EUOqGhD9PeeWmU=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Tue, 7 Aug 2018 22:49:47 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::9117:af72:e613:ca01]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::9117:af72:e613:ca01%2]) with mapi id 15.20.1017.019; Tue, 7 Aug 2018
 22:49:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Tal Shorer <tal.shorer@gmail.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
Thread-Topic: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect
 forever
Thread-Index: AQHULo9IbtFW8QpLZEefyasV3okIfaS04FTY
Date:   Tue, 7 Aug 2018 22:49:47 +0000
Message-ID: <BYAPR04MB4502CA560886C1025B15A62B86270@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180807204239.24907-1-tal.shorer@gmail.com>
In-Reply-To: <20180807204239.24907-1-tal.shorer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [208.115.86.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB3943;20:XANwIfQAWkXQBx37XSL1QkzjAZXyOGDCk5W4Mr/8BX5Zp/ILCWfkdlRoMaReuWiXE6PPOZZWyTi7XNHaH2/2OqXx0gzYw7bQ6rJKqcqG7nUqEX+ujJ0kWL5cz9phWmqEs4TbYsjgldAPTL2foskluUT/MxbGbjKJsaGJOSKoJSg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d605b595-0ad1-40e2-c94e-08d5fcb813a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB3943;
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB39430E8433CBECFC3A2E104286270@BYAPR04MB3943.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(67672495146484)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR04MB3943;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB3943;
x-forefront-prvs: 0757EEBDCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(8936002)(25786009)(99286004)(6116002)(26005)(106356001)(105586002)(66066001)(3846002)(6436002)(186003)(476003)(6506007)(229853002)(102836004)(53546011)(86362001)(305945005)(74316002)(7736002)(6246003)(2906002)(76176011)(33656002)(7696005)(2201001)(81166006)(81156014)(39060400002)(8676002)(5250100002)(1720100001)(2501003)(14454004)(97736004)(486006)(2900100001)(256004)(14444005)(72206003)(966005)(478600001)(11346002)(446003)(5660300001)(6306002)(9686003)(110136005)(53936002)(55016002)(316002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3943;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Raxcay11i2zcMp/YYS5imTUR+PeZ6oH1QYjxPvRzZpqXlmm/xZNpBkgpWSQRg3zQkbjJkAe5TNXAdjIkCryiGTFlaRTjnLhWoXE4dxGKDOqdTuZ9piM7UKtGFec7BDvudspgKBDRQUNsyikWu3y96XOzoU+I8QlMU+lXxNsw1oPT7QG+WTDFOclIr044X86uKXIC2YIAKQoJ3zdgp/VABGpJc7fLh0VdN9J5i2QvWq4VudB81ieKC8BZdzVhPUqpnqHPHZQL0nu/xRm6xy0NyIkOvvr0cQ5wgvkpo+xd7pgyYRzlYJLA+QUiM236TuCV6GeilLIeerkVMCCyArSoSSDq9iXmdgiFXCuHGAaNgp0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d605b595-0ad1-40e2-c94e-08d5fcb813a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 22:49:47.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Just 's/supplics/supplies/'.

Without looking into the entire code, If we can change the type of max_reco=
nnect and nr_reconnects to unsigned int then we can just get away with the =
one comparison (ctrl->nr_reconnects < ctrl->opts->max_reconnects).

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Tal =
Shorer <tal.shorer@gmail.com>
Sent: Tuesday, August 7, 2018 1:42 PM
To: keith.busch@intel.com; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linu=
x-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Cc: Tal Shorer
Subject: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
=A0=20
=20
When the user supplics ctrl_loss_tmo < 0, we warn them that this will
cause the fabrics layer to attempt reconnection forever.
However, in reality the fabrics layer never attempts to reconnect
because the condition to test whether we should reconnect is backwards
in this case.

Signed-off-by: Tal Shorer <tal.shorer@gmail.com>
---
=A0drivers/nvme/host/fabrics.c | 2 +-
=A01 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f7efe5a58cc7..206d63cb1afc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
=A0
=A0bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
=A0{
-=A0=A0=A0=A0=A0=A0 if (ctrl->opts->max_reconnects !=3D -1 &&
+=A0=A0=A0=A0=A0=A0 if (ctrl->opts->max_reconnects =3D=3D -1 ||
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ctrl->nr_reconnects < ctrl->opts->max_=
reconnects)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
=A0
--=20
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    =
