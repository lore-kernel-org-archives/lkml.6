Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoEZlK5rrY+difMvmPGzKc17ET1c8jO74hxIGlIhxXzMJPrW2eVMhrejXla7KQIRx8H8sP+
ARC-Seal: i=1; a=rsa-sha256; t=1525867023; cv=none;
        d=google.com; s=arc-20160816;
        b=PTiJEkp/RpSb8t0W2Ovu3rn4eZaQoW4d5ogfIUUW20TIzgW0eu1e7mjZPPJIRyH5+N
         2YeYO+PEWeu3kwjIfVfM3HNxReETrHrRYGF0Iz50w3pRPzfYmsEWWLTmHdQ786uS/APC
         lB7CfejOzuJuq41JLiUGRBBEiXFq7M5fU2zDhj4tIcW+34HfClutfjVTbZpvxuzwxWPE
         aoOMUjbcVwE5n/1HvKYWJeOjR9G4dAj0u7ugt/gCRAeE3wB2Unw1B7FYfjZLx4we8iMO
         2nqSozi2XQkT19GIPtMwTrWK/exHq3zffdoSNjht3Bi+mA0hRVtqglQl1gdtkEl8Vc8x
         T0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=ReO1K0uzur+DPV3GXq1aDtljGEAZujiX16BIbdadejk=;
        b=jH5dFcqwZzaCTTWpChNArVX6wxpGYCK5tGNJB77e26bpz54Ued8ANKZ9wbNO/aYXO/
         UOmJ1HYJ3Att3AOBh+SkvQSBt0YCROc9ahrGItglBd5CFmt73SftEDQlsivD+BAkzHof
         P/QGdIGLbldTemGoO5QFU88a4oNDHWraZc6Y9RT3T/9wuEVVUBdYfi4l1wO5ifTuLOlt
         0i5Iuysuib+A1gY+ql7Xyye3d+Go5BQj4Zw7jb+0VFs5hi9DhW0CTHftyWBR/J0yH13T
         SDjNIk022zrYMHK3aLgDjjG2ycAVUYJ5+IPTIjTbIeMGN2ZsuNPyT4Kw/t1PDrJbcHvZ
         n4Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VAbbuk0z;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.107 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=VAbbuk0z;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.107 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 01/13] mm: Assign id to every memcg-aware shrinker
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
Date: Wed, 09 May 2018 14:56:55 +0300
Message-ID: <152586701534.3048.9132875744525159636.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:g+Bk14rwf58BT1o/7iyHC0Q7ijDllXC4F2b1LnNF+id6Os9J5N7mozfI0QeOJBD9FOX/o9zbICwy5oeBUCgtaCai891GsjqohdwWdCW+ECq6W2WvFiZhAbtUB9i+vJiRCDAiNrXZavoM1dPvlG3qWVvNh9xHPHy43fHigfxNHkVfeKQjXaqCp+xuqSIi1WYgUKRQdueZC4IUZ41Zdv4suFna/BxKf1swDFaqUdJc7O6GgGLMQ/fml19+XRhROed4;25:q3F1TighOhh7y1XXilHiW5Ve+wa7HxDOjtdC+MQujBzdVUWAMQaAYWD9Sr6Yl3PMKGZHpWVwRH96raP6mMBcllHK1KvyUFqkDeOx8gY/Gv9JMB/uwdjbhxo0YPFHJDpQJOlKGeivhh/MuuYoElCh2GOrLGZI/csVF+xp7W/MhraA9kYpB4dODYKw6eBptweWSONlj0+GMCxRZWsgFnpFl/1DgPjHnHlCm81Uvp5QZ7QIrZlMfZ4OA2aOH9wQQ9yyFbQ6qxCvzRNC/E+xTTOyo7cO1Ho+xUNytcnnCegJSfNfUJucj5sP2r4IZ+CGTB+HXTPnhaaNUy78bHk0hga/YQ==;31:71VnEzFLf4jgoM5+bmPJgA9Z09fORXZyJsY68KIOCMG+ml8Sd1kWsPPswIshc8qqnKtE3wF1fq6CCbirokAYW/B3ozPOWtvEbwCOsrtYUmXQ7d7tzb2v41/TKY1KYaMtf+Vit5kyELq+dPQN3uf+4IAoeGnOLfZVGIKKCqj9i88j3jNfRW8stvWHzzC/aLl7aUYqEuUIj1G55+9+KLy31DABRjMWdv1yW0/4JAbIyms=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:UcLea2I/0xbKJORIi6Y6cVelp+JVFwLo7oROF/2FMTROY8YjENhh/tkY0wSgt7Uo9rbUea6V8kxIceB0070xJpbQIhTyBhHPBrbKAilZYKKyO5Y4RR7M33ehokPYiuoDFxIYOtEZ4gTlcU9bRop2x51uT92xZ+6m+e22YbTc6aF9ufkXGhWP0H6VF3mdtmBMHNtTn1O0DayQWVGahUgDhVnXlkL9YJFUbPxMObZg3ARTRERqQGtxLghnozLzZxc1LPx+QwoPgWn9DZGXPMOqAkFrAlGFINrBUO3SFdWK2y8BO9D000YtuhQIkm+J37OpYsJsasMaxc7KkwNrc9c8D7441lhXsPcbpoWVLJznYcgJcb7DBlhfMt1Ey8h6mLy/yC9CCA4qfMwbUXDvZQ9EWEBcJh9cICGgrnMFftQjAHHfFi2vrXPCaio+mzVYZiKHLUiuov/oKboMrmHQO/xEyEsIUHC5G6LHkg5gzrbj1+/vbG9atmBUC/Rs4cplr8Vn;4:LofXhnYpgsGR7RKYakqJep7u83vkoYqdXPgmWiQBRetlu7V/3pCIzBHXPb48YL1ZinjqR8rRl6LV+pxzsUv5A4eu777lnHWvYTWDddwGjEQMEWy1Rbo5ceaiD2j9MiR5fMtOHMTQ9EoyYq0EDuO9jU70lxDPRwRx2aWFoVWf/AQh8ueWlcamUw5orsfTQXNEJXCVhM7gDxptHfLsA0AbVjgHGiJP36Ya3hcVwKzqy1EBcy6EKUVpF4yD+BUoNtya3Q3RGGlL0i9AaTRFwZz12w==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13413D5743FEEF4D9699B90ACD990@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(346002)(396003)(39380400002)(189003)(199004)(25786009)(6116002)(68736007)(53936002)(3846002)(97736004)(476003)(11346002)(478600001)(50466002)(486006)(956004)(6636002)(7736002)(55236004)(9686003)(47776003)(186003)(8936002)(5660300001)(26005)(446003)(52116002)(386003)(305945005)(6506007)(2906002)(59450400001)(76176011)(230700001)(66066001)(316002)(7696005)(61506002)(55016002)(81156014)(81166006)(33896004)(105586002)(23676004)(16526019)(8676002)(2486003)(86362001)(575784001)(106356001)(58126008)(7416002)(39060400002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6TGpkSCtiTEkvMkhmeWhsU29PN3l1cDJz?=
 =?utf-8?B?cFgrMVZOd3dsRWhZVzVkVDhHUmNiN0l4Q2FlSHBVL2hpZnpEdXFRbVVWeHJV?=
 =?utf-8?B?cUx4cUpOKzdSMm5laktJUnFvU2R6NFlHajlpcjV3T3hWc3VxbExLRWQ4cklz?=
 =?utf-8?B?Y2Npemx3bzN2UkhVMktDVGVnY09WQnVranhONS96V1d1NlNWcEVnMVIwZVlW?=
 =?utf-8?B?NTdCVXpkOHhpeGVSZCs3bHdOc2daQThVY1Z1eEp5dHk4ZUtwK0hLdFkyeXQx?=
 =?utf-8?B?SjNwSE55ZDVhaDRtVXJTRzkwQTE3SVdPbzRDV3Q5QzlGemUveFJEYnJ2cXQv?=
 =?utf-8?B?VXRiSVFhL0Foc3A2M05LUEYzNEY0RS96YUxYZzBxMkwrM3pHckE0Sk5jekVp?=
 =?utf-8?B?ZDEwMjdEU01XVXpCeU1YVTBoVS81YnhJT2paQm5hckV3SEVIeVJOaUdxcEV2?=
 =?utf-8?B?WXdqNGFhQk04RFFZTGZXV3FBQ3ZyV3lMTERzc2I4VGlqcmUyYXdNOFlqL0I5?=
 =?utf-8?B?Z01tTDJrSzJITVJqS1grNExzcWliaG5ab01OSi9SZjJjRXBQV0RVbElVS0Yz?=
 =?utf-8?B?cEFzYW42SENQMHZtekZITHZheHR3Q0w0OWNJVEU2QUExU0Rsa2oyTEtlMG1T?=
 =?utf-8?B?UWhMNVhVQlA3ekhieHRNa01oV0dUZ0hlaklrdVZWWEpYWjRkTXFPK2V1akZI?=
 =?utf-8?B?MWFKYW5TTW5lSlRpbS9xMCsydXhNT3hJY3VRTDE0RFNBUU9NSEJjZGxPSjhk?=
 =?utf-8?B?VXBwWkhZSk12QXJMZEV5M3dXOFJicnVlOCtCWkdHeWQrTXpoRElURXBDbnow?=
 =?utf-8?B?Q0VSQ0RiMXMwL2plMkFUNnV2UHI2VWlPWjVvM0twTlhFMW45ditWMi9tNFY2?=
 =?utf-8?B?VUgwQ3NRQ2UreXlyS3lwc0lId1ZCSGlxc3UzRWxtK1ZlMndFbTVKSEtTb0Fk?=
 =?utf-8?B?Rm1tRHEwRHJMakVEV0w0Mnh1cnlneGFWUGpLdDBma1pEemQ4bEJzOU5iQW43?=
 =?utf-8?B?blBwNjBSblNVaDhlUVBaWjlXZGpLYnJMQ1NRalZDSFUySWlWWG8xZUc3RERC?=
 =?utf-8?B?U05XV1NOVjhkY3ZHTmpXWk51T0hZbmV3M0NocTVjNmE0ZjNJZmQweHlmMzRW?=
 =?utf-8?B?ODFHMzJsbE94ZUIwTjJKS2krdmVCMUlaUUFQeVFjKzg5anB6REdGNjl1QlVs?=
 =?utf-8?B?ZFU5Z0J4UHgyWUZkOSswSThDTFhMNUoxMTlmZnI2ZkJxa1I4Z2UyRnV2Vi85?=
 =?utf-8?B?bFhLVllEMmU0bEs4b3d6eGsyL3RUYWhlR3dzd3FnZkZOR2pVa1k3ck4xaUpG?=
 =?utf-8?B?b29IRm8reS9DbFI2WDVONlZsQ3dzM0RLYTJQZHlaV0YxWWdNb0ZxWTlpOXZu?=
 =?utf-8?B?cjg3eVpxS1VxemNIeUtaeTU1SEIzMHN3MVY1MzMvaGdJek5pQ3RUczZwdjFr?=
 =?utf-8?B?MUdVY3VNRTRSN3M2bHRWV1hhK0JQY1BsSU4zb3ZpdEJ4d3pXVHRZMFJJM042?=
 =?utf-8?B?YW9pSFV0aitRVS85djAvalF0Q2dDQ0RJc0UzeHNsem41QU5lWjJHQ3FERFlB?=
 =?utf-8?B?WVBiU2czUWxBNzc2ejZjWnVRY2ExcGRoTmxEOElMWG9FVlM3WmFOWThKWVFn?=
 =?utf-8?B?d2JhVndSZU84amR1SEtUZzV1R2RnbXhpbml3UVEyc0JjUlNyeTdxUEdiV1cr?=
 =?utf-8?B?K0NJTGFHa3BneDJMQVZiZ2dBWktIKzl2U2htOXRwVzM5Nnhad2pVVVdOdWdG?=
 =?utf-8?B?TWxxUytPQ1hIRXRiR1JHdXlmVW14ZGxKdHZzbW5tZWJGcnFlU1NuQjRKdklv?=
 =?utf-8?B?ZGgrUWNuY0w5d2d0VCtLUUlQWitoYVZXUDcxUEcvN293amIzQT09?=
X-Microsoft-Antispam-Message-Info: Wy4E19IXO8eEzv8t2JNQzgTJE38eXIMB346P+nDIT6AZ2K/Igd/jggntHNxPOy6DehP4WtkVkz6yv/t+CBQCeBTHQ/2+KentBRnoBIee/CNzja9opULrOGVf+pFFgAo4XTBRrm23Nb1dEtLdqckEqF8XjJEMEZZ4pgcfSdRSWg8VdZakpGSwqe2Dcv6tOPAb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:ojyhcBlzzXEApG7MLwYIUUA8y7pYo6dX4KHSRgTvqvDsyxOXORN4TlCVZscZoDdKK7/HBM3pAdVqybHpqJ/lkbbgdgiU8NDK1P0w5fDSCj/uwoFDKIhey3XGPl+tG1owcL9fSopItdR3OrZdeWOaZfHM2+VLOobAgP5S4MZr+z3yLleEmn+kX/ayPGhFn1tqTwVEtoe8exnj7tEAxHkvm1pwO80S0dbN/NOohuZiv/vXgoQI8sM/T3pHxtBKzEWk0z0tya7H4tEIhqx0HYku9aVsuT6CxmRaf1xvuWuEBdr32jmIvnhK9DBNcz6GGRn+ymUSQm9jjTKN7TT2DaFPvo0OGUeCKnVUTW4uJA10ePgyLIgMs8eZsmgJHNGJW0sggeLDRxnunFXO7KvZryMkCHAOyaXGICzPEaMKm/QnEurbrSV0KAAKEXixw244q4/CjrpkFnWjdHp5FBrG5BLV4g==;5:bmgBtsIt4uChFYSwinXsBET1UJ4GfLLizK8+io5u302vBvTpSjiVzT9CUUQCkQiZ5tCpoxk98uKjUdYv1T/pTMiuPSXTBFfkLTopkZPlT9G/hEN/hlrE+p7PQSLsbxQvSTkJdYCjgTmpMl+/TE61C14GeBmmTi27vw+MtkVhnIc=;24:xUonnEC84SPO7cyLYOxyx/LESz0dhcgiNjquBbOTCyh+Yb2+VNcF0ETqFemjdTR33Ion1bmYLvX50m7Ycwipqx7ogGnBh7s7rJbp1rRl5Ko=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:lMt7oK6FsvF2QglUawWEOdV3DDWo92tx9ufpA1qZqWXl1bxgL42XvN8yHWdeyCBxCWgdJANIEQTA0Zisc/8QE0Ab7I1EEeMpbbtGdeMHHb8PFjG1V2jJJi8cbfEYfPcCpo5+yoCllyn9NOLePxV+XGJHCQ3EyVdPutDl3QZEB84IeVGx2UCfLfJeCNIl1iiOJ2A12GyjwYfJN6ZzZIkNkfm1xfkcZnHv3za7OeffLQolfpSfqY9O3NybE3A1mWd9;20:LTrrYN2IyLGxQMzNuqrKKrCvmrgPnF2i0n8V0kFTE7FV82vPMSPZ26SHSkOQ+OJyz39Oa60ObmHaxnb5PpLO6vQJqRfU+AKTojeFQoSmFKm2ZzmgGEW/kAvqlo1egvILu3jxXCWIQ4xzFof/emT2woHSZYH38wHKD1/qoMhwcco=
X-MS-Office365-Filtering-Correlation-Id: 99a2b954-860c-4507-b74a-08d5b5a3f8a5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:56:57.9480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2b954-860c-4507-b74a-08d5b5a3f8a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1599987539736036809?=
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
index 10c8a38c5eef..36808bdf02ae 100644
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
