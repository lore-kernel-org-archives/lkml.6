Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E78C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669CA25762
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bbhe8V0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669CA25762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbeFYKXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:23:12 -0400
Received: from mail-eopbgr40097.outbound.protection.outlook.com ([40.107.4.97]:23680
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755050AbeFYKXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRpA+nPNUMYtwyULWHiNRTalB467O/COZKU/E0foiNw=;
 b=bbhe8V0Aon8f6W8C9ChIn1vo1ZgdnssIYNZKyAi5E5vhWKa9Zaxrpzi1ND2jhMXwIzoVJSAo0qqKApCwPhX1qx7xfD2tyNLjAyF6tPjxfng8lNr2G5KLjf/JtZKICgEhkiH/W+gPc1IM9Y87VMo1V4ZWVgN4ECECZXLV2b1D4GQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (195.214.232.6) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 10:23:07 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] x86/mm: don't free p4d table when it is folded at runtime.
Date:   Mon, 25 Jun 2018 13:24:27 +0300
Message-Id: <20180625102427.15015-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70fe2b7b-275b-4dd3-f2cb-08d5da85a51c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:Q/OlPtg7IphtF8JRa8Jd/plwzbMHT7X1RTd6ZP+r6WdnGRigqrqCPeoeQGFDHbzDGf96CU8avpIwVv19ui/YPCMsNkwE25VzSYXumgtIK/EuNfLphk8PTIS1MW8Dq0fWxSwOoMOw/V9HaPxudIHMbDodymi1m/17alFvvkQBRNfICyoVop5lTjH0elfGEUkeEtwivtjZJUuPPSKxHQIYgS1lzmPHRm6DKdJ/YHw+r52BeFQOtNbJmYN6WlmIps+n;25:Q+6JCdwaiJcIjAzUbW2g8vFFVe4AZz+W+dc6neC3Xutsq5tGUpF2Vua8JHGmfyO7nppPVBhKRbkmK/tQqjdoqjjQPsom4ErS0rGKhQzgntt9tkPEXi60BiRnQtX4bw8q4HiA4cfXwJquNxNsdreHwJFSEkH9/lXwcF+qxq4C3WOiwtMhrtkMtDjNeJX0+Z2Z67QSVhDaplha3ioYlBfkNs6rtI8cwj4wvXxKINrCZgwUULx4F/ibWjvyY2EnzCXoB/Zk2aZjmOBWxidD/AXizrOjFtQzPm1vmdEYXQh1GycoZxl9hfDo6PDcIyOaLeBChDV04bzx8/+eFJQQRxYLKA==;31:whvAkT6HwoBLU+oOwq49V69xqW03fuEnI3efqlm16YM6IJcKmYY4X7W4C//gFhaMWFHn6p3UKaE8uRlXy75b0PHZVaQnlkHnvNW3nZ95WvXp3VbRjjyGEu+9La0VIQ14H8yEzUHy23zhbsQ9BahFi+aLUMgHpQ5yuvzZXYS34vP+ty6tXFMjLFIsJfwhxmPryNZctzC2Zqbfhxup0rfsC1trasS0gkZfAqpOQ05pVIM=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:yzlno/KNHCL8P9nPuTPQGWUlPHC7Q19W5YCxwXiLYzyW7AEUcOEJxbWYpk8ArZA13q9rLoH8wLVQQMfO9LZ0KR3FLLq/YSdHNEMmKdB+uJEnZPVal0iHnCRL9McgiCrwf1W0uCQxenFrttlmGd2siHuo7BTl626uuRuYoTiGmsDDbQl3aysZul+FRn5uo9/ii7Shx1Z0KMcmV/SzJFT9uN0ydST6JWTNWHBC5bvhX48QHBSDjMF8uFtLLw4CT6GfM+tQHAp02OiIdwacaqEfoyBcFaWlhE8LFS+fvRRBWDmIpV0uT+mHOusG+aLDVaJ74Woqcxyfxnyi5HADiutpdDkcuDUj6TvNNpdOdD5HVRkmgfY0Dj3DB2g8JnJkVqg7KXyHJjalo0cLpYWriKCRuFqIm+2YST3DrpyTf7UAxP3ahrXmVqdQv5yCbCffJZveH4sLQYFqHxLvVuR7aiyxDsc/ffo0330SZ4EZS9mIWZSv+oO62sx8ssCUs6nIWXLi;4:Y/HuHp52RdLoBtOtt6nrYtTh/xjMltoN5jvftERyZrqqbSAM4TorTY4QEN8dSOKaXREcTD0KNL/eCl01NW4LFLNSOSaRz1u1tJjpWLjzJTu5rYsqXWQ6GbruJFbLhJAesfKyRSlULEGagzvv4ZkmCnOXoLEmiBRj2IVk9PWm0PnXlLHPUm1n+pA8cylaAdxDI5HTnHqlQO1DY8oBtDfuzB+s7da6+inKd1DobYpp0+at1d7i75MO3kYR65G2EDGSplCNSyK5qqUsvcfQhtgSRw==
X-Microsoft-Antispam-PRVS: <DB7PR08MB32584455CFBF3A64BF854062B04A0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39840400004)(366004)(396003)(199004)(189003)(50226002)(105586002)(5660300001)(68736007)(106356001)(6666003)(97736004)(81156014)(8676002)(25786009)(81166006)(305945005)(4326008)(2906002)(316002)(7736002)(54906003)(110136005)(16586007)(8936002)(476003)(478600001)(26005)(53416004)(1857600001)(1076002)(107886003)(2616005)(6486002)(486006)(55236004)(47776003)(66066001)(6506007)(386003)(36756003)(86362001)(6116002)(6512007)(16526019)(3846002)(50466002)(186003)(48376002)(956004)(59450400001)(51416003)(53936002)(52116002)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3258;23:0hA5Ekos7K041k4w5hWwFIWDsGHwpcKsZ6v53PPPn?=
 =?us-ascii?Q?QJgW8FCqzmfDTINDB+3uMkLZTlujtkAcavflxAYRPNC+JUlH+7XSpva7lnC4?=
 =?us-ascii?Q?dmylpYIHzp1GDJwUuyjZ+UU5OFgjNFedtwPnG/xpD4HWyHPwjdYAwoA6Ktsg?=
 =?us-ascii?Q?MjIQxMcAFmAcYPl1MgxyZCwJ4wGzGKOAACcOtqrfR3bygfoBwuPynQR9E9WX?=
 =?us-ascii?Q?osUmImUVHJX+BaNcemLvJ+tKPuqsll6Nod+uYz8nu59x/RMrJ1j4nhI/m+l7?=
 =?us-ascii?Q?3jwE7fEjGdnF68wciBPDv2D/mZuu+5NpbPd5fzMD3O4kCckQu4nd1xZFeAgy?=
 =?us-ascii?Q?laBW7gpOTfHmD/wC5xVXBUxwSVEVzjbh4fHbqi8mp/T7jwX/2dL5z4wS7/03?=
 =?us-ascii?Q?Qmmsik5GmKkEdq/gOue8scgMUt5AWRS+EIH/JftzFHeGJxBpDVuzM8ag3nGR?=
 =?us-ascii?Q?cEJZskv+TwpS/yE9ArQ99AmLfGByRwKr0jdJ32JhOtLpzRf87xYF+YB2MQKH?=
 =?us-ascii?Q?vKEZAd3RfkLFpLvTet6wmWxpJXIwdxnvouAOtb5LKST2209dtGva6QxIZaqw?=
 =?us-ascii?Q?2vZPWwpiTzkQS+Dp0zHCDH9ru2tT1RuLe0Hwe39gLAhRoE6ji7SytUIMRHPS?=
 =?us-ascii?Q?HNf9CCgA5UCJlTrJWcH+V0vJbj5CXbadHmCFsizi7OG/bIT+/Wav3yidHc49?=
 =?us-ascii?Q?wfMvyUwXUI9zbKTkX5OXTGQSGzd0xP+lI96tiG3f++LfCex1XZGfEV83G13o?=
 =?us-ascii?Q?vaGpa4npTfvijkg9hifBAjYvtqTC+dp1ZDNvn4t/U2+x84dw8EbXcR4REQZL?=
 =?us-ascii?Q?xJJMleHnZbZDxioAX4wwTaKJVhfRXsnOaDcTd5dmMIkWgDKMAZNPC/JJCf0+?=
 =?us-ascii?Q?jXx6bGLzghe64jLCS+W9mM/4kBSSV9C4BlJ8FbpgUNPhQ4YgkVL5OUse41ZH?=
 =?us-ascii?Q?3CCmIk1Tfw3B39RCSkjG8GaKyBhY1q2S4t77slY4GavQPkcAHMigDhL2AiyX?=
 =?us-ascii?Q?csVb2F9qb2irqs8XZk5LU2YK45lfhXU2Abh8Dwf/UlyEG3r0q8RFkuLCL82e?=
 =?us-ascii?Q?cwlLJCMPj/KVT0W4HXAc0JKdM8WwESufqqXQdIsSHeMm4ijbXz7SU7WuPJTS?=
 =?us-ascii?Q?pis1zZUvl92996B3S6LLaQVrOU+FAvOZcy6+Qm3RG35Lgmrs97AN3/5r03Wi?=
 =?us-ascii?Q?9NG5P4V+aJUv6YAkXugiQlAh7WlH5UUSa9Jz6VimmvS8AxjiMnkSXBpNS+qF?=
 =?us-ascii?Q?NJnO2bKhYaneJk4ClwCofH5zZmPw4ejlUlsRGp4eVs/gmzyz0Iu9lPCQCaM7?=
 =?us-ascii?Q?usAt9uGfEawMErkd4CqyvE=3D?=
X-Microsoft-Antispam-Message-Info: i44q7IVyGNfPVMDE8xia3yHTeo47YCjd+TKBqFj5I8Z0AIKtIZP7JCjOIpDdy0+IG48ioVxmjJb5YRuRW7wnJv0peII+NT30qGogivfqMSz3DlFpv32i8UvUCzPx7FjHevBvxMdLka61SPwJdxJHlM4iq5p23yilF17KdS+b9HJprTYWodiwNwfP5JnH2ukQ/UFwIz43U1oIVqQvUDpIkFqjCRH7wAChByp+PcJZZjb5gFcU43wVtiv4H5KX1bqmnKGNVIWHY6QYq0zeBdpMF9rAl6z1Ehe0NGHfswC5zhmw5Rd550rRh6Mb0VeWMLYw3DvIwzKVxlzDWV0UiPmSj0JU52TmZfwMw9ItcIGDGvo=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:LhWB1FoURvLjhxeapzdkNuH0fK4XuTOXv92HCoT9RvEpjBpCNlTQrNvCaWMkH6/TyuZy5zVxgp6B6JxrdRHcmLwmoI6rcCrQskOKXQNGlq3Ktwz8kfqS0rUHhwxH8cEX9qM/W0B/lGJ1KgKV28obYRg5mK36idjJrd68mBMpRTikZ4VHTGptbfqA4UGXayUVxZ9fuOMC0MBIw6UwBdn3UayCULkhoQ2KCVjuUYLT39rQlFpzGyqRy0nyqsWDWD9s84lcglQvp++Dtu4nfUFX8zt8c4qSmNyIrbZb5XHFqVTLBnVHYTauS8xTbO4WreydhWmcgeUA2nJpe8p3Gt1wngAWeBVtSrrzgNeV3Fv4oL6wWHxR+xXa9Kws+gdle4+J9legCnnkFhAUj2IaV1s/2msUgqlx5VcC2N88EbCwyQ7MQbk1gajg1T9woxye23Czs2Xn9ZpzhKURu/8Sceur4w==;5:0jDV3a4y9tWFIvgJwDZSr6ug30vX2itKttHko2+mHcmGQsRMsyg2V3auqLqWpGSbtUMITnTugQdsp+jLVip2+/52wlAqxCjR9wqbDBAlzemYEBA4hao9o1HZ2OXCaFAy1Jjc7SEc7Nw6v+mpYBY90x0JlPfHSWFzIbpz/j6e4Zk=;24:iWE59iqy4fhoDPVBDdQOFbhc/wxSGNK/ISPGaMlZ2iFa4BckVkOn4HTgRa3ihtXR2Yd8IiupU9w2qUDx40vXV6OYj5tApuO/RjsSh+ZKcoU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:NQcwUQ8iEDgfHQZppwlESGueXCjoTrW+vgiWfc24JjOkW+ueIt6zE38gllMiLk4aR18gpyrisssEUM5GWp2ZK58cPSmIPEVv19F4FAa8ngxuMA53ED1ZfoWuoCWarJSurYxj4/0LupTXhHy5ZXqknNFMLhwX7mWrPsBy8Y1ER7/wFr32TDQdbugrDmZnFg+JCtYPrAeOY1cbJ9wB/GlOqQxlHLL1ccNtThb8wvTkN+oKhgKRiXGgvbffK7HsbSjG;20:lWgyjfmJ8D3AJzopFsxrseu6IGWJfV2H+zSoyGmAxa1NErVv7VhvYbUJs0zkMYuRHwbJAM/zG5j22fenm4/j77lpqltUN5gfr5HCi6EhU4IltA+V2JFlzo9/M5zLIUauo4JQcfENi1xHamzbuVX9jPDEditsTO1WrHO5D9MA6fs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 10:23:07.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fe2b7b-275b-4dd3-f2cb-08d5da85a51c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the p4d page table layer is folded at runtime, the p4d_free()
should do nothing, the same as in <asm-generic/pgtable-nop4d.h>.

It seems this bug should cause double-free in efi_call_phys_epilog(),
but I don't know how to trigger that code path, so I can't confirm that
by testing.

Fixes: 98219dda2ab5 ("x86/mm: Fold p4d page table layer at runtime")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 arch/x86/include/asm/pgalloc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index ada6410fd2ec..fbd578daa66e 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -184,6 +184,9 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 {
+	if (!pgtable_l5_enabled())
+		return;
+
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
 	free_page((unsigned long)p4d);
 }
-- 
2.16.4

