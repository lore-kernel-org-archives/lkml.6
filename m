Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13723C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5279204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iQxQKkDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5279204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeIBRZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:25:50 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbeIBRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZv9eWNc0UsbrqkSG/N3tHuzFhTJmx5+usHWcBFpx+M=;
 b=iQxQKkDrpBMBIBW9c7Vh8QI2rHyBbIqmmvHCude7hY8PEBeS4S6JMhiEMWAyk3OzhS1B6sR1NtdAcymgru8JfmLsi59KjCosWI7mSCAp5z7Q38KDZN4xGwd9pfSR+DUr9eOa54cK79LFCStn8VhCK3lvfS6kbLAUDiPBzNr2KeY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 89/89] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Topic: [PATCH AUTOSEL 4.14 89/89] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Index: AQHUQr3/WwIELFb07UuJCP6HewXjfg==
Date:   Sun, 2 Sep 2018 13:08:10 +0000
Message-ID: <20180902064918.183387-89-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:XGE+EbmjNhMjoCKQWykNRXC8iDhxcpe9R0+pG5R5wC5hLmYgZI9Dw5ZGuQPo0Gske7h8sgu4OuCMtO0BRqCn0WgntDcbeVj0lZZ+SqUoJTi2b/cHZfD7FOPdV5fGybKWmo4as7i0WJK8o9+yv0m8sb9weOF/gqLqvRCZXrdmWz4Mg3DpTBSs1v3xB9Lc5gMfohb6Y6/TQxYT7iiaD+/j1KCZa8pWU5Jo4b7e6GHz9dq+8apYu+csYfv5ySbfC760TJ+AdnAO4X5YRqJi5+uVAmddfSNEVW0HZzcH6aoe1TLgsnIZ+BvSipV0AlLlIuk4sZgLdDcfsqxD8J6NxSFvBVaB7KZatjSBiojsaLdHKmCRZ24UZegdmtRiJrZ8shgDblYjgayXFQjsJW6c1WC2omlBsUk6wZGCkYGvU25vyf71oNcI+7JrtgucvTfffuPQQoaTfJcbWmCMMGKuu18vew==;5:mq4/Q/YOd48vhFMfA0iYY8V3St6jGrbOou6z9wVDoVkGbJgVK5QyPjjyxeKSYwxpjPOG7Tl98N6iGvMP75fzMeafEqbknCU14EGoy42zgVfkU6ZYfa6nFqW5UQVues6RQ5aFn91uA9+u7JIWiP68FgzusTXuRZrsmV+2AuA5wl4=;7:wmEWxX/b8umAiBDzjULMEyI3mPlZkLf9xhwzLEkhLUDUzncvS/yPlfPzGnvoNGRhrueMosfmuf2KjuRj4TCoFQ1RW2WCpI5wcDScvJf3XXi/5N3BuJ4ySBvmyWRz8usvn0EZRW/TkmhZto4JDFMKFKPM6WEw2UWXNiTL1BsPN2YIhPOdtT9FUnw8HccYD9T148fFf0TUJrn5K6FzFfAIw7QxNiQJg/RbyPp/5aqbKyFIaHaE3tN4Q28EUSqzl2gh
x-ms-office365-filtering-correlation-id: e3b58767-72fc-4d8b-a551-08d610d53b53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469E40BE5AE68536AF888D6FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1EuFNJ+rq+TZmN/4sXyHs+8AoLH5jm9Pd9A6jgCpO5o1Yzt/s7kv18wybcXGGPmuAeCjMdNFjqbq1iSHivo+OHn817dcZKPxDMD/+bFmKJsFsYFiCdPyyANAQYVkKe8wq9WRkZqdBPIXdpHMsyMdRPNi6K3+j10nJhjs9XUWp8NpPTulLr3tTeTnddshxh5BEf1WYJPpFYPPeU/uxgBI8nMNq13sSwi/0++bH2x0ktgKS4o6wJIIuscEMmQw7axX92fACUjgpJ5SBx8BaqwUPZ4s8jrRiK1o/iiApqr2ItjHBPBUxnw+rJOS4TFbbK3XjJP6Hf4kGgGxQNMirEkOEXZG+NKR6bwUK/rVgat5Fgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b58767-72fc-4d8b-a551-08d610d53b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:10.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index cb7dff5c45d7..fb4738ef162f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -866,6 +866,7 @@ static int fuse_readpages_fill(void *_data, struct page=
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
