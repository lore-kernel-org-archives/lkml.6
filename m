Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF33C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8148204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FMpuAoKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8148204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeIBRXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:52 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbeIBRXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVeOrQYO3eucW/RVsoq6RNXdSkvDNHIRynuyRohbJ7Y=;
 b=FMpuAoKKiF1s/edFu6NbWbg9t9NomV/UyEXn57mLtmC9btEbONlBVq/020zOfKGdJG4FcnbYsxm1AQjcvYJ6MON4d3irDwn9Up+vtZutmmYXBtpiC9wl1gJIdRAl3uxZU7YRwdwjRMjw+PSAmuBM3zOtKW7fA1wPYoy7E5yk87Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 72/89] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Topic: [PATCH AUTOSEL 4.14 72/89] f2fs: Fix uninitialized return in
 f2fs_ioc_shutdown()
Thread-Index: AQHUQr3ror2pfH7h00On5Evs4X8hqA==
Date:   Sun, 2 Sep 2018 13:07:37 +0000
Message-ID: <20180902064918.183387-72-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:4xJVtUuU/Y26G+aaCPu0IHQ5WDejjsqRvwSbTdIb/6EBBO73LRSDZ5R9tsyLfE/5S0f3MrzWuu6kg0vQYm9LV+rlKXLiTovRxv3YwpseHy3xrbOlpKcD82YecucamzC4fp1LwE6c8qNnxvGO+wgLXbGZgCYDSIBO2bQUXX8sAuz2ZWaWp73Ydk/sdF5YtC+HQmjF3t9syrGGQ38E+t4IAzYyeinWnaumvGL0L9UUwxnJzzownFBJLhR7dIsKshZnwdBs980Va6yEEkowSfg0+wGvKNRUZPYdCsZwkk5my2d6MGzXOo4r7xmj9vOWzi0z7kWIKPFyQHzgCpK182w1iCfSvstlBfQg0aSVvjbh3UoETMd2OHKAdxHMLcrB6GV6iiz+0rdKxmzTIEvBfpo1zVnjfhLph5XUZhJVsGfF7euiP8vNYQwlebmhb87yGiXyVpm/pnD3yR0oEPoh9nwU+g==;5:c8cLc+zu7vZXyqvCCDPJtW3+15jX+tUjUTIGhico33D6WqAiEBVln/LthDSRH3wdSUjtN2yyc6g07xqaAFDEliECGrpe2aFsefAPhpWOyYYedkAvrywBqxEP08yQOer5urehP6+p9Y8qbbCo6daH3Np1XtK5Be2sZ91wbs+WEmg=;7:cF3/GB6yy8KiBjrC4LBHzb72ingKku+lIz4JIMCphhSZSK9IVwPHboptikrslhm1AElGqNuK9l62LBBu4epYccdrogONNPl0RvH2bf/WE65426b7+3WHqfvGwCWyhdte2jd/j9c8W1RoK7F+5XOcJ10xjnnNRW7pH6r4eI4i7D/DlV2alRJhwc2d3ME3vf17qicAPE1GbfqOISLTqyX7SreJ5FgPBAx74d7VV7l4q2hPxpSU2Juvqy1wBZp7huWk
x-ms-office365-filtering-correlation-id: 89f8358d-e35a-4ed9-f194-08d610d5185c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149D5F55EE8372E3B1D5D71FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(15760500003)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LGWlzBDXACTtNB1TPCXdAWdv0AaxMC77UegZlRLrd4doPrcJzFEosNGdEFOIBj2L+lDS5HjjDk6q8XXez8CEGpnyOGr8Lkamd3qjYsTV5GtuBJBfQWJ3fVtdzHBip8RiEGE1744XCTpsDUsvFnuWJjXBEoF2xdv61wlMwebLN1P6JTUw2K8LBld8oVUGkoNRkFn23XNzbn5rmSBWMQbV0YX/LtTp1S+k7rYj9X5T9qjV8XGiztMBvRrSCAbVcUf1t2Gh3IP8svIaSfJrx6z2oz0073sxVmENPMkSJbau2El6cwAGQLaKvXAgMmiQorfrRV2454jtwq/W0uZyblUIrTp0RGAG34t9nVmZkAPkDOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f8358d-e35a-4ed9-f194-08d610d5185c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:37.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2a96d8ad94ce57cb0072f7a660b1039720c47716 ]

"ret" can be uninitialized on the success path when "in =3D=3D
F2FS_GOING_DOWN_FULLSYNC".

Fixes: 60b2b4ee2bc0 ("f2fs: Fix deadlock in shutdown ioctl")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 87e654c53c31..6f589730782d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1803,7 +1803,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsig=
ned long arg)
 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 	struct super_block *sb =3D sbi->sb;
 	__u32 in;
-	int ret;
+	int ret =3D 0;
=20
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
--=20
2.17.1
