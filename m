Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79120857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vjd3MD1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB79120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeIGFO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:57 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeIGFO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/m+TzlluKgTSZfEtAIPeSU0X4dWOTOAXBzskJoTDn8=;
 b=Vjd3MD1H+Pbn1l5kpoGcUS61ySG6zxW3sp7c5ei73gdQhp3f9SsDPszFTyRD2K61moyxjGjikKl7umh0ama02cAPc9GQq5HYWUWYjfQYizvjeZ5OSp+JzSDAJrgqq9jSg//rQhA7dBvfph5F+RTHsUK/JHzr0GA0p/6G0/0e9zA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/88] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Topic: [PATCH AUTOSEL 4.18 34/88] gfs2: Don't reject a supposedly full
 bitmap if we have blocks reserved
Thread-Index: AQHURkLJbg5i6Kq/20WTG266m/Ss9g==
Date:   Fri, 7 Sep 2018 00:36:16 +0000
Message-ID: <20180907003547.57567-34-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:CzQnkprkOV2Is8Nlkr3Yc1L+FNtbQWP5hdstLFB0IqwgP1KDK5YG0+p0UDiZVQyWteXrrJcYkel3ZygSPfv/VLqY7lmZmX3Gb3SYD8BuURdItCZaRmnThacW5n/+iPzNRV8TcLjmF/Q0P4z4JWFm8E7rQQyLf1C8S2S3PMZ/UcUNVI7hw6x+GZSewU8RCkFt9JvsqDdRjAbysNDVQ0BBwgZObOh2sMEoSeO2dCM1LudC9ZFKIBIWlxWoAkT6/oqUm0rxk1ZfhKHroHAoB+Pms8VTfqjMAkg/0ampI7Asj9lpFI9znetP0msGvf6/uVVgDmGc8kC9MV1FTEokFhyCcLb/NyYLJHshXmccn4ymTebXFyIYoZlYR2aJBUUnm5qFokevUysJa77HHvDMbCcfh6zMSKGVWS5IYfoxFLygRgpsUX8FULa+KZ3VjmVo+u4nu6NmhvCBCyP1EOAthWn07w==;5:HZFtUmXm2A3ZRVHsFKPqGvPE2ExsKVYIFed/968wLaCRbiI6RlDBJ1IO2AkNrAdQfaNFDZhP39Rbyj/CoS5LQ6J9XB4ae931TLn0wMr6WPwd5MLGRXXHYtkJLoHQM2p474CkY3BRZcRsLB2MXvZZvEMLdx2nwHDZPBTgg7pQLg0=;7:pNfjQ1SoyZwdXOF6d1Ej1vL8ljqmgMslpZa0nZyeWxIgbzd2YboCk/uFZK1PYellsgo2mxwEQ20cp3hKh1oR5UF84fUKnf1ZLoTfA7LKyU0UgfEJsD6D9NFiwoLx2vhqRF3ZJXCfjHZRrqmqTWE9y+VaLCshCxbrP5y7gBTXgt52uCzZJ6QhkCDiyCewQioTrgHTJrX5RmTmhccbm8x5Ovhve+wH2PzvjZ8joQ8RDUryP5ALVvt38O/urEXHQVwz
x-ms-office365-filtering-correlation-id: 9f44d37d-3cdf-42bf-d706-08d61459fd9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046983FEA6E97D4A1861B5AFFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w0VNuPdZliyO/Ycy65UzczXgIIAYyhsMEGRvbzb4vW6l0PUnQVfmDe46SnFVuLUleevAWtm1vcLwIO8TDS7GjdGJbPdSIj5IIHrjmNVrqK0RbQwxLOf+PwMPBtVtRgJkseXX3KIlds+0NVKvPz0k+FineSXU1lMnALoymxZSUsnYqThanldpZypVTwXeQ6T3ajJP9fjSFaaqFi8kN+CKDAy26cRhPv9T0jayLigfVEfyAdpKpwFZqjeYbj0CkkqDRV93zbphbxTr3XHAxSkQ+x/D+5QyEL+aGCvzKF07S+mpEt7PwZ61IN06zXPaQL+cG0ysNUFT1ThJzV2fQ8RAaneZ220zX2k4BOccY0Npais=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f44d37d-3cdf-42bf-d706-08d61459fd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:16.7219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit e79e0e1428188b24c3b57309ffa54a33c4ae40c4 ]

Before this patch, you could get into situations like this:

1. Process 1 searches for X free blocks, finds them, makes a reservation
2. Process 2 searches for free blocks in the same rgrp, but now the
   bitmap is full because process 1's reservation is skipped over.
   So it marks the bitmap as GBF_FULL.
3. Process 1 tries to allocate blocks from its own reservation, but
   since the GBF_FULL bit is set, it skips over the rgrp and searches
   elsewhere, thus not using its own reservation.

This patch adds an additional check to allow processes to use their
own reservations.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/gfs2/rgrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 33abcf29bc05..b86249ebde11 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1686,7 +1686,8 @@ static int gfs2_rbm_find(struct gfs2_rbm *rbm, u8 sta=
te, u32 *minext,
=20
 	while(1) {
 		bi =3D rbm_bi(rbm);
-		if (test_bit(GBF_FULL, &bi->bi_flags) &&
+		if ((ip =3D=3D NULL || !gfs2_rs_active(&ip->i_res)) &&
+		    test_bit(GBF_FULL, &bi->bi_flags) &&
 		    (state =3D=3D GFS2_BLKST_FREE))
 			goto next_bitmap;
=20
--=20
2.17.1
