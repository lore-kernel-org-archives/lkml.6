Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7643520685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MAXcb7pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7643520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHWAqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:46:52 -0400
Received: from mail-hk2apc01on0093.outbound.protection.outlook.com ([104.47.124.93]:1429
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbeHWAqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byniXtBbjd6TSxt/qvY3V6wML9eteI8dM+DyeG2GRYY=;
 b=MAXcb7pB1nTbf0TyVLA7VtB1ahGvoHiBDG9nHfNU/wctUFsN2RAp/uUG+Vue+MYJxGL58ophmmegpE5OD25zHA+tMTw5oeL08CSWAu9pGhn29WZ3zAbFWzReozt5HG1+i68CTLgvnG2Yxg0eLZDh6uNrOpHEmpZi1q1CYecbejE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0188.APCP153.PROD.OUTLOOK.COM (10.170.190.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Wed, 22 Aug 2018 21:20:04 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1101.005; Wed, 22 Aug 2018
 21:20:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
CC:     "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>
Subject: [PATCH] hv_netvsc: Fix a deadlock by getting rtnl_lock earlier in
 netvsc_probe()
Thread-Topic: [PATCH] hv_netvsc: Fix a deadlock by getting rtnl_lock earlier
 in netvsc_probe()
Thread-Index: AdQ6XXUw8kE8DKeUTSmE1/NI7CjYQw==
Date:   Wed, 22 Aug 2018 21:20:03 +0000
Message-ID: <PU1P153MB01692432D92B3A726FBDDC68BF300@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-22T21:20:01.1451985Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:658b:57a7:e905:fc7a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0188;6:uUZR9IV3JhIb2Fw0ZXy2CdRnNB4ejlt/AlQfEVPP8pPN81RyOaiEID7Gy5lOLASn9/q5dFLX1PnM54FXcKaJm3T3T91z9bpyUGR3D60n58Vww8LKmC0qbfxS6jCNxrkNGRzZtkQNFlsDMJEvjuSf02VjeFkRbKnmWzLSZBPQKjVw4K6wV9TS+4Hmd9AmCs4DpYB6HIrSxrTJVSDKvzbXGyZt5rTB3WpWqAly/Xj5/foxzqY22hzHwzI9TH9k+gMLxY4kr2NyQ1j2FpqeBNkX7QwQhQk/qswGT3OqAWnEYY1OEX73OA11BYW7TbSs0vMQNEB2pWpQbus4kqn3BInFywUNCbrrp/byqm5KoJWSXQ4VJ+k+kalj5ICATLqDEo1A66IKoKgNhlom1wzAhX5I1kDdCHXZ+3X/oEk8v0l49DlpgIDQESvS2sUWlfR+/5q3Mzk44lKM9TBzpICxVz0uvQ==;5:tSwkq7nC3odhgEOJ0WYOVJ/j7s5Pib7CwG77Yat1f4U12Mo80Gk7Qz3hJBFtTAksInwQawLbunAls1F95sw0DqnoIbDZS1mQew4mSf+YQmU2rH5S9tq1wV5FDJm0//xGv5mMJIzO85Hll/R48Vc9RfYdsnuv6ZWpEeyoT7tQISk=;7:ToF8WJZFeecl65EghdIWR8ocrFs4CgrVeZjY7G+v+zieBKu+oyZVetkUeISyWzncJKC4Luale3+y0aFBM5xgoJTONka38+GxbmcYTK3sE5xZJlXt2Fiti7CYKf33SM9OE21Bs4H8pfJMKM4i/HHtDLIJK9Uo1ttbs6btUjz6BQaXMM5GJs9wCSpZdqjz2hWDotxEJlax0brLW73RaEPDuppJTe4HWB0mumxnef6ddaVEhIebKicOSom2ZQhtjiSP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6e004655-09d6-485d-b652-08d608750701
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0188;
x-ms-traffictypediagnostic: PU1P153MB0188:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0188D8A0C936C92B0D7F23A1BF300@PU1P153MB0188.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:PU1P153MB0188;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0188;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(366004)(376002)(51234002)(69234005)(199004)(189003)(305945005)(8936002)(1857600001)(33656002)(478600001)(10090500001)(9686003)(10290500003)(8990500004)(14454004)(107886003)(55016002)(53936002)(7696005)(7736002)(68736007)(106356001)(2906002)(74316002)(105586002)(86612001)(86362001)(25786009)(2900100001)(6436002)(6506007)(5660300001)(81156014)(54906003)(476003)(81166006)(4326008)(22452003)(99286004)(316002)(46003)(486006)(5250100002)(8676002)(6116002)(97736004)(1511001)(14444005)(256004)(102836004)(5024004)(110136005)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0188;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tfyr+cmaeegy67xOVcU0eroYXmVcWQnNJUi0QnXgJVI0wvViC+o65Iwvm1e6BF5oqu5OEcxkJ2f0f5mWTTCz8QtZ72nccrbGwI4bNbW51g4nnFuOwYL3coLobpBXsleZ+zEIbL7XHrVlWu8Ivi+6+qkL3/ZtlSmx/bhOtQW+A94shzeasjD3gYpuRGAyhiBB9cbdb70U/+Iom/SLel6ZdoplSHEwtLto/MVLRo0Filz+1VZP5jBY3ftyl6JFt7vrePHu+YtphTAM1LOQMHfPsrhMqL6xkyI7Qb+WVs7Q1MHPtjAjZKTfaoVh+Yi1vD3ebRG6G5E/oYkNMLJ3m/5QKIFFznLaklYWotyI8o4qcLM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e004655-09d6-485d-b652-08d608750701
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 21:20:03.6879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the race between netvsc_probe() and
rndis_set_subchannel(), which can cause a deadlock.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)


FYI: these are the related 3 paths which show the deadlock:

#1:
    Workqueue: hv_vmbus_con vmbus_onmessage_work [hv_vmbus]
    Call Trace:
     schedule
     schedule_preempt_disabled
     __mutex_lock
     __device_attach
     bus_probe_device
     device_add
     vmbus_device_register
     vmbus_onoffer
     vmbus_onmessage_work
     process_one_work
     worker_thread
     kthread
     ret_from_fork

#2:
    schedule
     schedule_preempt_disabled
     __mutex_lock
     netvsc_probe
     vmbus_probe
     really_probe
     __driver_attach
     bus_for_each_dev
     driver_attach_async
     async_run_entry_fn
     process_one_work
     worker_thread
     kthread
     ret_from_fork

#3:
    Workqueue: events netvsc_subchan_work [hv_netvsc]
    Call Trace:
     schedule
     rndis_set_subchannel
     netvsc_subchan_work
     process_one_work
     worker_thread
     kthread
     ret_from_fork

Before path #1 finishes, path #2 can start to run, because just before
the "bus_probe_device(dev);" in device_add() in path #1, there is a line
"object_uevent(&dev->kobj, KOBJ_ADD);", so systemd-udevd can
immediately try to load hv_netvsc and hence path #2 can start to run.

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index 1121a1ec..4fd14a0 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,6 +2206,16 @@ static int netvsc_probe(struct hv_device *dev,
=20
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
=20
+	/* We must get rtnl_lock before scheduling nvdev->subchan_work,
+	 * otherwise netvsc_subchan_work() can get rtnl_lock first and wait
+	 * all subchannels to show up, but that may not happen because
+	 * netvsc_probe() can't get rtnl_lock and as a result vmbus_onoffer()
+	 * -> ... -> device_add() -> ... -> __device_attach() can't get
+	 * the device lock, so all the subchannels can't be processed --
+	 * finally netvsc_subchan_work() hangs for ever.
+	 */
+	rtnl_lock();
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
=20
@@ -2224,7 +2234,6 @@ static int netvsc_probe(struct hv_device *dev,
 	else
 		net->max_mtu =3D ETH_DATA_LEN;
=20
-	rtnl_lock();
 	ret =3D register_netdevice(net);
 	if (ret !=3D 0) {
 		pr_err("Unable to register netdev.\n");
--=20
2.7.4

