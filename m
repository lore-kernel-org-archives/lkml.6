Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499F22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IZ51arw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499F22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeIGFPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:51 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729396AbeIGFPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqZ/F6yjKWIjkwOng+G07hfP59lQblL8XPaRaHzz7dI=;
 b=IZ51arw+TFSue9O68o8N2Vo56Zg1bWR1i22RN3OaYUorEDo5b1nM+YyrXc0/PLzXw9fq6RQLVsdSb6/PlnRzaAwMpkKQTSRq/rr0/MpJhCbyAJjzO1xwnz0H0CpDWpem2urx25s84clPZzhIfRbFKjh/C4Vk5IbRtSK1jWoVfcY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 77/88] drivers/base: stop new probing during
 shutdown
Thread-Topic: [PATCH AUTOSEL 4.18 77/88] drivers/base: stop new probing during
 shutdown
Thread-Index: AQHURkLbbvxogz6HbkyKxoBRJ4pAdA==
Date:   Fri, 7 Sep 2018 00:36:46 +0000
Message-ID: <20180907003547.57567-77-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:WTWgoJUlJo7Grow2bA9N3+gJqq1B+gbPzUteuejboIQtj0Cw8P+Wnfg2JATmqVEG6Mx8qkgB4MAjOVX9vuEXJf5HVzAewrpx4n3irX+D0+sITI1bjrjjvQHmmpr/RTZhV+1pkRdRAGrCY3xhkMt8sNVERHdsWDYAYka3s37GWQsHMw9x8rq+7DIMWXQPqY6P4vcF5JcFl22wsX+5JdevWEXm+xIbQuzhvvFGxmu6xps8oiLllLh7jf+BuW07Q0MVn4f4uyCjKBdzb98Q56d8LRr2Z592bNqGAHAMPbN/THQCIbgSfUSwAygIb0ZzK5+kPJWky8iZqv55K3w+RrOWwg/4UzFwIsZAc9D1kbcwsDo1MqiYk21LmBYRw/SajLQOf9IzdENA7RinjkA5W8VL/+CdRj0e/UFLlaPvU8dN4OY762Fz3QLqq7Wrck4uQ5+kA2FjnmeCgql3F2T5PG5gHA==;5:uOzEj8HbIiyDK/L86jtBoSIcO6WzfHDP83pVCl95R5BRVQeB/1kpGszKKg4f61VkEr7ZzRAbBOEjpfymYXLxIADJN/RH3SUOrR0vkEYO5JlOhiB0vv93tLEK1YaE07rt2agt7VnWmULT0ReqmwUJIxWbW11J5X56rp55vdVDATE=;7:UWhKouGzRoxG6IK6Fb2yTxl0AZpn2+cDG04CNVvi94Y6yJ3gGLED8rWpd71OJ88Wsg1IdtI9tYzztMTdMGhnlUxdWIJzpKABBTXFDSUBKlsHi2a54ydG0vNeMRSEDmjht1BkNDBCNVuwVKZqetMDOty7zaOmddg7xKp4USIOv296VD/BeHw1o0wyu4p3INsyGYbE45yFQYmdub519vQ9nT7P+xU4gRuyMb34b4AICnWXHEtVndWC8AovdOymS1bl
x-ms-office365-filtering-correlation-id: cecf63be-1af4-4ad4-4a4e-08d6145a1bfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0118E65475CF979BF093971EFB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(39060400002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P0S1vZomuAtTK6wGEu4T/LhNfVlAkd0wOT2uAF/WPPoFBO1mumXeQYZj/Jb6CAXomG5EdvfIMy1z1eObT9Amh/uNwzq6f2gu65SlXocGU8ehvd/WrXTwlgtK0LG9BQ2VUcs/vQ03l8zBOS4DZi1XYLHgkyieLf+6vA5Ij3asJ+NeviNT7kEKCiqtgfJZfv7RnLloEYIhDTVTUHnz6A7AjeCUFXnj63a1me4vb1vot15zprozabjXT3wLgs/5Ajq7N75UPe4J0SgOzL4qmHUJU0uKSzhnWLuUSz8Ex1gCdjkZ/QKKKmRJWrY6fMAjsyk8Gya8C5YScR9JPdKWy4DOwKMq/UWofJglpEI//7IgwW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecf63be-1af4-4ad4-4a4e-08d6145a1bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:46.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

[ Upstream commit 3297c8fc65af5d40501ea7cddff1b195cae57e4e ]

There is a race window in device_shutdown(), which may cause
-1. parent device shut down before child or
-2. no shutdown on a new probing device.

For 1st, taking the following scenario:
         device_shutdown                        new plugin device
  list_del_init(parent_dev);
  spin_unlock(list_lock);
                                                  device_add(child)
                                                  probe child
  shutdown parent_dev
       --> now child is on the tail of devices_kset

For 2nd, taking the following scenario:
         device_shutdown                        new plugin device
                                                  device_add(dev)
  device_lock(dev);
  ...
  device_unlock(dev);
                                                  probe dev
       --> now, the new occurred dev has no opportunity to shutdown

To fix this race issue, just prevent the new probing request. With this
logic, device_shutdown() is more similar to dpm_prepare().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a44707a..3aba4ad8af5c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2809,6 +2809,9 @@ void device_shutdown(void)
 {
 	struct device *dev, *parent;
=20
+	wait_for_device_probe();
+	device_block_probing();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
--=20
2.17.1
