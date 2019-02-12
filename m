Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E57C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8402080F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GPOTefjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfBLL3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:29:47 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:31399
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbfBLL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQYVA43IDhME/ZzOTYQiEtsAAQ57YZJm/IgFCRGqlS8=;
 b=GPOTefjzI3/GKbr3JY4Pib2zSJ3hJc447DXI7NzpUCx7h2D5bhBw6C1gAMi/AFdVr51J/Uv47sTUyqi2IOLn+BrINIVbPMZ8nt9XJPMZLp1Mn1yfA9tP+l8y2BZS09RnMo5d3/EVTl6WQgkM0N3HBCFRKjPUOA0jW5U7DT07REI=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.226.9) by
 DB6PR0501MB2166.eurprd05.prod.outlook.com (10.168.55.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 11:29:43 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::ed9e:f27:4597:6db2]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::ed9e:f27:4597:6db2%10]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 11:29:43 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA: fix allocation failure on pointer pd
Thread-Topic: [PATCH][next] RDMA: fix allocation failure on pointer pd
Thread-Index: AQHUwsVBJSiLJZH/hUKxowAFF3kinqXcBvEA
Date:   Tue, 12 Feb 2019 11:29:42 +0000
Message-ID: <20190212112940.GN21447@mtr-leonro.mtl.com>
References: <20190212112233.25667-1-colin.king@canonical.com>
In-Reply-To: <20190212112233.25667-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0011.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::24) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:82::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2166;6:6KcdFS9JboadlRuUzrYzX8uY8EszmbdHNVD3QuoDiCxzwdgMNJnLrGDm9g0GXTcwQqcN5KnlP8cFSiCFE9K+kVhlf54gSLh7cGaz7k1EtvOdsr+eRsPf178EqdfXtQLz2KZK/NaQNPo8pt5pniWCxdrdCkawMxpiMyDKrFTqjnmrxCHOx2TdU6tJ9stE2BNh3VfWF6LaSuIDu24JjKvlZTGX4IHPWRvzpMGd7fPJMBkn/9apuvFUwiK9UJDMJmG0LomGa7Z2NniR7qJqGwBzQ/K45hrEqzqdQPfk40NKT0ALcdqXLWipMej35IgcqCQtsroFOIpxW7NVGfKHPI3tXaz7P4X8A3LCBJ2Gbh0hQh8DJ0LqR6Yzl1xDLTOxSC0DLH01sxdMmpqiOxWeVFCoYXS1MAFEuSfFj3xB4Ou6+bgG2NneU6V1DPwFFrBlSoev72MSid+8R+4L7nDaIidMKg==;5:0q4rrIwjnsj4XjzlH9FSXvYWQOQCgweZgkoijEGF7EpzPNduK92KXngQf0l0nINHmj1/0agOf0GbheG+MO7cYKRsd7BmF2XRfMwuVlThSok/RX1oUdbmK0Q8GEgRefXxlKXBijHAYhVKs2Xp2dKrXNOttM8icmqtMPY5ZSLE75sJmKhWb1vX6n35rsiOEUyMP+SNNr1Zhif9OFSDvEGGxQ==;7:YQEJXiq0lkFeD1grUsYv4F3oq5uT9kZEF5NFSOePb/lhjfLYAmrwEfzCE3u4SxxzkrrYzRCPbVH9hZDf2NuK/3BStwk7vsPD97fx278icn5e7Ecmv/Yf/HZYe6X3A82FEmeBuvzXP/0bmAsR0RQ6iw==
x-ms-office365-filtering-correlation-id: 9349b7b0-4532-475a-de27-08d690dd621f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2166;
x-ms-traffictypediagnostic: DB6PR0501MB2166:
x-microsoft-antispam-prvs: <DB6PR0501MB2166AFBE11DE104259A7BC80B0650@DB6PR0501MB2166.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(4326008)(4744005)(6512007)(76176011)(1076003)(99286004)(68736007)(7736002)(52116002)(305945005)(186003)(486006)(11346002)(6436002)(446003)(9686003)(81156014)(256004)(8676002)(26005)(86362001)(476003)(97736004)(14444005)(33896004)(6506007)(386003)(6916009)(102836004)(53936002)(14454004)(33656002)(478600001)(6246003)(66066001)(106356001)(25786009)(81166006)(71200400001)(2906002)(6116002)(3846002)(316002)(54906003)(71190400001)(229853002)(6486002)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2166;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7pRrsgWbI2DtWUv0XTwUqXH8Po2VuI1+h4cddrywvSglaZXP5Zj4WVftMDAMfG0vSnZvbERSEeXuuk3uVZEiXHQ10IkxDJJBljEMyUI78yvqky15wNSYzGSNObgsCLa1MizhFS/+dWQif4g5vSBfUxrNeWaJULPguuGvaTI35C6p7BLQW2TqmjT6T9c8K9c7yujwiLJqCpsS0cFzGz2mYf8Q7aOu2H4PzRdtaTbSy9S5KrlIj8ZiWAj5FTi2bW9AHb7pkLoJQrnC44EQR3muPnieh1DILLId2bcNmWkY8noEN+5blroUlmxUNWC1UFm3RRlE5xWwgYdw7uBmF5iBwte3g79bEVzalK+ivKQ4jU+eHAfijkdYjuN5qfq6znMKyJW/n9TEs2LwOC1fli/LKF7D5lIu9kYbg19ZmoS3U+s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6973099414FE5A43BD7A7EFBBBFD0477@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9349b7b0-4532-475a-de27-08d690dd621f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 11:29:42.4388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:22:33AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The null check on an allocation failure on pd is currently checking
> if pd is non-null rather than null. Fix this by adding the missing !
> operator.
>
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks a lot,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
