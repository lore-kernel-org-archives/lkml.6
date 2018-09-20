Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F43B2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FNc347Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F43B2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbeITTkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:40:01 -0400
Received: from mail-ve1eur01on0131.outbound.protection.outlook.com ([104.47.1.131]:6684
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731223AbeITTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Dz56mb9OPpPukvwWgrTKcuyK6SxW+YjWNTCGyfLvs=;
 b=FNc347Mms1S9mO8V6jY7cMyWJRSkqIrnfxksXlLq9hFI0BOx2vw8S2KWDZpd2e+JyFxxYTCDt4pum5IZ+VPuUYyXu54rywpp9QYid4dsAqfyXclJQmXrSYXxAhaBEqLouckqFhNzJipPbE58ydwBy3QkAjut49m2babpqN9e8Gg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 13:56:19 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2 1/3] linkage.h: Align weak symbols.
Date:   Thu, 20 Sep 2018 16:56:29 +0300
Message-Id: <20180920135631.23833-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180914152800.GB6236@arm.com>
References: <20180914152800.GB6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:3:76::14) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89c1e23-7118-465c-2623-08d61f00d7f8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:MYqHVf5ZIkGOqRvHzGkEdMss/r5xg6vmINaFmsQEg6uuV+a+UIJxIl5Hz5DxgRaR7GKPa98NhnuPxSEafSXh95Mj3dQ1N9JhoiC/3kh7WDojvJz+3UcuRWPUDxaDhF8nxQfvwuXqSHFBeFz4jUInaE/f1wg9nCbtuoDjI0DzgRO4LkXiSwRQ0wHXhyZsApCu7BGAB8yQ/Xbc+l+vgBocM7RRQIHpXhNA34DUCcnRiNZ+PlS/795ckibAZfTQO9xJ;25:CoH4Mx3beAmZZdIa4fnlXxMhIxlomF4b8lRG2DtUjIdTyyAXfxz8wSz8ylT167Q065PS0PwffciwYyzbsK5J0ACDjTB5nvZzog2+ocaPrIPssnlDtaucaGCpJcM6OWSjVehd0gW/NI4vlU9RGoosPRmmorGW0+rncNAlxwgWpwfzpgVWmgUh8FzaaTvOcV3natTATANKkvCCl3iU8kxfK3DvfpGqhX1wHG74BB1Dd5QdDcXGDJwlTRm7gMJkO905KbflyoAtpiijT+DK9BI1f3aay92WcCbjSHxZNiNnTmWqvs0UmYyq8Snaj9swMrWFLG+X7I83Azver1V2C/a1wg==;31:jYbW1wZDv3yDQRbQ2vhtLmsxi8hBQs3lUlTkMmjIqGlsLxH5MCmUHroFxFJhYG2alxd7TQDVRZJTlhmIX8BDzXqEpI5YhK2yAWuabQcoKARnsjpOts/uzSDH31sWeOflu7EGPhlapkbW6lSp7E2Hp34lBa7z5WJBKcRdgM67ERE97Ysv6Dh111SVL/s7MT+ZU3+6Fx47LzYLxK+cO+tAAuSTsW3PpFDDvw7YFHCVJ74=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:6JYJCYOuBwgq3bk37JMHu2XfjxZSoNu7vb2eBgzM9iJLFHql3RK3R01G5DaQ8GvepAwVLvFExRRQfWHcmpMZNhLm8l73ER/jsqqc3fWxFVwNcYSANmkhb4pHrbhyISsZStnTU75/xwSwTKkszcbwRo6iX5f9MbbjU/Esh0O+HG6FdFb2NzE0uApF5T+oBjrnOxuT8B54V2RHSeiObuF445VFZkmvzM2foBJQP+4C/oCF+AMta4hdVuIaN70GDynmv6aOUXicb45ck5ACh8TwHSB3/Pb3IoNMURDXqZl3uFgeD3N63xmio3LhYeNbXqtk/B2CBItaGDPqLAJVb+ZQ7wuK4eNuCS6XL8BsC/bCVzLlS7P2pgdrjp/4JxSlswNk8QiA8b7haoTLTYCe+H+JYS2+CaIsszkwnJxY8JodDKob+3tJrwNR1TpM3ZNEnH+iDsuowp3Tx1naEPh6JZPzsKRyVnSa88VZptE6tVSWEForiEbHDGThM6BUnuqJTc2n;4:fcpC6miEIIrS3S6/IS6gEI8Sj7YV/gPchqu1H0UGUWos7lm4w1ek7gtlLOVAO/vUIw2cY2NQ0UIowEFHFcwDvGBEOrGrWLVcfKLxuNIrQoTcrjPetHgVgVxffbzwVTyRwJOZpleKVpJbgfyxxFCEdDzdDtj2vTN24lfGRP/6DR0jnRbqqviLtPjOh5i8YIDXgNeROqI0dwNKjMvbjtMZTXjdVOGvRuKZ3cGDyWZIXVOFhL2FdDUcTMzv4Wl3W67CQmof08e9Uo+8Pae9txhxHg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB326439C93B05919EAAF86C99B0130@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(68736007)(52116002)(7416002)(7736002)(956004)(6512007)(11346002)(50226002)(446003)(386003)(6506007)(1076002)(6116002)(8936002)(476003)(50466002)(16526019)(486006)(97736004)(478600001)(186003)(8676002)(53936002)(48376002)(86362001)(2616005)(26005)(4326008)(107886003)(81156014)(106356001)(2906002)(105586002)(305945005)(5660300001)(6486002)(316002)(6666003)(51416003)(53416004)(16586007)(110136005)(81166006)(76176011)(36756003)(66066001)(3846002)(25786009)(54906003)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3264;23:nNe9uaCoaD63XFozjvQGn3yziddwH6O4jvZvz1vOe?=
 =?us-ascii?Q?/20kaVl3rltxJaKo7k/dlHR3PPTHpDRf2M0HqnueDnjf3RkZDSBGdvEHaACf?=
 =?us-ascii?Q?Zub75noNpI7rdE8P6JunVwdKJaiRB9GqXe+bztMEblcWUSCEhcEjM3ZrSByC?=
 =?us-ascii?Q?nJDyOpCaT0EfMUGNdmmIF0z1GZpkR8LofTnmBkkAbRv7yGIcg0TgY7hu0JW7?=
 =?us-ascii?Q?vp14svq4qFivQvtwVWbD8dOc9/cGU6f5PEmLUF2LV/QjZksktdzuYBYxBzBN?=
 =?us-ascii?Q?DgNFzAQQopyap7P9TmlyZHwFl7YVZPAVzOv2jQVpE3Eg6EOjV28/nwSCe40B?=
 =?us-ascii?Q?arMansp85EFpBd0rOM+Op0c/n43j+FZmSkiWlUjDF6PUujd8cdRMQ5S4lYOk?=
 =?us-ascii?Q?XuwzTt5hEMm80AMnaWgsn5hUlkC+5JmAfO+NzGI+rqqubVf2u2M9R/+ymPmP?=
 =?us-ascii?Q?oid8nIYvXQMXHcxzLlhCLM0P4xLUwowHPYReVAuVo4JXnCexmrP+XPoy84bI?=
 =?us-ascii?Q?AcJPY84sU628W7LgQcQkpIwvkKcfunxD9S3pfIp95JP/LskCauMQejyZkZKd?=
 =?us-ascii?Q?ClXJZHwLMp+aF4IXMS9Bir3eCNh9hwTNjxGTDt0Gmbw84AUcAwkp7ifFS+DL?=
 =?us-ascii?Q?7K1w39m4t535UUWXSJg1yNsJKPLYR6JgOlp7wrQhe3plOtw6+fgnFo5nTG23?=
 =?us-ascii?Q?mM2/7yGP/bd65JLtuw+PMQptR43NbLYrC9BXfae4K4OC2uh9B6pp1FVu15TC?=
 =?us-ascii?Q?SKeXcRYFlwiaV4TIHNU/iF5SJqWrdL/cWHKB3A7roHJ8N+z8UrEupt8znw8w?=
 =?us-ascii?Q?3pDNk3104nflc8wsvxKhADgiEueDgJKhN1PzRvKjw80w5fCsb+LUPGYw8eRW?=
 =?us-ascii?Q?H+WtCAGA+kAA/vETcPRlsbMZNwe9Nalo8Yul0BLoLmUvvuLoItDah/ENorPW?=
 =?us-ascii?Q?Acnuq7zIR7q1PA/cHth+gD1qqkRJ2CQJqa2T1ZwwPAUDJYEqY7R4Y8lTJZiO?=
 =?us-ascii?Q?MHV9Hx5tTba6g6qvvmkdLDUNMVFJStkAg2OlAsWygHI05sbdOsTYQSDug441?=
 =?us-ascii?Q?Q9wFJXw3a218pLZrtqKeRv+pM/qDH2LmawFBmh1o81NvGgL1Q3Boww620ijp?=
 =?us-ascii?Q?IUA+ahdEw+3eb8oDnZOECB+e78dmQSXhfGFnjCqs88/jpne8L4jIHqcN2wTa?=
 =?us-ascii?Q?R4Br4MhZtqddouD8fwHQT0C6ePxG5LNp0IeFuAkjlFWlh1t+6WRjryvmGJD6?=
 =?us-ascii?Q?Bd/SubXHYZgwWLJCyj7vsvFYG33N1AmNdgdXzfz?=
X-Microsoft-Antispam-Message-Info: k/NxHz5ZTsCNhiSDxPAYY+stqq5PSRrZkWlC9n/IENDfuAUWCiP55XFZjYI7CdDTwDliZioxq59WA8IROUQhjfH95ItDkjfd9j0LP0bY4vrKJM41HZr1fZSsVlVyUK+h5G8w5Hr8nVCkgrFX+Th5nBT8RPXGtfhCj2xLNsoPudDFEfy42J/DRQNY8JTibABKbLq/tQfhVhAUXTvb9uSQaQiNMsH+d92d+SAV8D8Wl0eHmNKUqJAT3C4KwjFvzmHAemUKKT7fFdkwCyY1B6GKV+i2mHCvlbywfFY/nTBKvCJaXC7efxD58gvNzo/F+A5DEso8DMMbrBqbaSQcAjOZQU0tBXE8IPiyrOP4mLkdGUk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:0JoPMw3SnGH7xxwi9t0QFg2uBnJf0HkbOqSp7vRZPMaOVbSMEO3OumYtM/UNBGprZRWrFyZL8vIjdzv1Ju2wVzcACfQM5HGVWSaoUjJO9OP52KzjmnonnB3EPCfTzIEUogKGsVRrc2M32Mp9RpyOH8RVb8b2MwTIETdrMJXjbf6xOdO9A81qBw8U8zrJQy1OkSnB+Ul9y/S5FpFlCOF5bEU3UZ6euUBkBzXg2N3L21ZiGUX20xrEN4l7oItYSNDYSB0rZCOVnVrBopIG43NJECVI9XGbUNmGbUYlNDxNNxGIZavHJQ6lbdN3TSDe6gXziEb9Yh7qldkMBeN8yQeLsqAE0d8cqTx7R7rdj0dQFBAux//6/6VVPkzGTrctQHrW+oI63BCY5eKKwh5+0STrj+7Mvx608MlHirJ5bhIPYbf1dXiyl+zkrucOkLKLqWMlWcWkdMefwiyyaJy4KmVl6A==;5:39l76fq6MIQMprsWrX7vW9fts0UdTMhMULKfyLRFTigggrI+FVXVsCr3FmxCp6/TGYew3e37dVFJQ1IAWxQVyVqRZ+m9cZlXDxghQZn06eG0ZffiHBG3B3jNUmw/k2biihH1Ti0JAiw7mJgLVDMOnijbmKJ0XJ7Ci5px1GYazGM=;7:0/VOgXbinN81CMEXZRI/sfY1PzrgTm69fydcks+Ttt6/75SnNcJ9vzvyL6Z/VcPUdON5dXw09zn0cpQLbb8Tli1m2GpDea+Xj5ot3CsK8c1di/CHPXBmXa4u5L/gFvagDZ5gPGS0T71WJhVPxPe09hWVBNrgNkDtRhv+eWUjMYLqoOWROgw+wX/6nfein3LDWj3pG8u88dE1/X3brk2A1IT8XrVCWItMz2wAH0Qq0RqKjMJUTyCjk76dL+8hrMX/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:0rOKq66dnhDQeQxPksiaa1ZlhMDNReTSgvVgEOM7qIO5UdIJQ0kYcLTrVngnvBOFC4MoYGAAeZB4GNb/5fK5FsovR/uiABuiSJZghb24uN/FvLTaZOgvO80o7XJ643Tk3c256j/yjJFlbqGBw4uvbHbfaSyS3L6eNRo9q1okKZw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 13:56:19.1461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89c1e23-7118-465c-2623-08d61f00d7f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since WEAK() supposed to be used instead of ENTRY() to define weak
symbols, but unlike ENTRY() it doesn't have ALIGN directive.
It seems there is no actual reason to not have, so let's add
ALIGN to WEAK() too.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/linkage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index d7618c41f74c..7c47b1a471d4 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -90,6 +90,7 @@
 #ifndef WEAK
 #define WEAK(name)	   \
 	.weak name ASM_NL   \
+	ALIGN ASM_NL \
 	name:
 #endif
 
-- 
2.16.4

