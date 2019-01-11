Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F420872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IMP24lGb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j/8QQG3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfAKGkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:40:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfAKGj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547188838; x=1578724838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZLztX5OfVg/04YI2TiQs9ZSWcRANPOMvPEBrrClIIX4=;
  b=IMP24lGb+02H339LesKlNpDZ4NZI9CN1hY9kbYLTZ2KnGQGfxU5bnQgR
   YwH4sMfjvp/3xWDefhtKtzMqU7iX6+6xYULuprxdT4vCF1rG1dX5k91cq
   Ns91/e3LHQBd2dNqjUxTO8/sE3tzXcjobDNJcZ33umSYlM04XPjb8N4X7
   AXUu+rzeqRRPtSWnCRS0AYfgiHoMCN2ndfkLgu5uAkXIgdDzv6UZabu8g
   Bt6Nviri6j81Pv1AA3p8GmopfZ3odizzn1HoVWhTPllHHJZK6T/fBJ3iW
   iKat29ZS5RDCOOmqcVxaKFmTQBjcgBNff1LCPM7xi2taEqZIQH5NrZSGG
   w==;
X-IronPort-AV: E=Sophos;i="5.56,464,1539619200"; 
   d="scan'208";a="196561864"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2019 14:40:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4IsuYaZ+Sjnk95TUL6/4EYWA0pZ3w4igLRrcc/uENU=;
 b=j/8QQG3ZrYwIyG7j0vE8LoFj3GQgJ5EkOq9Ee/PA8U+k/58Q0uOaaTyAO571Hl9otLJemZ166NJs8IrSl7Z5PhCcwLMxx+D1k1r9obVm3AtM2c5jTr2kOuzuQDExGX/szNHC5L0E5tQBHNE59xBGnDV6gONXk/r7NmUXVgUvBFI=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5136.namprd04.prod.outlook.com (52.135.116.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Fri, 11 Jan 2019 06:39:56 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d461:bbc2:b03a:d4b0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d461:bbc2:b03a:d4b0%4]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 06:39:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     John Stultz <john.stultz@linaro.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>, Wei Li <liwei213@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        zangleigang <zangleigang@hisilicon.com>
CC:     Evan Green <evgreen@chromium.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: ufshcd_queuecommand() triggering after ufshcd_suspend()?
Thread-Topic: ufshcd_queuecommand() triggering after ufshcd_suspend()?
Thread-Index: AQHUqTiXOPRGAdc4fka0CbD/Xj7qx6WpnjmR
Date:   Fri, 11 Jan 2019 06:39:56 +0000
Message-ID: <SN6PR04MB4925CA2AFE5F060469E6F018FC850@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <CALAqxLURfQcSy2w7F7NCPtGaChka4U5LmvufLd0VZ73S=AzHkA@mail.gmail.com>
In-Reply-To: <CALAqxLURfQcSy2w7F7NCPtGaChka4U5LmvufLd0VZ73S=AzHkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [213.57.170.193]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB5136;6:crpTj8el6Yhl1E6IF/EjnDfR/drYDB3oDLo3eAAIUSOduUXtL3j0MDO9kdUE4pHCtVRsZGQeFxz7XlcK0Yi9cHnhcMr1JMXl2cCJlj3bsA35deWWbihxZ2EwMyM4Vn9MFia2WcbNy6U9BtSq/iXWoMe2oAGOymjauXXT3P82EdL+b9t4oCL+5O/8gqnodRvNGenUmY+f43sj6PZzl7sf1CroOwGhUdCD+5WMmtGJTni6YzU965uOhAxs8GDAAKBuQd+4D424MBKEfmYbwuWr2WGriVEcNLlXB3/3kXO90O+2uaRvJZmvYWXEc3qKmUUEfzudiFC4stj2H3EBHaAssovsB1VtoVAor9nfy4GYJG+5qJTV5l/rhneIUcDejlNzMyKflhxnfs7V2RgoFHP0Pb8OMpaPcCXGFKiAmNQt25NJsMZASYqihIC7LA/9k1QDf7QLQdnQ3VvIcE0rDIc9Ng==;5:AdjymzCcOR/5A+0D7lSKW6BXCU10onhmBO64MaSduseBpLa6giYxecSNZx48YtGKXfMJkmXMAOJHyFL6awJOwgYB4M7gVFxoZMC0u6QHB8wHzj6tCL720ahUGQwngVftCScOsegtvaO3TRtHP+L7iQmWsxbOPMIhr9PbwYrHjOIYL/NgNV95l79iHhx8N3Ow63H2kGOy8wgPMZdATX0tow==;7:Nn1EeZrjh0ZPwa99fuBHZt3hPfxls7I32NG79qPv3CImevkNx6tb6XzKtFtCjD06sIe4CE0NXtR+tDj605hv8jsjFqUMR2LZF+/U8+xG5d5X4f2eT/R05K1GYKecuolLAssbLwbDlIBBHH8mvsRCUw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 792063a5-8133-4c8b-1c4f-08d6778f9a00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5136;
x-ms-traffictypediagnostic: SN6PR04MB5136:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB51361273C3CDF2517A7629E3FC850@SN6PR04MB5136.namprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(376002)(396003)(51234002)(189003)(199004)(53754006)(305945005)(102836004)(54906003)(45080400002)(25786009)(72206003)(2906002)(186003)(53546011)(478600001)(6506007)(26005)(66066001)(14454004)(74316002)(106356001)(316002)(86362001)(4326008)(229853002)(105586002)(256004)(14444005)(8936002)(99286004)(97736004)(68736007)(11346002)(71190400001)(53936002)(476003)(81156014)(7416002)(6436002)(5660300001)(55016002)(486006)(8676002)(33656002)(81166006)(114624004)(446003)(6116002)(3846002)(110136005)(7696005)(7736002)(76176011)(71200400001)(9686003)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5136;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HBPf6hY5joUkXUtw+oZ8PzLBVQ8i2MExJNu+fQTr8g8n6W7ERuPSphYHdNI1USX+olinlaE9LFyoeqWzx9BL6T0vuuZ1sRREsOwHKDoCdVL9d0S9sU71NEdTidN5QJjbLovyzw1uOcPwtcZVoKLZ8y8RlF1+4WbHmdtgTNv38HJzjNb5s9hO3KqK/CXFL/C499hWA/5esHBycjppXHHFQlSN4xGnZL8Lp3T56yYGecJnUS2xYUmii6JtpmsHdWwAMLbGc7E73z1ln1KU1UYdAYBaTLpOaondsY5gTy6gkaztYXPTHURzvWqRD60HHGOsmXYjMTB6aBfGUZo/XgcEzOA14Z7QgcP5J8VaI1qxRvHnwYCt82c2XtjutWqIk5Ma3JoxTp2/9FnZRk8enpXqscgDraT49aNeB9SeBurgcQQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792063a5-8133-4c8b-1c4f-08d6778f9a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:39:56.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Zang

Thanks,
Avri



________________________________________
From: John Stultz <john.stultz@linaro.org>
Sent: Friday, January 11, 2019 1:02:21 AM
To: Sahitya Tummala; Christoph Hellwig; Wei Li; Martin K. Petersen
Cc: Evan Green; Avri Altman; Vijay Viswanath; lkml; linux-scsi@vger.kernel.=
org
Subject: ufshcd_queuecommand() triggering after ufshcd_suspend()?

Hey all,
  Frequently, since support for the HiKey960's UFS code landed in
4.19, I've noticed the following warning on reboot:

[   23.086860] WARNING: CPU: 0 PID: 2507 at
drivers/scsi/ufs/ufshcd.c:2460 ufshcd_queuecommand+0x59c/0x5a8
[   23.096256] Modules linked in:
[   23.099313] CPU: 0 PID: 2507 Comm: kworker/0:1H Tainted: G S
        5.0.0-rc1-00068-g3f81a19 #273
[   23.108873] Hardware name: HiKey960 (DT)
[   23.112802] Workqueue: kblockd blk_mq_requeue_work
[   23.117591] pstate: 80400005 (Nzcv daif +PAN -UAO)
[   23.122378] pc : ufshcd_queuecommand+0x59c/0x5a8
[   23.126990] lr : ufshcd_queuecommand+0x58c/0x5a8
[   23.131600] sp : ffffff8015e1ba80
[   23.134907] x29: ffffff8015e1ba80 x28: ffffffc217f94048
[   23.140214] x27: 0000000000000010 x26: ffffffc217a7c8b8
[   23.145520] x25: ffffffc217a7c000 x24: ffffffc217a7ceb0
[   23.150827] x23: 0000000000000000 x22: ffffffc217a7c808
[   23.156133] x21: ffffffc217f94120 x20: 0000000000000010
[   23.161440] x19: ffffff801186d000 x18: ffffff801186db08
[   23.166746] x17: 0000000000000000 x16: 0000000000000000
[   23.172053] x15: ffffff8095e1b7c7 x14: 692064616574736e
[   23.177360] x13: 6928204e4f5f534b x12: 4c43203d21206574
[   23.182666] x11: 6174732e676e6974 x10: 61675f6b6c633e2d
[   23.187973] x9 : 61626820646e616d x8 : 6d6f636575657571
[   23.193280] x7 : 0000000000000000 x6 : ffffff801186e000
[   23.198586] x5 : ffffff801186e270 x4 : ffffff8010096dc0
[   23.203894] x3 : 0000000000010000 x2 : 47dd99afde511d00
[   23.209201] x1 : 0000000000000000 x0 : 0000000000000000
[   23.214509] Call trace:
[   23.216952]  ufshcd_queuecommand+0x59c/0x5a8
[   23.221220]  scsi_queue_rq+0x5b4/0x880
[   23.224964]  blk_mq_dispatch_rq_list+0xb0/0x510
[   23.229492]  blk_mq_sched_dispatch_requests+0xf4/0x198
[   23.234626]  __blk_mq_run_hw_queue+0xb4/0x120
[   23.238978]  __blk_mq_delay_run_hw_queue+0x110/0x200
[   23.243937]  blk_mq_run_hw_queue+0xb8/0x118
[   23.248114]  blk_mq_run_hw_queues+0x58/0x78
[   23.252291]  blk_mq_requeue_work+0x140/0x168
[   23.256560]  process_one_work+0x158/0x468
[   23.260564]  worker_thread+0x50/0x460
[   23.264222]  kthread+0x104/0x130
[   23.267447]  ret_from_fork+0x10/0x1c
[   23.271017] ---[ end trace 45f1ee04059cdf00 ]---

Since the warning is triggering from the WARN_ON(hba->clk_gating.state
!=3D CLKS_ON) line, I annotated the clk_gating.state changes, and am
seeing on reboot:
  vdc: Waited 0ms for vold
  sd 0:0:0:3: [sdd] Synchronizing SCSI cache
  sd 0:0:0:2: [sdc] Synchronizing SCSI cache
  sd 0:0:0:1: [sdb] Synchronizing SCSI cache
  sd 0:0:0:0: [sda] Synchronizing SCSI cache
  ufshcd_suspend: setting clk_gating.state CLKS_OFF
  ufshcd_queuecommand hba->clk_gating.state !=3D CLKS_ON (instead its 0)
<warning splat>

So it seems like ufshcd_suspend() is has run, but then the workqueue
(occasionally) fires afterwards triggering the issue.

Maybe should something in ufshcd_queuecommand be checking the
clk_gating.is_suspended flag before proceeding?

Other ideas?  The logic all seems to be in the generic code, but I'm
not sure if maybe the ufs-hisi.c code is mis-managing something?

thanks
-john
