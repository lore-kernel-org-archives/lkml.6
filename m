Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F325124EE6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XZMm9uV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325124EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936206AbeF2Snu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:43:50 -0400
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:39424
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935928AbeF2Snr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjQ1pKmQSQ88guZSAVBVF2bq2IJ54XmaJP7r7Bld1dU=;
 b=XZMm9uV9KOd29vGIEBILkU23Ssr1jt+48FvdgAxniMYOiybbZHR4ZQKlkZp7p3CwBHmgGwbQSJFvT7/vvjwd43kL0e19gvQNIQ1lhvEo/KR0gI4NVV/osPPgYILUttxY8oMsAYz+qOR07SEIU/0xvTueS/ls0RCo0DdUPggMzsU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 AM6PR08MB3256.eurprd08.prod.outlook.com (2603:10a6:209:47::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Fri, 29 Jun 2018 18:43:43 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     icytxw@gmail.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] mm/fadvise: Fix signed overflow UBSAN complaint
Date:   Fri, 29 Jun 2018 21:44:53 +0300
Message-Id: <20180629184453.7614-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180627204808.99988d94180dd144b14aa38b@linux-foundation.org>
References: <20180627204808.99988d94180dd144b14aa38b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P18901CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::13) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec025f2-a2b2-4b97-4416-08d5ddf03dee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:dN7bOMnVDFJryR5Lb+N9L5qB8f7/HOI/b3xqpL2ro4EG//2+mlBemDf76jw6zuGpdde0iYjmzY396rkP6kz7AgwOgxp12Z2+iqWLUQBexQm06yCw1K90jqPSzo2ne9cgLRpFIBQAwbCbRiSLKHNQl6X0LifXtuhDaRRszLsuE1jmfC/ZM5DNiWE3LiQypkGcAGLSWmDFUoPcqGrWeqOvNsDffwfW9qYwvV2528Nzq1q87C9mu7biCpUmMckQXYXx;25:00oOvHeNk74VSa52aDROk4F1J6qb6znmJtYdOJ5qR4wGlpH0NiuFwUUkipV5MyB8+mEnXPOvZjif43rJwePZtp2ZifeqtflF9mlmwc5anbR5YEVI40BuHySQTyArtdrqFl1MgwMWJ2zhh2H1CjOQ0Rc1ZMsnlYnAZJREV+tea09NFnsMmam+yTT2ljHwXwlPE97MtlFEpt0MVRHO6VMkIb+jngmEmmWftiG9oMg9ZQ8F8z9wy4vcfQCSJDKgfJ+1nreZyymVRiWa8OF9wJY6e+oAV0ML3Yka9x4GO6AU73gd49ZUVlvYsgIpNMU09CErY5ibGVn9FdjPRVlfTjYeAg==;31:RZsogR9QTijzzv54Mm864dbLf9mOyokNhul/BztRURHjm0YzbXQWsKKYjCEkpQrCxSY6MyhGSw76oBbCc66KaomZwm5w0w/FuVXUQNr0lca9mSCKmEBhXVwPFKk5pTZnR1+wPGZiYCWMDtxzNGQzLoEMyFEh+qeUFD9HUInz6MCHiW1teEsf09Kl2aIeuGo9m/w4MPW4uMwYe3o+wQnzeWrkyrXKataXV4n1FHkUMhQ=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:N8EsvGsN7DuaWRGaj7gsP3Wox2lj6nEC62OKDghO6Pl5K262bdL8qcrCLxF9DcJ0uLqp0HGofJXuG1VuZxxURSCcTSN70/CnJ3iMvXQKbGX6QtP+y6yal2QO53lWv9mkDJ8EGfWO5KWevLaTZ/0XEbLeKiV5HlVJ66lZpMWZB9VDH+Xx7uwPjeRsoLsimATxk1QC8Kq8BOZySLGilEWOMAtjTsTYmxNMQjkNmLqNbEXSplZ6OryX1dVFqcQReVzSaZgiqxTGhGUoK8TCzqoxAkr6ke5KvdTvMiWOsfoxkcmazwgPEeo19+M3WLs1XzzII1N1FcOr22EECCghwPRj0JWWB7pB6H3heJuiySOjQE7G7LTOMLwwmbPiQXHUce98xEJaoKcmwMXdrbJpI3qSIj270ZzDp6bnNoIw7YHOXJITpevgQNywgT23UjbNTqRI0XWWv38ZpIFUu/e+a6JpyM7p8jwlfT+ax1X0XOjZTXrP4Vb/PZa8OUSUIUfAD2pi;4:ChBBOazfoAUuCD7SJV5P//JWK7J702Rh1M7tjqZbEL0npW5NnSf6puTg1yWlHpLkLVZPHCJ5i6fXLVJ8Weje2XYMt6ijJrHPWCJjeBgqZ1t32UAA9VklydW5IOXUvs1ydxgXOzBwrpgeHdCSsWgzA3+A+I8rFkP5TEeSKbF3Rdr0M8XsvuRM/ga124n69Lyk32B69c3FL+7IarsfEPOp4cTUAJasr5rdaJKYpCpFUVSnj4HQKhv7g9atZBIlm6mWjtHrAbrhm28CJ0wtIsKjtgrhKnu7d8Q0SbbbpN8xcOT2eX8RgxvLi+O8dkYq0QhB
X-Microsoft-Antispam-PRVS: <AM6PR08MB3256AAB8918E5750D3FFA044B04E0@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(346002)(39850400004)(199004)(189003)(105586002)(186003)(1857600001)(6506007)(386003)(48376002)(76176011)(50466002)(6116002)(6486002)(97736004)(3846002)(1076002)(68736007)(53936002)(51416003)(5660300001)(107886003)(39060400002)(52116002)(478600001)(26005)(16526019)(2906002)(36756003)(6512007)(81166006)(81156014)(8936002)(66066001)(8676002)(7736002)(305945005)(4326008)(86362001)(6666003)(47776003)(6916009)(106356001)(14444005)(316002)(16586007)(486006)(50226002)(11346002)(53416004)(54906003)(2616005)(25786009)(476003)(446003)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3256;23:Z0XFHrEk/ronurh39uxEnG8OKa5Ny54VR9kgJnx96?=
 =?us-ascii?Q?2rJXj7hK9fjp+QeHcFyQ4PqNvcn/tJRHvsNHpvNWRQ5RbpZ01Z5pTDaT6+mf?=
 =?us-ascii?Q?p9z+o9E+qpIe0gdL6j++gXIFOQl9g/p5OdADN/8JCVGXZRk7nuq1zJhFRGfB?=
 =?us-ascii?Q?Fz/5wTyve01rVZ0vY4X65URJEb2bcnAZsKEvpHk0YoljpD7X/QnYmFPLRoSQ?=
 =?us-ascii?Q?QlMM1iRFujmKoIGliu7sED48/pWSU8oG7RafPlTlM8peH3ZPNzM/06MhpI+p?=
 =?us-ascii?Q?HEmbyFe7agyR6HH6IFcVCZBTiOEyRtafEoUoLDx8ac2u+b1nCsIijtKkik5T?=
 =?us-ascii?Q?R3hYL+V/tqdtugGrJ8jJ5vn5RQiJjWkdZOMob2Mk8qDkXpu1Q0Ou4Wzj276I?=
 =?us-ascii?Q?2OiFcEsw7aoJFGrOeIpoo59t19wSd3HQjSS8a5VnWvkCdshVCeWZj1HuVzVz?=
 =?us-ascii?Q?/9OwnTYp7oKRikoPQMD792P4LB9+E87HmegajhCPNmEGltk4KFLV91aweFoK?=
 =?us-ascii?Q?pbKe5rS6uEReV56ftuI/O2NIZCtyWemtBSTtc07nD8Sur0HyBHnZAn/qEn+E?=
 =?us-ascii?Q?SXma8cRjQPsmitvxOPzmasS/XQdPO18nMZLbooYZmx6GIOOD7eNBnw3Mk5Kn?=
 =?us-ascii?Q?VovvMyWsSer6MaXKvMwTXd04O+oybzvpdwMnvLKYJLcCN0lUtXynx4PzsAP1?=
 =?us-ascii?Q?sjwLdEWzP3lElDjF3rrTyWcZ4v3XYkRbjUw8Kp2czlSUQ56d160gUgmq21rQ?=
 =?us-ascii?Q?ZJVcAjDjCovNGrUpPnm0X4Wi313GHzplhn5Mglqq1zr5itOZDwcknm4uPK+2?=
 =?us-ascii?Q?15rlvpDFbWAz1uLj1kzJwKsutzeJSU5SJIYsFHimaGE/btLeAd3Oa3PLeB0X?=
 =?us-ascii?Q?biK6Xbactdzf7gsPSgdK2hi62HyX6nSyiWCQdmcjICPCRyb4l6zyoaoygMa4?=
 =?us-ascii?Q?BbxZpXx0blVzCmgBuwz3mWzoqVHSWF8eK2biXc+F3M/9ifnPM7Kkfk6LE2pe?=
 =?us-ascii?Q?YWl5FcyT5ViiNO/Xf5nDUQ0OXbWBh4/yLdgk015aBXEFB3vyXKNUhLrIN3xR?=
 =?us-ascii?Q?kaF/IVhv4z7LosaVoX1dxEGJIpteGII2yzAy/krAzi6mowH2NXEFwjBxRmOA?=
 =?us-ascii?Q?rJYhjoDWEKXIY+hsAHpT8EZraiVj6FueqFpJihNN0wlGT64fOnsOGngUSyLV?=
 =?us-ascii?Q?7jByR6tnU7sB1BKd2hxeRuIxOIVe6STDA3O+27mvnqy+5KoxyTmsSMgKd6lY?=
 =?us-ascii?Q?qaioNQJ0P3DKCmVHRaxLBjMQTp1dQAaYpyH3P6iSB6kOZ/KbwiOeExqAeOyK?=
 =?us-ascii?Q?LBjRBaRAFgtI7ACiENoV7U=3D?=
X-Microsoft-Antispam-Message-Info: ppyK5HJ28PbALNNrBI/4wYEwZxhZKBFb9sxdt1YdRVlsVwsM3m3h9cL/tlB/44a2xigrLQIIeYyOppmfCZgldJ9ItM7rr5M1Hfw0kYnYsPQJ780T/pnoJYJth4c6JCbwq2OIin0QBY7ISWjCXJIIqBuRAz9B0Nnudwo2qJBwFAwc/x5ngcKv8dEmgjMM7s6VmwFBbYJMb9HySs9F5dl+WEig252v6gQaxu8QDfDm40YVhAVVal9Ct4KHN3+gTyiHHg7UGZBD5F457w1QSWPjDUrigdiTnt4Ts6tGXfNHmFeoF2Mj+6WeRDnb8fDlOt4EaozgekPFv5MteIrbSoQ6s5z6iVFXn25x0BVhY8xpBU8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:1e0h5rNfuUk9239Kys7PVjerwc9sOg4Zz1wp58i0WOK6WLfRYNOk5UF679XhKjaaPuTuY38ushDA0aeikNK2B7wA8j3dHGYDJbh3eKYeDlRhMNqBigNAiFehxWLD92KvKqZalpF7gvXO3XFrX+jGXvEsydWqh9wcJCjZp6qrvekxzrgcnsto6xbYkwPcsutbxtkr2TiMd7mprM+tjQPwHYRLQuHcJJcvyqmqUCbyzgMoQmjrD5Kzr2pTDR9/EF8YIXUdO7CobK1nQyPGwoYZ37vOKlvodQM59RRSgoqUeKQkP/y2dXIHjomqBK+MjnEWO/Be5FMFzHj+115s9xi58E+5a1y3MXwq7JNIZV3fLBUotkCo067dDWqI+dbIeY7Aog9tUm/02ShJQDZPA8sqR+l7pMbqyfMlPDpAIpSlcikGfpdE2eCPLpDRoObhE1/qh6W/UOBulIwkRr2XF332Ow==;5:4NZGNfWCgOrJeOvAxSMmo6bog35lakxY6342kf282aODct7byLHKery4IWQy+tbUoB5ow5+ktGGC2ogV1M1Y2IX9tyZQ6BUv+mm3SrerLz8NZfQr4J6q8RRnfRssxgxfCqhlPAeZXrqdVITH3u3GxZq9Q2mXBOeU4AHm1R9HQ58=;24:UJevNJwK4PLx8skSDDN8B173Qv1ph95/BZvztu8f0wzDSqBaWoNwGAkwyQduNb+IiLk/dqiNhEntzbkZdRJl5iRKltNT0mQFOG7+ehyH4Y0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;7:AK2/w7w7qz+455zBotX2kreMUpvLD2iQBUwEbAxM5COALHcJ/m0OFuF3LX/WY8K7WdU6kJv2Lovp2Q7DhSMSu+e7ts+ZpCAKOZA4snnjQsM1nNtj5OlJRTYgevH+tVifp3kHc7px49QvXKsvXaih/4D4KI+AhM26wZaqkl4LU4yC3IETSS0XWOJo5JDKEz7gKKM5z+ZYG/38GAnINWLJFxgWP+u8VrD4ojbZvSRTIRBwmBJBsyoKC0qEKH2fzVQx;20:Hf2lVE0/khMOjNVnpX3LxDe5823nE/5TVCamR4/fblBP8/uX7YYtImEeQLso4r5Cy5igUz2OEVLTMAGoYL0D/xTgwzs26QqGGmgCexX70rhVmSjHeJ3KaK39Ted4S53Qrak+kV2KfvSBzlafuojN0c6589rAKouDcDGd/Qjoqy8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 18:43:43.6912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec025f2-a2b2-4b97-4416-08d5ddf03dee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed integer overflow is undefined according to the C standard.
The overflow in ksys_fadvise64_64() is deliberate, but since it is signed
overflow, UBSAN complains:
	UBSAN: Undefined behaviour in mm/fadvise.c:76:10
	signed integer overflow:
	4 + 9223372036854775805 cannot be represented in type 'long long int'

Use unsigned types to do math. Unsigned overflow is defined so UBSAN
will not complain about it. This patch doesn't change generated code.

Reported-by: <icytxw@gmail.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/fadvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index afa41491d324..1eaf2002d79a 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -73,7 +73,7 @@ int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
 	}
 
 	/* Careful about overflows. Len == 0 means "as much as possible" */
-	endbyte = offset + len;
+	endbyte = (u64)offset + (u64)len;
 	if (!len || endbyte < len)
 		endbyte = -1;
 	else
-- 
2.16.4

