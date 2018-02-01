Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeBASBT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:01:19 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:56704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752888AbeBASA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:56 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, Eryu Guan <eguan@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Chris Metcalf <metcalf@alum.mit.edu>,
        David Laight <David.Laight@aculab.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 5/5] fs: dcache: Revert "manually unpoison dname after allocation to shut up kasan's reports"
Date: Thu,  1 Feb 2018 21:00:52 +0300
Message-Id: <20180201180052.32643-5-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180201180052.32643-1-aryabinin@virtuozzo.com>
References: <20180201180052.32643-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:800:92::19) To HE1PR08MB2827.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddda18eb-8e3a-441a-c96c-08d5699dbc45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:8tIkMhBEGHKmGZQ1Ux8/v9vUPSIOQ7WeldxUT+iUj3k3y3h2GNffxdfTzj/He2dSWkb8Ececd091SWMtQCXr91+ByADnozhFIfdVtvSU5UXgi60l6O3EJNtjfzg5fJy5sHTmodzF+3UubOT6/9DZlA1SFiHxnVBsKdp2GdmYHSAU9Mr2QUBzH6hGPG/Vt98nLhlVjjJpqueYnauOzdydE8MoWNNaGEhLmDcnqeo1o5wj1++BcGYb7Bqs50pfuu1K;25:n+IY4bBiVwbFqXmSYw6acZgLUVveOApV95Fup1R3RejfOzgNsiTFcJ1ShBDzxjxa2GYsXRIV34sn9KFeOM1D6HrHoD+/Z5LyV6CGCkqzVZZ1NKAVmuVLGebs1q/p2xAI4kMo0+lScbjDxY4N+EcErLdFsoMS4dPTMKs0bRK9Grt6ZPfaW+7PuOt3Nz9qpl2186HAKqTp4jJi0122Jr7d+Prbiun5D04u+dMa4BTuTFsOZAwEudKDXskaqny3h+MU3fazDG8WjCEigdSyJvLn1zrvZ9DTk06alkrm2J7l9eTuGni8gYPeiVKQP5iSVRLnYfEdmgrhohkCZDY2dJSXAA==;31:6+BIv/IgZcfa7TICKHMndXSKzHPx21XeV+L8OM1cCpqckZRn6oEyhAs5FsUp/m6LbBHbtuJHOv86si8zPqRYik+I492TiXSunCjFR47OzpsRfSQNDC7iXDCr7WKtBnLrvn6tBxffyXjWwjFk6pdJykyVV5Rh4KnLzJPrEgrJGARkO3QHspxWhbefa3S5iMsGyVWOUduDKAKsRbR2izeXQuyLxh/Kkcb9/bOq3/imUts=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:CCQRif++lP61uqWOA1iUQkhEKqz8GJCEiU55Lz/z9yXGP0ZPiLnMEFq9d4lf/OsT3ds3B6EjbyzNYKy5B1Nq73LkvH3blpZTQ7iXjD9UD/Lw4GgXlnJ9HhPxThQhUz2xorvqsPndLe7ZB/uKdTaKu/bVdtIeu02BJ1J42zHlfxcgDbDeGatmrAmSYZNhodLShEFcT2rRrSq2gV0cVEXvpSqdbuBQtdzM3DvTuE8qWuJfmfg0jE15gv3umJUemUQ4Gk/CgoIHrpU1JK6xu0OYNot9YyZnchKVSPQR+UvTN6DS6tguPJks/4UcXa44+m0QY6nYaFQqAhfHvHCIX7JfHwrL/OljJpDtPF1CtJOZdejdtrPk/JI0XogRyMTqDVGd3e0TL3rqBwoOGIU13Zc1TO8mMvb9GW34pfpUdHKKSZY=;4:4MLDM+7pJhEaoHowCCZvmOg+iNTFnDEt6QABqAiCzamjZMWlQcaAe6Macekcg6VVj2VI4NIuIAmtlrrvQBBP4wkuqPVqszAy3MSFh9+pIA0A9GHY9xGauF+ysXj2tA9YfV+CZILNDq5briCAmxSlRiaiF2aaoaUiRaQix1tnMlaWJO82JjZvhyoZYn9sLiOHm1W9U4+crVH9SaGw1/7kjz7sGeBgQTYd6RNCpauYgyQLV99toM5TNXMD3yRlsAHYncHGvZW+23JMrvlwcS8RpcQSir8VZP+fYtQhr2CicaO5g1D3YGphhw3UKaUH50ic
X-Microsoft-Antispam-PRVS: <HE1PR08MB28275A15ED8F0260BA0F3F0AB0FA0@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(39380400002)(396003)(376002)(366004)(189003)(199004)(386003)(25786009)(6116002)(3846002)(1076002)(7416002)(575784001)(316002)(47776003)(54906003)(48376002)(53936002)(66066001)(6486002)(26005)(106356001)(16586007)(6506007)(55236004)(478600001)(16526019)(4326008)(76506005)(6512007)(50466002)(107886003)(97736004)(8936002)(50226002)(52116002)(81156014)(81166006)(5660300001)(59450400001)(7736002)(53416004)(186003)(69596002)(2906002)(86362001)(6916009)(305945005)(8676002)(68736007)(51416003)(36756003)(76176011)(105586002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2827;23:0wmF6kCLgHh5v4118uaji22LFdgIzvDaZV//tm3jR?=
 =?us-ascii?Q?ylJqLwOskRg7rlytpw3WEaXdjzeK2uXjZGwJdrBmOkFFmNpRtcCUiHZXNdc3?=
 =?us-ascii?Q?Iopwg8MKiRRIq5F1D+sP0/OWMTPT2aOLCuw13YhYncKFDzwhXxmRz+k6L9gX?=
 =?us-ascii?Q?ijhU/kf++EYKbt7pBnXL9z7PsO3NoMhkDPDrDRRCR5VMISc1jo0QAQOjE/BW?=
 =?us-ascii?Q?MQFVQBkOa8gvX18qUGEPI5X4zT8b+aBy3y6PbPdc+Y1cQhvKD8aTZghPPBNE?=
 =?us-ascii?Q?F21iUPYUJKsmpBVCqhV/EQpWd9EKmgPeQnJogNI5O8FJq5stIJBpjxqYWtjC?=
 =?us-ascii?Q?sMqC5f5vEqB3b5EVuCITA/7TElIikIeJkA+XsqnqurYPcmfQx4zXbvKenuM3?=
 =?us-ascii?Q?pgklYknNB65Pgh26+zFuUN2Hh8ywroUbeS6H4B24dC45uRT0xE/3vk4Fgve/?=
 =?us-ascii?Q?dAZNxJC6I5y7VQSycMpPUIfoNgbEJTZgoxAEeDge77xQHiNa3mHxBnmXAoAb?=
 =?us-ascii?Q?9KDsIAmvFxoRwoKY6IjA0oRsd3H5vsxsRrPR/OYm6pxClMpOB4IBxTlgdpvF?=
 =?us-ascii?Q?davmhr8c7lp4S4PE3uvpZjhz04MyMVSMSKLPrqSywwYmSFr9z6X3oiZDNI4e?=
 =?us-ascii?Q?spFGSsRglC6nHpjdTjaWGDs1yzYzScgomYBEKCJiSmrru8mMLGZGVYP2MlZ9?=
 =?us-ascii?Q?HRKoo9pgTFoFT3SETznhOg6ynacf7wkEuNVE0cOgBqlXbLDKbRC6RWhWJQdy?=
 =?us-ascii?Q?oZJ7RtjkCFh7Bx14RF13s56lFU+5SIwmkeW3J5KWq8icwrgYTlcsikDldo2W?=
 =?us-ascii?Q?bbielDvGW5STAq0Gr6mDoD5uT9FH4peMW3RkNnuBtPiu9y+919tcxwD89Sq2?=
 =?us-ascii?Q?kPb/zafWUWN6Dz2HDe77QViSL0P0M8cTgZRvNTla+xRaD1+o09iXA+FpHOGf?=
 =?us-ascii?Q?oy83xkRm/SAMGdZ0fGJ/KBdwfxlO5SIFECKES99EXnDB9sg+YyeLnG1GF4/X?=
 =?us-ascii?Q?m9Ko67AXzSTesKePQremxeTKY5ldZDanHVcIwZBeGGC/0wxvz3JvCOKRxATN?=
 =?us-ascii?Q?NdRdOUgqSQRXPfcVUSRITv+BcsuyOsPREf1RuvME+3mgouFy5qm57p6Lq2qI?=
 =?us-ascii?Q?k6a94lyld7/BqfHWgI+jFAyCIKK+th5zIOd+Ay1+dhKEbKjdos4msNEKeyUO?=
 =?us-ascii?Q?QQhsBo0m8TPqaOy3pdJ2x7S1Mtadom4bGWotEHoKvc3VR8Lgh3RID5v4yHf5?=
 =?us-ascii?Q?b3YO5l5BXr5iBJiJrE/yiwxIlACaYNLyaIsPlmUiKmGpbf4ITj3GsCfe9U18?=
 =?us-ascii?Q?/1oJQybAX+tpY6XgLajA0I=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:EBUdWyNdxfSL2/59O7FX/lZSMpIO8aOMkTk4jbuMlBvOeZJQt6TbuAcW8oPqGlrJ1AxjVeTO1ooe8+7OW0WUDDSGS0zAShyZhRDVrk0CNoRVOmcbSrXPUmql9n6/rX6eTsnBa6UJ0enzr8UlWnWRUABVw82JHn1Qw8V585ThKqj0TvA9F+tD+NfOMQohRNlqkJYYUJc7wHU8l5WT6oLtxX1Mil/WrAFKEusBa9hwlpOph6I6uFkB6tq/DBspezSrGdfwpdOHF7iQUVsuCfD/jTJNX5NZYoMIW74yN6vNCDmypAQyr3DIPe1bWbYRUzeivZ5QCKMaHod4hwNukAzwKufkuFmcmxRkYnntBPR8Htw=;5:YwBhc7thOKzU6IK1qH+9sr/AYGTfG3TUYiolCxyIHNz/y+Q8Xxu/trkjfrl/g2MY5N/axsM8ddDlKbvQJXegS00aQCVlYBpUN/bDANKBog0HjnCeHcnL9W4gftyd9TDae/fA2fIWkd2wrz1SmqKsEr2zpwov+N2anvbm9WqdwMw=;24:2k0sWFeXCLgb7y5+7f4e7I2ZYCf7KNOCUoaE6uHuqoJbt7wJ1Hxb0/PwiHOWPDSfuAbMntp2b/NL18F4Sd9FQlJdsvIkqb+VXj/Zng19jkU=;7:u9yZf0+8l43ipVPOilIgT8ra8G4ZeIHr71GjPLlQgXsotukBYs0ti7iYczd5G/Vfae1MANWsxjEoj+iC3xtoo9glCceVQ3s+pDfya+oQ0E7rfLfmwvoUQGqQGNokrWlWe3RbnMARaBkKi9bzoAQG+SAI6ZQqSNp93BNo0//ADR5fA6gZwtJU392uCO9Zx4hdP7X76UYkpBCM5Pfh/M9VQDlWoQKi4GTw2obpkt4Dr/7Shd04eNMMeHdRNXqCW4Cb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:OhS4vlT9MkrungcjdvQX7JfQOCWaaEMw4Yho1/I0IEN0WQJszgjYsqYoKEUjdvCyXftrSdLTt1VeHZdZb6BRC9yJuQz5EYywqxR0MKYN7F/6urXzbJwP9E8UI+fVn29wZpf5MNubI7h6tUpUrJ86Uw9Lkte+OJ2dX1rrsXF0WCo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:00:51.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda18eb-8e3a-441a-c96c-08d5699dbc45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit df4c0e36f1b1782b0611a77c52cc240e5c4752dd.
It's no longer needed since dentry_string_cmp() now uses read_word_at_a_time()
to avoid kasan's reports.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 fs/dcache.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 195999c8d1b4..b3dc1870caa8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -37,8 +37,6 @@
 #include <linux/prefetch.h>
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
-#include <linux/kasan.h>
-
 #include "internal.h"
 #include "mount.h"
 
@@ -1629,9 +1627,6 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		}
 		atomic_set(&p->u.count, 1);
 		dname = p->name;
-		if (IS_ENABLED(CONFIG_DCACHE_WORD_ACCESS))
-			kasan_unpoison_shadow(dname,
-				round_up(name->len + 1,	sizeof(unsigned long)));
 	} else  {
 		dname = dentry->d_iname;
 	}	
-- 
2.13.6
