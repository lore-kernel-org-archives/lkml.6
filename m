Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E832083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DeOuo5VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E832083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeIGFR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:56 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:43908
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeIGFRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTvsG1i5nhZi89yvxemT3AZ8d55HBGOk/k6RWekzlP0=;
 b=DeOuo5VVBpdCAtelCSNudpBLeFC4Rzgw86Whc6T0L0EdhWA0gg8FvJTHYMRv6WExLZ5V2kmNUB4iSz6wRLdjOIZmSLZxrJe8JLhcH1u4TlsCjsln5Z2Mn7B9HfCeoEt1S5HaJLd5QF026VJcl+kB1Gqpd8D0GyY68/E8DR8tVGc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0695.namprd21.prod.outlook.com (10.175.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 61/67] drivers/base: stop new probing during
 shutdown
Thread-Topic: [PATCH AUTOSEL 4.14 61/67] drivers/base: stop new probing during
 shutdown
Thread-Index: AQHURkMKg/VAqsAZc02uoVWG6Df8yA==
Date:   Fri, 7 Sep 2018 00:38:05 +0000
Message-ID: <20180907003716.57737-61-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0695;6:QBH+IIfgrfOMjDhh1Pbr91DpxhlhOxFtA0EdCyUkaOAKdnS6g/PejG/GiL/rWJPgftOq5pM8w/gN1ZpysNcIJtRljmCZl/r53tCgKyvufaVFqL6EJcOfOAi3YATfu7fqhqpp5z0OA+H8fTlcRs5448wBoManIsVMeUGSwD/JnjjOkQUW8exOsFsvGbMbRNZIRs6PvfEnFKVEHZbwwUXs3Y2Odih7rXbpfdKAHHTRpHPD6BvqZJRChLcLEW6HUslMKgLdTEdC+sFBw2VPXrhludYaac43sxHKpLl0iqpyyCchB/Ullcq2HsdKcRz3/+qgWbSCRJ8MtPxJwdk0YDbSiPW0BZzlCMX0hG8/9rehhZeBQCssaGYF178QoGcRd4pNLQ0jwMagk580PLwfbJJlPEgT9YfEUp1lBCG9jc+GQRRruX0UDcGr8UT66w67+Deopx+dDfnmFJt581HBlZ5BTg==;5:3ND3CJrAoJjUYxwQoGUCgd4hz451fiQ4E2G4NkYOoZJ2TNGs9Ukwg20fzRepDibcWwm4lP+kR+JmhW8WatzDMPWAACM5V35manoxlvxHwcYUVTPHAXcS0+J3mqTNIqhn81c6Md3uz5cFDVmoavF4b4QYZxwOQG+EdApw7O+HLbY=;7:axAQkYQl9GunObVdI44vQYsCPpWpFxfRqeRibkAZBTUEOAA5LmYZx0CRq477cM71qN2BX4YMNVxrt+JzWAuPJ0gspwVjlCCdTIsk1sT/T/jailVsvIXF3plOikQlnohKtsJcCRsnwtbXFrHGb3n0ZVXNUAtRxN9AKfmCInu3lpzvPqiKVMgXN4uWXq4Kvcwv6Xc7wNdxGb+um4jHM8cAhplgPSn2ytdLgau62GX07H2iZqxgLdA/Cd9Kq4e78RRu
x-ms-office365-filtering-correlation-id: 0dc7fbd1-9732-47bb-3e37-08d6145a53b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0695;
x-ms-traffictypediagnostic: CY4PR21MB0695:
x-microsoft-antispam-prvs: <CY4PR21MB06954E42501DE425D55756E9FB000@CY4PR21MB0695.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0695;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0695;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(14444005)(99286004)(6486002)(5250100002)(256004)(6436002)(8676002)(81156014)(81166006)(2906002)(10090500001)(97736004)(2900100001)(76176011)(305945005)(7736002)(25786009)(36756003)(86612001)(105586002)(22452003)(39060400002)(106356001)(4326008)(66066001)(476003)(2616005)(5660300001)(486006)(6666003)(446003)(11346002)(86362001)(316002)(8936002)(6506007)(6116002)(72206003)(3846002)(14454004)(217873002)(2501003)(6512007)(478600001)(1076002)(10290500003)(53936002)(68736007)(102836004)(110136005)(6346003)(54906003)(26005)(186003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0695;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: SGwIBRnhXD78tMjexUthYh+940zV63GNTrx/7BAxlEfz36dgcdGtPecgbfQcOKTPV5RQVVZ4pdmkm8PSQo3UwVVmGdte65DnAA8QDhid6X5QGM0X3tiMzsrfXlkoUCE1aWVNSFovsD7xEiroyBtavkz3RKSCg5CRTebtSIuuOFprB6UxAySFK3kGVOooR17Ow9Tapk+IYP31uH8wtomY1cs2xlUHSPQ2XqvvGxdY17jzjOs2MBmmhNS41hwYSEGvsA9p+GvlG6UBTKC8OnVPqTIhxvy5xdM/xEOsxmq4pruJNr4FGrSzegvIq8goGDzcsqMwJZCjKbskTZs0fkkyao8Bf0bemFxpviD3JquKuxs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc7fbd1-9732-47bb-3e37-08d6145a53b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:05.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0695
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
index b054cb2fd2b9..eb066cc827ef 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2783,6 +2783,9 @@ void device_shutdown(void)
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
