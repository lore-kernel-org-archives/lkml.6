Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D07ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F6E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TzxqDIPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F6E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeIRSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:31 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:10848
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729746AbeIRSga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1huPHcyZca1VRLaLMf6QNOZEy5zXI/fLCza7yuO/VVE=;
 b=TzxqDIPcPtsO5YAXsVLfsSJVKl+9hp4+tvB2nBpHXbWnAhihHbYpQML05Wyv6uc7BFTwySIe7tiffF32q4k8t7/vaquJc3GIw211F1twzkq5HRyh5bCx8bjLowm6gBuVmwooaZhdd1DsE1jwXuhmyXupLeGJk2nRWUszXMaWM0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 VI1PR08MB2782.eurprd08.prod.outlook.com (2603:10a6:802:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 13:03:51 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH 2/4] IB/mlx4: move iboe field aside from mlx4_ib_dev
Date:   Tue, 18 Sep 2018 16:03:44 +0300
Message-Id: <1537275826-27247-3-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::15) To VI1PR08MB2782.eurprd08.prod.outlook.com
 (2603:10a6:802:19::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40516efd-c640-4723-0fb0-08d61d672f2e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;3:O/61PNzu3sO12G1oGfrjHBqqMd7ENeegyzOqqImhGqMvq2/HSzh0QFinAVbAvcuw9jcEc2h9rY17RsESxdQg3A0MkN6BB07v/f4kABAnIa2Q/UkH+he50A9MxnmDlnBqV55ZkVsk7EyrLtamiu3Vbz+piFq+N+Q3q3TkiH74ckz09F4L3L47ZxKu6UsASNqy4Bp2GkAZidMgqeSRZyKuyabhIuEm7gmu9deu1hqFBBdSScngTgA3AUVIS+DtjMyq;25:kMhpghOz54CuzfWFGaaSBmuMe6QX0TSqJ40I/zDo2ZnRL0BMMUxaet+jIetDmYdXqLimk9VGz7eKRV6YuML3fhKERX84MjDjRzqxHQG2+AhUipgltsL8YbJalKyCaw5gPcerdj9ja4wNYhnOR/9iOyeAZV35BiZ0EmgvHlvlr5XC6947Oy+Uj88P8NS9HdRg7AVf4CUcB8y/E/j++TrHbBtjdqLwkokU4GqxozDoxN3EBp+XHzZksf9iH+RoCvfQjmk/zH21lfOMKr9myolNvsiJR8NNcbcnjkYUbhQ1gc0CXAReMotLzi/rktyYtSpqLAvt/TzTK8/05pybS4c3Vw==;31:irdtAdDAJCHRL8aMPFTtAGI3GPi1efyZorLjJrFC0uGZyxppFYko7rJQmsijxmabo7AQnjjYEim00LIc7z2DW4FiHQPppONOSITud8Ee+TlK8OrjGQ8hkitp2fg0WGYkHLZ/kR0V+eU3zQL6TYu4I9ReuNkiqsOOS+DoapJx6NSaWqqJc187s2UqCq4FY/uBrDY1GFVJh07lJzm9azAKxyLnaSPmMEtBhBffILIIVxE=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2782:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:RJ7kTLx+Q1Iyh3+7Mz+y4wKAaZbS7goe5V2h4rl/XGqUJg0ZFcr0IvZWQHtS3PlTruilP9LLKAEbcpveoVzWSVMBaFP/nVG1Y0gX18ANRkLX09Usq/w1SYO1EiKwsDD1Nz8h/ou5jtFGN+u3wpg4wIOXprHL2ISqGdi/CqygoFWEzj5paOktNYGVd1XRhWCOwS3WxRQ7t+luSNUB0W108F1tKpn7SdiQYYGrfYmgW1Mo5XheQyomlpA4nmkymBgSm/dzpdWfuo00nd8tFUpeAhc/NMhLBPHw9UeH3I4c4gXgvXDt5MrqZYbZoNNrGTdVEitPzcvvB6jB82i9crrtYf44t6eK5IMMCWRsC/JXj7yYFS50H8r+SnavKSfokJWimu7AQdOLepRHUxwb3cXFyygvZlIeQukWGntMbTND8Q6dHIWYy7OsP3A1wkhmIUAQ5hyOWVShxu7XYNMJNIhJh+cONrl2S9OHzvgYeF4u3phS3npNFOwMBRZHedhMfoG4;4:mOXh1m0K/odqeoGsMuSjti6XzraI2JlPYcZpa51GzMQrG2Or12pF/dglFb15x6cz/mvJKN0j5haC/PsKn2FH5TQ9yaIn+UP09BhcftoWy/g70UKLnG6t7W+1yKiycrNFVd/Jd0bkfiyDrQMvopr8K1tHCrAJW1eI7rh7P6TwZp7mw3cpMSdtf2fIcXg5skBpRrKIS5/oaGvr01h7KQpqnoqTTZnk6P1tJqiqCZcvOFlANYklhfTVXmk/xt/93cQg7EYBhJr9vykSifAx1R8MSQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB27821FCDBFB195D4A0AFDF078A1D0@VI1PR08MB2782.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR08MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2782;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39850400004)(376002)(189003)(199004)(3846002)(486006)(16526019)(44832011)(7736002)(26005)(68736007)(39060400002)(6116002)(54906003)(186003)(53416004)(81166006)(305945005)(16586007)(7416002)(107886003)(66066001)(2616005)(106356001)(956004)(8676002)(50466002)(8936002)(478600001)(446003)(105586002)(11346002)(476003)(110136005)(81156014)(5660300001)(6486002)(6512007)(14444005)(69596002)(97736004)(4326008)(76176011)(25786009)(47776003)(52116002)(316002)(2906002)(50226002)(386003)(6506007)(48376002)(36756003)(6666003)(86362001)(51416003)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2782;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2782;23:Z61D0YCxYjmESuLIjBuAwOchXTsdjln9Hcx4ickCQ?=
 =?us-ascii?Q?j8ckBkECAUQbHd+jmd9revzBveVgNY1WeUtrwRFYfYYnV7JKnHDhsR9aRP69?=
 =?us-ascii?Q?mmQwG1JDoooMCiejeJdcEYb8WD84gr64vcvqnOBDoSWoSZHtNPIxCDaDJlCN?=
 =?us-ascii?Q?qpmF+/qan59vNEHZ4GgQQOLR60PyakX/LzEUrXADoWvto3+JJx7fBxdUR9iu?=
 =?us-ascii?Q?CEBkyW9MbNGvFKdlL9HfldfSKgujxmPph+DD2RtnhQqug+sIy1SMHBFbSSIb?=
 =?us-ascii?Q?t/DxXqeIFNBKBoyoMBwIeSQdR1kB8PZDn5sXetthIoMHuevLDGd5KSS8nL0Q?=
 =?us-ascii?Q?bBve3M9r9JOldYsFxWiVA88kLmJK0F9XOTnsXc3UElckZ+1JJoJv1i8PUbfp?=
 =?us-ascii?Q?v+0AZ+ZRVVhURp0q2WBYQIS2FUITh6N3XOOPiLe04OBhlyl98uFcMDee+VY6?=
 =?us-ascii?Q?mdmBgyE4KIIrbmK+318qiNYy705K+fcM8yw8ToIjnsrStsLJA5uc5wp7Umf0?=
 =?us-ascii?Q?EE9yKoBfoH+50TRbSuPPS2vfzn6KPLPOUH6mCAZERQreTozM4k9ARHe2G/Y7?=
 =?us-ascii?Q?gkNg9JSyZOdgplg1+sqJtvlXgoVTsj7JmkihmbEa6cYvWiWLszkBOxOsE9fc?=
 =?us-ascii?Q?HNPzmwyVFxOicvD6D/6m1/dfwhwtEjbN7cvOyW7ewF35pcOOU/fkVkC0b71d?=
 =?us-ascii?Q?6Wf5/3ALjjtOZRo4d/Dvy25bSd42LXL3CzSdtqZYpVNjJeSidUjj/GFGk5/W?=
 =?us-ascii?Q?XZ+gRERhYSZbrI4avzHWE8HRR+Qepcyy+a5JfZntgOXYdECS1/8dDgzyUfBq?=
 =?us-ascii?Q?9oNC7hYIPHTTWyhfNNHyJbEfQ5WzmeunMqsecaAGGUPoaMAX5OkHHeEz7Ttm?=
 =?us-ascii?Q?U3eFX9sCBIac9RWtK01QyFSWxOCu8oCXFwQumdBlvRbpXOgfgXiYt7JUmDv2?=
 =?us-ascii?Q?l2botg487oziUfGslrQ7wwkuI15Exv3Tofhu2r20V4HzFGZDXZQhkjuu1R6R?=
 =?us-ascii?Q?lcTtgZeuhL9rXlJNC182c8P0mKkW6OJsH/PL5s9FnTYzDMBeZosTIwx6mTm2?=
 =?us-ascii?Q?C8dtij9G1U2/yMu5SoRaWhkwwMBKKXlv3iJqP+jOes7ecvg1F9PsVRHpw7++?=
 =?us-ascii?Q?VK2GsHYK4XJsZTcBd85qt36ayU0cYLAIECSiWrABKlEQh6+Ng4wR7776P3WJ?=
 =?us-ascii?Q?atXorERrF95URkr1p4qJzBCvvs5E1qooXLnBjmXfcIocdSk5FkcyL7roW+Dx?=
 =?us-ascii?Q?EYEq/P+ZoEREmFrbaMlFg8d8itp5R+FZ8E6Gfx3ZeZQ+2QKuJJ9QkHcIKqEz?=
 =?us-ascii?Q?eE3FfwMs+6msPUAHy0q7LnAJFRlgPbinmSNGMBC1DKcZXhbmo/ohShqjndXe?=
 =?us-ascii?Q?KGMMnTts05M8hUEL3Iup6PeVlw=3D?=
X-Microsoft-Antispam-Message-Info: bD2otbvMajgXGDym+j0i5JmchVMG+M/V+6IF2UZ+d8I92J8eTgcd7TN0NGH5uBy6qcVhsThJ6IoE+noIOspJtic8InLQL/iY7guyX4b1C5qB3ON+sU8mZEGrRwhJ5Q6g99Hnpcxtyj1Omc+Z5NSFf01zTOI4UrZomx3s7RDR0DriZAX2EcP6SL3Bi8Vzjf4Mh+TTQvVzE6P1cClwk+8vwNlKL7Wu7AQ4kmowSsPMO1X6mS0vH1irEoMrERkBeM52i1unj2zenPR34COSt8lxD+4yBWGPikP0FW9X+8buSOr4nQyfiU80i2lirurv7UVTW4WJKnZxGl9DctILXNxe3HJf/yIahO1POMA69lhE8V8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;6:zQlzDHXFoeEXDTjCy4D0zsGnXyXBEaAk7T0vKRKZOTmGto6qIy+8i3XL89VRdyzD+3qcR/DOOLKJMzt5geBbmQC5cHYfjMy643jsk3iloiHc74mG0nefqEc7fkpfJSPoz+WQfNCK0SKG3jvCNTd+seKMguCItcDZ7KZ59DVsmB4+mNXq4NlUwQA0RMeFuTFpGG771ge9nq6/G3PohvTYOZdJ0rxE1SXqyf2UxIrlg1rUK/RsdiAdKxGNf8fQ5GdzXJA7PmE56TZotxdR5wTKA+nBX+p0p4aNfCTDC+GI4IjRNY4O6IueZ4ogYEnIW3DERssIsbt6WwyCKpeZxQp/nm42zKP90JLRaz8awgmDPvEWcCqOACOU5Uy+dN6LKr8RotgkYxb++7g2HvTu5JxDQ8f7nth098EovMWmYuxBr1F/v9vZbzmJniGYfHo24wBAsKz3eTXqBjAHdyURQanSlg==;5:uKhHHikQKM2BeOBLKRlsAeVbOngvw/HQdsjU0KWHxLehf5SiNEu1vjhBH0suyYj3scfXBDrAVN9V89kP5WZLY251S2TMHKwHCGKrb3ozL++o9Ld6KsbQzS7JSrQoiF2syKoXuZi8w82/nYFJ9IGNsg2r4Hh5a8ZlPqy1s3991sY=;7:WK7GR7qX5LEYbxarjOdDo6SXPc/PgE6ylcPF+BifcLz1sCuMePqSXcixPU8BMQmXLjF0WID3XE/hTvDNElqjlyboCU3zFc/xXzZd0IroWdN9YP1ImcEjHSYKiRCysmgGLT6x55AedJB+w5/E2ZnrTN9oHP4ANvQYNlS77cj5TLfHL0vR1PzKQcqx9MX0H5Yr+hlgwsyAvg0f+ZXQ0gH1NyvugTpvwrh5IJpa9fPwsa39lNUqRZM2+XykOYc6/eft
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2782;20:XWnzl8Lrr/mBoYK+1uFe0OY6SjKo27LEmrKC+scKpFjPYvi6D20gdF8ra/hb+PhI3f6raUR4P9yLfJ0cWhfONSSoAq03nUy1D8MoIgWFR1reaIBjTPFbTP+nJ+Rd5qrLmM1ZsbeGcd2d6iWWBKzL++iASL66sTIUjifSbYFQ2+U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:03:51.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40516efd-c640-4723-0fb0-08d61d672f2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 1st patch of 3 of the work for decreasing size
of mlx4_ib_dev.

The field takes about 8K and could be safely allocated with kvzalloc.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/hw/mlx4/main.c    | 65 ++++++++++++++++++++++--------------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  3 +-
 drivers/infiniband/hw/mlx4/qp.c      |  4 +--
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 0bbeaaa..1e3bb67 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -249,7 +249,7 @@ static int mlx4_ib_update_gids(struct gid_entry *gids,
 static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct mlx4_ib_dev *ibdev = to_mdev(attr->device);
-	struct mlx4_ib_iboe *iboe = &ibdev->iboe;
+	struct mlx4_ib_iboe *iboe = ibdev->iboe;
 	struct mlx4_port_gid_table   *port_gid_table;
 	int free = -1, found = -1;
 	int ret = 0;
@@ -327,7 +327,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct gid_cache_context *ctx = *context;
 	struct mlx4_ib_dev *ibdev = to_mdev(attr->device);
-	struct mlx4_ib_iboe *iboe = &ibdev->iboe;
+	struct mlx4_ib_iboe *iboe = ibdev->iboe;
 	struct mlx4_port_gid_table   *port_gid_table;
 	int ret = 0;
 	int hw_update = 0;
@@ -382,7 +382,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 int mlx4_ib_gid_index_to_real_index(struct mlx4_ib_dev *ibdev,
 				    const struct ib_gid_attr *attr)
 {
-	struct mlx4_ib_iboe *iboe = &ibdev->iboe;
+	struct mlx4_ib_iboe *iboe = ibdev->iboe;
 	struct gid_cache_context *ctx = NULL;
 	struct mlx4_port_gid_table   *port_gid_table;
 	int real_index = -EINVAL;
@@ -742,7 +742,7 @@ static int eth_link_query_port(struct ib_device *ibdev, u8 port,
 {
 
 	struct mlx4_ib_dev *mdev = to_mdev(ibdev);
-	struct mlx4_ib_iboe *iboe = &mdev->iboe;
+	struct mlx4_ib_iboe *iboe = mdev->iboe;
 	struct net_device *ndev;
 	enum ib_mtu tmp;
 	struct mlx4_cmd_mailbox *mailbox;
@@ -1415,11 +1415,11 @@ int mlx4_ib_add_mc(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,
 	if (!mqp->port)
 		return 0;
 
-	spin_lock_bh(&mdev->iboe.lock);
-	ndev = mdev->iboe.netdevs[mqp->port - 1];
+	spin_lock_bh(&mdev->iboe->lock);
+	ndev = mdev->iboe->netdevs[mqp->port - 1];
 	if (ndev)
 		dev_hold(ndev);
-	spin_unlock_bh(&mdev->iboe.lock);
+	spin_unlock_bh(&mdev->iboe->lock);
 
 	if (ndev) {
 		ret = 1;
@@ -2078,11 +2078,11 @@ static int mlx4_ib_mcg_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 	mutex_lock(&mqp->mutex);
 	ge = find_gid_entry(mqp, gid->raw);
 	if (ge) {
-		spin_lock_bh(&mdev->iboe.lock);
-		ndev = ge->added ? mdev->iboe.netdevs[ge->port - 1] : NULL;
+		spin_lock_bh(&mdev->iboe->lock);
+		ndev = ge->added ? mdev->iboe->netdevs[ge->port - 1] : NULL;
 		if (ndev)
 			dev_hold(ndev);
-		spin_unlock_bh(&mdev->iboe.lock);
+		spin_unlock_bh(&mdev->iboe->lock);
 		if (ndev)
 			dev_put(ndev);
 		list_del(&ge->list);
@@ -2373,7 +2373,7 @@ static void mlx4_ib_update_qps(struct mlx4_ib_dev *ibdev,
 	new_smac = mlx4_mac_to_u64(dev->dev_addr);
 	read_unlock(&dev_base_lock);
 
-	atomic64_set(&ibdev->iboe.mac[port - 1], new_smac);
+	atomic64_set(&ibdev->iboe->mac[port - 1], new_smac);
 
 	/* no need for update QP1 and mac registration in non-SRIOV */
 	if (!mlx4_is_mfunc(ibdev->dev))
@@ -2429,7 +2429,7 @@ static void mlx4_ib_scan_netdevs(struct mlx4_ib_dev *ibdev,
 
 	ASSERT_RTNL();
 
-	iboe = &ibdev->iboe;
+	iboe = ibdev->iboe;
 
 	spin_lock_bh(&iboe->lock);
 	mlx4_foreach_ib_transport_port(port, ibdev->dev) {
@@ -2453,13 +2453,13 @@ static int mlx4_ib_netdev_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct mlx4_ib_dev *ibdev;
+	struct mlx4_ib_iboe *iboe;
 
 	if (!net_eq(dev_net(dev), &init_net))
 		return NOTIFY_DONE;
 
-	ibdev = container_of(this, struct mlx4_ib_dev, iboe.nb);
-	mlx4_ib_scan_netdevs(ibdev, dev, event);
+	iboe = container_of(this, struct mlx4_ib_iboe, nb);
+	mlx4_ib_scan_netdevs(iboe->parent, dev, event);
 
 	return NOTIFY_DONE;
 }
@@ -2589,6 +2589,14 @@ static void get_fw_ver_str(struct ib_device *device, char *str)
 		 (int) dev->dev->caps.fw_ver & 0xffff);
 }
 
+static void mlx4_ib_release(struct ib_device *device)
+{
+	struct mlx4_ib_dev *ibdev = container_of(device, struct mlx4_ib_dev,
+						 ib_dev);
+
+	kvfree(ibdev->iboe);
+}
+
 static void *mlx4_ib_add(struct mlx4_dev *dev)
 {
 	struct mlx4_ib_dev *ibdev;
@@ -2619,7 +2627,14 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		return NULL;
 	}
 
-	iboe = &ibdev->iboe;
+	ibdev->ib_dev.release		= mlx4_ib_release;
+
+	ibdev->iboe = kvzalloc(sizeof(struct mlx4_ib_iboe), GFP_KERNEL);
+	if (!ibdev->iboe)
+		goto err_dealloc;
+
+	ibdev->iboe->parent = ibdev;
+	iboe = ibdev->iboe;
 
 	if (mlx4_pd_alloc(dev, &ibdev->priv_pdn))
 		goto err_dealloc;
@@ -2948,10 +2963,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	return ibdev;
 
 err_notif:
-	if (ibdev->iboe.nb.notifier_call) {
-		if (unregister_netdevice_notifier(&ibdev->iboe.nb))
+	if (ibdev->iboe->nb.notifier_call) {
+		if (unregister_netdevice_notifier(&ibdev->iboe->nb))
 			pr_warn("failure unregistering notifier\n");
-		ibdev->iboe.nb.notifier_call = NULL;
+		ibdev->iboe->nb.notifier_call = NULL;
 	}
 	flush_workqueue(wq);
 
@@ -3073,10 +3088,10 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
 	mlx4_ib_mad_cleanup(ibdev);
 	ib_unregister_device(&ibdev->ib_dev);
 	mlx4_ib_diag_cleanup(ibdev);
-	if (ibdev->iboe.nb.notifier_call) {
-		if (unregister_netdevice_notifier(&ibdev->iboe.nb))
+	if (ibdev->iboe->nb.notifier_call) {
+		if (unregister_netdevice_notifier(&ibdev->iboe->nb))
 			pr_warn("failure unregistering notifier\n");
-		ibdev->iboe.nb.notifier_call = NULL;
+		ibdev->iboe->nb.notifier_call = NULL;
 	}
 
 	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
@@ -3218,9 +3233,9 @@ static void handle_bonded_port_state_event(struct work_struct *work)
 	struct ib_event ibev;
 
 	kfree(ew);
-	spin_lock_bh(&ibdev->iboe.lock);
+	spin_lock_bh(&ibdev->iboe->lock);
 	for (i = 0; i < MLX4_MAX_PORTS; ++i) {
-		struct net_device *curr_netdev = ibdev->iboe.netdevs[i];
+		struct net_device *curr_netdev = ibdev->iboe->netdevs[i];
 		enum ib_port_state curr_port_state;
 
 		if (!curr_netdev)
@@ -3234,7 +3249,7 @@ static void handle_bonded_port_state_event(struct work_struct *work)
 		bonded_port_state = (bonded_port_state != IB_PORT_ACTIVE) ?
 			curr_port_state : IB_PORT_ACTIVE;
 	}
-	spin_unlock_bh(&ibdev->iboe.lock);
+	spin_unlock_bh(&ibdev->iboe->lock);
 
 	ibev.device = &ibdev->ib_dev;
 	ibev.element.port_num = 1;
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index e10dccc..2996c61 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -524,6 +524,7 @@ struct mlx4_ib_iboe {
 	atomic64_t		mac[MLX4_MAX_PORTS];
 	struct notifier_block 	nb;
 	struct mlx4_port_gid_table gids[MLX4_MAX_PORTS];
+	struct mlx4_ib_dev     *parent;
 };
 
 struct pkey_mgt {
@@ -600,7 +601,7 @@ struct mlx4_ib_dev {
 
 	struct mutex		cap_mask_mutex;
 	bool			ib_active;
-	struct mlx4_ib_iboe	iboe;
+	struct mlx4_ib_iboe    *iboe;
 	struct mlx4_ib_counters counters_table[MLX4_MAX_PORTS];
 	int		       *eq_table;
 	struct kobject	       *iov_parent;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 6dd3cd2..853ef6f 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1868,7 +1868,7 @@ static int handle_eth_ud_smac_index(struct mlx4_ib_dev *dev,
 	u64 u64_mac;
 	int smac_index;
 
-	u64_mac = atomic64_read(&dev->iboe.mac[qp->port - 1]);
+	u64_mac = atomic64_read(&dev->iboe->mac[qp->port - 1]);
 
 	context->pri_path.sched_queue = MLX4_IB_DEFAULT_SCHED_QUEUE | ((qp->port - 1) << 6);
 	if (!qp->pri.smac && !qp->pri.smac_port) {
@@ -2926,7 +2926,7 @@ static int fill_gid_by_hw_index(struct mlx4_ib_dev *ibdev, u8 port_num,
 				int index, union ib_gid *gid,
 				enum ib_gid_type *gid_type)
 {
-	struct mlx4_ib_iboe *iboe = &ibdev->iboe;
+	struct mlx4_ib_iboe *iboe = ibdev->iboe;
 	struct mlx4_port_gid_table *port_gid_table;
 	unsigned long flags;
 
-- 
2.1.4

