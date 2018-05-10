Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZos7vK1JWCbtLrQb9Eo2I760uCuYpLjl41x0Ssx6nR/XFW3u0nXwmKx+bq2Y4MqcmxdobBP
ARC-Seal: i=1; a=rsa-sha256; t=1525946055; cv=none;
        d=google.com; s=arc-20160816;
        b=jOFRfOH5BfWGf+pbE8TwDfQ1EZdlZH/bzk8Z9vuBzXc/e5cyhW9U2JGoLNtdHYK5UX
         k2lB3xxjlj4bB2egkT/ABAWkondjIJG5TwVDHsYkVhOX790qypirLO80GXJraEj4Xv6X
         IuUC1U3oy0ISYIyG/vR2spLvpZrXvUYidFxChTZ0NOxzvyTyyoY/JgyI2RT35GvWk36t
         cMfxU5QI1LNDWozq0iTnI//PERs5iHKoYAcF5JPCZdmwwvFY8sena/ijRFfwV5AcELBI
         5THiIUlrm5N2/U8Sln1CGKcbVE4LPU1z4ECBCMV5u2e+dnhUelpJHDTmoMccqwoNx8JF
         6iKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=GxUUVkzyfzxekYFSXH9ZiF1N0xg6ECCmVx/5DgTypbo=;
        b=CjHLa0aPn7Hqc2985Ls9JMD4hkYQhjo+yJKiSovoDAysxu1tLTYHYasWU2GEMhszV9
         pEaEQl/IFuyWoG9iWGy4ke20RuREPisykjzIR3UBFiYi6hDFj6nRuyQ14OAoAnnktBrd
         XYwsLlWWoeXGxi6Zv8P3h+6/2ZW6E107svZwZCWNtBi2bT2WCw53DrKpqcEQS2QRwdCV
         S5j+9dyzpO8AvSI5yZ1TnlSGAgLO6uQy73MNv9HjXPNHTCyLT90scuGYjgHLsi67nwGB
         vtKVXiSAibG0hTCr2yOyUIp3ik8UO+FivLfXnJFFmFO7ti3g1Ez8m0e4+G85EARbPKvA
         hZxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OQmkT8x6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OQmkT8x6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.124 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 12/13] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date: Thu, 10 May 2018 12:54:04 +0300
Message-ID: <152594604464.22949.13100629516136544648.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::29) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:1of641lO+l5FWzIXvh9onfASEabATpWDMe+cH12Bev5abYynSzSC9sfsVbmRRMXvmNOi+2sWKjrqbzyAB2ru4nZRjvJuGpWJ7KpaIo9qGQ9N4oqN3EwVPBP1aCI4AeZ/WkFgH2D1gnB5f+yOWxEhbIZ0SiT5EZ5o+tYyz+XbBLEH5pWwhmkNO9lWKk93K9+Z+3F9VG15+n82shv2mUrCjUgIkd22j09bEVu8LGo8PykvVk29nWeuew0/h3R/19gg;25:+2YOmRQEOrFJ7i0BCt+eTLtkxT5oEnPOlaS9Hd/F8NMXWZOIe5VmQuLHRvMkhfoVPgGHJF+LANazaryiaU9Xq2cV8C9aQVEcOk/zalUJSw7rMqjUOVvtq7POd+x/pgiBAoc6/x1p0pXwJnCM1fNxwu+iZsWcnflV5+6+FBJarUGAXpE3K+Uxs1IVMh8XiWMV8C2c+req6xLwuX79lErF2HajP3x4kjovDYCaD248EH61wwCBiSr0/HlFo9RFs3tXKNSG90QFf+4XcCP+G7Z6V7MpEPHuk1AjhtVz1s6Lh8iMaVfHRi6mpzE1Jb8YDCjfOp5OTLSdXkIZbezSmZgmwQ==;31:sWOCauzrNYCrjcTcw8+9GE3Yw+T50IHfna8PSBqvXKHezGLWu+Ivy0D7XDkHphwOi/1x9jKVvusARiywK1ZdpdzY9G30drzwE4Wgf+p4cDRAS84GucVYTtt2zeZg40esYg+o8lD1hbIhie6P9ZWDR3MuWQXrr8Ph52PPMgE/jk3RpUpzLeqzXBS1WXUz54PnKuy8VHfWmVeQ7E8C5++SyoN4qcHnhm35qGiGSveqpr0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:Ken5pJjXYZcjDADXpOyNOzk8UbXXBGFwicASVPv68K8FsoOcWOMzUPW4P5j4sNv9pz1w2JkeZ9XH7CMD75thMq0rfDqZOwPqfE/a8LZpP5y/1/80EGekM93hLBcSkWZc7BBS/qV95OWVMVcb/8LmasxR+XPVna8/LAs+VlwfmGuEdPUW4/dYguhdnXrARAKIbtwUHnCSaDE88egzzS/Wxq3TBVwpIBvHC7GvrYcw6Z/xdmn2PnX/2Rm97DP4fL4kDunA4YBMBZmxNljpp9lvaE0xzB/GsVaE+yK/WvGYbi9yf5qK7sQ8jf0ZPq38vzGwV61AGlTXB9SgjCfsdUrTturyudz2Q7KN4klHSt99noRJiNGpeK0WQCXGsH9zCmZ5erAyFwoqUpZHRQq0zk2q5Jgsq6Bxhv9meLcqMh3rzNNDEgLyUOgTsvE3vvsfgktmVFuUgQlZd1gGaDSjuDOkupnYmnaYWjxU5n5K/42NyLXGGEibY7YneiGdFv5EiOxT;4:uzbyIGx0DsMCHbRV0zlUBS1nmx9AIP4wh5H30evEeqbz10q9zQR94rrroWCxWvIr7p54jzbFDePR21YWSGYtdWbnYYeskVp5iD8e1ZKfunrY3BUB0qcv4o3n8gzM3JUPy6JCHGUHtUC9ltVkIf4Tanyf2EXkk8s6AxTm12TUQDduGOBAGc18qjTjr7MtuHmjVqpJiO+zC2rCkXxd42pVn2qvn4GS1DmwzD/SVNxvTGMYHVSpVj8ZCnQ1kypOaBcxvQgcxWqvCH3VTpCE/cx1jQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13350E6632B33C65B36D7246CD980@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(376002)(396003)(39850400004)(346002)(199004)(189003)(105586002)(76176011)(186003)(16526019)(230700001)(55236004)(106356001)(26005)(7416002)(2906002)(11346002)(446003)(81166006)(8936002)(50466002)(33896004)(486006)(476003)(103116003)(305945005)(7736002)(316002)(956004)(59450400001)(6506007)(8676002)(386003)(58126008)(81156014)(61506002)(68736007)(6666003)(6636002)(9686003)(39060400002)(97736004)(478600001)(25786009)(7696005)(66066001)(55016002)(47776003)(575784001)(86362001)(53936002)(52116002)(6116002)(5660300001)(2486003)(23676004)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6YWFDL0UzdFREZGw0TnVBTEN1YVFBUVg4?=
 =?utf-8?B?SmdrUlBQc1hzbGtQUjZneG9kRk9ZZ3ZSZ1NOUGNZNkNPTVJNQ0Yzc1E4dmha?=
 =?utf-8?B?VnNDOTFHTS9iNWlwVXBVZUpZQzA1VW43UDhCTkZ6elI5cHhnbkZpWlkrQXVH?=
 =?utf-8?B?Mnpqc1FnREFnK1Iya1lwcXJlQTNPVFlkbWRvUkZxSE5CWlpFU0hXTG1BV1Mv?=
 =?utf-8?B?UkQrYmJxRmhCa1ViNFlhT1pZZW9EK0ljUlJkUlhpTU42TFc0Z0tJRUFNT2RM?=
 =?utf-8?B?NWJZWTRUY3dXd0xQQ2tKQlR5SmdwSlIvOHdOQlJvOU9OVzRBWDJaUUIxYWU0?=
 =?utf-8?B?L2dHK05oSklsejd4MjJJNmlBU2RDbmV4eWx1ZUp5QjJ4NEQ1cHlXUkR6bUhG?=
 =?utf-8?B?WitnZEFDNHpTSHowYmQ4RmwxZHlQckQ0cnorbTFna1cwOU0xRDJsMW11eEdU?=
 =?utf-8?B?b2NVTTdDZkFOV3lTUnpNTElMS3dWZG9CZWdYYnQxMy8rdkJWTXFIU1JITnAw?=
 =?utf-8?B?MEdTTitLS3E3SVRiYjFpd25MQTBjcERrVEM0SUpTN2RRZHljamsrcGNxVHlG?=
 =?utf-8?B?YjgyV0UzL0kyN1VjbC9oazg3UjcrVWtRS1A2MkthQXUyWDhGRHZ1ZGxydTN2?=
 =?utf-8?B?TU5BOU9iemkvOWF6RDEvRkVMOEMrVW9YM0pVOUtBR0lDTW4vTXlMWVU5MStD?=
 =?utf-8?B?TjZ5Zm02dENqUnZPblZyYXd1UTc3WC9kUkJIemFvQ09BYTFsRXRSZHBaTkJj?=
 =?utf-8?B?bjhuMUtqK1M5RUxZczVZMDdPWmFpQWNlRU9TKzBLU09oZ09KT3k5Rkg0NUwy?=
 =?utf-8?B?RnRlRlNpcUs3RFdQb3F1WUYrMVl6cE05VGY4VjdPSDNPaW5NQjl6cGkzUnhD?=
 =?utf-8?B?elZsUXRDK2pySFFmT3ZKZTJYQU51VGdXbjhpNkNLQjU4N3haMlBTazZsTmtp?=
 =?utf-8?B?VjExdHUyYTRUcmJac01KdlFLeEFXaEZZY01ydDlDRm5rejVMOCtGQkRLOHNN?=
 =?utf-8?B?alNybmpsRUg5ZE03YWZtV1ZQTVl5WlVhYWdBRGl0RFRjdCtNeWM5T0t6MVpp?=
 =?utf-8?B?M1QyUjMycHhLWG1Pc2xkSEtCWjBuM2IxUHVYQldZU1RodTAxRkpjamg5UVNl?=
 =?utf-8?B?am1XTk1uRkN3OTBiU3FhTWN4dzBhZXJZckR1dEpOMHFhQ3NpWkc4bSs2cVdy?=
 =?utf-8?B?QUQ0MDZJcVk5c2NDamQxaitlQ2VYVFR4WWVvaTRScUFzK0RSQVF3VWVZcENu?=
 =?utf-8?B?TnZEeEZsa1JDejUwTTdCM3JlUFJoYjNXd0hEckRDUWRQRWp6MmZaVTlLUnFo?=
 =?utf-8?B?elZjM3N6RTE4VW9wZHNpbWlSaHhyc0ZKSUUzUUhUQW51aGZ6cE52elVsNU53?=
 =?utf-8?B?Sm5EU1FJTDRVb05kUWY1MVVGbE5PeXlHQ25ZZHhOdEdlN3BKaUpkUzZibkJB?=
 =?utf-8?B?aGROMVRtY1krL1JxSXpEQTNkWXVPcW9VZFJGRFYwWUVvU09sZUxBNUI5ME9t?=
 =?utf-8?B?ZUV6cm5jZllOU0gzdEJ6dWhEZ25ENCt3N2hOWnNxVlpnc2ptdC82a0YrNERT?=
 =?utf-8?B?VDlOWllMd1BIbWhGQW81UnpwTGM4dnJtbUFFdkVIRnp2REluSVdibERad2c3?=
 =?utf-8?B?RDZmRUtTZ09oYytON3JxL0RyQWFMUUc2R3FBNDlsUjFjN0kzR28zMVBsYlpE?=
 =?utf-8?B?VTFJYm9CTzRpMi9HRG9ZZ3Bpa2JJR3VWUHZiZGFxVklxOW9BbFdhOC8zalJG?=
 =?utf-8?B?dEJNbi9FMnRGQytNYXZOaXlqK2hFYnV0VTZBMERLMXV3Z0RsK0QyYkcrOTZM?=
 =?utf-8?B?REN2SEk0VHRodGVHK1JzVjVSb3BZT2hNSWJJWlJrZjhwVEZMS3J6TEgvOW9W?=
 =?utf-8?Q?Ad4DgZ8ACIvkI=3D?=
X-Microsoft-Antispam-Message-Info: pS5odTXYYBDHYYJut3wqG9WbnAsPFBe+JpX4wRVPjlyVXwuAnVrrvVcWy7O2MrRI9NhdKrsYj2gBRhiI8aFG01ClXTnO7oWQgGrj9eeOvLgSdJhpBXcsaskYmYZ1Q6Tan//4djNvZK1R1q9jWCgW2c8LV9+Gvn2CVOw5uAsN4kTA9HHRkyoO0LwfE/nGXt/Y
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:jnmhuqtP+Em333hzQrg7VjobuxrLWIYUmrIITKg3Djwp/DcOZak3fDbIT2b7FX5g/xh3qpXyfvs1JpzxUKXnn2D2ZC0yAINxqbWAezQyJHuJjNV6QeMj99VLQfV4K31E/l0YDD1LA0QKn6KeDcUoTNavsTZ2lM0HERx06UhpWrnqd/MTZ8XaMEaV7ocodq8EuAXh5jIwQVMxcBL/AtveOsoXzVnHVQYgbBKdkLfO2Zih7w0V6+Gd3KIFSS5Tf/AIX6JWvTeiU2KHu8KxRy464ZFW7wKouxpisUqLvRf/L5z3Cpk/45Ltlh4FXqAljf2koXvTsuZc/+2Ti4g8UFD0mukn+gMKY7if/lCMcwafSGY6uALlcUcPtv2JNW4jvpUaE/tmFl93/kTzDtRGL80MuGm7a21WiEmYj9hbNuwDSvBR447s2sYEuZsuxOV/GYHxtFrlMeS2ULOEQ45Ah6D0Rg==;5:I//GFsJzeNcyTlDFw3b6B+wPKJVRk4UMcX4nYZaugG96OC7fEO2NA5nCcECgyyBOAG0okY7TBMbR8Q76gDsYrlLPKknemHiuvZ08q95en5rYGwPfjMxtA/hgsVEkZ890O6avpD2ov82BKIzxpmI7QJVN6YC6lWPnCDsScbNv+nY=;24:rUw1nFQzLy3WutCAWo+NReU4kWsSyC3ai7B/xl17TCVi3XWBX+Ee3ynZS7HAwLBJoHG557clO5lsl2vdOClXedpfpsEaQFHrT5EATYP9rmI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:KNmrh3bMR9tBIULi/Q821NIusVJ08+0oOxpj4LfMs/5GJ8Khn7onHgXtxbR+LM5VgcQOwk3/AKOMITB75uP+4IzKjIcH9GJEJaZuTW93wFW7SFONFumUyVDYfyU13f4fVUIw54s3uNnj7eqelZUTBd9ahRWkg20AOLdpBJVArZQi7XjFyFhwZTI28BekrJOJb3ISyGTKTiAc6PJoeONd8cEXiJ2JCiL0mk2Ogpc8aX2wq83vc+VVXdgu7VxT6N6r;20:KbqY5SLu01mcVY36M/cpU5Hzg2aaf27G7ZsGyNRV/3ghtEUhM/h8Ccgt2EtdLzoA8898WSgzAu/Zyr4+FjBr4d7d1cfCjw62VqyK17Kot7eEWhN4BpR/tdZLP+8Q2zNfxO2BJD7bcqJm6Nb5HHs/ISRbpbI1QwgFxKO0yFaV1hE=
X-MS-Office365-Filtering-Correlation-Id: 83377715-e519-4727-8256-08d5b65bfa37
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:54:08.1200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83377715-e519-4727-8256-08d5b65bfa37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070410856684202?=
X-GMAIL-MSGID: =?utf-8?q?1600070410856684202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index dfa85e725e45..3cad04644329 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -134,6 +134,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index d8f3fc833e6e..82ea5012dfa0 100644
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
index a2e38e05adb5..7b0075612d73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -446,8 +446,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -586,6 +586,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -633,6 +635,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (memcg && memcg != root_mem_cgroup)
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -653,7 +656,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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
index da720f3b0a0a..e731e21a9fca 100644
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
