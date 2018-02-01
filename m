Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeBASBA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:01:00 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:56704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeBASAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:51 -0500
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
Subject: [PATCH 3/5] lib/strscpy: Shut up KASAN false-positives in strscpy()
Date: Thu,  1 Feb 2018 21:00:50 +0300
Message-Id: <20180201180052.32643-3-aryabinin@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae3789b2-b98c-474c-a559-08d5699dba3b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:K2jeiCwSnvSUgmOwOGKkQ/XsINuRU0aE9NM6si1nGZOxJ2c5BAMfIgzhh1CkKcS5Gfmy3NyZPFwXRBgBHLvNMGbR+npvvLLEb5nQLCjrNavg8K8uZGkoV6k7kyFvs/gtuUoxqmd5MEOjbZQt6xYv227CLNXFCoxOr4si0RosWNyaNn3Ob2W0zK5RBJ6cLQVb6GBtjFfTrGgRt1jUjaDHRriAO+8x8nXx7T2jxD8RQXx6bj8fsQYeelNMHsQrCZxI;25:vw0ryb2DL6etz3fwRe019xUWZdGYJ6q8H5rQKEx+yo3PRK+86HjQ2inXFD/VrBROoF5BWDkcxMVUjgmvR5CCGk6MxOoOqMAFT5VVwqHYTH6DH5Id158Aqih3+JOyUz02sfSucdJeUIYX2a2x0aIX9VFsfKYIKce+HB8v3LMxipVlD1nCfV0zJJzx7XH5NxkDqa3C+eqj01VBg2dU6VW9jVk7m0G44NJq9WcwY6mmq1NTH9WrrZmWEe56VtHiDQObD4/i1vXDQbB68MAS6BNzlV2G4WnhNy2ClETE75mou+s/WVYwfVfXQKZgVwo9nvrM+MKCkmSm3hspcdJxx+8ExQ==;31:mrMC0rqJj6DHyqbGyan3rkLKbx7JYA+VJb6o0JTCgR8RglhEwByKiBpldy9INhMQjpQRAv7aI0Mzlv7+wT5Zqd1B/QeuBaVhVfFAMd8NzhUGduD39RvNjKtH2nnbttEWMfjN3HBo85gUNx0uMqOx8p1Rp5PXkDGl7CwXJ+M+lz02/3EB0ec6Sv7/RPpPgHkHvlkXIEHP6iBgx9AZBJEv4V1aJbGHShrcaImXTWb3/Io=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:iWUfMD9+yRq6aGh2vOfxeRYu1ISfz5rXIgQnco6TtAZurH1pVaG9fg0BFW8NXsV42BFpf6uXL2TN02N0jwsQLxqtPOE/MO2EQeA02FE0h6uzc0n/wJBMQxt7HCuX5ZAHkfgMaSJ8KnoZOfFvbHNpzJRcGtXKXSDqSMI/tyF9huhfNgHa2fVUX4UhoAL6BL//1S+kTU8s+vEbhiOH0Af3z9mJMK8a86AAoP7B9xX7x3+QkDRSf3eQ2MlruCgqnQFB4b0RFjKMc2Hzf8WCRqBIUjQK/YxeBQPROkwUjhrX74cOZkbcnsFUPU8TgW1yfkrOfnUi8Psp0rqna1iXPBAexgLIaBMNuAZvRdk9GkCJgJ0tpz2N0wOzloWMzVMCIk6rq0Uzwx954iyHJJAiOHCr3yXUZhBHiqE0aAx+ZkVesO0=;4:k9Dw8jPiJGt3lUee1G/esEM+OZfVSEKK7I3zMQKPPZgwhgNeJrndo6hnqxhymxF7zhEs6FNyunVs0nQ04hSdVAfmQi8iwMBHde0Z+EK3VYQyOU4jaI0YZzHVil5HlTBI0I+f/9M69CicVkufzhgYtfqSs20i4z7UKOAZzO9Ck518/mJUpGBSI+OdvtpOPz2c0eHBozmWj8dDQMWfVv9+P4FvBWYd1IoP/wK+BFUiK9ZLKki53G5GEJGAECbRui8ONJsjcaafJE3XQliguevG5Q==
X-Microsoft-Antispam-PRVS: <HE1PR08MB2827A3FC9C09FA027A829177B0FA0@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(39380400002)(396003)(376002)(366004)(189003)(199004)(386003)(25786009)(6116002)(3846002)(1076002)(7416002)(316002)(47776003)(54906003)(48376002)(53936002)(66066001)(6486002)(26005)(106356001)(16586007)(6506007)(55236004)(478600001)(16526019)(4326008)(76506005)(6512007)(50466002)(107886003)(97736004)(8936002)(50226002)(52116002)(81156014)(81166006)(5660300001)(59450400001)(7736002)(53416004)(186003)(69596002)(2906002)(86362001)(6916009)(305945005)(8676002)(68736007)(51416003)(6666003)(36756003)(76176011)(105586002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2827;23:M1qrJMQ7Y387Aa5UFi2w8peSPtN4PtqcEIjH5sa9D?=
 =?us-ascii?Q?MkgDxtcKayhNsC9XxTxjRf2spNQtZ8ORJmXOC+zcHJeCfvEMhoTXj8zjHM+/?=
 =?us-ascii?Q?6Iz63CNqD3thnEpY+c804ADagUddyk4PLtMyoZCEO4yWBV45o0ffPQf9Msq6?=
 =?us-ascii?Q?IzY7TOkeFFlUqJfTcd23nZILIgm0bJN2p7vaUv/HuMb2zSpZWXVDul+kEwlD?=
 =?us-ascii?Q?iex3EZkVxuXNRaYHyT4pQkv4bpTV/c8hCU4xr7RIA+0cMnyLMOWLCQm9Vo71?=
 =?us-ascii?Q?8Icw7sZ88HA+IH3p/NFflxlJBEbVzvVDvICVpZANDYxVFA7FK8I6HBGpD5Ia?=
 =?us-ascii?Q?Pvvr135KFyTpKa3mTMinlzFEvoxFpWbj1mYoWnBxKAd2kl2LNgoKx8lhqpZB?=
 =?us-ascii?Q?5mWopp5BpPGgXGa2Imc9fJyQyPouMVS+cf35dsizo7iDXmHrUFGb9KL+1fjw?=
 =?us-ascii?Q?iwNegJjO9sz1qXZ9cANbNS+w4g0xdEd+dDUDdOKyRV6h/97qj0i/x/k8sLOr?=
 =?us-ascii?Q?OBt69nU7qh0AVPkc0kzSXhytoigXMpbHAEsbLdTlY10rszwsks1zHui0SoQy?=
 =?us-ascii?Q?mhhhWqZSXW31CIki4s52GQehVdFQY2DcCevQcp/2SpwRiWViDfzf/oYKogKM?=
 =?us-ascii?Q?qpJKN1l2pYsgvj0X5iNamEsD0M/IJ3MnOX730VvXTfseDXAgGc2D9xnCUNPh?=
 =?us-ascii?Q?qn2yBeDzNVyKRLWB+2hvbWj6Q77loUbArqQCM6DWkMLHHb0VOiQgG82q9Jxx?=
 =?us-ascii?Q?Qh4LmpelvmoCq1t3U2eg3Xo9PLb0aIAHjWcJORwC7ZUGAbwaRhW5zqgGBgyY?=
 =?us-ascii?Q?ByBMCss3WKUmyZUhILTunZqLuiu63NcXOKVBf6A4aB6NMveucVO6Z6rzY9ej?=
 =?us-ascii?Q?VOIDJGqJL9M7N8J5kk5V1zTZNHNGur/PmBWKgBdL1rbEn66Gk9iEYcHtq8zj?=
 =?us-ascii?Q?dibY5H/elxbWjDqz99DAZXaE32WrW6l4UZIsAwFtLENYxHPCTzLD8nL1urno?=
 =?us-ascii?Q?K6OQLHA+NVl5YO/AKRFdCiM3YaE57NtV0oNA2aE14IpT/05UYxmymxkZNM35?=
 =?us-ascii?Q?7VIW4RgD2shwQfqJRjK3D5RoFmvvN+ZTs/yFeVN5cXXuPaut5JSqXc9dm0qy?=
 =?us-ascii?Q?1T6sdz9X38dG5qVPpDkQf0YouJb9VN966l4/KCsMcGsUeS7bwncGFCF4l0Om?=
 =?us-ascii?Q?YFitztKesLFfIaFEEmgNFO0oRC2b710dggE+6auH0LNi92O7SET/ug8EF06i?=
 =?us-ascii?Q?iGohL/g/z6/SVVNZadvwY+pahkR6pqGAEFQVJP8Pmfb6vZOf6XC0e+ainbgw?=
 =?us-ascii?Q?yutvNaOddVxa0u7aD6LSCU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:6NBOe1IxpbQQGFyu618/1eeINSvlMA0DG1vBH80mrfgCy2GeUGOzJ7OjJ5ohqnvzqdYwyIFgT9tb2L8TTCzqSjWewEXoBmLP0CjGFTbPFIrilCR4aVpdcyB0Y44tcSMoQ6dOM0GIKanXsprdrw4wrfCsCCkdYfFPFqRancoFWuJLPOjWQ6Afhdrgq0CVzyUSDUMZb1AEQOnbbbcvVeC6DWs/zZCdoeAgm7QkjZtHTF+mogdVIdeMwoqmn51MT2NABGAeO8y1VPJuUUCB3TQ4t4oKussQGmtaI1E34KNkoMs6jx/T0IVrPC3zyZxBGPKA+WJ/0dfLzUy+WfoUvtx/6iCrO1BtuwIDyqJV3Imcr4I=;5:SWHNPrUVpEuTnqCp7cQ/rppZH7Kj/X5iiI9iVtfhAsDKrfjLLcJ56ZpKD26pJC3jBQCAnCbS47qHqTMSlUm9/dhoTqA2b9nnyOI39/U2glTglmoyCUHMkYLCgHT/pyosQX0VcPXc59vO+/JgYqRO+lxwOQe3HHc4hLg2y52IT84=;24:EheulcJwi+7tgJ8/xRIygucvHg9grlJZT1p0PblhYgbJqcLKFTsdduMLEb0f3sxaRJnXZqw5sHHZsCtyPiMGyr93EDRAvUquKlIAONmdmus=;7:ZlINeF73KX2hOreUjLvn+amBi+pjRNm6ROLKvzx5qItwMpBc8CpTLB0Bl+z4Vo+0UvK4liT/hQFdy/8c/hXESURSS2jjpwuMTipd6pJN2RGE8nrfUoUEN7C/996yr+CSgc7Pn/p/kPzXVouKeaWol/OGuNExxS1TuCDQSNTWY6VZaHa5JHKu0puD1khPo5ZqZKJROikbwRNB8gWmQrYh0Vm5zdRhJPBSQHfGCfeulyJeyQyJ8MNmYRIsPAH+azUi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:cvO1Kg7nk1/DLN2FtFKQWqFall4e1H1tsv3kAtW5rC6WrGOwYQcdM56Y9l5a/JX0+fCZ/o9u3Xta5ceYfrGdrCPtQfYKF8/eYwv4/As/a70i1NiEaOroKiTmI3+nFbOKKMO3e3+BpSEd/78Br+BpXmmzOLh2jJyfaW1ZDeT725c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:00:48.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3789b2-b98c-474c-a559-08d5699dba3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strscpy() performs the word-at-a-time optimistic reads. So it may
may access the memory past the end of the object, which is perfectly fine
since strscpy() doesn't use that (past-the-end) data and makes sure the
optimistic read won't cross a page boundary.

Use new read_word_at_a_time() to shut up the KASAN.

Note that this potentially could hide some bugs. In example bellow,
stscpy() will copy more than we should (1-3 extra uninitialized bytes):

        char dst[8];
        char *src;

        src = kmalloc(5, GFP_KERNEL);
        memset(src, 0xff, 5);
        strscpy(dst, src, 8);

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 64a9e33f1daa..2c0900a5d51a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -203,7 +203,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-		c = *(unsigned long *)(src+res);
+		c = read_word_at_a_time(src+res);
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-- 
2.13.6
