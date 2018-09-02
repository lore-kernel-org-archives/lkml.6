Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D281DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F2C204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TnXISXEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F2C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeIBRXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:47 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728742AbeIBRXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHXC8k+lVp2Ptcr+tjFBY+2xR1MXXuJGDpZae8he16s=;
 b=TnXISXEAtU0FZXtSeb4G8pNo0/2H0/owVfOPX2dQJEisb6eHRdEAX0TZYlDDzuFdpOaVTWJmTdjiM16e7v6wAvoqkz5NSLevUasavOiczzaGGMu5TrZaDmaPFeRLL6BeSBGcHJZmot3Li8jbHJ/TJGi+m6BWY+v6hPrYqEnkHY8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 71/89] f2fs: fix to wait on page writeback before
 updating page
Thread-Topic: [PATCH AUTOSEL 4.14 71/89] f2fs: fix to wait on page writeback
 before updating page
Thread-Index: AQHUQr3rHI3D+7voo0qBqBMKeGouVQ==
Date:   Sun, 2 Sep 2018 13:07:36 +0000
Message-ID: <20180902064918.183387-71-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:CBOTKie62zJCaF8zmYM4hbDSrdOn65J7gxW5XcglM6GICA6rQJHcKi7ujKLdBnATDZae9zy4Vw7F991eMqRoMrg7RzPZFG4ni7iDdXSmvDhLwAQaHcbWUk7/kF2EbjK01LcPjoum449t8qcwMSh6HTRVZ4wix1qMz2TDT/TJDcPUc9vZlPvctuMhjGa3TmaycreV4X7hxNm/A/HPezrbpiWD0IdS2CwT+N3qPY09i/LmrVU3tW8wYuoVl+QAjUvfnS9igbtZbctcH7rGE8szgvjUUGnDBB33/vk72QN2zkM4nbQHv7u5/P0wubG+Dhu/We1YMrwFfdu+YHceN+XT0OVqnctZwUH2uO+fL9ROGidZ0aI88wDO6WvOw3kXJkNFmyr8kKwpVAcge3ArvjcW2rW/r4BGXUaAhgqqW8R9SLT9FrFI9PRxyyTkau13ZI7nHpaNcjQLi3eWaEd15ZJGeQ==;5:p7XFEtpVMmQuay5jjImCJNJHOdJUt7lW47qsGdslFwxcfeyCvxFhVwkJwXPaDZ8+y9W9mkFjEx9roDoaxdTsZJTs38bjUGCprvfnhD8QOrQZU08MuLmDksVx5EAptCbmnL33iKq/nEDo1gL0yfxJfqgxgJUx1jeg3bAj8ecGYNc=;7:E8qbdtsx1yWItA6bh8ENs24WPB0tJWFm8/NcYBYNDev1TWN2ZBTjcmG8nm67KSG042b3JULTYd7jKZmXwJhNjivLkDz3G1EK4TKG57k1L5g4bC9mhzrJxKSpUyXISvgh+37bOf/WsnFJIGvG6gylXRSJn5U+IXgSZeX87iFPVMJ9g3PkGrJ+yIUCJOlDdLYi5LSA2WxP/XWmAasq5OiI9q4Pe7yzi5jsRnKzp7fBqQPPMHFiEcJu0C6nlsLfpyzZ
x-ms-office365-filtering-correlation-id: 0a5798a4-b0bc-4783-9234-08d610d51812
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01494741488AF414071F7B4DFB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YccNLHhX2ODUhELi/Izzs1TKt/gRNBnyGC85HLG0YDCBwjJiN0ePnOMNjd2el7nF+fSIKiwk+10lfx5NF1MkqqIFTY4JhaDTpqQ0G/sByZ8dUQwlCB34uhuLR6wmrq6nizsKKl/Yo6okawvFNM4TMuOBuI7o4hxFRDEPrhKhtP0SdMpfgebignnr5X0Pvf3vXIvYqgafQUOnR59W8zYd7JHdCNT+xJljazp/5JrnmECg5IX1n+MtDa0onmTkOg7GohT9vZKuhgiZyFlhl1N8K9VWnUadl+m92jceVpUQO7dhfgWmcz5Keb9Jghungejp+rQ6AWhqTuvNSVIPhu6fRKtSm3SWkCsIT0TGM0b74vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5798a4-b0bc-4783-9234-08d610d51812
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:36.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 6aead1617b3adf2b7e2c56f0f13e4e0ee42ebb4a ]

In error path of f2fs_move_rehashed_dirents, inode page could be writeback
state, so we should wait on inode page writeback before updating it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 295d5505b939..888a9dc13677 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -502,6 +502,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir=
, struct page *ipage,
 	return 0;
 recover:
 	lock_page(ipage);
+	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
--=20
2.17.1
