Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDDQ1L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:27:11 -0400
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:44128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751606AbeDDQ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:27:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Yury Norov <ynorov@caviumnetworks.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        syzkaller-bugs@googlegroups.com, Noam Camus <noamca@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib: fix stall in __bitmap_parselist()
Date: Wed,  4 Apr 2018 19:26:47 +0300
Message-Id: <20180404162647.15763-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [58.11.97.202]
X-ClientProxiedBy: AM4PR0701CA0042.eurprd07.prod.outlook.com
 (2603:10a6:200:42::52) To MWHPR07MB2910.namprd07.prod.outlook.com
 (2603:10b6:300:1e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6c8eb3-02b7-4874-21f0-08d59a48e518
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2910;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;3:iLfSexr3PbZqaMxzrIl9yGQ+Nn/JAhD440i0JXdAmSV7rFu8wDmY3GVDgjtAVMTiJ+PvcIEYV7I92jSxLqBTeBKAwrVLq0PCl7tghwTcK51kV1s0IV7xZoKz9EE5w+onxrBIrSmGHxjlZXGWOlmnrtKT831vWfFUg3oWg1M2MzYmiJ48YVoaOAsx1Kue9XPxOY65z5RijZpG/AXUTcsvonppOPYA7BE2UNuLJoFFbE/6V4i9EZYX/sy9SUthWZl9;25:LzBsWE1eAmSrWPYF+i/S6ot8jplwM7TMMvFIeXxRMg+QuZGz7dCdnaZZmVpOVbtgam/BsMaHx1RAsGXH9dPz5MtspUkzjbKfLPcmolrgAycq4WfK4sw9nRRnQsGgb77EIFIoK7mklt5m7aL/R3WVbAim41AYBT0t+2cH19OF5UOYqcso9cuN7WM4WZhh3lsBH48mwctxfm618ebF5Pog4YqZdAg1kvsFK5r0PRVEqlvoimcDK5CGZww0i/pbdww3NYIjPw6/njH7hPRh/elOLKKfRHAXmsdw0cnLbJ1MLWEumAqzS5JQI9QzfOS1SLmOU9SKEapgbxHM/LNTFxUIWQ==;31:YCeg7czHVJzLKT2sb2pHnNEDOEKp80gaM94O6GrjxFUoMN1qyGOU67cNw861N+6xeHl6txL6fZTt/w8tfDaIJ4bLD9HIAZRM/AKocAmEdcSKXTqMue/3KGAPIR/TKjYbTsvGj60ANjfKMkuheolNbwQyrS7+a9jCSs4fld0ssx7jrgc6PAWIWvks7663EVSm5zaXxqA0tVlHnpetlr1sv/1iOcULEmIGYJjlv7JCnao=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2910:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;20:QY/q18HOPMUk5CuaAWvXHXDVEgFsq3m45aikyDvvPw5lajlrqePXO2PYgR0U38l6MlM9DLP9ET546oruriGyeBGwdiI4bOTXRuPd18fT53rCoWleKKAWeKYH6v65PzYj93vh2MZMPOjmi1V6CNplpn9SRvkP23phLp+anyCq+CPYA2ssoSAKG5MzYK4Wxxw3yGOX7uMgUaallFqx3VCHtQOLpKHSfiHz4oizTYq5BgJ90lZx4oqA9opWh/OKvHYIYKS2X/UXtNABGVeo0x/Gj9PW7qjTOIL/1GwJPAjxDcn4U5ltrm7MMNmwvvvSy86CkWozw05hF9nGLJIGSQW3fcUvgpe7l+lK5EBwcudTFH8qgJG/nhDxjJgnl/9JjUR+0W9jU2bew6UZBfUi1p8rULxgRiiEAlae+UiLHl8w9JTiiRTuJ3JZgmvuOA/WftyC2HeR1eG8gl7rgUneqy1wveAJyeP1rMoJr2iyNzxQUd5vab8ujlEObdAWXMewOMBjs9j5ubLrWwT1f1RumxGTEGbENx28iAlPAWYG/fL1F1GWPTaUw5MoiJA4affpKyx1tbuMFDETnZFR9KqqHVr8cZC6CH6ViGLP2aqcNqddLhI=;4:wMTUlRHSiKo31iGk0/gu6hM20gjFfI2tFpz4ivypJZS4w1CWYZIVhRLnIkst4P1alurZDsbJnGY4KfHCIiB4GmeOT23xkTHh8YEl4gyOjLXQiFvzZGFPJ8uI0gkWR1LSQuZtT97y95vQB7185mLatG/EMWhP0wpGXb1cfbp1E8XIe71i/vIzMSa5c2bUIhV9NYKHOrlgJVALAh/0dzEU2ncqlygsNsTx1Udl70dPoi0TOf2jxQ+K3N1xWtOInKF2rhwlqeRhdDxX34hSowCcBtsRsqEsWp2Uilwf0AU99pkh8qvZGvsQxf4puJ1xF42A
X-Microsoft-Antispam-PRVS: <MWHPR07MB291012C566DB7E217596CDB6E3A40@MWHPR07MB2910.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB2910;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2910;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(346002)(39380400002)(366004)(376002)(189003)(199004)(5660300001)(50226002)(1857600001)(478600001)(3846002)(97736004)(305945005)(7416002)(575784001)(76506005)(7736002)(316002)(51416003)(52116002)(54906003)(386003)(36756003)(59450400001)(486006)(6916009)(72206003)(16586007)(2906002)(6116002)(6496006)(68736007)(25786009)(4326008)(8666007)(1076002)(8936002)(6666003)(26005)(6486002)(50466002)(956004)(8676002)(476003)(47776003)(2616005)(186003)(105586002)(42882007)(66066001)(48376002)(81156014)(81166006)(16526019)(106356001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2910;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2910;23:3a4RiqDZsf/wvQf/aYd0B1BGlX4hrWmi1T3M6exdr?=
 =?us-ascii?Q?NVIQxSZLmpDxLP7g9IzOwwJtX0Xb9ZoR7EmWcMygvP1QVNoqaXxvfcCadoCB?=
 =?us-ascii?Q?ZnSlNoJ/sit3BbPJbOE9+ds0HeQ2t/zFOH88H7bz2R7pfcxZk3ohURczInzt?=
 =?us-ascii?Q?tunBHa2ZXpO1Jv+hHPWidhacZ2g5GCKsDo8/0E1gSs2xy1yKsdXM54L3veWc?=
 =?us-ascii?Q?2MsZElZtHTBRDO1kpYb+S1GrEpHz2OVJXPCnFB25Cd316dmJA7bxgYRxBFD+?=
 =?us-ascii?Q?Z01isTaqb88rsl/nlPhA917W4vzF+GLDQpvBIT/CkDlUqD46Euv2ylEULrhJ?=
 =?us-ascii?Q?8IU0Ov7uhaa0oI9tfjzd/lORnoiLdPR7cA/bspqkVohqHiVfeN9hX9GP+XmJ?=
 =?us-ascii?Q?7HzlImbKGz9rNUP6E11rvntZTnaLWDvGRNrU3hDRIyG6YnAdpZ6SebWu+Njt?=
 =?us-ascii?Q?ztg3aa524sVjIpALIv+i1PWL2GBpxwGLlgt0zIcxUTVQXIjglYGXyhexytWm?=
 =?us-ascii?Q?dHc18IMEigt8rvK/H2r3iNmHkfi7j9NIpCPB0nlKICwOR6QwsraB/9kXf4ST?=
 =?us-ascii?Q?uzn9r0R3ZD+mPYPBeFc3gMuCxCUFZr4vNJjV/xl2BhHDDkasXVt+GlNTwkZw?=
 =?us-ascii?Q?I+0m7iVrY+3iZirfNQXwtSoPfw6LIcNElRZLVvmJWsR/nSjPjcnzpmYAUFoq?=
 =?us-ascii?Q?jcKkBKraP9jFQU4qVAifi5mjnt2LfipH3LU3Gq9PWxxCu3VZdT65i2rxFIa6?=
 =?us-ascii?Q?IfYtWKlZLxas1faG4EPT8ytEmMXw2sn4WqaoBZKkZmnBaUO7BM7AHXf+pYn4?=
 =?us-ascii?Q?CAy2pPHAzE+0o4WVp/fzzwjE0WnzHDhBTgefAFhRuAtBXkhrD///FPSYholx?=
 =?us-ascii?Q?tHf4KwjXZtw6WvDSLpqiD/54wF3MtF2ou2o5PeKkVutKsA9E2NIvybQmcF/V?=
 =?us-ascii?Q?3s1kJKkmc2Z3LCUhqaBgdWlsT32DRwBS2FAxxdkcRdMExO2bRW5lgKrc/b4d?=
 =?us-ascii?Q?GBT7xqF2KXKuIMnNnadTdNGLtX9KLzw8VN7FeCPjKkrWIj4CKuJvtINipdrU?=
 =?us-ascii?Q?wLyw2ogXLE+8ARxMMDtmdLauRt3dGG1IJDTObkD++J1LkoDlnepivhwK43qv?=
 =?us-ascii?Q?v2oT5OY1Q+c4h/2bI1V5XYaCc6Olqru/bk7ZfktT4S4Fs12TR/cWXxr4onJf?=
 =?us-ascii?Q?xO+0bCDc1PE3ALeQq13UFr3ZKW+dlW4q8Bo5Oyin8hbLMuHj6KELSH7WEKNe?=
 =?us-ascii?Q?6C6WcV4c2nMxTF7Sy5r+Cpw0ddX8KK+UCKZIgxRN/TrzgQmftZcDuIciMHxh?=
 =?us-ascii?Q?OlLRYH4SkCcJ3eJ7/RqQ8g=3D?=
X-Microsoft-Antispam-Message-Info: ofuIfNgZyrKWiqjESal/ikJUznVDSBtFyEyQKlHOO5iRUR1BbadswUDYIB1VLiabLhT1sfnfvibgxk4RweWRokH1D6xROpr+9EmmkkXfUvtQ7IxrpSRl8pO3jviXdFHEdbH+lpOOCe2WQaSbIU8Yzej7K4nxD2n7trMymvzZlEM9BKTtCrxHwjrDFUtaFQPP
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;6:dIZap5hAJdstFPS69P9BJbFh3Ky1u48eBvRYhdt1ufuspHoCoF4g8uTv/3uAuuhgcHJvAuDczJ/myJUe4gaQ9ehW2QBhxOTms27v9AI60P+hjs/OkGvqBoNf7Y2SP3/U+Dn4aJmjEjcfJ6Lc8dJ4HU18hGqLxoJ/RZ+wamE7pd62Mm6NQHWY46MUBVOLRmVQEDAPMggjc4t+M5VGimusSaGx8NlU6MB1eG4UoopjJ3N6bwgCNceFqA8/ov5NO32swuId8NiS4n3WZhY0FKGZN0wtBSoJvOYSzrt89BCmu9YnWo8GeR0DCybPGxm2lB9TcWP2DliuMrQIn/5mE0gtyNHGjmuNOUFJcP+MoO21TRW2PsfU5lPajWh3clk/duRfgC74DGxje5MJpDXtiuQbNwsleALtJPe6r3LCtKIGMGdfdio8wSgPpth6UGwUOHSON3V1DyyPSyyMGVb1tYf5nA==;5:zsRI6cfg0KxflioAqNdPNT2I2XNavhWImndmGPgBDNQtZRwYdNybdqYiqzrM7Pd4K3AOsxtrdvs2KJIlCzh+m8bXAxzErtYoVIXSuWT+S/9uPcfMgs/odvpTO11vx3DdpWD7GTQCzvHAzaykfEDl+ovgFFlXuI3Iw5JZ6cYGWyc=;24:EXAuAiz0QjL/BNwPINdKgBvR6aubQmBaTGInZAiPKrU0uI58dqmujbiSaAi9czbzcf09T+99J+vtnGf1OaJqscp4qX9CsrhwqalQplLyPWI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2910;7:wp04DCCa69+nk1cx0oBdMd+LyM3fCwPwckU7H10LhAjn0kWj+zYQX2H89xGpjcwJgMLtk3L7j4GXRUJvJpQ9/nPStn8DKCu8FCeiRKbfVAkvJJ9I28UwJVVAKVVMmnQGcDAf+YXGjci067JWieKhxca2NfNwsBVc3dWHRCWXkV9tAhqPkYBSIJc6CNQN9L5NpnpvWnvT/HCBmaUxJnUSBo2YRiTfUVw+kJgBF0drEXXPYAKRKTbtn+HOyT+I7LST
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 16:27:00.5304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c8eb3-02b7-4874-21f0-08d59a48e518
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2910
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is catching stalls at __bitmap_parselist() [1]. The trigger is

  unsigned long v = 0;
  bitmap_parselist("7:,", &v, BITS_PER_LONG);

which results in hitting infinite loop at

    while (a <= b) {
	    off = min(b - a + 1, used_size);
	    bitmap_set(maskp, a, off);
	    a += group_size;
    }

due to used_size == group_size == 0.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+6887cbb011c8054e8a3d@syzkaller.appspotmail.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 lib/bitmap.c      | 2 +-
 lib/test_bitmap.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9e498c77ed0e..a42eff7e8c48 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -607,7 +607,7 @@ static int __bitmap_parselist(const char *buf, unsigned int buflen,
 		/* if no digit is after '-', it's wrong*/
 		if (at_start && in_range)
 			return -EINVAL;
-		if (!(a <= b) || !(used_size <= group_size))
+		if (!(a <= b) || group_size == 0 || !(used_size <= group_size))
 			return -EINVAL;
 		if (b >= nmaskbits)
 			return -ERANGE;
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 756f20ad03db..de16f7869fb1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -255,6 +255,10 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 8, 0},
+	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/0", NULL, 8, 0},
+	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
 };
 
-- 
2.14.1
