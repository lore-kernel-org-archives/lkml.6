Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+bOIB3jy1DU9VrN7UXTdPfe8RiwpuwR8tTbck5cSRXSrydoIvjNgTV82Vk7jBNcxcqJDuX
ARC-Seal: i=1; a=rsa-sha256; t=1523980495; cv=none;
        d=google.com; s=arc-20160816;
        b=cs0lvkruA/UMviJ25vnK8oHi8USIRJTXFtdt7iAWuwX3rrGlYcsADD1n8pNhUYq9YJ
         T0QmviFYxWEZwgHtB+lHrXT/5CgolRm2OFNJeCzlPxrrGAPlhwpaBvyQJ2UztbFt5UcV
         vMytzT4lAZWriqdVkc3TTL/3U14TzokG7PA+Le92DhgtowV7FYrldsYitnrF6QrYc8bX
         XohrZsALoo5ZgqAE6QZTU+gBmNJX1gfEFgTU01F2WSnoQkuEh33AxrJfK8Cn7rj7WY9s
         fqIljyVdaMVkEoarD+mu8V7RQLoqSPZPZcTUj1gI/59lx0OtKHV9LsEAb/vGHOBLMqHm
         BhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=d2NzK/f1wbT68LZoS7Uc6KHvxCaF6CCFNp1YwzGxjI0=;
        b=KbixW8fjSiUt4fNbdPS0gJHjRVNp33HWs9y9vgQmG2ZlE0aKZzw7cyR7IPuOAiFBGO
         UxeAKtipFyQ53p6sgRIAfdOL9aNXiA9vrD7/7BSCpwPP6d9gSYKLI4KQlhF1afvZYmYt
         AFakhqMgELabTIjRJ2AKO5hChF4LbS2gDWNgcX5VA6PdB22gnzJcDmrUYtzYMwZ/Nu5U
         PQtw+GObtlk4uPCVTZbsvpggNcuPyeauFRjyVJOYY6A0VZ8ls0gSv0D0gGJmN/stp3Va
         j0bz9kf+l4Ly6TI267URwnadH2MEWfQJSZpeOQJPFb4Yv47Lsqkqoj+g4l3+pugE2d65
         i4ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JfMjP4b+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JfMjP4b+;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 11/12] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date: Tue, 17 Apr 2018 21:54:43 +0300
Message-ID: <152399128393.3456.4036800434493129834.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::31) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:/PIPHEHJ2IhG/dI9hbzjeF499bTmnt7UmO2LGDRoLUGPU0QhOXEBRS12H5RbKJ5Ycx4+oFbQW+ptilmSlTJtKcJJqV05/9+a4cfIr1K3+9dv0NtRKro4SMM3Zm7kqkM5NSDVywbECtREfNcPKN6I5d2ImVFIq+h7ca8dEBv3tCLZ2byoHaPmmrT4+mR82hcCUN5DAOuhSohHnD2zLjIzJeJDzL8zZcfSYa0Llt3Xp0NqSyGy7cM2rQsPkHVHM+oe;25:2Afu65rOGHqmt+bH1LcUKe2Tn8OS93SE6BYT3WeOvjLNxEmg1gB96G+X9+dwdz6WlSbjJdPcyXPUAM47lCRxFwEClzaZcXnCAuz3dPN2W4swRRODMeezZGV8jgc7EfxZDjqjQdF+pICjY7Gmrqfnh8PwRNp9OI/1afhpffwkxoTIS8Iude/ku6HwI8SI8Wfe2ElIrvaOE3bmVmTNjr3rwo8jOdNdvoSb5J26LYe58qolA8e1x4eOtHvDdEiXpYqyD3d7+wtlZaEDms8+rcsQetQyBm7xE4zvWaz0GZ7YE9208lkWKmPwq32PR+O6GJ2Uycg+uscFWsecZXqY3WtWXg==;31:+jl6sYkM11LRqvKr/GK2u5453gUS46Mycu1KV/eXK2Ht8+ju+M2H0IKHcPukUWM2q2VJs1gknOVNYPGtbe7lGyHL04/95Sr0ToBz6D5XAMCpm8ZF7yUc7Ok4/+EQ/4J5POmwuEB9z+YgoJjtOjrjzIBGm7HCh5jtx2Dfjty/5B+5cxDsFqGYbiRH5+EyenI1aWtqxlO6Ptu8s5LX26iDfp6yMcxXbT6NQ7aax7IE0Q8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:yQ5lV6+3CyMv2baeuq9EBlDdqCAGgROGAN364r10V/f5Tyr1g+atIXiH+8+o6yRKWM863kGiLlPXilVXhbwuhZMCpTIAc2FXXAtx3HdqiacjTCRaSrnQZ+30smmcYnIXNbgyDxFUU6yXqzpIVdKfg9xMir1EuhhrWYTiEb0p3IgEx9M0s+C6z2WNg+WduS2Ytm4Kp2SYNlKeMi+EgppeC4GT/i92WOOZei119UAKFFUS/SYWRvpEg7uYY74bkK+EUEyqOCAYmr2pbH4p904KVAUQax9rVR7+qaNENbnfVi8GBW79Ei6iA2j1wRauFZGP7Ug5ZGWXke4zOtAP1XKi1blffpZj7zZWHyr72yZnd4jGjPMr/TCCCi8KeeWbelk+9fg1bUyn44RPWV7HhD8WnBy9UkXud/P9pysEqkbVPFNRu3fRnluDrQJDjn7XJltF611oZ/k9dLpGgExYnLWrdSR35Oyy/NuQm3BeVaXc1j+2+BoGrY5nD9EoYFXHhHbc;4:E6FkOd4uUHdtwLEf6QbeWBXK6OebtqSsa0mUG2n6rfIN5SqcLwcTNQeYWL0NtbSsf1xrEAVm2HASV9gGFqTqegoq6toPSq92INMMslIRTB8jZk6OUmVXQabit4v/jqdJ5T9qerVTtW/zCsrVn72CvVXJQE/wbBA7+JMt8YrzGQ8jVcZZA0KDEERYq/Q/jifAbUabKqPp2sAxsjQ7RuA2pTHSxDtIgUvYhMMTAqvXKBmOXKJlpNgS4/Bp+vT29dGDAPZyShzxL6MG3vGNmcjBJA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338C9EF91E7E03B239E7051CDB70@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(396003)(346002)(39380400002)(39850400004)(199004)(189003)(47776003)(6636002)(7696005)(52116002)(23676004)(55236004)(7736002)(68736007)(7416002)(53936002)(2486003)(33896004)(76176011)(386003)(6666003)(59450400001)(6506007)(316002)(66066001)(305945005)(3846002)(478600001)(230700001)(86362001)(6116002)(25786009)(5660300001)(8676002)(55016002)(61506002)(16526019)(26005)(186003)(103116003)(97736004)(106356001)(105586002)(39060400002)(476003)(11346002)(58126008)(8936002)(486006)(9686003)(81156014)(2906002)(446003)(956004)(81166006)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6SlpWQ3QxbTNGdFBrVERJM2U2b2RoVlZv?=
 =?utf-8?B?eXUrUll4QVhoMHd4d01LdE1lVXFEdUJyd3hQelpjdXIwbUMzZ3B6VVgyZmph?=
 =?utf-8?B?STk0STVpeElFSVZyTEt4S1o0MmF0NWtmSXdQV2ovTUlydGdIR2xSa1daM01S?=
 =?utf-8?B?MnJiUDZSU2xIaDNwdlk3bmhDYTV6akk1SjdRZis3eklXaTF0a2Y0WHd3YVhw?=
 =?utf-8?B?aGMrOVBMZmJDWFhIMEtUM3Jmd1N3YmYvRDZnMlNYTE5rM3dKM2M2cDF2NWNm?=
 =?utf-8?B?SWx6QzEwQnhadGZmTEFHYzV3N3VyVEZxTFpIWldmdEVwWXFCV1FUcklqNmNp?=
 =?utf-8?B?cmdVcmgzeVcraGthWk1yS3g5T2duK0FIZTJqOFdJbTBDU3hSSElpcGppYUQx?=
 =?utf-8?B?c2dYWTJ5ZGtSbXIxZ21pNGFLQkdiVGRHLzhGeWhqbFRjYmpNY2FmVDVWVG1J?=
 =?utf-8?B?TUQ5cEs1djh4WWQ1MG1uOXh5WktxZnBjL2RNdWREWUFLRFlGNUtjSnA4MXE0?=
 =?utf-8?B?Nnd5Q1ZzemVuL1ZsZ3NEK210UE5XcVF6U1ZzT2NxRHVvVStrelZnTzNnMEhL?=
 =?utf-8?B?cXBTWVExK1RGemQzTyt3NXppeTA1Z2htcFRkSFR0d0RwRk9mb3phOXloNVJS?=
 =?utf-8?B?S0c2VEI4aWRlTTBZTUcyNGpOZ2tqZFJUbzl4WmptR21ud1lsY05JUWpYQVVu?=
 =?utf-8?B?bWlVN1MycTJhV3JpTEwwM1BoRng0T0NWa005VEU4ajlkek9RVE9uUjF2cHRS?=
 =?utf-8?B?WTRlLzJlY09McVpLMmlUWGtCLzZQY2FqTElEUUNDRkx6UFJZRFJjWHdOOGEv?=
 =?utf-8?B?UXBndG05VXEzZkFpaTVkRk1zTWY5cHVEZ1R3Z1F3cU40MmJwVkdtK0lsWlJw?=
 =?utf-8?B?dlFWREJ2RFIwaWtJVFlYM0g1ZGxEWHVMS0U0RUp6aHUvc2NmQzdiZHpLN1pu?=
 =?utf-8?B?dnh6cUkwaG5aSFpoMThIV0pKanRFYlUvTVB5aE1UUVJ1MkdlMFBhdmdJQStN?=
 =?utf-8?B?U3dZeWFBWFE0M2hIVUdCNmllaGpQTmFTMkhEV2toeXRxVDQ5QjNEdENKZThJ?=
 =?utf-8?B?eGFiby9CQUtLcGtKdFdzb2hZSUdSNGVhamMrMElrR1hYa21pTWNSSDdoMG1a?=
 =?utf-8?B?Q3k3ZzZocU1jdExiQWE3aVA3L08wU29JU1lVc0hDRnJYd0RXSVBhaTlvanFD?=
 =?utf-8?B?NzE1b0lYSzRDeWtzZ1R6VzdoaVJ3RnFqc0ptUGZEdlJybkFnekVkK3NKSVZV?=
 =?utf-8?B?aUVwYUVrT3MyQ1lSRTB0NGl6aC84bVljWFlLNmg1L21RTCt0a3JFZXFTUjNa?=
 =?utf-8?B?YVAvcXNzWXdGZjVERmpyaW5hZUJzTzhCU3AvclJkcEptS2U2cmd5V1NUN0M1?=
 =?utf-8?B?SjVQdW1XMlJuMVJsenNxWElUOTQ3aStCVnduVlJMb1FjY0NVWnBKVE5rSGFN?=
 =?utf-8?B?KzZlTTl4R091eFFTUG9rTHRKQlE1RVR3OHFiNHd0ZlE0cllkWkxEdWRsQ0U2?=
 =?utf-8?B?N0pVNlRSdlAxT0lEeDNQaTJnYjdwRTczd01VdXU1WXhsaExjMDY2cGNCZUdZ?=
 =?utf-8?B?WUdQa0FwTi9vSmI5a3dvYnZRVFlDYWxtWERxa1JRRncxb1hCbG5LcHU4Y1RW?=
 =?utf-8?B?Nk1mSktrUVY3WWUrZ0Q0SlZWN0ZQY0dKMnhYZXQyMDZpUDk0WUhJYUg2M1pC?=
 =?utf-8?B?NXRMYXhYUFhUVTQxSlJzTm9RdmUyb3pkUmdDWGZxdjFiYVpDOHNrUWdZL1lo?=
 =?utf-8?B?cjBSWjhQM2krdFRqa2plbGFWemlPMUV0U2xCcUtlT25vYTNYUzgxUWRwL2ds?=
 =?utf-8?B?T2FkRlBwcHp3TTdrMjY2SWM1VS95N2IxeG5VWkI4S1FLUVYwdz09?=
X-Microsoft-Antispam-Message-Info: X1Nu8e+/rLfPdfmNH/4jLB7iXc8QC/x/PEv6PcFUHVcY4vu7iB1vOs4qmGlnS7Su+ix7KNcMA+Df0/32kiX8ZRHia5nUX4P2uXKEKCsHhfR4b8XH5fg2TTFNBfSkd4egGKS3LW30NdNCAN5wk8UAxB1p4QAXZV1XzXLkoQtSe/S9aADltT13v97mYrGd5vQX
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:/sAIwwoov2hgqtilSVznxIUwk+YOgvMMyjHyLfWx3k4JGkiuU8trjRjitW50Ia7LTQq+lCzKuTze3WrMnPTE5GJP+HclKTOik0fnAe5vzGm/OMKOjFCiSG3JcW+85XGacE4LUnJ/UMh20SYcDSGWuSfiFD2QlbedtzfpHSd17AcumBrBQSbeqPMneU0qY69ELMLu0QBJNbb+NTc5ZqUetj5LBJhGZQh5FuSviywUvlQkpd0bAdIfoDmij3Z07YcNOskFwfinCptWwzCt5QY+EdgLAxbo4q++JUjfWRMdBLh0UehwdCi5kfyH9W/mqapUQbfJls6x3JaTrKEOcTGBPAA4AW0qYsIL8O91y3fKCaOsqv5e3+yEKc85kooHvFoK6JcCX3i31QHOAji++V510FSHvk/JzvefWn3KJp9zFgGZPHyxGSFyh42fBpUqE6bz2kc3ko17z2tihSfynPlLAA==;5:MBI3g9rqivYQtSFD680QiOr4ohD317a7d4lgOhRS6cylY60XzDj0YmOfdhPqB/SPzaUYBGEHhI2UDwSUA1FP+t+sLjjh9Q5IOTcBqfgJtFWWidA8l74rlgOva1dWvS9YjRqaTniQanXcxIma14XlgetgBfzwdH23rqpK3n50DFU=;24:5M5DzLokXcVpZo60SPFOFaWiTPingXP/R70LR5rHZL1SfSMqgVFHokyNs+dNNFQv8qosRuCMr8EChmJ+kd8BPDAbgoO2SbR8Y9z/KeZkgqc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:9vuy5A2c9Ar3Vclibv8+LDZdjKsy3N2vI2dwOAQhcdQIlKB3+Z/2CQhVvKgIqia7Kz5kAWEhXeqiGutp1s4HQboOTBdeJpeaxLLdGq1Im9PO8MVzxfsrEJ7aogbW0bZpAcfTm8RIniNzZGW/LEU8eW5+HYQ/ieIkiqOv2dQh58KZDXnylBOVev/ZjiCBw+UOLavH4+nMQQibxCjxlAMli9cGoT5WN4X4YEix86WUpoSIHDT9CPNHfYbHzUVA1kRA;20:xdwkOIoNxgVxFedJ6nebxd60kCHDmEpXr7YAjNXGEzpzytjvNwucvuKsjSkOebqVE1mkonsrt+4IU5O1B8MHj1YeVoLlztgWHWixVBEVaCXPlyS7mUYD9JT0beoaLCSCtu/1c8Ad22xEq/MgCKB6C6IIm2pA+E96tSMUvXsh5u0=
X-MS-Office365-Filtering-Correlation-Id: 5befc364-4f15-43b1-b4c5-08d5a47b8f21
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:52.3482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5befc364-4f15-43b1-b4c5-08d5a47b8f21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009372299777748?=
X-GMAIL-MSGID: =?utf-8?q?1598009372299777748?=
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
index 9bc5698c8c3c..06c87f81037c 100644
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
index 22ee2996c480..973df501c335 100644
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
index b81b8a7727b5..3be9b4d81c13 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -443,8 +443,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -579,6 +579,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		}
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -620,6 +622,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
 		return 0;
@@ -642,7 +645,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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
index 2e2555649d13..075b990e7c81 100644
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
