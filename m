Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+hC4rlvSbeIqLpD84Nn59/zemUBI5SSNBszcvmIWneXS5eXcEnvsP5l62ZvHHl1fRCMRBk
ARC-Seal: i=1; a=rsa-sha256; t=1524571932; cv=none;
        d=google.com; s=arc-20160816;
        b=uEqcpDPv23x5IWcy5FZ7gIGYLPY4hvF7eUNw8eXxxfJeHT3Tq6v+boS6xCZ/0Vycbx
         F1Oimj5XIJNSL3v8B9dUA9kKTxk/eMvZriqX3jMepwUE5ADxHZE8oITJw8DCG7+sBvOV
         xfNgxFF8hXKICzOQRceVrT4y1XcohARYXEMqY2FDnHjfJWzewroYQ6jk7YmM8ZYgzXR7
         hP+hvLcKHPP1YjZ1WyXaLx1ljMTgrTYJYJHbuaiPhmbHeG4Sddbxp+n033ygLVhGU3PQ
         3z/1UCeoPuzMJDLQcGRqRk/+Y4AEt2t0iDUqvVyiIyiy3Z7mdffbTCHHwhzz2PIbd9XR
         GhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=YKkhVj48yN3L6Jegc5jNuibsgQVc10YAnMe85k0qUdA=;
        b=E91wNLbNBxJ7Mpi/rMJImge3n7T+F42uPTBrrnTPX1djYpdvw241GYYSwm8/ZZrszt
         v04htCyzq7EK5lK21/IHP1ZkLDIgQtbc01rVEaHCkJ6vvsRKGBwJHNp5tTFr5Eb8+1yT
         CYSxmMtHSSsuMd+hDGUl5KOmHO1fp8Vd4QsPd43yu6EwI5a5j8HXiEavI7XplaANByj+
         m9s8crRXYivt7kWNLgdpTDkp1aOhw8MFhhHoTE8RLqqDqrA6Qtx0DkBRd8eTglTaR/1V
         ph5VIaFBzplvc4YfNLNTjwsaQjt5X7EM/PVTWfhem5V+6ygGDk50HxtSYiczpsKhncgx
         A6cA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=KixgWp4v;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.98 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=KixgWp4v;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.98 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 01/14] mm: Assign id to every memcg-aware shrinker
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
Date: Tue, 24 Apr 2018 15:12:01 +0300
Message-ID: <152457192101.22533.16719199747465975214.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:7:67::32) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:U+9MzGQPhQ1QpYSO/Uu3nik/LvX8FyMsv2myPcpZIgIMDr7oz9xiCgbMwtBVOmcRTBgPoHLp4JoHCByVaL1Hy/L4x5cnuyNqBl/0pTV6fF957xOWYNweZ0fkjl/1RnqRT7t6kgY3ibmzMmXAA0VXoDJyITMQOL8Ke43ObHJkXRnNN10jjLsUVlBqQNNVYeojoQ7mD5Bb7YCf9oe8Qt3eE/EzGJ0/PisLUBGJ7NB+1XI6s3NfahQcTNRai3ophh4P;25:lNXQipIOIzSjpaa1KmqKRTYOovYeeyyYBbS85UcrQB18zB+EJ3UhF/7q84eVtKI4vcIHfD9O7GAIwvRXcO5fvqJJLU+99BS85GpV5iwh5BGWzz5WShPOMnmcuC32fotvZ53lBcEtm6fPEA9PVAAPlIg1I64RDYmj/vPf6QoOyDS3t1jgFzaHH9Nv5EdSya2x8yFnt5sqVPAasAvMxPKav2V2E8znNcQ+o3SZHogJYEj8ixPUI/higbJMYA8GnNxQbQtOKrbkFow0C7oDx1AZiXRdVJQRWbC7akg5S67GBR+qEXD6orIGoZ+ToLj+BhpMXzkh0gYuTWQFLYNRcnKAPg==;31:e//2WFzO1FqxdWuCUzZlT3XKpIHEhXg7GerHzMQu5Z3JccdK6tfAjUQOVD5Wvs8eTl3RsXaRfzlKD7lYoXqg14ySuBlW0Xhsel77cGWMoEsGxgb56ylCkxOQt/CYVzwL+lIHHR5inJMkUgB1Wdlone6ATFDP62NBBsgCeeiTxRhmfwmh2BggrgAT+ZLOPcWWefnovr6PZRgA8wY3la7B/WqQuQCNfQyxjNXpohFBeXs=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:TLGPVUmU1ZwMiu0pFm5LA+odD1RVbXGy67vk+SrOwG59RjG0e6LJvLb4eXgqrHNDB4lxGskA3mURPGJWoWvjzVEa+yWhotZioX/5OXSkkg2aIPoFqrby4F8Sv3p7tRGkimrd0fShFrxNCEa3+fdUFFEK0sJAS2sM+R31GbqSCBDAl0e0gdeRQO/SwdRowCPR8i/j+KO4ogYK+FsOB0uWRK5Y5twfSsXJt1eLbAf39FpusFu7ynu79Qz89zFRGfNEzjsjmianKc+Uck+n9kijbyN16uPV/09MpL8PoizhPFxUT5kfyG1lSSsC30fgWwp3b06cAOJb6CE7o/Okzhz2DIYh2zaxk/tg/eKGy8mYqxFivRnrsQK5WNczJj2X5Pm9kS7p9onp7g9H836rDnVoBGryiv8Jb2/0ijFtmLirYOqfB7NSXmEGJLl1EADa8JOZ+0bSr7/Qzp3/aoghk3i8Gjax/Cqj9jx3MH0PVtiT83bxIDy4AlLifx0LINtZVmYg;4:8DLyDAVmWHsm5klMHKSZeQuN5s1AjLIPE/eJo1Rq6sFgXEr1fCIFqvLmDVYPcEq7Rd2Tz0V7xGkQgdvIvF3iZTp9NdFOil+PIydDYNDq2EmQE9tw2U3JJejR8PjU9ixdJ/2TYwy/+XSN1OJjaivzk1OIi8k2KMOBw6qXTCuZRuHyxo4cXkz8cbD2bFrqUXQdv3wfrmbZLSrT+fxLbQc6Ziw/YDMyvq/TbNUtw5m3dDLLgvAE9KotphiWxIlR0KtzfwMsemFjE9G7D3+VBfJ+tQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13354BFFB283DC289CE0AF5BCD880@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(396003)(39850400004)(366004)(346002)(39380400002)(376002)(199004)(189003)(6116002)(68736007)(3846002)(33896004)(305945005)(25786009)(106356001)(486006)(186003)(76176011)(478600001)(58126008)(61506002)(575784001)(316002)(476003)(97736004)(86362001)(66066001)(230700001)(16526019)(6506007)(26005)(105586002)(59450400001)(7416002)(386003)(956004)(50466002)(47776003)(9686003)(446003)(55236004)(55016002)(7736002)(7696005)(52116002)(8936002)(53936002)(2486003)(103116003)(23676004)(39060400002)(5660300001)(8676002)(81166006)(81156014)(2906002)(6636002)(11346002)(6666003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6Mys3cm5JMFNDSkg1TDEvWmNwbmNtNmUy?=
 =?utf-8?B?Wmg5d1drdXF5Zm1wcXB6SnR2Q21xZkNBTjZUU1pYWGdlMk4xWkJmc2ZIMmNP?=
 =?utf-8?B?a2lsZzdDMzVHeWhKVEorcFBPMVJ6LzVPRk5qdStia0NKN0hRUUluaXZIWGVR?=
 =?utf-8?B?R25oa1QyYzlxL1ZwQXZPRE1JYVlSUDhQV0J2KzgxYVVYNVZwUTRXQVlPemsw?=
 =?utf-8?B?REtGVVVRTVJLeVBnK09hUk5DMktFTWNGcE41SzdtcG5zOFd0WEdHV1g5S3NX?=
 =?utf-8?B?NUJkaEFKNm55TENKWGlpSHRYQ2J2bXlVTjhXeks3R21Ga054OWNXS1ArVURr?=
 =?utf-8?B?ajZ0UzJVZVNKR00wbWU4bDd2ZHBsbldPcWp2cnZrbVgwR3JhWTJuUVRWTHhG?=
 =?utf-8?B?YTQ3eVhkZkY0OVcveXNyb0JoYzBuMlJVWWxkU1NxWkJ6VlVMT2M0azljb24r?=
 =?utf-8?B?Q1F0VzBpVE5jc1ByRnZ3Y3dqZXV1Zk5QL2p1MC83TnFtZE9ISU9sTmp1T0FR?=
 =?utf-8?B?UFpqUFp2ZnlubS9MZVRFNWJ4WkRYcm45M3M5czVIUThRcU45cm92QTZjU2pG?=
 =?utf-8?B?VEc0SlV4L0NJODN0WjRMQ3JJQjZzc3NtZ1BJM3VLd0lLeFgxMktRR05uVG1w?=
 =?utf-8?B?ZWR6cmc2STBsU1NsRENUSlZkMm9HV1pJdWFYMXIxdE5zUG5CTnZRbnpTWmRI?=
 =?utf-8?B?anRkUUFDZVRvelByM2FRaldzMHJ2eFFwNGtJL1Nnb3dzTWgyT01oNjJ1UHJ6?=
 =?utf-8?B?QkpMWGJ2Q1phZklBSFRhQWdXbDFqRUhLRnFvQTJ3NW9lR05kN2dTWXU5M1Z1?=
 =?utf-8?B?Z2t6S0lidEJwTEo3ZHdGemJCdUhkM3FBQWprOEV1cWZGZVRBeXV5TE9aTE8z?=
 =?utf-8?B?aXR2T25EdlRRTVNXQkpFQi9NUGlZMHd3cE9sTUVpaFlQYS9OTE12RzJpUVpH?=
 =?utf-8?B?dHVnRUVrL25uT09QMzZ6Lys3UEdaeVFLMTlPbmQzR1RlN1ZPQXNMaFJMb2J6?=
 =?utf-8?B?VlloVGlJK3ZwLzRTYUpVMzVEUXo4Q1NyTHczNDNERDhHNnVQLzlENkpBUTJ5?=
 =?utf-8?B?c0JGQXhHN3JNc25UVGprUi9vODVqWmtIYnBOQWxqaGZGZkZjQXJqYjZmK2wz?=
 =?utf-8?B?T25KeldrUjQwWXBTUHE5QXB4NEFVdnp4cmcwOGluazBDYml6Tnk0TVZYTEhy?=
 =?utf-8?B?bXpXUFhLdTUyQUlLSmttNi9nWEdFM0t5QWZ4cVVRMnZ0UWhMcmk2c2JXZTZp?=
 =?utf-8?B?ZEFKR0hkSEo0clVYVlB3TFZ4WHAxT1lyYXBVcUhCTjlmSzhIcHN1SjBGdEVo?=
 =?utf-8?B?MndhdUFLaEhWZWwrb1lFeWJxOGs2Mzdtcy94eGw2SmUrU0lIeGdnbUc1T0Jo?=
 =?utf-8?B?dW9qdVVoSVdhY1hJRmowaUwxL2pqQ2VndHhvU0c4NkpRdGFaT3hzOVdPT1po?=
 =?utf-8?B?eGxKTnd5OXNnRExVYTkyS1pNTWZlcGc4WEpPMTdpTExwUUxFbWtJVUtHWHNw?=
 =?utf-8?B?VXk3UTVUYmZLcXdjdm0rNnllWUd4UWxCZHpFTWkzSkZVM29kczNsK0NtT1B0?=
 =?utf-8?B?WUtMN2g2RzF0Y1ArQnhpY1FLWUtrTXJNaENTWFdzMXp6Z3JkQ04yb0YzeWta?=
 =?utf-8?B?NEV4bWtzWjVxUStLOXc5ZG9aMGw4dzBlRWQ0bDRaQUFMdTU1dXdXS0tYLzl0?=
 =?utf-8?B?Z0E0OUtQMjU4Y0JoU0k5bVY0UWF3RysvNDR6bG1HYWQ4R1FHamhtUWIrcmlR?=
 =?utf-8?B?MVZHZERDVlp6TzhKN1JMendNZ3Z5MkdKZ24raHZpdDhLU0FXSkFhUGFOOS9w?=
 =?utf-8?B?TkxJczBZWlN4NDRZeld4VU1GdFd6VklNNER3dFl1STIwTmVlUm1BalBEc2Mx?=
 =?utf-8?B?SFVjNEwrUCtVblo3T2tJOTNESmVhQXBGTXZSNFluZmR1SVY2M3RJWkw4b3Fs?=
 =?utf-8?B?ZDNSenVZOUlHZWFrZGNNUE5Hb3gzZnRoUjhLbVVMQWF4RTczNEZ0eTlsQUQ4?=
 =?utf-8?Q?V5eIkg64?=
X-Microsoft-Antispam-Message-Info: hFJwhJxLEsRQse7F1ms9xFJJwuJf4eoSz/7z8hDKzjI/iNYm/UPETqkIIvNMt8LpvNPa8xab8dg3m1aIjPxpuq48HhNfdQkm2c2RYla1GlaeXejnB2h/d0bX8xm0QD4q9GEA4/rBqfPoddlIWnn3jU7kWRwf3X7OcvDFNiaNi6JuIj358kRpKStrdDO/3qA4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:vQ4teg4/cOzVMetFhIXi19GGvBO03ZanO1cQG9lGd8YHeUURWACeYSMhHtU4TRAytvGjVXzdTYMwBt7PwFIZbCx8x+NSPJEApMmFn7Hpl8JHBvxod5Odckp3gmsoqYd94bY3fSMrmHoiiG6SPSGKgGFAJxipuRdQYOXTnAiBBxyok1se6CH/ocGiH+XI2DxHaLz3HTCreXz7nw44woqKewecTS28Av8uRTi25/o6r0jhFzEbR6I+QDR1dQqAEnb8g41WuEBxX6SoM2mlx9/RIlkR0SGY0BH5jlbXdu1l0X9GcfV4hrMWTIcyl1BQdHMXB0LjgX0F7s5oQH6VZguZPAsmRTRbLlMZKcmJP9MUnyrH0k3Jr0nWmw0wWEAu09ZJBubUFYUA/hfU+6O7sF0J3ZGFCjHrwQRMfhZ/Me1Y5OIICuW1TtOWTGQ0coYxtKs1FAFGKDYfN3LzXCu9wCKmQA==;5:ZwbEqKPjM6jqFBx+/2debB8KvhhgbOUtY6v78VMaAoE45H8G0uMReJuR/oNBK26NaNgUMGqo5fv1f4pnZmucbrE8LHiO3AUskoNPGihclGxwiMidd4kT69zC2pOzK14UVCLufHvTlnBNxGkaxyuINUkV+vT3judclhgmtqLy7ss=;24:Z13PW30Hf53xyy85RgGoF/QLJ+HzMFvejGdVNNdGWxEQR0EIEvgDuDQTnVYMcv/wmTnPvY8N1fw/A2a3N+oHc2hjuTMeU29sb+SYK2UhCnU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:HWZgwFzCIqwunLvoAAkrqngAth43L0vCVANXw6rkEPttbxUXpyO4tWBG6WxGtAJoquayVkSOoB4/lrxV6ootzv0a8/V5zum7EDS8p5/oNYj3+ru+xy0et9UWrMqFRoSslhOxmTLV8DWIXPp6GRQ/KzTlG0nskAIG9B8k2DjSvgXNwWaOfTMpLVbkut/7ACc6M1SyCGzovXetwNoPZJO03fyUl3fAfqPZXmQb0j+jjboMcxM4NNNDgg91KlOHfv8Y;20:Ko63resax5X40AvZsJ1hrguaJB51ELlPXv9wzrtTKFkhrAvd4bAniLjd0IIcKHOZdNLVr0I64H+Nq8X+yqET4yEvt1FkECZIXxTDlLnADqXU/06n9IMsmT2IeaWYs8/p+YQim4ezo3LZ1laYUJaHcvfoeUG1gas6ESrpK6FDHpk=
X-MS-Office365-Filtering-Correlation-Id: 4bd4fd63-cae6-4514-3b21-08d5a9dc98d4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:12:04.3174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd4fd63-cae6-4514-3b21-08d5a9dc98d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629539352200402?=
X-GMAIL-MSGID: =?utf-8?q?1598629539352200402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 ++
 include/linux/shrinker.h |    4 +++
 mm/vmscan.c              |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 122c402049a2..036a5522f9d0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	s->s_shrink.id = -1;
+#endif
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
 	s->s_shrink.count_objects = super_cache_count;
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..a9ec364e1b0b 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9b697323a88c..6c986c07dd75 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,47 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+static DEFINE_IDR(shrinker_idr);
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret;
+
+	down_write(&shrinker_rwsem);
+	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto unlock;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	if (id < 0)
+		return;
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+	shrinker->id = -1;
+}
+#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void del_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -306,6 +347,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 int prealloc_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
+	int ret;
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -313,11 +355,26 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		ret = prealloc_memcg_shrinker(shrinker);
+		if (ret)
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		del_memcg_shrinker(shrinker);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -347,6 +404,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		del_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
