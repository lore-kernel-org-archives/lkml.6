Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D773C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3272083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R25zJ8R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3272083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeIGFZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:25:16 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730522AbeIGFTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auTMMH+6Pbdif/D5AxZRHLbL1kwPzH5nUs2si6mMlwQ=;
 b=R25zJ8R4LG5iB61zsi2zp8lPTOsylUfHnMnSX6fEXGSr5+/me/y+G2c46fo6HtUebkLKsavdea/ck9s7eOT8gVksvcfT19chLKDZkB3mCYLjcNfDbo6CctNOzR0xWgJDf21bLHVZPQuUeAAZPUxv67VZh/Z50VVaGjM9dU7YMLc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 41/43] drivers/base: stop new probing during
 shutdown
Thread-Topic: [PATCH AUTOSEL 4.9 41/43] drivers/base: stop new probing during
 shutdown
Thread-Index: AQHURkMjliTvKNWoVUO6bL9V8OlRZg==
Date:   Fri, 7 Sep 2018 00:38:47 +0000
Message-ID: <20180907003816.57852-41-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:iS3x/A5PTSIu5lifgBx478HVaoP0U0uzJGwclKhUYFaDU5CizHlDdKbi+sPK/HUUYRXy6zqjsxjzvwikDUHnbOdQZe8SjGq3lt4dDZnZynuWQoSMuVQVPjEPKVZk96bayyIjUUaCljPzYij9LdH+LBE/zaQN9d8U4rvb0fDGfpbyrHyEC0ecpnwkJNAV4xetcdsPmISTimNKpWHr7c1zJb6w0WwlVcPr4v13L9Z82BKVAX44t1ZgN0ShnC/hj8oO3jZZOjEeB1XSZ+n5PrfKLplRaUQPvvTkFT6sZnNWpbFdJlGyvfalJjo45GCFWs70ZrL7DOe/GmajkGSVcrIeL2YJyOL5I7toQXJ7p3hBOdiYvNkLH06H+hA3mtFrzFb8vVmG9P5qbq9f2ikHB0ZT/TropfFq2STa1YTvQLQ9KkecA4TVMuinCUpY5xre3+T1ELKLEtPbagPfpRB4MtjwDQ==;5:pusX+2zjcbpG1altKnPy9hFbXMW5SJXuONRh5F9twNFzqZkX3e31ZBCOkqbiw3UFyc2oOS/3b39URsFC/PcJvlTeUM4D67EkxYJnu4TNrlN++rfygg+1gEcL27SrNzGFOmmQ44vMm/v79e8unA+c+R3aEo8oZbzUd0iaz1xj/ng=;7:j/PyIgNlUtTw0+dFdIWreH+GDMSA+/4V6EeQHIFy5zqf4Ivk+6P9ZCgfuxez7X20vLw0IYhvWZdK2lLaq8lI0PIAx6TIAzuErSW6Hg67vDkaCQFZfuuT5+WaPXmJNL0UcJrlMZnhkZya09jsI/XUcCaO1p64wU4/8Z+XkvaNZWKnbm3LLg740R1Xo5DvD/iZA0ZW4dDTG2bh8akUBFKX5wnxZL0skHlsz10YsD2/zvpILtZ50xP6sXSZqB/pWAn0
x-ms-office365-filtering-correlation-id: 6560da84-8222-4b26-a55b-08d6145aa310
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06943C9A729B4067ECADDAB6FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(39060400002)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: EWboXDWY3RSpQBaOAgUyZIHjHNjpvYLKBr7CvK5SHIBCZxxm98Zb96qDMLq/KL8EZtVAoWf3jAvDwmSNdpV61y3D/UIlKCyy0+zP9O9m2Ra0hq9v0V2Oy77trWoU0mGWZ8sDA/zsrL2tM8qEJis74cAP/VZZsOP1KBmTEwAb8BDaU13lCeusQH3RSPVfhW96zT/xTOkTDTytN8I/1MU1WDYyazMPzfvlwjhLfV7nFO71Y635jHHSS2ui+x7ipwUocd6FWriCtqSoU/3jotwPj39unNjE7Ku215NpDiZR0Axjmqx6zTQD9jAl5cjt9oltsalXgg/Cmp3I2fcdEnCFsf8B/yZ17RN1p3V995L26v8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6560da84-8222-4b26-a55b-08d6145aa310
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:47.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index a0ed957d738f..f43caad30e1e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2072,6 +2072,9 @@ void device_shutdown(void)
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
