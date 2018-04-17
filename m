Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+Fh8W4Gf6ctRWFBCeuid4p608PyDMqxiw11EhQu/mCyHDKnveTCyGt5DG6pVB5nc+RAwOG
ARC-Seal: i=1; a=rsa-sha256; t=1523980478; cv=none;
        d=google.com; s=arc-20160816;
        b=LYdiZcw12dGnAWRUdAAqFgJFyhHE+mNn9W3g/86MPYXDYjKU5FLPBvgwPIEAo44WZA
         HYBq0IyOC2b/58Sf+ENKH+65o1uMMtHx3Rce+MRQxRAWQbw0eg75i7M+Fjx1XcPs9dmP
         Zztk63Q+Jq/xcA5PLMG0LoPxdqbO/gklmwq/Uo9TVA30UrzWRW39Kbg215ybCLskU3HK
         zVsN3Ph8gwkoH5C6RgiAtiWsyv2YrxfrBc+j6j1dHqetOF6V3fsB6MDAz3Y9gyArjtD+
         CtytWiTgQAlpTxs9EaPtuKs7Dk7mRLXaoOGi+ocPaYxvexQ43reoCReVL+qeXXf+lgv1
         KCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=Tld5zhSRywCheeZ0pbt+C86bFBnlcfIXsKX59mKWhYM=;
        b=thIL1w9jAq2F0Ij9t/IfeIjRpB5H/Qr06mr9ppOZ72xNWXa94hqrwUb/Aq2Wxo1Y49
         ve/DA/KbTV7dr/vvOl7ACE/CTNCdHJUfrCjiM4m05tL98i/6l5up2jby8d78Zx7QIyIp
         vEjEa0wuKkiGrgLKbvn1ro3sZVk4akrRaV/vMKkoKg4K2Lepzf4A2c1LJZF3EYi5j5f4
         2MmK+QqSX1GVf0L+E8/s8Es3EFQUAo+GprN0vBw9F5Ds4EeVkhJRLis7ajALLuxftBjh
         OkpTDWAvHU5qpERWOtkcjE64DThDKAFXJvQDlbvZxTtzvS4qtLQt0H+2o4K+bixQ1ERV
         scqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eaLwTcKn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eaLwTcKn;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 09/12] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:54:26 +0300
Message-ID: <152399126619.3456.6019144653654528911.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:YYErI36z1W05qLlVmlf7THOqK26CJXiyNIGifjZipoR0is0/NCo6wgll9x0KU8J7Ekn3KX2XVfAlLOq6tDdqUIYAfNkmFbqodOUtuz7NbUvM4r5FPLIry/2UsJABYYmEheUarmKbvWPuUwwAnBt7AZfJ2SsVfXGU9BD9jzBuO4gL3X4dhvuQzBtRTEpBX+bIrTntBlvSodNDZNQiDOlzIWs2WA6DBo6q6B4zxjs5xpe2qERpmIbExJw2WtNLTXxV;25:7PuQ5pDBnzkTUupj6w0TefjhteXhUYdOqBhbC9yOsOBL/Ph/TLI3CxoeejimmCl93iCOEzEmoex66x1Lz8/RRCZkM0WM41mX6UgzcDiljz/CqIU0UWLxBt90DbX0d3tuhSr57Dp0G/3XVTNB+3LOmo7VZRWtqVf1WRo3CY3bQ6yw5S1UsAwLFJwIStMZhcq1h+psOW+fU7n9Vm9nljhCk0W9LUI+rnxLJWueXj5jV89en+zneIePE64X5X9v5gqhzIXtCP/VQl4U+BQ0kKXKWkuYTZWAEn6SPIY4BHLGrGA1t2uPyxUHXtN2iQdKDOfZ28xC3HeDeDU2iPfWC+t3wQ==;31:CBmPnQSxspOiLO9R7hzrNxbiiHXgMca7PFDQVKg0/R0EoFTMjGN1N0PdSnza2fZp89upspMnQFutt4lHuQFAs4aDF00F95BlIsAZ2ivLr9dctDI/BlLprXH/O1U+5OWqwCr99PNqQKY1ScHBDRHtFHx/RAcOmc7IvVx9zD0a9T0xX+IOOWDK970Sq6LS8EEENh0JSmyMwSLT4/ZxwUrZo1zmi3AvvEuzuOm/e54QS5g=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:GmMnQtggmKJrzGBKzW73IKs3JzB042WxjqrPxjeaQJOUDeuk74G6kPqtbiJdKScSqmcSVfr5GO9fmVuC22eZNt14CyHGzdD25YSezDn035SEod494qXraK6N5Ck3X/55VH/HJWYCx5J1gGFs7AjHJE0uDCeMxpngX2UMbQDJAre0/2wzg2JhBTwYdQ6N0M6MhOO6H4k7dEvGoHWY1mWYWN0rf8gUWTbTHER1svvJyFBLGAGbt+aHCK/G2ALcSW9OBKjEFmIYiHOv5DU7uRfNL2WgsV8QsrZX4RqlCE12N/VToVVk6DQgEzc+bidEuz+PCuXmYKYjlK06p0+kEtYrd2POiQ5BijcCNuM82sIRrK2cUGMxYyHkHRqflzT2xrcRW9uxThnA/80og7MY9rT7Vw5IwaWFfuHpkSlwCNsK3k/Sf4fqQN64RJ+bORNTSiUYqd+VErkQ2c1fBwgXslwCkpY/imZL9LKsjrIZ9+lb6MNK/a8L4dD9/r+VfvqBjfPU;4:dGVGYRoc5I7/Mj9PlckWDUgGjrLXxM4y5tjb/JZ66HIydZ19BSzMS9hglP/qMheA9Et+yAt3WIauysOisRX6HDf2XiG2G/NZrF4wTS3Rrc9eNfoMzH4VruvmiN8PO/nC2VfNkIwl9Z4bfHZZtCoDW7YKSGH16C0lEsIJmU7FcMxvB9FAHYRo48zOelkqJENWzjxT9WePHxQMXCK/b0RNI2XTAKG0+Qbdy+RfxId7o7wfBgGqoma6sj8C+FxCzSyjpXlWvO35u2Q1cV/Dh8lG2g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338D379A3A48DA41446FF3BCDB70@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(396003)(346002)(39380400002)(39850400004)(199004)(189003)(47776003)(6636002)(7696005)(52116002)(23676004)(55236004)(7736002)(68736007)(7416002)(53936002)(2486003)(33896004)(76176011)(386003)(6666003)(59450400001)(6506007)(316002)(66066001)(305945005)(3846002)(478600001)(230700001)(86362001)(6116002)(25786009)(5660300001)(8676002)(575784001)(55016002)(61506002)(16526019)(26005)(186003)(103116003)(97736004)(106356001)(105586002)(39060400002)(476003)(11346002)(58126008)(8936002)(486006)(9686003)(81156014)(2906002)(446003)(956004)(81166006)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6WEd3UmMxSUwxQ1RwLzlDMk1POXQ1NHVu?=
 =?utf-8?B?cnk1Q1B6VE80RU0yT0ZGWXFzRmhpQ0U0aUlsZWxPaUZmVmRKYmNDS1U2RkEx?=
 =?utf-8?B?WGdwVFpwZWNWTVhJOENIY2F5Tjlkamt2eEsyV1NnaFJCdEhvcnpsL0ZHc0ls?=
 =?utf-8?B?dG96MlhVUDI2ZGZzSmtCKzR1aFFEa3Y4bFBHNlBpbUsvVFdKQkpuWUVJTy93?=
 =?utf-8?B?YzlBS3N1dXBiWmk1Y1hheWl6a0Z4SFltQXVZYUp5YUhNa0FudFUzNGM3NGxK?=
 =?utf-8?B?UlY5dmdzaDVWMlJkMW5tbjZaNmRETG5NT0xDV1l3cW9NUGJSOXFnb1dFVVVN?=
 =?utf-8?B?OURiL0VkVW81dDFvUUJaZ3RIU3d0R2hUTEllV21sTU95QWpDSXc0Wjh0bXpH?=
 =?utf-8?B?NEQ1NkJlaUFBWWRqZzVUeDJreUhrdE1XM1hlTmgvTll3RXd4Sm83SzBDTUVJ?=
 =?utf-8?B?MUNDaXVwL2dXdk1QUWg3ZytsRUpBSUhjOXlNTW9tbThseDV6WHlqaHFPVHdt?=
 =?utf-8?B?M1RjektUOUZEaVZkMXdXTzNmMFBhYXBCdGFzVEptZi9sYS9CdGNIS3lzM2ds?=
 =?utf-8?B?QzJ6UkNrODRJTlVhd2RpTnV6ZG5zakRZVXFUMDljSFY1dzdSbENlcGF6dm9U?=
 =?utf-8?B?S1NlcGZsRURDUllZRHV6bUNPaHZqOTV2dGZMZ3prSzc2blRHOC9VV0lwWmlE?=
 =?utf-8?B?anB0YmhQdlZ1a01rektVMTV4anFWY0p4b0t5Y1JZamVGQ2pMU2J5czh5U1NQ?=
 =?utf-8?B?OTZrK01LWWFBZEtkc3ZXa1UrWVgzMElkYjk5Smx0WmM5em9PSGdUeWk1Rm5V?=
 =?utf-8?B?aXpzZmJvNHFFcWdCZ29xd2JkU1lxSVd3akxNeUExRlhUMkI3NnlDYlVJaVJw?=
 =?utf-8?B?eWFnU0YwRndncWZ4UXI2aFVIaVcwbS9JRHpFM3AwNnVmTGdNT0ZWOGh0VXg3?=
 =?utf-8?B?b1RSRG1wb3JKbDZFczk0ZmtBSU1EdmlNcVlrR0RrcCt0MkdpOXdLdy9LYTdj?=
 =?utf-8?B?QWRURXg0MEtKdzhyVEovdjZPY2l4VzY2QjlBQlZtbWxSNUdTSXNEZXpWTUFz?=
 =?utf-8?B?UzJVK2VDRmxjeE9GZW1TVXlFR2g4emhoSE5mQ3NtUmtwQ0NCVEZUa1hhQS9y?=
 =?utf-8?B?VGJnV3dVaCtlbmxLc2hZSlNQRXRsMk5iN0N3aEdzM3k1MW1SQkdlWnYwSmRR?=
 =?utf-8?B?MlNESGtnZlg0UUtjalNlbm9DVUFUS3lZakc2bldXNGJqdndXK05LeVQ4QU8y?=
 =?utf-8?B?dUpaTEFvcFUwNzhUTjR6cExMSS96SXRXRHBQcXN4dHV1UU5iMURINEhqNUY2?=
 =?utf-8?B?Uk0xaW4wc2YxblF1Kzc0OGxkaG9zTkl3cEduc1RkMWw0cVdUOTJ5ZVRYWm9W?=
 =?utf-8?B?SXBBUm9uR2V1ZEFBWDQ5V3BrUHh1ditiMjJkb0VCd1RUd1RWRmdoS1Y1RWZI?=
 =?utf-8?B?alEvMUdvczVDQnpYc0drYkFXUW1rY1llZCtoTExjV2R1aHBIVTdkbWRqanV3?=
 =?utf-8?B?SU9iZ01qSkxjY3NXclNEVzhraERPMGp1NktUaHVRaUJPU1dsN2x4UFdzVWhH?=
 =?utf-8?B?Z2tIWkdSbkEvcS94ZWFOSi9kdG51dzNNakJPYWt3ZGYyV1pVTk94WGFnWlVi?=
 =?utf-8?B?WWRpV3hPU2lLTmtrcXpnZ1Mxd05uN2FzTkdZZWMwVU9xdG1aZWlBaVhEMEIz?=
 =?utf-8?B?N0RlaHVHM0EzeWZpYkFES1NOTTZHZitQY3pYSEpqODVhOVRYUFd4VDlpQzZk?=
 =?utf-8?B?bitUeUF4ZFZzRUV6MVlGQmI1YWdvZjExWTFRc1ZJTm01eUloL3AvT28yMEpm?=
 =?utf-8?B?K3N6Smcyc3daUFpPOTFEaUJwTkc2SFY0OW90NTJtL3crR0kxTFdzN1h4R1NZ?=
 =?utf-8?Q?CFn4bGu0k4vr0=3D?=
X-Microsoft-Antispam-Message-Info: 1jJQTavtZqHQ/t5h6AGqSxxgHf+gXgKtmmx3PB6yp2Y6ZEHtPcfQejh/f+pQx967YJl6ZqOqI0M5u7QgwFEZKuok8o1zy91sj9CK4p+HeFrodk2SmtkDT9iYM4i+H5ws+OE/q0v/i32feTWchYebu5PF+c6X/ivf7VjyeiQwuvFVlzKJoAMvmAiWMyyZ+EDP
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:Ft5CvJVjAOS8hGAjKcN8hQLtbzNMxqepWZVDtbv4ipUjjG5KfbwdtxUfRZIJrsuvPWfLwFIUri5KBWfZ+RuAnCvZ7SQ87QW5vcT+yp9MBwbR4NyH3dxpG/c3sVOn96suo3G0QtHVzt3yolZJOCIINquoBg4roHtLwawREYk+6ezYQNORtEZW9M+L2Mzye47dKRaNGhp2DOlVWxGnyJigduaKzix1f+Wv4NK/UBO6w6aLl940W3ySmMlKPOpMDYs+JYj0NjX46AoGwVVMigdU4b6pLkasszwpdD7d+4+r64DHcFL4bjoZIsajQQOSjszTT72bQcgYaWhc46Tl/gXSSsnYU4GyaFOafH53keEqnktj+7VvlTTCFRbvKOSxyFs60PZAlYkuIDjf1FM/ckhjNZctrHbZlggYBO1CgD6ycq7VzRIpf2KXM9pEGokufBsJ1aXgN0gXre3ScDdp4bfUlQ==;5:lydydzO3CD6yyuF17gZ/Oo0Wu25fAi9uafusOjKg3xSAGnqxsVVOfIol0hQtxppDvRLoLbPD4cs7ovSHOxJcsYLMNo7+ID7EyTIm2ok4Xd447iAkNMTBaSueFk9Ho+5ySkl1SKr/MzxlTrC0jH1fkHMr73JZtTEG/IP98ifG2h4=;24:HBEhCmAQao8OqV60wwP5ny1wqlacfhYVOn5/EvD2xSJE9YeI9KSO++fVsQPhVMwsMl2/ZHFzLPEh8Zgezqt2W/sa5JX3W8XsGy8iF6wwcYQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:mm6uNdOhOQdKusNEQ3daYVoTGueXyJLa3cqtBYmNYYF/+46YMGjz/gbMp1LLHjfxdeyamJgJvNK0w3KKFm5KjpPV4rylU6I70hsXQ0hYTOgI1blX5NHWkLAnX36DirjsJTnn/KPOrKJLXvDMROYUCivfqNVlMy4T2ulOAhKjyGTv3TQZ9Gi5EoJr8DvfK6jav6lhn/0rMX/IBmQW35ICL1lji3EGTLv+FCrRgljQDQ9Jt7Kna6YXwNPF2hEaN1vl;20:uX8h3QV1TdANv5v849vUqiNZyGzmcgqfnbnuHu6TU6NQIsqDDoqSP7WEYVY0cnMxEmBeTL6Ru53I3LzsCODsnqDyX84na9jafedd0GFDownoV2l6TBH24n3VrsMXiQd9/PF8Ez4QndzMrAgLhKyZwH37WAG3KhQXFI8d/SVYY6g=
X-MS-Office365-Filtering-Correlation-Id: 7d7f38c4-a878-48d9-7fb8-08d5a47b847c
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:34.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7f38c4-a878-48d9-7fb8-08d5a47b847c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009353682846273?=
X-GMAIL-MSGID: =?utf-8?q?1598009353682846273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   13 +++++++++++++
 mm/list_lru.c              |   21 +++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2ec96ab46b01..e1c1fa8e417a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1238,6 +1238,17 @@ extern struct memcg_shrinker_map __rcu *root_shrinkers_map[];
 
 extern int expand_shrinker_maps(int old_id, int id);
 
+static inline void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
+{
+	if (nr >= 0) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = SHRINKERS_MAP(memcg, nid);
+		set_bit(nr, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1260,6 +1271,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void set_shrinker_bit(struct mem_cgroup *memcg, int node, int id) { }
+
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index ed0f97b0c087..52d67ca391bb 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -38,6 +43,11 @@ static void list_lru_register(struct list_lru *lru)
 static void list_lru_unregister(struct list_lru *lru)
 {
 }
+
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
@@ -121,13 +131,16 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -522,6 +535,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -533,7 +547,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
