Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCCECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D9208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D62ydY6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D9208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeGPQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:30:39 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:25850
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbeGPQaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSYdj9MmgsfqwZxbIxmcAjjOnx3Ll3TwwcRcm2BK0xU=;
 b=D62ydY6hrcovm4i/A/poDzlUSincIalgJ5O9L0NTPQUZqgjJrbWeJronv2vzJGJNAoGK7c0LsxIkFUJuM/U/4AbKhtCdYSYxaGEcQimnbKdS9Ub72CSwhcf/ncPmII2ca+PgBxjzCAqQWyV0SAKD2fd0hRRQKSvHh0TSU21gDv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 16:02:30 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 1/2] fs/fuse, splice: use kvmalloc to allocate array of pipe_buffer structs.
Date:   Mon, 16 Jul 2018 19:03:43 +0300
Message-Id: <20180716160344.7015-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:800:60::18) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77905076-a122-4a95-bde0-08d5eb35893c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:PAv05TwGWPCqGaCs1yz9I13/YYERiIuwTE8CgiE4ZjrHYIddLGWwwmdD+I8Ja2JQqlKGT5mfR2r/jFmDREMB8lAvy4T6Ci5wpnBLZH22U493MNuopowNRxw2Jyw9QXNdOxrbBkWvB1dvKfiKkBh8w9DmbQ7wpL/y2WxyLwVOYAkc+qqGkFVE7oeqdnr2gc3Num2Eu5cNDTyr7VxQFQLz1k/XMKlAtTyoDpzjjGJ5nvzXnUTGue0iYgzpaKmjmHpW;25:zILaU+RxK5cVtJVKkBOdlURGgPVaE9sie9H6QGO1hhr2uZ0any5luaSn/Xja/opADaHJ+NILT8UAzpZhURpv9lQ1ERaxKSc1CifBLIVM67tVPSr6cwX/Xy8AY4aYQf2IZH1GMvWqn6bcBMz4ESqLJNe5tGSRKNLXAAPUGz0PWml71p8IfL5W4M8Wka27+pBdcsNZFEo4rmtZkyipucBjipyU0iaKkoB/FJAlTCNZO0rUWiQwulpcTRTKm9iGAIDCd74Ac6ssvaqVuWYNiibXkhbC0ckgLFtPrvES3AmLkzuGw6xsh3wlBukSw5xoCbM4jqPVUEeVFo8OnjDGZc/80w==;31:ljjm1hN9rpxZLHhfTHMYSesxHWvHnyvirluT4JZUSObEGYdacrs/cHPDhAVqqGo8pA+/bQL+qqhYAz38qJe5fPdWlXAgjMrh2qByR3EydDllXud+j8TSAwyvlceKjOcR87nTNB5PKCVKfzunDkLkgkrMuzXQ1gc2Uf41OyX9dAE5+YJtXaWRAgfXspXEUxf7iv4RUr+fj0008877+3veyfrfBvgX/UgXttjWaw6SbrM=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:GQ1TPqHTiKOYwLqtnOcs7U5eMoGct6rL2hn+v4WuuYSwr/J3H7YCGOEOope2i5pF9/NPsPGmeNAA6t9+ZkGAvwWr/z/ncglvD8Uw0HZQnF0DUKIMjfFRi3AtDlfe0js4WbV5Gzk1Yvn9c/FqeWcb57Ne4vias8cBEthe15dI5o/2latothkZbkopgzgiDNOTPeZJaLmN02dMeyeIch3Ko3dtkaYwSsCdHjZHMPdWSEgtx0j9o3ukE+hffipBd7FAGS3ZULQlNH85bMYneKj1mTSbdBTDcb8fMd7mj1TIkbQ8MPc+I2RnXmAfasyOW9yNdE66iC9+bzq08MAW2ViontIRx3aGB9iMttJ6CK0o7DvUyOI1epywqG/xzlDA73RWZPMkWBt6r2BJbBo74maCxM/+abn8ggLGjuBsqZ8kWByFKQVAg0MJRqEgwQbtRZl5O6D8Y1RAjBui+XnyLpYTJduxLozbPU4E5C8SKmbJyptmyMuJ6Vh21OguAiP24u/n;4:v97lSkGkqV7bmgvMsTvK81BwlYwXomGXeuml1eIrFRMA7PJdLbS3+skA6jeO8ObUmyINLBTr8bGPut+ZiaBAjd+ac2pUVrAy6owI/y2p5xFcYyNup58ZkyaB0qQKtd4FPvO5mGAqCkaWX6YbBhVohGxJ/EwDlFujxzsK629KdWwVrJ7M3004C/u9T3bzcveSTWiulp1FnZcf+n8uh2OPbjiEtqWw0+S76SG81T+wQCdSFIwgEKqVaWYK0wwGoTsB0AeLiKd4PPXLFXAIyfJO4A==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255BE4D81963D1FAAC741E5B05D0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(68736007)(305945005)(53416004)(6666003)(53936002)(36756003)(6512007)(1076002)(47776003)(48376002)(66066001)(4326008)(5660300001)(25786009)(6916009)(107886003)(50466002)(105586002)(106356001)(97736004)(3846002)(16586007)(6116002)(81166006)(478600001)(8936002)(81156014)(8676002)(6486002)(2906002)(26005)(386003)(316002)(6506007)(486006)(16526019)(476003)(186003)(50226002)(14444005)(52116002)(2616005)(86362001)(51416003)(7736002)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3255;23:Diiknn6dzPndrldRt4s5XaU+IRC5rK0aRME6wAC5x?=
 =?us-ascii?Q?mZOXlW0VCxgpAh+WrecMlZ6kBCFFHlJpylz2oQxXIoxVxFxOHlWoKvA/em40?=
 =?us-ascii?Q?iDqDuQhxlns4pksCySB6hVirOIIA0VoaiRVdkD+QmGQjdo0jhOqC+EJu7YHH?=
 =?us-ascii?Q?lYoLI16rgxP552mqUGtLoiZ7c4tbFlNtP7GDd72k4mZeOBEZ9J2mkjZqGqR4?=
 =?us-ascii?Q?PEukMlMiHmdH768r8xAVnWY3LmSg2/bajZgpYeo0tDyfPJWcXm9aGTWph1RX?=
 =?us-ascii?Q?/OXYmO48+UhmpQeR+vrgLhiS3kcs+8VSz05TjmHC4pUcTqknNintkSoSRyE8?=
 =?us-ascii?Q?l3x1jxVLV0kPYUahTyY0fowAV+XWagCCkHPi1I4uI7/UZMd1TLWqsy1qpLtZ?=
 =?us-ascii?Q?hTjFdCy64nhxDg1AJ6TsZ9b9jxO2BgKs8UAI5SaS+/VNlelKnRR+u4YfyYSm?=
 =?us-ascii?Q?8oBf/8kqA91PFZaZWmWvs8sbO+QVetiSOC0xRf7p3gnenDSNBESz/SX5i/0+?=
 =?us-ascii?Q?W3ogLz3gPUA4ytb7JOLmum5gzv2+7kVKJdLpfBB8HRU9cUZ3d5/nt1HsclII?=
 =?us-ascii?Q?Ki0YkVtNXxvH+xe59Aip7YbxNnkBUL4P5bWrr2W40lF3YgAe4muC315v4n++?=
 =?us-ascii?Q?Fx1vRsixzFkb2AqlcF3tjdRAJhKCG53RkCQ4PMuUbVXXGDmnwu9UFtgreNq6?=
 =?us-ascii?Q?7DO+OX3k4D5//Qmy3d3l4aeecAX32uurts2B8jSezZYFYPVCa3SPpte+b9Q2?=
 =?us-ascii?Q?lH/qv6WWJzr9g3t5NsAV2+lghXzyhSwz5nIUaszRjUVBa+D/0xmb1AnawM61?=
 =?us-ascii?Q?CrE6vHb8lXrzCYHBzu4cOEgjCWSphCx1PlbZ62tf//2MHAFLAZVa70voDu7t?=
 =?us-ascii?Q?HIXJMRmUquiEnhXHWkGaeolUIXBA5ZqiA28bWBhK2uuEdzq9q/1DfhqZKYKm?=
 =?us-ascii?Q?kqj6FtuGun+hGjbknoPcpxL7M0LrVSg+oHEju0JegPDSb24APHWxlaPtDnNr?=
 =?us-ascii?Q?s2z4AMK9rOW/i8GyRby2N7ofZhmTnjH6o5Jl4Gm/1PFVt4ydQR2Kv62XcUDW?=
 =?us-ascii?Q?Y0j4LKt9+dDzVNUl+FoDVcWdNZSMdHqpWwvff1Eka3qzA5Ck2dlnWjwuU1lg?=
 =?us-ascii?Q?XgLCkhD78LGNqf27T/XF9fsW+gXVyk7p+WaXWLqI0VRtlj34QHYXJEYg8vuT?=
 =?us-ascii?Q?o+jg6LEFYqDOkQ=3D?=
X-Microsoft-Antispam-Message-Info: 1sreP9mv2F1ELH8tvl0U8hpteiFWsg9YC4i6Jgg1tCKmMh/WkBLrvHn2wJw9+KQsp2fMifik5oUic1Dhh2x6dCrbD0I5UzIHlk6vMAjnWoxepu9J5xkcA0fzIWDmQF0hty97QNEFuveHEt4e7GnXPAMDHfvfYVU1GP8EXrJW3dowxwmbtGaxNiL3tLopcyMvWr1fCl47de/FE0mIDdmGtzlLtcjQyQYs2hHSyvk/K9xsGNxOaU6H0Iudrixwxli5kdxc5AgXWVkyICZIBJriu5k76IRtqEH+GIzYbOZzRixJHS140JMMyH64CaH1ERdSdoVhFbyY/00E8Mm3IJP+dxifPzxN2TZ1I32GDCmzVDs=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:EL+r6w24GxJmHRyd2SRwRwow3M77N/ps4oJ2F4Uygbb0XphQFAidTyjXSPwo8ns9CvIiIpabgpz4LmlQJ+0pmMlRIlhue3bFMMX+QxUQR6RV/lGrfm3HKKl23x3hK9sfA68q9Hc+Dh5AgIxV9YDMUtcZPLVmLL526pFJxkDsKYW00WHbxefqSlsj9gT/YSBdOwIjX8rOt8TqB1x5UNmQ3PRcgrnhyLntFJKnM/FFatOyiIiXzDHaPqwKyohM4uNFVNSqXamqqmKwO1wZ21hccahwNJSxRBvw7WnmifUvJ2aOTis9oRhfOqkNBI9lpBSIIxGM+qr4D3bbxl59I/zusajRCDHmeACcTHc9nfarRr668DLG/EYKkG0oBjzEHyytQOI4S78pXYlw4Hw3zZoLoExZf0ev+0/yHO/TezR5posBGiP4+PzssQMTmzqZyHl673H51Y0U1cQ2Jedod4NyqA==;5:SB5vyz9/H9m0aHQSPALv5VN5iWB8rdnl+ldjwTRKm/2W5HndNlhTqunUGCOJGrW+YTyWKc0H+iudJjCSnNtzJmNjDFgdLmn3fPQ1Tpr/ubQL/I/QlOk2nmdvkRnjZRZMPvgeUvlbboVH6XPH7S6aWVp+KAkdve0BU9s0TNM8414=;24:dAdAgW4KRipHzqJ5bTdzwRBHLPoRGzfDRZVExVIwMIHgY0kvTuvO/Y8Dh71+nNg8t2KKv06VKZbSjqnfJTJdvACfnk/8hP1Yv4rX2DSzYBs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:4rLB/+bdgoU6VKekAeCx+FvTydG4aTtORdUWY9MwUVqx6uSMXMrh2ExOKhzKWdBTeEBe9/IghtxM502mo7Y5KIFiS2nmpyqy+NBrFKSIunm0dUbO2HAtyK0XthXmJbAXwiUt1OPguTMmEOPdCNcmEfT3tedXKI/lLlGurLDqY8RWJY2rfu7hTzIulMspyMgZn3w8MGQD32rQOZF4RWk7EFu7+xq2d/xcjcFY8nuLH5f7o+69yz7UwfQKDekpwbMn;20:Ax69wtcjCsF2lQG2M3n8vbYCNcAb0tQDmtF15nvCWKcla16YQcvZ8u/m/8cmyAvg756a8A2qcJ9WxvGumGEsdXwKZv4Lq2SGtrSOsLau98qUCJMV8V4kec4VTOqcZlC0SiGj2e8Lt57IY8c+k4RIqEgnOKYQ0R8nqqHX8TRJu30=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 16:02:30.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77905076-a122-4a95-bde0-08d5eb35893c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
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
index c6b88fa85e2e..74900571546d 100644
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
 
@@ -1944,8 +1944,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (!fud)
 		return -EPERM;
 
-	bufs = kmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
-			     GFP_KERNEL);
+	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+			      GFP_KERNEL);
 	if (!bufs)
 		return -ENOMEM;
 
@@ -2003,7 +2003,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		pipe_buf_release(pipe, &bufs[idx]);
 
 out:
-	kfree(bufs);
+	kvfree(bufs);
 	return ret;
 }
 
-- 
2.16.4

