Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpBLS+My1vCaqkb2gktwZNHmlIobkVj1EmdjwkuPeJF0Ti/AuQQ8C9H1NQowitHXKD/7b2f
ARC-Seal: i=1; a=rsa-sha256; t=1525945977; cv=none;
        d=google.com; s=arc-20160816;
        b=t2BMuv8UZI51wAwt6L3xUC14Nmi8ZlJn36fWHT192TJie5I3jcuk7vcPLWphFxqrYK
         yRh+1OIN5hStEanDVeUPp8XOOfyq0XAtJ/+IkOjfqyCM2UxkIlX6rBUQD+1qiT5+rN8U
         R6gA+cnZ+l5ul0NUqrGLXEux9o74NlwE04xIU31KSQUPHjTK4M5MFDnkLBeSLEYuXq13
         Q6EcA8TJu86ZQxjbKWSubhEuXdjrehLtzhSNLk4CaMg2LIdcbT2y8Yfc5m78R40F05ex
         jVnmoq+ICFgzsiihjCKlBWjSredG1wLc8cjfRf1DIlPAHGvc7qUnqjUAWeInbw6s0yq6
         20Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=6Lv+JfRhmpiB11xmNRi/HUFuAWVUELXj+iX52Hpqp+Q=;
        b=zRmoXSo4JkMMhgawwkikq3OsSE3HLjRUPx0Ie4Z/ut5cOWe5G95kUdxknT4+addUKc
         NFnAjLbAdO6uNWNr6JJHaOqiRFYyLsbCbLtF3uV7cMx7bVt/UrU0aKnRLyUoHnl2Huah
         +xthiY2Mnh+R3X8fyHSY97uVGXe+zn8FaWHuDuPEtGKV4ciZX2yvrOQpgmSwqVcqH8HW
         upoGaVjk20/PTsm0nHc1E1nw4GCoF20pY1QUJ2VLVwWFYNIlsFwtGx0tRZ9s+F1HikWl
         gno9EtYhEoLQl8y3ZWaTfcGG5TSmzi/3+6jbWtEVcOQIOZr6lIsuF/ecV79AeG66JSbj
         sYCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GjgsvHd4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GjgsvHd4;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v5 04/13] mm: Refactoring in workingset_init()
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
Date: Thu, 10 May 2018 12:52:46 +0300
Message-ID: <152594596685.22949.8660258274427608623.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5P194CA0023.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::33) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:K5lK3+uQ+y6CF0d9xdlXXQejXW2tv/HCwokS37UpWmFyc4xQcaoEuy4vpQk8XzSMTBeR7koeT2KpD9WgdeyMQV+HRy0Wu7+D6QyzIvD6+7DIsiFZOheEHa1K2JPIBm/q35A0ChsvByr+CZg6B3JWSBGkKvotymxmlHWEMC3sHamKSYfwjKQGKi9Lc3/K3RZ4eDk40ucnJrCvxFH/vls9zUhBOy4QQVJHWcgC4fpf8u2K1Gft8DxQG3MOIPcMHevT;25:8qNRAfd6JjiAznSW1ujRnd2Vt1n81o1obt+0NlNyef+1Q8YB6nagAqVnXQYyRadtdIfwDY8WYP+2z8V+6AEmXanNbOwTBVYCmMgAte0dx8cMlbJ/fa/WY6fuwvEbhXq/WMEURUjNpiq+jv482EDGDH+cMA0Aa/J8geiCxA7XNJ43s6O6JJNPBr33fEUOAwQdOZJpByUEwf/OSEwTMmF7wMkVghtbJKN8huukKuK5yoQjgkwqxqMxyvqm+ndh4oTQognDa8tBKl/xVGvshwN5yJmX/Tvvb1v5oqgIMBxMmcKlXbTlH8JwhzkBFECnVqvBUHLIrxmubnpMfDCO1IYpLA==;31:rkQUUZG1pcO6Tm2DD/PK7vkVu2pg2YNFV3KNz44aA7LQcVcaIEAzGOChsCPj8yGpHGxAMM2VYGblWzwj2/NouFngXnoYfynopUDRJrNELGlbfVA3CNkaw6wmZ6mjHn1zlAAqCjuUf6bNzgWsSGsEG8/2gK5gjrq8df16g0o/X9UFNDrbmSgPmkOS95mpuH7eaFhng23/G7Z0HU9kqPSGx92rlfnTmOHfjNEev+GgyH0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:BKVMJ4MrKVL2Uk1sw4Ff2VeudTJSe2xeVJUW21MZARWpTgE5+TQHtc2Awz+mCjMwN9zkXOmCUrN689slYhzXqQ5llqOlh0wLzieasDs5vioJZt0MRSdPa+HgS1MhMJOGoL+QOxPQcV4Pc4/GvNRNqRg8AUUHLP4F5DswTvfXUbauTXIyR1NUmbmupiNKW+wBcUauPNNglivX0UFy63e4n3/U1c349t7bfcDGbyiuLmaRe3NcDhHdBAocOz5XM9odqa+ZjWtdiHMBs/nwX3qlGO6gJGvBKPZPSQIJoPz3sgBVWwjLfM7AK74+GwaLZy5s6C+lhXIynQ3d4Yc2CzFq6PH/HvMua4ZGfPVVMlSC5y7hzm38WrDPnoMUT7f0ZFHbgB/Kfmv59krnJRodDFh1Pv0VEPpyq9lPJPVe5ZxqD3QJ/+pC43NiQ7ZdacX3VN1mOa5IeI6/hO9vZBf4v1iWDOG9BIo8mT/EXMf6qOu9Bi7GIZRHceL2Re8x69hOcZLj;4:2BIfU/QaPL2BdKeqJwMlL19f11EFEuqKR4QRSdqlVgSRIPAITOCJ1guxJ91U6d1q3w+jm30I1d12DvF/xswaPnT5uv6Da9lkA4jr+kTl0NnuUS4i/6KQUMf4g/QYjo7eKpERz8GP2aOAhq4FNMM750OJ86yaE1FEVN9AXG0leiX0CVHywtfvh+nT7yQceGU6RVIUYX3bKnKFqEwQmJSxSiQXHn3RllLmvk0XIR+rKb8OcSOnRWaAIJDI3qc9OfEAkNlF6l/b0Xt7e8ePvMafuQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133978998470F8F954F86C9CCD980@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(39380400002)(376002)(396003)(39850400004)(199004)(189003)(316002)(5660300001)(58126008)(52116002)(7696005)(7416002)(25786009)(7736002)(2486003)(478600001)(186003)(26005)(8936002)(106356001)(305945005)(81166006)(105586002)(76176011)(97736004)(103116003)(23676004)(16526019)(8676002)(81156014)(55236004)(3846002)(86362001)(6116002)(446003)(11346002)(486006)(230700001)(66066001)(476003)(6636002)(6666003)(956004)(386003)(53936002)(6506007)(9686003)(50466002)(39060400002)(68736007)(55016002)(33896004)(2906002)(61506002)(47776003)(59450400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6RnR2ajZGY0drNTl2aGRJekRucjljSVhh?=
 =?utf-8?B?SlV0UFB4Y1RwYmd1MlJKQmR2VnhZZG1tbFZKNDE2eG9VaGxSdlZkcFkxVnpK?=
 =?utf-8?B?VjhJWnZrd0FhcXBMUit3WC9NV05tNEc0L0VIcDJZeHFKMlFVbGp5bmwrNnkw?=
 =?utf-8?B?c0VQaVdRQmhlYSsyQTRwZTVUL3NzeFdIaGFQeE4vc3RBSmozMWwweWwwRnJi?=
 =?utf-8?B?UnZTWS9FMExiZEVvaytDMTBhUFBzQzR0ZmJuVTFDcmtQMUxLUjYvNlk2VXpG?=
 =?utf-8?B?QmpNRFpGeUJuSjluY3BnSEt0MTNnTzg0UUk4K0ZaUzQ3MnY1V0k0aGdZckg1?=
 =?utf-8?B?eWR3SDVkZjlMRU9zQ3pQRFc5b0J0c3ZKK2Y0SmoxeGV2YzFLZ0xsVi9JbW9V?=
 =?utf-8?B?Z0x2SEt4L0tKWVUreXU5WnFrdTJ5SmpmeDlFaVAyMVM0TnJwdk0ydVpVcDB5?=
 =?utf-8?B?VGRiNjVja2MwU29wL1NEWlZsSE80T2p2aVQrVmtMYk1ST0ZjWEl3Y2puZG5U?=
 =?utf-8?B?SzJPN0N6ZWZTK0huY2pMY3VWV0lrdU9POC9CUERKNGw5R1pBakNOOERaUHZY?=
 =?utf-8?B?K21oZzRrZ3h2bDBuSFg5T2RHeWxMU2NtTEpUL3BQQjFyaUxaVVo0NmJsbHZ0?=
 =?utf-8?B?MDg1cUxwbHdwZGJ6TmJ2b0hiM2lobEFOdGNQTnlZcStjaDJ4VzVXK1dFcjQ0?=
 =?utf-8?B?Y1pkYUZaQk9MVStkTSs4RG5uVHVKVkJJdUZTTmZwZHlaSmQ1cFArWnZIeGlD?=
 =?utf-8?B?aFJSSGhFVHFUU3BtNW1Tc0JCUzkraFRpQkhheWZHYnU2SzBpTHNJZnQ5a0hD?=
 =?utf-8?B?NFpMeVlPVWxNZFZVTngvZ2I0cEIxSUhXTGpQZzBxUUNVaGVxUnlnUnh6Uk5o?=
 =?utf-8?B?aTJRQU5pZTFvUnY0UURKVlBxeEFlMUJYbFFqVElkL1NGdFNheDBGNm9TNHE2?=
 =?utf-8?B?d1VXOGhKcnc4YmFhbk9Zd0YyRC9vcjM4L2I0TGF2YXVFVWNnd3h1a1MzUEF4?=
 =?utf-8?B?ZHlXTWJGZUlUSWxyYmRQdk5nemt0S3FicWR6eUFXazQyLzBHRmIvWndHbHZh?=
 =?utf-8?B?NkNhZEVlMEtxQnkyY2p4ZUdrYmtsa1A1TzBaanZ2SnV2WnZyUStzazFac01k?=
 =?utf-8?B?OGlLQnRLZTV3cEF1aFpuTUxpaC9GRGI4U2hmL1pjMVhEZ1Q3TGQxOWJyU0pC?=
 =?utf-8?B?bERQbFFHYWhQOVRrTjBPWHlxaWZCZHJOWEtiZjRLSUova25MeFhmL085MndO?=
 =?utf-8?B?UjlJYUQxTzlTbjJJVFdTTEluemZtYkg4TmN4ZXk2SFNuVTlLR05VYnVtcjIy?=
 =?utf-8?B?c0FGa3p4cy9IbVY2cXZEWldWd2o4MUZ0bUNMSkNOTTV4MWhvWWJrMTRsQWxa?=
 =?utf-8?B?bTFOdVVNcmtXcGwrSGs2Y3RiSnM4S0U3a0tTMEovTDFrZk5XcFpVWnZEZmdn?=
 =?utf-8?B?SXZTbm9ZRXloRmZEYnp3R2RRSjJWTFJYaU4yKzM5NjZ2Yi9FZmE0ZHVuZ1Q4?=
 =?utf-8?B?SmROUkVjVUdoRVRKaTEwTDNQVHlpekJzNjJ3ZUVQcWZBdytVa2daNXQ4NGRQ?=
 =?utf-8?B?RnV0UFpiQ29pOUFwVDdSbmNKdnh2WFdBazh0bFhzRkQ1bGc1a0pqZGU4dzFQ?=
 =?utf-8?B?dmVvc0lCTTlVNXc0QWxNNGxHMEJmNjBUekp1RTNmd0NaQjVOczJzUlZhMk13?=
 =?utf-8?B?b1RVZjJ0QjZYbnBjWkg0UDlpeVp2dUxXR3BVQWxjR1BpTzZudGNob0ltZW55?=
 =?utf-8?B?Z2VQa3M2dUZocFptWjM5bHRTekRQZ3pPY01DZk9IQXViZ2JtTkxkaTNWbUlI?=
 =?utf-8?B?YWN4TGdZRFlIRnMxRkhyWExVcWNBMjJkZTc4TlJFOTUwUXhKUT09?=
X-Microsoft-Antispam-Message-Info: hogzXkLOFqnQO6Z9ncFsbKARgQGRkhZZsoaJ52ZqSaHy5a1KrqI5uJKyi15y4jnaVRdDbXWkLzAyCNx+BA1C+UwQhcb5h1v8oKqrppuLXThyUXglyTdZRW6eX+QZS+Iudz6TGKkGmUsw2pckf06+vC9PMPMi57lwgGRm6PtHeq5X+kIz/9HzFpxhEU/CVyqP
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:465QHYpMqqF9J7I0heygV6McvT/UYp+BZJxiyDdMd6/Maq+gcu+dHfyyOPO7/58UcKOe1enq9IcpkEyGPbWnlW1R/EyTUSbRX+2/p0qixhYxcRQy8ydQTlC8dQcBfN+ZJ3XZXYJF2VO8uLukzicvACgG6RKH6rlnDMAaKj51To2rPWunTFA5LpTE2Ezno/VRaflybM51ZgqfEr3mL5ikhBJqB+gC49ZEOj09DWSZOVPkTLwjnN5Ntm3f6IxYhkv7lIw8AfQtgVsvY0Hk7QdsbrkXdTfqEdsgSFhdCCNlgtoevVuYn/7AMqFanFYwA0ZsosIWJD1WVYhTBdrL0EXhx/yh49pYUCpUkKGm9/D04Qi1pKkS8gg4tiboIeQUP2KrYTnye6ekMORNF/ZT49jdmCw9rONQ1K65jT5Rmx/ZpfWhXYJz1Ccu3vfLWNs+CeMVpqhx5WzkBps0CGLlgdKVzg==;5:MMxHOR1GLLHwx881acCivngAbwGh7xVU06b++TlE63eeRQx94e/UPWv2viiIutthWnuh4ziwHaSJsS2E/KsnBxVKvVsE/+6nlWnB9sYKD3HlQ/aAEcuwM76/VsbVwVKJDl1rNROOgtObtSHNm6dHwPpB6QC/WkvAHqOSEULUp8U=;24:ea1zaAwZaFdOYdUzz53WnVwJOgZoSZZlAJm9xXK6CMkQ46qAiWWUO+KmCPKp8gY+C8UR6o4jZ+iQzqMp0SCWUpDKtwe0hTo4ahx0G9TC8Bw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:nNxTsE6xStF23j2+0IcNfRdi6NkZOGiCywMektaF2ELDVHp8u9fW5JD5P3pfec8Y7xTBCVzp9GpTnWCUaKcWiw1UqQq80lZsAUatfY3Ux0qMRLhY8n1dhI0+ut0ZEBIHKEnUTnmX2vGMCHQ09F51jpmYeXR1LR9sM/Dz1M35YKgE1bvatH6NieSnfU2WMSsAHW3zxdwUBccjTRw6/iPS+xGyBweFN7OiCXOlJBjMQDb2j0rUrDcXgwZp8y7vq3ak;20:WhUEPdecflKsgRCj9g2yUNbPRaCiiIu6xRjelYtxcki2PH7oAS2QEy50uJaMRCVDjvBb5e92cuv7RBmRCr374HH/CXfPUUPollaRapCfL00NY5lBXVkHEIs+/aXVhKeoF88ROZuRc0oCuPdyjFvoWO0pLP2kpDB7NBuXxooDqyA=
X-MS-Office365-Filtering-Correlation-Id: d8a5e98f-2bc4-4e7b-ab88-08d5b65bcc53
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:52:50.7544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a5e98f-2bc4-4e7b-ab88-08d5b65bcc53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070329493485581?=
X-GMAIL-MSGID: =?utf-8?q?1600070329493485581?=
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
