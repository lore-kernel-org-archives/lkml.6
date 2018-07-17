Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B54ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1D2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hGrq5d5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C1D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeGQQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:32:28 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:10642
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbeGQQc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOE6ibYk8zWr8jkPQUWsv5ZQ2aT2gGtMnZoI6MsRcXM=;
 b=hGrq5d5bycW74hNmaQLThUXMpp4WUfh1nFZbv/T9gU247tEFT2+7adnxwZk67OlFTLZvNZLJraf668Z+Fak6ZoFWAASlYYHEgCUUGo+76YpJLrhtfqcuyIyJq9nVKPYEm6Fg6up/1QNHk787I0T6022uWweXvj7KVPOI6qdmp9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 17 Jul 2018 15:59:04 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2 2/3] fs/fuse, splice: use kvmalloc to allocate array of pipe_buffer structs.
Date:   Tue, 17 Jul 2018 19:00:34 +0300
Message-Id: <20180717160035.9422-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717160035.9422-1-aryabinin@virtuozzo.com>
References: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
 <20180717160035.9422-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::15) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98dd172-a4ae-4e37-2d2e-08d5ebfe388e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:mM7Wn1ppUdfl6+GV/V6HxBcvAoMClhYXAgDs7UWnklX4Kn/gTXP5D6Jo+/jstR70qIOHJ3thERLoHfM193jv3xfn4rIk4szS2S52lsiKhOteOI6rvmhOpwAxVtkwyWc7LdeqkXfBCLD9cqlm5SnDd7IQNWsXg3SJ0ZTGK5zdeaR546jVoBGtY5EMLDt7c4jSSKO6AW5Lp50fF1a1umiHbZWNml6k57fcpa1yWLYZqN2aCItEtMUNe3q8395yOONz;25:dlHxVgWETsmTWTsNIMSq3+6AjMicePcyq5oLN9MJWgkVyU3nSqHeKHn9XgPOan/0ImRf10YpZpoSEP9j6THXPnkjmVpdZMJqTJoYzYfVMmgFED8zzCWzm7/WTMkFOygZh6kTYpGtLtq/fkWLRSev3nP2hyZqgZfBMPSVJzU9VQSyZXv8HnHv5h120Zv6H7baHxoqGSjWP8ksK7Gjt3EXdSW+KFGdrH54ItwxZO6duKayry6Ft/vY+e51tUlZ8BSFZzIWv2fvJUAYHM1ksvFwdXit/fvn3tyQZgYa4vV/b2jbfOas8g119S8/bqDoTPam5yseIC3UQO53pKjQcUfkvg==;31:v8Hr+T85qvNCgRAnWATx0tg0kFYjDPQ5qh2EGCcBqQjxrHgZ3eAiF65n85dnKasyb9A8jFj3yftddj8KYPm7lzBx/m9+RFtoN3zaIZaBgofa8hF6oFkK3TZCNTtYbHxKqPoeqT3350e8LVu5PtB7TyjsGiot322T8jnPocEq30cIbGBkhMxQ1Fag1nOp1fD3LvbGU/H+Bdv4KOMROPBwK3azxqN94eWEQPhhYeAYbwI=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:niAb+oIFqTCp5eS3vi9ZEbG40gAuJ+ogUgkx9gj64+yRMorK/p710Pw+NYCGWmTB7XMeXdwF1DrIurBsvJhDlpkxfjUlLN77rSzogytBcX1BIfFI2cSMaYNY0gkWkQl4Bmixlua0iv4banFaIhSipp8rqcG/y13S8cjC29BbhulDMXqCxvJ9xPhbzYQ16Z+v+PUaueEGV/ZnI5DS/giSCRfcK3i6Cp3TetiyyR7P+46wAT9+XDuvQo98nYdqFL7KIjVjNXohaODGauwvnylYT8ABzKttimpNLLaRetMOVn2pH7KVXL1tVhKGBn9AxCe3TtHumj/4q6nYCLMmcjyfK938+7ZgkBD20YOUaaAiFrhI5btUzpHsbahkaOUVIFkOcPCY9tuPIXrJZvW+MYhf+4Paz0uOWgj6jS7yc5QGf6QbnKZdPLTg/GZ+hzEth823MfLqcPD/o73pjWPHiyZ33ULvZ4gXA2BNpM+NiKCXbp5ErSxnWNx44Eu/OQk3bFin;4:4zULwzmtdxvUrY454ljMNUkREBiUjgzi7u7OsAPuCZKe1y5T1xVIM4afM9ht9xzAkoYxOPlGvQ2x/mEiuJBPlDopkDPa/QzatafRqbmEYL6TsbnlE45QcV8DrOAQFhX1A4P3onot8iIKK3BwDTNYSe3dNz/l/ILVN75Zf/CfPQx7ZR5pg2w+mugopZYmpJLcqMMVNtCPvdQMi0qG3QW1MoixOc3yjHpCT0i/PQkMBFUmG/PzU2fCFyD58d9O/BL0UiIqMfBsXgfVNUcbc0Zdgg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB32587EDA4675151CD56BCE1DB05C0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(136003)(346002)(366004)(199004)(189003)(48376002)(68736007)(6512007)(2616005)(5660300001)(36756003)(476003)(11346002)(6666003)(446003)(956004)(105586002)(106356001)(486006)(81156014)(8676002)(50226002)(81166006)(7736002)(16526019)(47776003)(8936002)(66066001)(50466002)(2906002)(186003)(6916009)(76176011)(4326008)(14444005)(52116002)(6486002)(97736004)(6116002)(6506007)(26005)(51416003)(16586007)(107886003)(1076002)(25786009)(53416004)(478600001)(316002)(86362001)(305945005)(53936002)(3846002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3258;23:99jPWSfXa3SEmjNJYBcSOZ6onuEmMWi4/smStgaGk?=
 =?us-ascii?Q?vN6+bqtlaNQhoLCUGd9W4OQTKZxPwgCPMpDqhQt+HDLiOIEpAIeG545DpZrY?=
 =?us-ascii?Q?7Trwrq4IqCKchVJYJu8Kepu5tUFHmIf7AUULtairsbf2wNfXWEbcsOrm2xrn?=
 =?us-ascii?Q?IzktEHSaxjhaV2sB5wEf3isM2VXgkymREpOE3CPTwOzm11LaRC5JKwpma9Xq?=
 =?us-ascii?Q?hq+PIZ8FUXgaBGh7KeNSCKxDTwKoOq9jwabXVjukU8DwsBhlXr8nzMhtw7b9?=
 =?us-ascii?Q?hetCVcSLrTPWIDXiQZez48hBXELy98JPMmD7Fk5KQwoMDtA8gEIEy/XVjlow?=
 =?us-ascii?Q?F5Vy+PmPJmrR811S485PSNn6kmpgQVndYH3yIfAsh5SwV+Gxqta9m+CymLSi?=
 =?us-ascii?Q?2Xjc48YOnc9+TOM62+XegJQO9he/3JZ0adM63ugZMSPsKhAwZMi1TkRToa4N?=
 =?us-ascii?Q?zN+klv2qSQWK7pDtLE/IrraXvXjcbyBer3tv+k+254DEy65UE0mFWd37USz+?=
 =?us-ascii?Q?OrzWxFrq/rLg6+ezQKmjqM3aVENP8gHGyxRFVdaSBtSQmlbdkXvRviljPziz?=
 =?us-ascii?Q?GNaIwUWLj2QQSLyufQO3HdY/ujh9ZRqsKr3uvMUT0Yi8tH9JXm7carzehhAs?=
 =?us-ascii?Q?V2JAIrWUPRxSSUL4gVWucb89YQM7iJkjKxPFrXdecNN+lgyzcVawvIQXwY6s?=
 =?us-ascii?Q?YJCqIXPFehvGdFosDfKKXuM5nwfs/MdBc5DrGyw2DsMamntyKz8x3h3Ih6rA?=
 =?us-ascii?Q?NOKnJ0YYZDLBKtGfKEmxVdfz4tBphlSsM6KR2MFqKMZ5Vu7Wh9vu9ViQBbZl?=
 =?us-ascii?Q?uRWrHk8PXURHFRQx4iKJnnv9MFVLPDOMCiq5egmIvp+/E49iBTVcmGhGgo9J?=
 =?us-ascii?Q?BFVgqQNTjqVEXRoeXHQLn8pkYzLc8eKN7m51pjV61YEScxIqcLD6cZc2UQp+?=
 =?us-ascii?Q?tGqyS/Nv+1nXkR3vmaJiz9y5LO/POkrVgUTPT/H5Z/zkJLvd3Fi5A4UCzbZj?=
 =?us-ascii?Q?MDtN60dzmzIh9V4ck7p8PHphQWAXm+I7KgeGhSNmB4nM2KqIfSUWBSomT79Y?=
 =?us-ascii?Q?1w7iNrDxsqIePy5Hr/GeqEMwDml1oYhQMr3IAsI8Fk9fx3rTVPlt5+wb0NBp?=
 =?us-ascii?Q?QeNkqlINdqnDwVijR3ZRc117ggK2zDTwf52gPIEHQcJccNSXSXI3nK608oTT?=
 =?us-ascii?Q?9V7yAHsqVEtVG5/9+p90kzDjyPlMp1SxB7jTcflgzXdyktB7OwHZX22h3uZb?=
 =?us-ascii?Q?L/T5NzyDDx3z91CAXU=3D?=
X-Microsoft-Antispam-Message-Info: pWEezx71Uqr/fkQhtPqmtTJZjDi4zOet7tKyqNHEDeKLD/2OFzbAqzWzzrGjoxtktehinTRRv/Z08gRdIbHZ2rMbIL9OxuyAu+EF97BN7bXD5HoYIXwAgAswahWd7ADI6byf+6fgdZs6/I+J8qso9/iQqLSl/c/NnR6o+tMlXQ4NQM22GVqUFpD8H5nwM/IHBFuMaQVXWtMQKy+YOCirdZeb+CZptYEoL3k16StmHh+2rrDXJOzVm2dDduqUlGBquAKp8swlQDJsblACxEa7jctgvqWeOaBWHfFsw1ktmkigdd8ziKdOcf8WnqCULw8bDToYEB6K4iYcyXzxJeN67E9VoeJwmkxmNQyW7BB2klc=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:KiMaodKvOKpdKoZKdsAALLvcIxfWGtBxzRNXNWkz7c7hzVQ4nOG6Szr3YkjtE14chv26wUZSlUdfL+kBuKfmDeFq+N+xmcCbSU/uc8muScbbibHVbfC9RpqIO6YaxLSVQtlNy/R7XPt7AyJSZQ0FVQ5/8+vVqcdI4VhN9uzggmcQvRMI/VqdvZP2uXeAg7diCElDf/gHQJyNNGa5q+TqRBd89as4TlrT5cRjJmR54XQKOWDWo02kVg/xUtWm4tE3w6YZMfs2oVSC1ZodsujZY6SNTIQ/ocOMih3yd+0Ji1nrfxGtYYawO77Y91QCPHl70PaCVuDwbMB+koQGzsks3j2mYQijf3rJR79a6mEYndKqkDP3r2jLDm31R0IJTgouNv/Idv1K2889gE9URdcOmKKCedQYYPu374YW8wF0SRcyfYscF/uihazhj8Hc3K3Jz4Gzr8s9aPwzUKSUdyVmiQ==;5:AXEnbQJ6Rj8G1zEHVkgTVKKHnh8O4/QIDsfNxjkCVGr5miGA3uig4Y4LF2GcFO33xro5jP0NPamVZ+9dn0dzurlYGTvRf1RwXCaKXYaoCo+cdIrqBGG9P9c2cPp9k1ZMEnbOJTQqL18iv59eZkFLAJ4y4kP0z7twiOFpwKuRjUc=;24:4wEfH2YpIqPPeBYGEtnsqBcN4fs9MGOPAd8g1CAEPH/VnXquz0W2XdoNzWY7d+SH9g42XlrQQdcU8D/4D3yl3MKgUwEgS16KhRP9pWt59LY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:NwhbSRQZkZal8C24btmtfKy6iYV1wZfmYWwx91smAA2Dk5Sy2Z+ROhdEdWueaHsBmqN1hJDNWSkXeFjJr6XAleQS6Ba7xrfL0ufi8VMIAi5dN+ggwu1VSwRDdi3OELpkjvrmaGS57Zg5wvY/2E4a077hDpDzOUdb3C/VHJtiZPDCQNVCIYQCoWiwqNrdUPKBGszmdLZCKNZA/G5ESsGiWAJ3Yr0LXv+vt4vk1i1Erc+DrIC2pfHQOvCJCjBUwkr0;20:xvGH5775xFzGJawgGI/HgtghWCqt90a3Ciz4Bi1GHnutk7JeUwi9yAeNXh+w3jA8tQ9dBwefCIWhcdBtg2V+ULNNRw2gezS5WDBVH+gPnh/PIHQWaWnKkr7mojgse5rFDYcX35PeLsroMSTaq/RHmj6lV4GOv2OJEWrfTWan0xY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 15:59:04.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98dd172-a4ae-4e37-2d2e-08d5ebfe388e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amount of pipe->buffers is basically controlled by userspace by
fcntl(... F_SETPIPE_SZ ...) so it could be large. High order allocations
could be slow (if memory is heavily fragmented) or may fail if the order
is larger than PAGE_ALLOC_COSTLY_ORDER.

Since the 'bufs' doesn't need to be physically contiguous, use
the kvmalloc_array() to allocate memory. If high order
page isn't available, the kvamalloc*() will fallback to 0-order.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 fs/fuse/dev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 702592cce546..fd4a838c1673 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1362,8 +1362,8 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (!fud)
 		return -EPERM;
 
-	bufs = kmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
-			     GFP_KERNEL);
+	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+			      GFP_KERNEL);
 	if (!bufs)
 		return -ENOMEM;
 
@@ -1396,7 +1396,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	for (; page_nr < cs.nr_segs; page_nr++)
 		put_page(bufs[page_nr].page);
 
-	kfree(bufs);
+	kvfree(bufs);
 	return ret;
 }
 
@@ -1946,8 +1946,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 
-	bufs = kmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
-			     GFP_KERNEL);
+	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+			      GFP_KERNEL);
 	if (!bufs) {
 		pipe_unlock(pipe);
 		return -ENOMEM;
@@ -2006,7 +2006,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		pipe_buf_release(pipe, &bufs[idx]);
 
 out:
-	kfree(bufs);
+	kvfree(bufs);
 	return ret;
 }
 
-- 
2.16.4

