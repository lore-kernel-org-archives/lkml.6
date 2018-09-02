Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49564C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733320841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YJgnLAS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E733320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIBRT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:57 -0400
Received: from mail-cys01nam02on0091.outbound.protection.outlook.com ([104.47.37.91]:41829
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbeIBRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj+ToagI6lAQmuNpu+acXd9DLO1qVrTjGBAZMO56o4Y=;
 b=YJgnLAS5NMsbbTgw1LcBze8leYJq1yzZHqSzxJlRe+td08PjJqeoCoOuvYL61KyVpzohh+DNkzI1VYbsDdN3bBJ2f5RNK5ZodVfLnQS54/slQyX/IMECbkuNMIEKndFgytCb5JhDVUxLUm1sDAOjTSLUyqMXtfnA4+RvthN6jRs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:04:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 031/131] Drivers: hv: vmbus: Cleanup synic memory
 free path
Thread-Topic: [PATCH AUTOSEL 4.18 031/131] Drivers: hv: vmbus: Cleanup synic
 memory free path
Thread-Index: AQHUQr1cz7pXKJBvxE29rTlW6q63jQ==
Date:   Sun, 2 Sep 2018 13:03:36 +0000
Message-ID: <20180902064601.183036-31-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:1HZ//eIzwy2nMhx71doxietvuhXvc46vr6VgO8C/2VLC1lx9OM8VvBeS6S82LpT8sJ+qKcRFIVZhSL3otduwck1jvdYIUrtLbg11WVrMp0JR/iKG1OFhHGjs3Rjc10VKNA/ESfoMddXwlmP89h8Xb3OjRJhY6u1DKaVTJmMmvjIxOWY2t/B0KaiiK2mMwRpcBDjY5WICx2xc/ptV7iaeLHmbnC/AkyKI/mWb6DJ7gIl7TK1I9i3iFrClGkMOYvz2MZjLiMUq9+zAJWXtjvWIInObAyFQrF96v25Nm0FMHxghktcpYXAO7zzrKL/C+EbDfUJwGHFIB4+d2/Gsr5Vt12qT3DCT6HrPFcxfKsyja0jF0UFfitHMbgYJYEQeIP53cpgMTaXdUIfyL3i6eZTudmKl6MXGBaTmK4WpmevfGcMBCwbMxLL33DGTwsTf+sz6B7NE0iwSIV9njoBMAXn7/Q==;5:Fib9sf4Ll/Y9nog0A7+E0L7zFmUKYtlJkfh+wEklUhgIBAqbkjgAqRCsTN54hzidk+S1JTRXuacAoAmORGy5c8Pqpvh8sbAem6FcydWnCiMQDr4+Uz5LmbNc8+IzT4xm8w+GvL08jq+taOHo0iiv8Bu+jpbPKdXqO7gJhi8LMLY=;7:iuKduvWV228aKLMw6CGqF5gVD/a5AnV9WyK6jWMo94zwqQsqgP8wSg9Zu/2Er3vnQEEoDWw5Ov5e9yzECzX13FJVtKyEd33UEzvgbsVRjGVKXZn2mR15390raSbbn24kqOnfPnfPZb+TZb+SzkPYzY6GEVTKMhYAgTfvbdz7wgmX3ilPB+o98343iNcixN81zXRxhS7lzZkee/t3WjXzuWNW22dh6P/pHXApSvoWrvEdN92Pzk7FTLIMPRZZ8f4h
x-ms-office365-filtering-correlation-id: 2132288e-7fb1-427b-a4f9-08d610d490e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150FDA6E6457CA96E3C7AEDFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(6666003)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bwNLCM80FUQJn66W1xJAOm+41DG8bqyLSpuv+RZNtyipKXKhjkteT4MnKbkRpQKA4YaFz4PRgNGvJALjkkk7V4y2xEOEVFEKbTrB14S6PnDQ+ujQPhQrRgEmojVLH3r3E/Vy2vr0mF+ULU4SpGNenrVJflRxID3ozLc5tJKW/ekeyuQBgCUlBHGicmt0zAQ0WgS1o+NrlUll0fXGi5vCGd2WTF5gyDEmlybkvzU+/8MNiVbzv8ViVxue1d3h9+acZf4DyycGCG44zlgOk6cKHXVXIFJFfu560Xci9ix1ty9dc3MPbUt1zC96YyXQNlUIN4gpt6n5Rb13q1vqrYxnEWwZBcraQ8ldqjp7+GFJCyw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2132288e-7fb1-427b-a4f9-08d610d490e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:36.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 572086325ce9a9e348b8748e830653f3959e88b6 ]

clk_evt memory is not being freed when the synic is shutdown
or when there is an allocation error.  Add the appropriate
kfree() call, along with a comment to clarify how the memory
gets freed after an allocation error.  Make the free path
consistent by removing checks for NULL since kfree() and
free_page() already do the check.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hv/hv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 658dc765753b..553adccb05d7 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -242,6 +242,10 @@ int hv_synic_alloc(void)
=20
 	return 0;
 err:
+	/*
+	 * Any memory allocations that succeeded will be freed when
+	 * the caller cleans up by calling hv_synic_free()
+	 */
 	return -ENOMEM;
 }
=20
@@ -254,12 +258,10 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
=20
-		if (hv_cpu->synic_event_page)
-			free_page((unsigned long)hv_cpu->synic_event_page);
-		if (hv_cpu->synic_message_page)
-			free_page((unsigned long)hv_cpu->synic_message_page);
-		if (hv_cpu->post_msg_page)
-			free_page((unsigned long)hv_cpu->post_msg_page);
+		kfree(hv_cpu->clk_evt);
+		free_page((unsigned long)hv_cpu->synic_event_page);
+		free_page((unsigned long)hv_cpu->synic_message_page);
+		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
=20
 	kfree(hv_context.hv_numa_map);
--=20
2.17.1
