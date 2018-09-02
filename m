Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDAC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F64120652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MWH8R4W0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F64120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeIBRdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:33:05 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728496AbeIBRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5Izo7d4Hc9CVOGUM93xzoy8QpbhfBlx4yXQtSOiu5U=;
 b=MWH8R4W0Vlf2mGjWMJDpwi1HAQjbaN0iC4ggl5XAEnLVukgtkgICWoMmoPc/SnuqGgGfq/jSXk3IH7PFUQDwkAglRo8o6YOqVGXXxjW7MNTpULuF5RAhxaMypqikWwFdsvfOxQQ5hxh3MXpqcTSHLMXpbMf2eXVgxgYSjhigp4Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 47/47] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Topic: [PATCH AUTOSEL 4.4 47/47] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Index: AQHUQr8rFzEGsc8Wc0WOhhje9xO0Jw==
Date:   Sun, 2 Sep 2018 13:16:34 +0000
Message-ID: <20180902131533.184092-47-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:MEMRwXz5cWdBXEAS8oURix5DGRR70q2q8gwHLwlkH6KpTq98WV+AkAgzoyrYmTZ+BBBB7aJTQlQ3Z7hxr6pGmNbfOHi8DY+PSHb3Qh1zbf5UkQrm4ePOASfhqauXhmgU9OQErxbLAPcvebf1lDTEHVSYHCDgK42OZfB6J11OpDaZKNjQ8f27V3ayTSbXIlGbLiZA+YNvozEL6pOPHopStD/gIl5ypVUd0H6vPwB1sNAPDkpQizWriIOIWT7A4q+EBTCpUyR/fOgYcbNME6shl7kZsMclzhFKfK59CyHGSx1EjH3lLGjpt7oU4gNxC4qB8MJW90aA3/zpJ8+rGfH35dNK79x5U9XW84oktAmB4bnpkjfz9e6g1MZSs93pZE5B9EcHxVrY0mvTj/O+SR2Cdj7v6EYs9v/tHlU/ID+7sW/lUNTx8RCB6ReYCAhc7h61OIKKef2ujcBmoth3eS1MIA==;5:nqNDQsH8iA2H2frapzsStRAB7ArqEiIu8D2xbT5X+XwF3JbWyivLM5U4VQlYsy5/ZN2f8ybT1h0db7JilgCbSWhHSuvARiZhp5In5B4ei7M1U1NtWRw/uknX+MQX6kZr6lIodGFwnteTbDr7VfEfRyXbLTM8bxei6AtdO9M0tFw=;7:dqDh0fvdCiExbO2kCyZOZ42xUwcQ+69R9cjf7euVVBJzr9KHKeSPo5ruohKFf6mJQu4ok6qFRXbUbk+ngsW5+Ud7TJk5xKCthmAinUChSPzMRyMy9o8j9wCsKTMdvCdb0ysTg58Xu/5CzPdSPNq6/OC+QYpoXVhJTqtp1Kw2JOJwgZt1KB/+D79chmGcgSVz2WB8eWHAfRqBALDuZ4TVaXILHHynC2+PsqgGZLHaQSLesBplPfncNzBIyYYg35Tl
x-ms-office365-filtering-correlation-id: c138962e-a6c9-4c4b-c717-08d610d66043
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167695F3BF5426E450F1F15FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8SSVusUbRBJDerp/Gn8AdDp04OMKT2uHWk63BX2XCtJyiwZRTnDD1ZqGNWkcgNjbouCK/TNSupvDDv8wLuXFQT1LCzg46qLv0T082X8rdUEYcwzYhfK+DYYgJuk7eGRkiFYe5mAk7d5irMpDOnkn9giwvP5SugEvqKJA06JaX0KI11io4RtsHy2zcWRM/3/asVWT11PNaebNLvlu2hIlfAGmZSPHTDRy//zjuRD+ISAAx/E7+/eKiJ9/Qid550HlKPfhQYs/3oRrumwYsspG92IjYK575FTd4W0lT+Eh8cfcZd+2rDdGfs+NGLV9WCwLkVslHD+HvruX2/E9W4P31xuScmjqJvL5HpmrtMVRm8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c138962e-a6c9-4c4b-c717-08d610d66043
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:34.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 109728ccc5933151c68d1106e4065478a487a323 ]

The above error path returns with page unlocked, so this place seems also
to behave the same.

Fixes: f8dbdf81821b ("fuse: rework fuse_readpages()")
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a063cbfe503..8577f3ba6dc6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -879,6 +879,7 @@ static int fuse_readpages_fill(void *_data, struct page=
 *page)
 	}
=20
 	if (WARN_ON(req->num_pages >=3D req->max_pages)) {
+		unlock_page(page);
 		fuse_put_request(fc, req);
 		return -EIO;
 	}
--=20
2.17.1
