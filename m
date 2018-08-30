Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A02C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881E20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y31UjgAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH3Jmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:42:50 -0400
Received: from mail-hk2apc01on0132.outbound.protection.outlook.com ([104.47.124.132]:46832
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbeH3Jmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8RoZqe2IFKoCKa8n66oPXEIX6G6W6ZwMAmuqzVg2Lg=;
 b=Y31UjgAzsFOXtoD4/1/YRpcf7kzcOQyacMtIqHJys9EknMs/emvsawOq+VY+cjQaIKx2fwLvc5PpOaI0LXDqlQ+/QTz/J6e9fPhFObQav/y3u0WvNx7JZJun0yVsARgZxPgLyc/12Mx9DkLDFwAeReDt2vUoW+Dkxwe5ouuFpIU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 05:42:14 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 05:42:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: [PATCH v2] hv_netvsc: Fix a deadlock by getting rtnl lock earlier in
 netvsc_probe()
Thread-Topic: [PATCH v2] hv_netvsc: Fix a deadlock by getting rtnl lock
 earlier in netvsc_probe()
Thread-Index: AdRAIxmKjYWQfaELQr6eHyvzsPVzyw==
Date:   Thu, 30 Aug 2018 05:42:13 +0000
Message-ID: <PU1P153MB0169F05DF2A05DC39B4BF360BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-30T05:42:10.1732732Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:bdf7:7909:bd8f:3027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:FlXQf5SWtdnS0TpsuNpqKPHE+8NtK26tKDWunZwzoHL3IESNsj7twbsuDcjkuDSkGeskLymo9bNr6w1jNK5ATF0cyZvcx1i07irTUZh5kHOcHL7sUB2mufWBe6m0v3p0dBMUHqxf+RBf3k3nH+ooDOBTOjOpHzNpP4Ff+GCJQARc1WXhexEBwXZuvHF08d7lJxXo++qCx/uJIeQUYNwMMfhzbt5wAQvxP6MMHJ7VfPi7ESjvh4543Ftrj7hxiPns3P+3Y4wLUglMnxwB26uBScUqNi4kNOLSWyCkYknEoWaQQ8v9PtoLY9DBvTg75tppQ24qzlT4DN8fC7p5XgEcmlPtFJdDuZvFUImOVeLxvGgHaepXuzF2TZel+gInF3YBVzW2ZrRGYtbeoixAaq9dDTrbFoDnlhawsIoaVMdaUjn6rwaiPe8p7WXRl/HB+C/LlXVBYbjHjBl1N5gV5dt4mA==;5:2sTrcAGYADwn+DNTTIuvsed/KoMa2eROfejRU+1oIQzzlMDOxV7jUkNF9o/AGlq9PXwfvSXwMo/D7aR7pwKFYkC+DI/pi+ot+vilLtRrLG0g8BTUoevT4dUR9bbc9lCt7Md/KIs2IPYgENH7QustwP/AeNXeRgowBbYAAvaoQQ0=;7:qs2XKIH9XiGPDhfjiNf+FxjC8KVIWWFQDcpAvQiUsJkeTCKTC2EyF+1Jcz0qtdvq41q1i000hmgKdr55Hv+7Il7UeVaHCBJNFKfluOuyNxEJAydzIl70BuPISDaiSrXPD4rN+3JnSMJgG3FP95l5Cbl2ohXN6MyOWgEEnFcCQTKMxSF2B8Gmr0xtWXeB3FsKoNmMYrv/nZmR0MmEqvdKrnhW5nIxLTw/CbqeDCwXVyI4ftj/yAOwYRyUlG0LaIdW
x-ms-office365-filtering-correlation-id: f991c05b-0671-43ed-17c1-08d60e3b56fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01559EF806379B923850E41EBF080@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:PU1P153MB0155;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0155;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(366004)(136003)(51234002)(189003)(199004)(86612001)(10290500003)(14444005)(6506007)(256004)(5024004)(8990500004)(105586002)(478600001)(74316002)(7696005)(25786009)(53936002)(4326008)(5660300001)(102836004)(97736004)(86362001)(14454004)(81156014)(81166006)(316002)(33656002)(1511001)(6436002)(110136005)(54906003)(22452003)(305945005)(99286004)(7736002)(6116002)(55016002)(9686003)(68736007)(106356001)(10090500001)(2900100001)(476003)(486006)(8936002)(2906002)(46003)(8676002)(5250100002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vNOtxTwa2A3jyBDmcCZugPcxXjZF/PbuqI3gHAUhv0HraMFyvX9j+uXJfgZfLGutwfjVzHTTjL2+X1swBrsbqbqdmRp/Fr6500lMVJUmQW3GPOblKmAjGaGRA7AJ0diH2Q7BnbqTVtlAO7f9soB4WBpM/5RRM/9lLNGg8naOrrbsUcLMU2Y/TVYafIIylOAyhRgHhlaMzVjua+c9jCUj3UeT2ofuivkDxR3cq2cZ6BvYwP6CwaNqz9olnTiesc450BQezjFTHFUeQyXwGCijXWXSITIPQMoIcVSpiN+ZcXXksLR8l+dip1pSgDG0xVq/00Wq1iItc1BQ7w1OzO+eWp/jm15hj2d70jWLq6dSDqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f991c05b-0671-43ed-17c1-08d60e3b56fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 05:42:13.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the race between netvsc_probe() and
rndis_set_subchannel(), which can cause a deadlock.

These are the related 3 paths which show the deadlock:

path #1:
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

path #2:
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

path #3:
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

Next, path #2 offloads the subchannal's initialization to a workqueue,
i.e. path #3, so we can end up in a deadlock situation like this:

Path #2 gets the device lock, and is trying to get the rtnl lock;
Path #3 gets the rtnl lock and is waiting for all the subchannel messages
to be processed;
Path #1 is trying to get the device lock, but since #2 is not releasing
the device lock, path #1 has to sleep; since the VMBus messages are
processed one by one, this means the sub-channel messages can't be
procedded, so #3 has to sleep with the rtnl lock held, and finally #2
has to sleep... Now all the 3 paths are sleeping and we hit the deadlock.

With the patch, we can make sure #2 gets both the device lock and the
rtnl lock together, gets its job done, and releases the locks, so #1
and #3 will not be blocked for ever.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
---

This v2 is a resend of v1, but the commit log is updated:
1. moved the text after the --- to before the ---;
2. add 3 paragraphs to elaborate the deadlock.

 drivers/net/hyperv/netvsc_drv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index 1121a1ec..70921bb 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2206,6 +2206,16 @@ static int netvsc_probe(struct hv_device *dev,
=20
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
=20
+	/* We must get rtnl lock before scheduling nvdev->subchan_work,
+	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
+	 * all subchannels to show up, but that may not happen because
+	 * netvsc_probe() can't get rtnl lock and as a result vmbus_onoffer()
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

