Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167DE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LJQzBQc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167DE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965373AbeFRJrm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:42 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:24758
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3I8sAUCxEio5mBazdf6Wc3d0pfy2mz/2jehuekL02s=;
 b=LJQzBQc7yDvnvoDmaKRgtv+lkicq02r2leh1WXFsWLq5in5SvZThoZuOej9yoUE3VFNeNgC6nSfjG3t6w2AKDG0/kzVpOVweqtHmGbpNwlTaI+3HRn4Ked88DH4DSFCfcSgeN/31p7/HaR/cdfKzRvtGpokHIp68h899aBelyXo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Mon, 18 Jun
 2018 09:47:32 +0000
Subject: [PATCH v7 REBASED 16/17] mm: Add SHRINK_EMPTY shrinker methods
 return value
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:47:29 +0300
Message-ID: <152931524916.28457.12974705300364778836.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0239.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::15) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebd9917a-848b-4a69-70cb-08d5d50084ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:E8D2rUN6WcmcOxN4FAMUuyvvrd7+RYKpDWttkpsFVlnqjfjKrXLNDmpbeN00dtLaM9LANk/t/qhrBLVMZ+kzjnzjkdsvPpdUi9L6fQG3FgXZoshAjcMPiBfLTpxH7RxUXjer1Piftf2TKeWqzceLprBe+DHxv4tdIsDUZ+3S7jT0fAv7eE6jNzL9vwhhpc0nh4KBbi03uJDQdyRp2ghN850VSnEm6UbXc3ES+Vqctv3u/M7qD4Av7q7HSlQvtxgJ;25:YNlsc8+b8qkDaKFTDAVzJTQxWW2p4w8/XJ5fB2fV2WQ56kUw9nXSobpVYn69S/k93jOFUyZiZd/xxyS8OJX799PSb11VRL2Jo56ZAUI/Mkeg3F3uWRKz8XXxtSNVWa71xxVM6AoKKGgFqsI7LWiRc8pIB2e6UeMEgl04okGwi+FJgFRt0+KLzg8mkCVw9kbLAvcHOMcbSqyCOUSPcblrw2qcq9Ksi9kBZpMb2MBucCGFj7/KOTdZInaxLoQDpCkeogamdzqTy5YTrkTaQPJnDXDlSQMOo1Hd0RfjsafXpohKqZS62S7TKzMgNRpa0U1C4im4+HWEmne+sDpGpSFFmA==;31:aVZkuQswre4Bj/S6GxXVum6IvxsNLTdTm3OrUUq4sTq1vF9JvejNBiYLsuOCx49K/TNQCeJBwllKaWqiQwLyUen1lZijeyK4peK+ETS8NrSAsVAUsV0NtndvePwc3AuHM8H2behIK74BHNJAJcsCFfJD9Uhx+snv6BiwmxyoW3l4PWSNlx1KPFllhjP3SdeOQ+KAZvqSmN7OxONUSyY9j8OIC4D63REMXnUl0GjTXo4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:L+STwrXmFsFVAelW4zxURh8cZjMyYDcg7yUdit1mjJL7+ipXRZrDqmbtA/5pIQ/Z8+p7rMuUeke6WLCPmHwhAIjAdXcrErQW6TPvWvjHYX0ANVgP4Ph/Rcshq+MzzpSQW5pHpQtTYaxcK7gl+qw8FpAZfsrBpFQ3nxp8ZMo7p3MoMXjvuGRU/v9sUOMfK4VLlVZLp/JJ/m2b42dAfYJckmiAllZ0wldTVpULJVHOAO8lUtv7Rn0dXesxzPjdHcO5/AuxcYGsD2JNB1xAJw6VIFaMdvuF5+C1OKHGQIyBLzSureGeSbUSIXPyS9n2yuf1klrWWCd/+9tGmzUzVslexGklSoL3c2QCtlAYaHOp4WuUwsJp0G+n8TiYZ4f/i0wEiXhsUKDbwEZkehaGZraXSY+YNoQs1ahv3RDmDLX6SCzQ1KOfgI3P9Nndykko6JlWiQxEAEdMRgF0RvFBRJrHxV/h613x+L86VO2jYmzGTJvzG5Iiny/wpx5bJ7xSu7RN;4:wkCbukVVq+tUutIJ2i0FwaN0H3r4r3gHu3PvYLOKs3V+GiZKCASr3jlm0CmKNp7oK7IkUwCeWjrNoNX7Kj3tMR/ECGMnEX3qaF7qmfoZ+SOYjIOhytVUJPjEJFAaDZShA+0t2EVIx6m5QZuLuc6V7OtQrsqMS14LmAoYSjsDqi/FscdUP9G6KTkxbEkxOpBk5ABEnt4+hE3a8g81ihA2PGyH4X76nETGPPdLTouQaXa/h4TqNbFdSSgvuCzdeQWRWQWlKqXHeDW0E8M4otLsx2et0Xg/DOQvY9Dct+o2IENGYhaM/GPe3JP3g2aaLEziDtrZFqrlf+8/UsiZUCM4DcqXyzc4R0BfKeipWAkiWdIr3kXWjSsdZhNcUPhzzuyp
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341C17167097C970195C238CD710@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(396003)(39850400004)(366004)(346002)(189003)(199004)(2906002)(6116002)(3846002)(11346002)(956004)(6636002)(478600001)(486006)(5660300001)(86362001)(61506002)(81166006)(25786009)(575784001)(6666003)(39060400002)(446003)(97736004)(476003)(53936002)(81156014)(106356001)(105586002)(9686003)(8676002)(230700001)(6506007)(386003)(8936002)(59450400001)(50466002)(47776003)(7416002)(55016002)(316002)(16526019)(68736007)(58126008)(26005)(186003)(23676004)(305945005)(66066001)(55236004)(2486003)(103116003)(7736002)(7696005)(52116002)(76176011)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6YU5FenVCMDB6MFVqd09DZGdtKzhuNHRN?=
 =?utf-8?B?UjlFZy9CdnRXaUp0M1NIdmgzZ2xMVndSajNQaDFwblJWM3JoU2ljVmRPTEFZ?=
 =?utf-8?B?a0EvQXN5NEY1UThkQ2JUYThXckVjQ3d0N3hhamJMVzU5U2JLR1AyUlEya1k2?=
 =?utf-8?B?VXJqTkEwbGJmeDJrMThvOU9qMnFYOXRqdnB4ZFptSWZRaXl3VjBYQ09tRFQ3?=
 =?utf-8?B?R0FlZ2VadlNBanNYSW1STEhzSzBub0twV0FWOWNIZjMrK0lLQ1M2QXJCWlJS?=
 =?utf-8?B?cWttTHhzY0pacnZJbTJkMzl2dXZQWGlmRmhGMjJ0amlIL040anVXRjYzdFND?=
 =?utf-8?B?b3Z5bmlSa2IzNjh4cTZVRUpKdmozU29TZUJNaTV4VlRqdklHV0VQbXhjQ0w0?=
 =?utf-8?B?TVRQeVhiMzlhaEh4Wmw4Wk1OT1NKOFNHclhiVGZMZGU3eExjRXZ3eCtCWUk1?=
 =?utf-8?B?VGtUL0ZsNXo3R29TbnYrL0RrK04yZTIzMCtxTU1TMlVEaU0vaHo3YUZ4b25R?=
 =?utf-8?B?UExJY2hUUVNQK29WNzZ1bUx1OHRuNHFpZUVRS2hrcHhYditYV21PY3FEM0l6?=
 =?utf-8?B?N2JXUmZTTTVkR0FTeFYwVGxET28rYlk2c2ovZ24zYVNaOHltR3UzRlRRdXI0?=
 =?utf-8?B?SkpyaWtNWk5oQXcrbjZpSExLbEVZUmJ3VzBzNWtDMGdEY2x6UTJxZmE3aElF?=
 =?utf-8?B?RUE3MnBQNUZoTk1EamF3Vnh5UXAwNlFKMjhmWG1aM2dwL3kyQXZnL2JrbjV2?=
 =?utf-8?B?ei92TDJNelF4WFNNWGJ5WlRWZ3o2UVlBMkNLQjBNZE9PN2FSVmpUM0pVNVhY?=
 =?utf-8?B?dVMwK1ZIWDJDeHNoSEVjc0ZKa3BsUXBFODRzSXZjSWlTTDNUWEI0alFaaUlL?=
 =?utf-8?B?R3NaeDMvMlRCUWR1aTYrNGYrc0pqWWp6a2QwdWFrMkdhMTRCd1ZGU0Z3ckVH?=
 =?utf-8?B?NkVMSVZlNzFuanAzMnhCY0xTK0VWUC9OTUxkYTRsNnZGd2NldW54QWgxdFpp?=
 =?utf-8?B?TmdSYUl0S0cvUGh0a0hNUW5HTFM4aW8vLytPUm9DL0kzZEE3cnBzSlorQ05K?=
 =?utf-8?B?RGliTHJQSzZFQXljQXIrck9scEI2a2lSdVpKUTRISFpmQWI3SWpvT0Z2QWsr?=
 =?utf-8?B?L2V5bjdlaW1rTFRuOVhRS3U2Z25HWXZvZ1NqUFRZUU55azNURHNJVk1rM2FG?=
 =?utf-8?B?VnpIQTIvT3pnS0s3RGlsVm8ram00a2FsemMvRlN2TFV2cC9FSGlBeXhhcHJO?=
 =?utf-8?B?N1IzcGh2ajBWVTlRREp5WGh4YUlKYjBKYmhDbEFyRmVIcFB3bFNWRWFoWm9a?=
 =?utf-8?B?bmtXREYwcmRPSUtrTWdIQjhPUWJGS3ZBQnc2bmtkSmloRFVwb0g5QmJjdDMy?=
 =?utf-8?B?ajVCWHRXQjZaOXpOcTN3RzhFTTRBV3c5Uk1mdGxLRTRRUEJNSU1hamovZmYz?=
 =?utf-8?B?TEQ2QWlrTlZKelBROVdDNUZxTS9DUEVFbUlEci9GRElxSlBOWEFKYXRzTkhS?=
 =?utf-8?B?UC9GL0hNeDZCN1dHSkR1TDZmYU9FMDA4NG5XMDNPRXV0bVlaSVNNTms2Y29X?=
 =?utf-8?B?dDZhd3Z6RUttVVhVZnNhcG0xMnBQMEc3TnIzVlNpMDYyNThtVzZDS3NWRjJm?=
 =?utf-8?B?NkEyWnpHdXdTd0djU2QzVk0vbWNyaW5SdjJOWjIrQ1NTTEVuM3Jwc1o3eVhM?=
 =?utf-8?B?QmFoZGUzenFrdEZPUE94dHJjcUNwcE0rcmNHMW9ueU1nOXV2d1pTUnhZLzZl?=
 =?utf-8?B?blQwem50SFllL0V5bTBlbS9vVlpHMjRqL2l5ZlJndFMrMDIxY3N1YzBuL01G?=
 =?utf-8?B?NUlVUExqUWd0UHdhTHh1Y2ZKTlBSNzFMZE1jcTBjTVJzSTl3clpsOVdPcUxE?=
 =?utf-8?Q?zkVQytU/tY/YE=3D?=
X-Microsoft-Antispam-Message-Info: fzKdr5MAZgZyk4Z/kJP6YZDX4lyAXer9DcrgpEg2d4pz/nbz69fOlu+4ef0Zpbj9GZwIhgyQYo6Uo4SA1LTDrefuJfT6Nuvi6SuBbmqzo9B7zxUL529R55beoqDSPcwYcF4GX+ZawAB0OdbNgt8EmzXFPtCI8sx1iSQKkDVwqz8RZXnPSzKhlUn3UEJwpQwdGuXotfkKiMM1n3wtrBiaPg2mkxZOiVBsL+7zJWxeDm5VqKRzolzQJWppdS482yEy03rw2YhWEmBiPNc1ZbNl85SszplNaA2VYdouCGqyG+KnQnah/XIBJ9NbFRUXstj6BCozgAw5JCiFjYVlKDTI2w==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:zqdkFGwQcANOPZeYgLsGE0LnOyryk7O0wxOGAxGtm55VFcB+QGS+eXQQQbpmF9DrQi3uQz/IjIbMn+QKT1TLn/HvVKZd4cUR4OEJTHZkxODlrXjW7ukYiGqojSiSG/uz1vT1izKRAGoTXpOr11gqU6FFeOiUXUBYvVm819T/dNlQypoAd/1CkFpKvGkRXPzvZQpW9vD7XwZt1jxdRy3P/1wkvEXt8aiurG91n1kOvqBqcr3cPBXrI5IPrtXj6rgdf+27VGaNSPjLEzl4UAnY0Fze8WmpYGQHYKBw626yzHe04TPcUUeyl5xLk0oqGAd0wxAl8mlJ4NpzaPl3mbFEdMcEnrxdue0gO38zFk+vDe0QilCV9pX7QU5/oGy3ukW1UucQs7v941jBtyjoRunalF01CHOExfSflJCcHxTiibqwVdKJ2O22RaG08IeboghGed+3UhSvlFn6+phmRiVaQQ==;5:pFKnRjmAErV83kVlB7j8hI3WKNjYhdYv6K26s8PeqgFyrzKns85wm+Nk7a5bAJxen0RjIlzligcweQv3wfrU7836+1hXHmSebmmUZLp1crpKlQ11ZX5z2Q4tmLu8OEvY5rie+2Fe0D+zPL0ssIY7xtbbZmI+W/3kintx4YfX9CQ=;24:YtWheGdTaEnLqVuXFdW7nf/iRbuqYjppX8w3BHQ9XcCwkKkmtZP0IzW7makV2t+sbZShb2ixhVVKPIqcQN+0qNUiJjBkwv84KyVVB58GZ+I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:M4MtwyzlEWFpIAaH1j4nOqPBrnkDiALNgVxw3ijAz8M9EyxkSfLC9+TC0ph7dbH1MGeOtgyaRemKqPJOpfUyc4ZVFLTqcJ8YZeWez8/0YdJYrpi6HTcadJbf3xrA9v1o46bJ9MFpqdnLoFktcNr7Iv3KIjeHzV+kXdmhI5YTs6colXW3eYJ/DnRItZvWM/bSeqmIeMbk1rWpNZL94hh7o6OBEJXpunyb/Y72eB4RXGMOMxKsRgk22AalYIU6/j0S;20:jkNvFOSRGRN+VhTjVYulRRHFMtfK2hAzPvKqzvzoncXkdGHp6BCy18awhL2OPEGflWmC46+uX56bhf4fJqd2I3HoArNQnUqEEqsq97MpgXnUC/5xWvaFtpt0X1MpNeTzTR6B6x1ODqWHXww50XSiiqwhu7FgK2Vk/AHugaAPxYg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:47:32.9596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd9917a-848b-4a69-70cb-08d5d50084ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f5f96e52e0cd..7429588d6b49 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -144,6 +144,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7ca9c18cf130..b154fd2b084c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1518f3c613f5..d24a3e16ade2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -453,8 +453,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -597,6 +597,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -642,6 +644,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -659,7 +662,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index 79099bc5c256..3bac1b2f649a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -402,6 +402,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;

