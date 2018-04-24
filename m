Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48XfPFtGHRKzPghn4U6WDG1EJHSTLIk6T4M2kqSgdoSMxnO4r09SgmmQTfQbzIxWbt1UjXW
ARC-Seal: i=1; a=rsa-sha256; t=1524571980; cv=none;
        d=google.com; s=arc-20160816;
        b=IoEgpQTwnK84T/gdgO9I5sfmaDoquBYsZ+rydu1V6tnGx62SNnySjI+duMRIz27z2H
         V13pJab1a+uTsJObKeYgYhupl3C1FpJfOnACFoCYqWlkzdMGj5ZzfATk6fRj3XGSoJ9z
         +A67ZajTV/eGPA3gBFuyS3n7G1f/UYeIBz61eJ5+C8mvCaAWPWtyp8qMCV7WY+0kRPzb
         /TQaSDmQFSFLN2jsFvkl8GauUYsoUXm3ixSCXVbNFbCzt9nhMuPXDAUaAfO41BGeeekH
         IKZLeM2hYIm9u6xqM9KxGQbzenQb7xJzpq+fBQIuEHiS6p9vquEw5A4MUbQAJ7c0iY79
         LQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=6Lv+JfRhmpiB11xmNRi/HUFuAWVUELXj+iX52Hpqp+Q=;
        b=ewG+XmZCUVU08LfDB2q5VSCkz84+46lXQxMV+CZ3wBtiw8Pf7AOidvzTg28CUTafJ0
         MJ7MHPbJx+RQfcTda1s1neZSc3X8iEVUIhnH+8AVYPYgPn18/vo8fUABmxxDtpzzEddv
         KJbOMKLJJz6BCA6y/LvqmJ79+Eq6FParNPiw0FL35UCuxXEKhbjtZROLF2ArKYyH3jkG
         IvF0APJdZgLg9vCfs+V2kjzdvAw4t90sojxoHeRMT/CIVDgIs57PJwU0t2mf9qbnIwCO
         dWNhXgIAzbUNMCcmL3H9WlA7dfuVLxYlOvPgUJtNTsdEhhELmehH3qkjZjZnWb7cNPJb
         3yXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aeRXrKW2;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aeRXrKW2;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.0.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 05/14] mm: Refactoring in workingset_init()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 24 Apr 2018 15:12:46 +0300
Message-ID: <152457196629.22533.11183248990205297327.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::16)
 To DB6PR0801MB1335.eurprd08.prod.outlook.com (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:8b5mjNBzlSQgbmS3DfSn/5sVsg40BLpPvQHUkKDQuFQIEPym10att3sC7aSOOQEDHDzQ4mcfO4z7+Xnd16NPZ80w+g7wQbFIme/jkOZY7TnKa9GqepyUbKU5gAIGob3agld2roJtXDkgqWTvSFcwgHIXRb7hdRSuEKGaAGzFO+xFxBKgaN8ZfCBPBKRY7zulJriFivca9l9pFGt7/ASzwb5ZdPeUpFrDy7ZeLUhBEzizRC+7FXn9eno4sXR5hlEh;25:fHq1kzzaYYS13AcpTf0m58lAeOvXR450nRNymvI6E3d3Q4fb/dK7uirqS4aTKKF0Cf8JlNxZVJZpGe82JOIvGvbbVN8IS3bWSyIerKOp0PhtBq02CnMKM/tRgO2NAUScuCKFIz8ESzAS9LJrXp3hvY8jj6Dn9Z5zYaOiq5JGhUgnn1v7QcVY+hTYFhmxt1HNTpRHsy4279memaAkjTysDHU7xiLVk/aRQp82FdwbH6RFjAF1JmF21RfimsO1oLPsMii6KbDglj62mXI0sPd/h7qwwQ/ejwdlOtbxPLvRjDY2Q/LLH/g9+e8+8rSH8kKA0mws2gIs1MzzTverF7gvZg==;31:al0bNiyfpjDMikHlf9AISC8cbGSFBNzv/S6Y1i7tKHRGTd/UuDFaVkn7BzessAiTvwb+bPtwmuUFn8CTqhdHRFCqWZzi3Pt2Kk50CXrSE4QVc2kO2n3i46TRaseU9mvdy/JigmqHei01wqs0QL4jhlLzaJRUCvWlk0FxkdYWsMiW0Rk1zrMeVrGS8IjE9mKRkncY1PLr+o/xUJWiPd1wpwe2ZiK+gvHLr81s/JRm+/U=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:WWVNbGtVJ9SpmVczx3Vut3N7dtPkJxaoj0xbh4he35ZABbZrKgiyapPJz/zRBOE4K/7GBmH42Ed41n0IumCrsIb1nkRgFCSlXuemxew10p3tXiaXj88JNJ0EuYjcar2PuWGpuCuqH4ozYOsQ6p7bf2UBxayISCyBFTcm7K1EGpsVJYv4Su9/IKw39hKfrWWl6l72qNiFgmMsvQBfSPGSyMDB5JhmezEkVEoAC9oaGOzO1G6N8sf3GmL3uQsjkBEbAypk0p0yubR4wtRATrE+xl/pgLwxuVqzC3Im10NxYVf/zb4ZOZtDs9PpFP+xoFyksyFDjP5V+N6lZCdElrOoiZFIqP1HrLCfnB0SZuYD4fJ3t+icbqDzK9xnY/ePeQINMMNwpDnkCFJTcMHEOv8UXLKLh+rP/u5buhu1EXhD5liH923asy7XWlCt1R9IWtvYDFHdwz7yZFZhDPrui3aDaMjMx2X7Qeeu3SU7mAjtoBrnVKcqkx/SL8g62mCYGNhh;4:rxOZdlv+XeLrapGF64hOxTARmfJSxc0kYnI/w6H0I4djbL/PtsRHgSCgS0LfhcFigM43Lxaxk77GRsZxRi4e1Mtp/yDJZIU5d0i2JG7r4PUkpzp4koEwJg/ryIYx193mLUiYeqkFsaHWeFhRbNOsGMmnes9r+fZbx2VirB/v3CEDeEmaxZBrSkwU0+uDpQWymkClNfRQNRAgoznKAvOvAPtvdDvwo49wnOlV/gHXKtlDhapr2EZKpFX2XwDeR9qS3EoyyiNWl5CPLxzO1ngyrw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13353F22B92F45EFD2789B96CD880@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(366004)(346002)(39380400002)(376002)(199004)(189003)(6116002)(68736007)(3846002)(33896004)(305945005)(25786009)(106356001)(486006)(186003)(76176011)(478600001)(58126008)(61506002)(316002)(476003)(97736004)(86362001)(66066001)(230700001)(16526019)(6506007)(26005)(105586002)(59450400001)(7416002)(386003)(956004)(50466002)(47776003)(9686003)(446003)(55236004)(55016002)(7736002)(7696005)(52116002)(8936002)(53936002)(2486003)(103116003)(23676004)(39060400002)(5660300001)(8676002)(81166006)(81156014)(2906002)(6636002)(11346002)(6666003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6YkNNUXVsajBNK1c1SVFHZHByYURwRVNJ?=
 =?utf-8?B?MEdjOXNwSGtnd3F1emN4RFMyWWd1dTRpVUZydExhUDR5eTBJTzdUVlE5ZGcv?=
 =?utf-8?B?bEI4dXlYaVBzbHd0R3dDSnRKRDdVZTNTcFdOb25CaUQwV1l6TFBEamwyMU4w?=
 =?utf-8?B?WFVscHJPZzMwMHVmODRRTTNuOHAySWFyV2U2T2FHcXV3Nms5TDdVZ1BIME4y?=
 =?utf-8?B?ZTJ2TmdNYU9UYThuYk5KTFFpME9ycXYrN0o0bEk3VDloaFpXbEtvM2xIbzJD?=
 =?utf-8?B?YVJBdWQxUnR1QkxoU2JYMlMzVDhROEE0eTdLM2w0ck5DQ2xSTnZCbTVLcXlL?=
 =?utf-8?B?SHNiSUJHMkV0K0cvdHFkSHBUYU1TYUxHaE9RYk1YSTJoQmRjRVpXY2g4Vkdi?=
 =?utf-8?B?VlMyQW5waTJjdDRHUWpyUzA4L0xDWUhHdTdLQ2FyUjJqZEFvY0Nwd21nTFEv?=
 =?utf-8?B?YkNzYllHTFJGaGllcitnaUFuYUViWmM5N0szdWVMbUlTdVpITExaRU93YmJo?=
 =?utf-8?B?cWZKYkdKQXp4V05WZUh1SkR4Qk1JTEZYaFBGSCsycVBJZlJReFJPTE53TktK?=
 =?utf-8?B?KzdORXRZV0R0cEh1bExnQnhjWHRkUnQ3YzIxRUJNMXhrdm1RNGkvMlJJTGtC?=
 =?utf-8?B?YlNMRWl2dDZTYTFBVS9qNDFRWTZzb0t0dGZsZjJ0WlZYUjlzaDB2bllSZlJU?=
 =?utf-8?B?Z284ckUyYU1vZkZWSExxNVhoTXFGUVhDeGhZdERJTWFhN1NTdHkxZzdySE55?=
 =?utf-8?B?UmdXT3RxSFFoRTdpNUc1b3VoUkJrSUFtK1ZlaGU1N0lSVUlER2VVb0t2TVZJ?=
 =?utf-8?B?NHNha2NDMVFxT0NMVDI4eWUvZ0RxdzEzanpiOFBhbUEvS2xSTGhxYlZ2MXZt?=
 =?utf-8?B?L0ZSR2hIY2dIQ3F2QzB0VXNzVnVEOU9INmhzSUNsYUFGOVl1TzhKRWJtczFi?=
 =?utf-8?B?MWVhSlloV2RXaDZzVDRKZHNJRzNQWUhHMzRVZmYyMi81N0VscEVQamJDQ1Bq?=
 =?utf-8?B?WFNtU3JHMzY4TC9JaEIvK1JGdklldStnMUFwSTM4Y3hPYTdIWUhJQ1h6NWEr?=
 =?utf-8?B?UFRUMW42ajJTNlo4ZVVlSFNpVHlhQ0VuS214cjlnYllxczBtQVpzYzBVblNN?=
 =?utf-8?B?WGNxMVVNekhxa1FoRS9SUzhTdzgrc3hJTENJREpLMGFibTBaTWhady9XMVN4?=
 =?utf-8?B?cFd5US9GS2swQ29tSmIrM2I1aVl1ZWZQbVVpdlFpVkw0SUxJU3FVK3MxdEc4?=
 =?utf-8?B?bmVvSGJ2bUQwS0FmUHhrTk5ic2ZEQmhrbHdKM1R4Z2dUYWJJM3ZjQU1oZWdM?=
 =?utf-8?B?aGdxNWpySnpHNGNtNHJIRkJDakZlNENVNy9uRzVDeXN5WUMxb0RSMGRmcXRu?=
 =?utf-8?B?QWdFaGF2UllLZG9icFFIL3lZL1NMK0RxOGY0Q05UNVlDVHkrTTV5UU1zSWdH?=
 =?utf-8?B?N1FFeDlKVzU5cE0wZzdKYWloZDF5Y3BVellwMHlNRzczdTJrRUs4cFBBekVM?=
 =?utf-8?B?bkQ0TVZVWVV6Yk9qM05venUrVVBRdTNFQVVDdVp2WG41SmlQK0R5S0t6ZjFC?=
 =?utf-8?B?VHBlMUU1cnJqaFJESXd4N3RobktSSmVyVGMxTWZlN3RHbmVRZHZITWt2OXVR?=
 =?utf-8?B?Y3Y5VHVXeGVlR2dwYmdRMmJ3amM4cGlZKzBEZUJUM09FbW5WMnN5US8xc0dk?=
 =?utf-8?B?eU5ob09YdGZ0azB6WmRPR2NPanRJSWdiSnc3NHlOQ0VaUGVlQXBWVTJOZXpx?=
 =?utf-8?B?UGkxcGxNaTZzUHZqRlZabWliYTM5K0NPRzJYNkJMTG9KYnZQdVhGYk5hbkMy?=
 =?utf-8?B?SWRFSFRYNGNwM1JWaTQ3TmQ0MGdqS0ZndERYUlFOV2FBQWJGdz09?=
X-Microsoft-Antispam-Message-Info: 6q9e7odNXXUybI4fbiKErvQb1edz2saxHx4UZmON18bI5z0OtzhUk5xhQkk2hinCZm62TDIJd+pICP+v4x5zcxGLSRik+9emXzcaeiPbIM8JBxayGsrUYt7DZkjaGecKEl+okfuMa2zlHf4S65BPjPW1lWwmgCAH7I0HsFyRoq8upwRZuaAiOs8Uq1XjJs0Y
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:JkfgmC5xSPHFXPOfLSJCxxTzAvjyaHH1czHe/0tgLKb2j4oAN7E+0wWtxTWY+38SqHZvuVQCXscCRdn9WiD7yTeLkaHnU2s0lRQTJI5fQ1C3W8oukkvB1eAu6tvWbIkyB5cLsxMrjJYUFx6ZN0cVuTQN/UkvmEoWSsRBCl/fu4hMNjD5UkvWo41S77+6V6z5fn6lrXJSVo5JsfXv7jYIKk1FQr32+xBzYFkSCdPk5ooryGnMRFKbMCq1qONrlwb9ZzDTqaLJdrQB8fYt1QSYf+kPhEYS/1NC+SYIANhVRn/A0bsQvNjGsZ3Q2rpoTL81eg53xoMVty5DwG0u9iwDuBiDiaqS4YysosgAbcA+TEYXU4OT5mCr4tW0YbmMANW7ss90UTv360EJCYR0NsMOnK14MdM4uGerAbCKJENJgbrBvctypQY3iLIsgIgIGUPUtSLHarHcF5yLI7YsxhOeAA==;5:KbGzo1SO/+ZFUcPMD5bn4aP3L/uaswz+ACO/IkmGqBxVa1n7QOlgteqWUS3l34CBAh2aj/f4SrcGLK/92qrchm7pRsAreE2Zop+z0djFdEL9Ab92jPQl9WK9Uw/9R9rsFV1p2z7DFCIE/mBgHlTZewKFZRmpvZw8IKR/2aYd/gQ=;24:6ZjkJ2onmTOxNh9cmh2hcsB9guGHMdLyYhStej9VYow0iLrxKGHg3VYuFSEjbbU/loUh6RWxsv0NB2rMVGoQn3d1gSYG7y0iHo2GOS+l/3g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:Jg7kOvRlaK4FaMfDMwYisnjgXROuwgf8TtTrU9ZerztIV8mSIypjkJpU5KhKRnVDrp65e0KtVZS+Kq21ADnKw3ZDY0Qg/g5mcCeS3GWtQuA9tiktfb+mJCX8VroShKDaUSXQpbzd8UinSrKr6wP3cZLA+SQ41OBUeG/h7pS2ogGO0lh7yo0Zpi7hvqcDyLOcadMdNRfS0fH5qA78nsbjgBuAQC3FPuu6NQLI3mxBvQf/XuIRMtRgxLkjEJews+EV;20:mOVJvRrbKPICrb3s2EXy2UapnVb6jT8+Luf0ScfNQoT02sCvSytxkXEiqtFII4FjBA6rmcktzBLTSjQUzjMyB8zh6CeMDOrZy0i7Wi+3AYtnNKpYfvbX3AEEGeFcyZgNHITFHiNIGQ3KLoWM60VaOWGymPoXMVCBSYgIX72WqI8=
X-MS-Office365-Filtering-Correlation-Id: 031a0ea7-93e5-45bd-f60b-08d5a9dcb682
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:12:54.1790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031a0ea7-93e5-45bd-f60b-08d5a9dcb682
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629589273704131?=
X-GMAIL-MSGID: =?utf-8?q?1598629589273704131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..c3a4fe145bb7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -528,15 +528,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }
