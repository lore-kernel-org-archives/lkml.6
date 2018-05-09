Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoLop7QXERL2qXNE5B1b6zzgsiF1bP9zNQYOxoGsUdhPgOdMMIaJp/ycHeKvrRg+4nCWpW4
ARC-Seal: i=1; a=rsa-sha256; t=1525867078; cv=none;
        d=google.com; s=arc-20160816;
        b=x2/y+Z9CsXLMKp+hIljV455wfGdtGKX92ZrNrch6sZWsPll2IJvCV5b8RU4bw8IT98
         z/avx5H7qRAUT5n3o9xB+wHCAad5YcRgMZ2ga1OQtnRkFEOaHcOa+QZu3o/VYKP17YHl
         DZjXQ1qdD56wIOYVm979eZPRNtOFSH0f9C9srKnKjSnH71gMZ7AK424dVITNs37A0kVt
         0CE1cBlkcjpY2tApqxSpOyNrioDv061tEQjpMTD/MbnwrHVHrPnAvsfg4VYsfhPJVZcG
         8qdHDWCc59cREs44eVlWOnh8MjEna2v4hDfuBXCqwP8YvPATFZ8A1NTU2OVazDAyKBGy
         b3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=QcMWtAEy+0VHDZmDG6jQCfIQudxP7WG5YAbPgRBEqd0=;
        b=wYfBoKVpxisnuyjxU+AbOrlEN3TvTG/PjOo46WZturhJzm7t5lpHNriEwVIXF275fC
         J2gg9Nnz9jjDoJ0QdREoVInfGElKNjA+5olxiqF19Qz1oZs8ADXntBL5cnYnNk3klUmy
         rViW3rrEPM3u2J4ppc0+MPNewQsOVRsApfMJaUjuAzwbRL9VnDhknOvDTkPi1Q3wLWOI
         Ns0LcM03vUxevFkn/SuGfxCurWZs+mq8CfSB6MYxk+sFW9+kYobuTWQSR5fJ5Wx8ff0h
         wB39LQeiLSs83mp0iaUIjd3fvuDwBCRE1SB7hIoNORSj1so80WdY6H2RrC5H8+w6lsae
         BduA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=e8NYrCOG;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=e8NYrCOG;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 06/13] fs: Propagate shrinker::id to list_lru
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
Date: Wed, 09 May 2018 14:57:48 +0300
Message-ID: <152586706851.3048.15461278706880255477.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0097.eurprd02.prod.outlook.com
 (2603:10a6:7:29::26) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:5vJHU26FVLrmLAvpamPck4kh76hTYguiBHfHKJkl4YjmoK/k44JziU2XjIRQ28KvpSY0gQOSnjqy2no37VkF25xNdAuD3cj+H6t0YigmATdo+0DmFtZuZs92C7hY/3m3w8hmEVhhbLQEEb/d7HwW6VAmBz6K5SPNRvMBrKgXAUqPlUA1jHk+YZtIIbTKHrha76orKynvjbwUUyue7nTyzhiWgegEkzZaavablRArRpy0FU/45JNyj4MlkQxcFmLY;25:8SfNbcsZVLsngqSSn/vfLZXpgO9H/z4ZczkdDwEa8F8WspZyVD2a5XS0qIzwhu9aCizjLzfZ41KOxGwE7uOa2/Nxscd4LCctVbXBbQw6euDjbz5spFgM/IqAgBHPhOdViFib7tleLaB1Vxho9hK9tbiG9uoVAA8SllzXtzW5ta5khbB8rLjdu7/0VyB/7wyTVSN93cORTAWleyqkGXIBYFfUIiltABX/ecn9MazH8y1PS10Te7lb8tBF5HNOSkocLROGsyZbQebXOZS5s1tgc0+ZXLrbTO6kRuDLRX2fZKIY0orS3KRcuVbbY9O4ElomFoUbC+p6Gcu9eVscuEp4qQ==;31:DaGm3STLNt/nZI5QddX20b6UFyaztq93WXTiiheT8EFcJfMfeav2EYHntlbG93RwUYObbpprSs3v6uswBYJxBYpIFCL9G+vXnbpKZQKLLSrdYoV1MYRRSr9hqgXu0Gk5fsPqdbtuLoM7O30UvA72tTZlBa+/Crk5gZ8Qp+GH18yylwOr+6PatwVEh2mjJiPze7UzlS4s8DYDN+CSCCFJgzzESRopIS+Jg0owwm59ulI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:FaJwOxSrjIb3rkOUSHOVrj+W2n18IYSuJu3uOTbLzGWa3pl0YIKdJo781XzIwMojomaXYWzZ6N8KRdTVG+R1BrSiyITQwvzqqdHLqP1Va8QR7ej6UpWOZ/Kq5unzGwc15KdEp7K/WtnAbjlczSC1qXhb7QmNWsFrIKMIF1U59c3AavnccfGbQanjI/+fAY9LQEBK9vgmpFZZ2ojMYE3Wgck9usdtgk8N3ljAbfcSsj0KNXcW1jSQvnwlKEe616fSUU5L9T9In1X3MDotOdU8eam6MJa22FllYIenBm06o68RmlvaSGn5jmhmWgk6vEggOqzYqjDuOcQkvvxtGT/Nmig4GTJdgWoohzDtWsQ7pcKrMgJgMvyW2XotEYuTyAwuHhYYrXmJrB8fUFn8BW4hcVJPB8Mc6e9/FmY1uLLDjHxgYKpzq6oScMr8mNW9X2rwf5Sw3R5Ac5jQ/F8AmoU6e/FVJlPbCIxaJGf2Sqs2hjsZGVWyg2vswYQtLJ0kfO4f;4:WLK3iWcPccPI2B+RQrLcsGI8hmcJ8+s6oNmlX0Dhb//JjJd/cXq+uB+NrSEfvhmxKrRmOHsWyaScnyuDdk7r3fA004HoKCFAltg+bqMUrluDJX1eFR9IYBh10GhyV0zc+ijIOmab1KzFxlZggROLjL3GwoJeUa/DaghN5No86kHsWQm3AepvyCrga+yIN4mjB38jNtE+t6bCtGD+nB9ZMdCkIJTiil4K7r7yNHW4GPECsqkgWFgEthlI+6/WyZTqQExcBhasfp4tfx1ucYJKUg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330C7EFDB419EDF6A708D76CD990@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(2906002)(186003)(230700001)(6666003)(305945005)(103116003)(86362001)(6636002)(7736002)(478600001)(11346002)(16526019)(58126008)(53936002)(476003)(6506007)(106356001)(39060400002)(956004)(105586002)(68736007)(5660300001)(7416002)(2486003)(446003)(25786009)(486006)(61506002)(316002)(97736004)(55016002)(23676004)(52116002)(7696005)(81156014)(81166006)(47776003)(8676002)(8936002)(50466002)(33896004)(26005)(386003)(9686003)(55236004)(6116002)(76176011)(66066001)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6cVA2T1J0WVliRmkrMURIUk1GZGFVWU5z?=
 =?utf-8?B?dG5wbmNzUmp3TUJJZEdSNFR4RmdtcWhPSTUzak1neXZhZTFYRmtVbHUyemlR?=
 =?utf-8?B?VFdXZTNUL3FEUzZGU2FsOTNEUGc1eTNCcVMwMkZFNFM5WXE0LzlsZ0pjeUdG?=
 =?utf-8?B?QWF4bWNMV1dTL3BoTGlOYWM1ZFBpWmw3Y1h5c2RZTnkzckg2TERsbDVkckRF?=
 =?utf-8?B?eUswcCszWnpYWGhYaVlFOGpjWW9TWE9rNGpmTHQxUHRPUnVJTEdLSlBDckdC?=
 =?utf-8?B?Ry91QUhkSVFCUWJiK09jVWtCNlZjSFJXNTJxSDFSQjRSRko3U0x4TEdaanlN?=
 =?utf-8?B?MzJxZVZBMUovRzUxWXVJT2JVQisraTBTYVNKVE02WlFEUFhBamFhRkgvam5J?=
 =?utf-8?B?T215ci9wSWt5cTl0QlBWVEZJME5hL2RRTkphNXErWUUxM3FPK1plRmJSN2g5?=
 =?utf-8?B?d1RLTGt4Ny9vMjdhMXhLelI2Y1FOL1JpSU1CVHZ5TE12QVpnUlUwcDliTS9O?=
 =?utf-8?B?L1hsek56aXZlWW1PTUE1aEkxY01Hckc0akM5cFNtWTQwbWVabVp2KzRvcDZz?=
 =?utf-8?B?YThRQVphK1pCMHRhTGMyNUNKRUNQUldydzBwTmdaaGFxVDNFTXZ2eXhia2l4?=
 =?utf-8?B?MUxndkFIVGJIa2ZxVEl6Uy9oRVdDVGNEQ1NSTWFTNUJZcDA2MFUraXVFN1pP?=
 =?utf-8?B?SnhrN01CWmRUWTZobFpFUHJrc0dQMlZDcjNYejZSSFFkdSs2Z3IrWkgrV2k5?=
 =?utf-8?B?alZPWGZWTjB4WklGWS9DQ1RMbGZuRDE2bElGajRCZE9OQ1VJTEdVOFN6K3NE?=
 =?utf-8?B?a1M4b1lnZnFZNHl2S2VCZWNDVVV4Uld0ZVRrb0dYVU5SS09KY0szWGR5aFJz?=
 =?utf-8?B?RkV6bnFldkRUa0dhOEw4WjlMNGlzVXZCMlRhd1ZReVp1VnRudndWWENEYXkx?=
 =?utf-8?B?djVHZkl6bnNvMUFXajV4V2x3c0swUWNVVnhTbDVuQUpPcDJoMUp1WU5MMGR3?=
 =?utf-8?B?bzVXTVNSaWNvQ0c4QzVSV1NmTjFLeXNNRmo5RmY0TkxTdks2Yy8xZEF4MWhM?=
 =?utf-8?B?bm1UZ3h0TlNLTEVmSHR1RWxuaXVTb3dkeGFyYkFyNUZlOXBNRklQR2NtYTgx?=
 =?utf-8?B?eTBKQStBblJzNUZJajk0NFJIc1hvZHJGTUQwaGZkVzh2dDRaY25wRmk4T1Jp?=
 =?utf-8?B?MWY1TWFXK3pUL0szdWc4SkRKdXJNbzVSYlF6WGpYL0hFdm9JOG5naGtSUDhr?=
 =?utf-8?B?ZFZ4anlwNXRYdTZSUTRsZjExUFliZjh4eDhoVWxmbk9RaHl0bmdjUmZtSFZS?=
 =?utf-8?B?YUphSis1MnNLenBCUFFKeWZpV3BXU3hJcmp3TTg1dldhUGFlUy9XQlNwRlR6?=
 =?utf-8?B?Y1BiL2Y2c2ZrWkFhQzBSa2dsakF3Vm5QVnEvNHhwUTFNbW9ML3RwVDNzQjA0?=
 =?utf-8?B?N2ZlZHdlSlQ1RUpHWFFLK0lZZU9kR09sN0RCL3pYUHRHVlIvcXJkNExYUDZG?=
 =?utf-8?B?OFVuZlRtUUZBcEpBcTJXWnVnV0E0ZUoydXMrNktlemxVYStZMzRwdmgvOTY1?=
 =?utf-8?B?S1k1NHVvMVFucDNweXdjemtEekx4NkYybWJCbGJzN3V1VXpmM2luZDZZeDNa?=
 =?utf-8?B?TVlSejFlM2hvRWQwLzN6UWJNZTY4a2ZyR1RJT3FURjEwODVXanJTOFI5ZkJ6?=
 =?utf-8?B?Y3lwNWVsUWYzZCsrMnA0NnM2Z3h6OWdxRUhEbkU3dytONUtvR3lKV1lncHgy?=
 =?utf-8?B?a0R3QTFHRTAzSi9hSVl6ZlZFR244L3ZrQzlQUWFWUVhGQ2Z2RXFxZzk2bmJo?=
 =?utf-8?Q?biQSBFpVU/xR5za?=
X-Microsoft-Antispam-Message-Info: teutuJxBDR54CsfR6Yy/chwh8GZo8B2HoYDDddMRY0ysUSMQkI89RLASZqP/aTMWddCV4CzUbT3CfNhujmgvcpe37rfIT9164Prn8YuN5NJdHT9IUTaOXwYw7r9xqWA+nWdsXcsdf7ghTu5t9qtLN9lemh+pEMXR+XawkXBopmGczQxpS+rk+avMjUTZqfCO
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:IIcjQfNg02JMS0jag2fO4qMOK+Iq+RzUk+yoml8ffZsLpdSmjxu1eBRtQhiDajkZ2f7mm0noLjE+GOD+sljOjOkwBHm17Z25eaVgQmFhl/OZGjhmEyPrPv2UblnERughblBRyMDHODhAsFknzobPMJ8MhaCLk0k6tUv/EE4oLGJ+JkS+zOXobCAIuglwqLFB/3u+c3YX/l+HCrrsGq5pKb2Fvq5KvZ/KgNAsFDKvpnazHipBkzWW5Tpf4qTHiJRsyWR47TWOn/sZy7K35fmCaZO7oeMbkawkM2kzs7tcxpwoXUatDb6ol9X40rUQ/RXuRAcvj1N9Cy1RH8EYXlxC39muywG9YMnmtXPHb71kkAOYksd7OIvQ1i72hb6NuhQ71fhvZJCavL1TMNthcBAv+XjpVQj2Vw1rWoZZRK6WN/VqmJmUlaULmHS/f0NUoIeH6T0F7DdLORnSR2k8Pu7f6w==;5:Y4XVZx6TqaA1djsEK+lY3uIB3F4otJBVPxJJMFRxKEbxsYwPNzpUCRGvRjGV8ijqqka7ZobJnb/J57pLpqrqxKKOAMdaeFDvf5chWDFWrAFdOUh5nkuCOPl9HkY2Ae9n8K1VfgtDM1d9mBkx11OtiDCsh2+/soA4QALIe357zOE=;24:rLqQsKfM/h8A6FB7D9mabCSVlo0Jc1EyRtIn+8cFDLfNpGHAya9cgcW7964Jwiu54xeLWI2sHxazB0LinK1Fp9Bun6YTuvIIyx5uwh3OEBk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:ANrm2NUe8+StToUxo8YAI76zfIP4r9iJ4O55ea/596PVR4+L83lqxbAYPa+2rmGXCayzP0CGHh/1+ggf5L/sE965xwiXqvp2so/zVVkN+QE0cTe2w0ehI0TQCI6xoAswxbqcU4Jy28ttndGkDn5lfwxQW4ZpRghCTbow62G+bR7trIOsL64JcbcGzCYgt1I+csG94H3jWywYiN9uNj4C/arGUabe+OcgdFTnndR0oeT8YubSOWJNrIhu3pYM2Tra;20:m36MRCVjBz9OReJ3uApy2GFTfQZsdHj73uIh4SYiHAPfTbyheB6nONbiMdw8mp8/wPgNGvufzKIRyX82YN+BaJYUlvyQosDiouE+jTHTFe83SPOOUa87XRCimwQ45hbeD/TaHhUROWW4Do95E6JxGMh9BuZlBx8vYTDa458Jg9I=
X-MS-Office365-Filtering-Correlation-Id: e1750353-0292-4aff-9236-08d5b5a418b5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:57:51.9885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1750353-0292-4aff-9236-08d5b5a418b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987597367230992?=
X-GMAIL-MSGID: =?utf-8?q?1599987597367230992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 ++++
 include/linux/list_lru.h |    1 +
 mm/list_lru.c            |    6 ++++++
 mm/workingset.c          |    3 +++
 4 files changed, 14 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index d95fa174edab..c9a6ef33a98b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -258,6 +258,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru))
 		goto fail;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	s->s_dentry_lru.shrinker_id = s->s_shrink.id;
+	s->s_inode_lru.shrinker_id = s->s_shrink.id;
+#endif
 	return s;
 
 fail:
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..f5b6bb7a8670 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,6 +53,7 @@ struct list_lru {
 	struct list_lru_node	*node;
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..2a4d29491947 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -567,6 +567,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -609,6 +612,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..b8900573db25 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -534,6 +534,9 @@ static int __init workingset_init(void)
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	shadow_nodes.shrinker_id = workingset_shadow_shrinker.id;
+#endif
 	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
