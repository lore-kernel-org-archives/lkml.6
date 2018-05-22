Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeEVKMF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:12:05 -0400
Received: from mail-ve1eur01on0099.outbound.protection.outlook.com ([104.47.1.99]:45280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751404AbeEVKKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:10:17 -0400
Subject: [PATCH v7 17/17] mm: Clear shrinker bit if there are no objects
 related to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:10:10 +0300
Message-ID: <152698381022.3393.6474755436628067805.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::34) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:9KCjjF7FvzdmccFhhZn7DGKf2O2A7BKjM23t0yHis3p/fzKYbDiSHALowyXGI2QceI0Li3j0qq8JH1sD/X35yziI1QPhrT8aXpVVq1XdnSlSmYAYpJ9OrSukdeCuNuEhORDIaraIyB/SCS2WdHRNzaBzO/THMK1TnNeGRtl5vcxLXzgeOKO3OmG2zVavQMwdDUnXmw5ITaFav8VYP672WRj2WBsRkLQ7pCFO9UlcE2Vb5hvgH+HbmY6/a+hvddGA;25:lQGaEgG7MGSLAoyJJMBGZYEdJj9fZROeXYwJkIHgYboKNulSg56TgSE8JZKmCv5DBoQrpE9Cmxh8RLDx7iK5A9mh/ZGWXa/rNLJXdQ2VXDzFoTvIez9mzuqhDWiYiNr/T5Q9vTvRpqqZFvzhUy5NmrmknLSG93s31bLnDG333HRtzYBsKXJ7q356N3WS7rZJafyWWvWEwGSYxHP5+jpb0QrhX6eblgaD08bA15gDOl6+MUisjd8rfpZ8f6Xy1Qce/EOhPCJ1F2HFaBVdF/5lnqmli1lXo0pE6Q5ElLaUcFZmYLAn44qgC1HKvC032qyCm7BfGQNT+pHYXWZXM7ncNQ==;31:D++XoQRRJ+ivFrr2tnVAqAwJhzu2J2PPzcn195vJMQa990TR+OtJU9wCQn8TXVXFZjE6UNHFYBG+ehdb4iZ57nWBUIxeNYlxhSMnNWs5t0O2LgqOi7AGrsKRCJ6XD4U6f9NJqUNJcUSyk5LhB0I/SdJ2fd7fA81e/FpuNFXPSKlMWtBhh4YE51pNo/0KhoPWzz4g9yamkWLZffElnrZh3ICWkhss/Y6a5YFgfgqCNpM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:JotN/IrSCQ85/5zrS9ZOoMNu03vAkCMycWfQitbInvM5cCmdiS+Dt8irSGGdducOLmwsopW/x4ZiEQ958qBoJXZGRaWrZaBBc+reIGzsDuAWphGJTjXf0oysK3sU6frFgTOYNyIMm7JPrTBkgEx/p6TLrN76ffEM9NLMKK7qgzDSEtJ2sD4dg5zWHwYTxdQCwcuLpiVkGRbzF9ub2q4mnOSyHQTWE7zXZgPQqTrmc/f6/Ad9/CZGifmOpDCUy2MHy5G1adfcmFkEqL7qKAJJazLjchtcMRo8ruxESFbzcCKHcAwIxDpnDt6lVYxT20gQjgLVrqLip5h3njWKOSkwNHQ/0YYgBr2rGvH8Srot+soQUrHeSqddC2LhXhD09kAHKkRwf5tw+7GR8dCghxggPgMN7R6kAkPjRtXWPaL6MmZ2ucH1vfFmaol1RikR+FwgYTk4klETO9L4di0UN/dTOBOfuwtbE1zIx1XfZUqjeXRfWFiny/LXbuWfaO1OJAKr;4:c51wEAemHicsT5ohPrSyhaNDoTNJkZ+1V5OI+jmn/ux0wiYoxISk79wSgwKl4Fb2GLUe4upwpX3NeeZPtpClNzFjyby/oFH3IzUQDQBkI8HCfZYUInE4+5SfCjxj2MihOONlgjbJREjSHm9kpZnArneMxvnYWxLS8PNy85utJ911SkMj+zYQSZrq1SQd6zYoEKZOrqicaFo5SYSCxM2PHYZbdu+bquGjJtEpsnGM+YcpMlPKABSVeNCtF9XDJjR2Wl1DXUoiDih/esv1kmhKiwxYMfsGHZKkyON8Fw6stouHZcY8r8AGx8BcMTBscmk9
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339A2E06104A51827507BD9CD940@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(7736002)(25786009)(2486003)(6116002)(6506007)(386003)(16526019)(3846002)(8936002)(186003)(61506002)(7696005)(106356001)(47776003)(486006)(39060400002)(446003)(476003)(23676004)(11346002)(86362001)(956004)(52116002)(68736007)(97736004)(478600001)(316002)(8676002)(9686003)(55016002)(103116003)(50466002)(5660300001)(81156014)(59450400001)(2906002)(66066001)(76176011)(55236004)(6636002)(105586002)(26005)(53936002)(58126008)(33896004)(81166006)(230700001)(7416002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6dGxQOThVcFZOOTBTWnhWZHBBVTFpRDR2?=
 =?utf-8?B?MjFkNzlXdUcwREJnV0liN2Zabjk0VXRuY2VzamhoV0dnYzNOWFVTWDcrUnRK?=
 =?utf-8?B?bWtrYjR3MU1hTkI4QWpacDJ0REYwRHJiakFPbUcvZHZKNW14VWE1dDN6cVV0?=
 =?utf-8?B?cDdpbkg5a1BQSHB0S01Jc3ZpU0o2SzJISDQ0QW5hMTJ2cU9Mckh4aXVIN3FE?=
 =?utf-8?B?Rm40WDdiQkdqK3V1bmh1RmtYMDRSN3RtdzVpcmI4ZnBQMEJscktCQWJld2Z2?=
 =?utf-8?B?WHQvNk5teDRZTjErZWtwNERhWEdoRVNWbFEvVHEzekM2SmZMZXVBSDUwN3hF?=
 =?utf-8?B?UlBlS0dsQkdIQlNaSmpNRUYveVF4M3M1YWJleHp2ekhHYk5OQ21GMGdLdDc4?=
 =?utf-8?B?NWVQZ2IxVW1KU1BxMkZVbmg2Wkl3UmxXS1hGcHlkS3A4RlZGM1BYb2RNa0xr?=
 =?utf-8?B?R0V4bFRMNFZ0WVF2UTI3cE9uSVlKS1o3NlNrdzhnRzNHUHBTZ0N5TFdSQjR6?=
 =?utf-8?B?VVNvZ0x6dDg3S25nSTRvTmdaR3N3K3pzY1lWOHV6SU4yTVFVYjV2dkVoZWtI?=
 =?utf-8?B?Z2Q3dE0rV3RLa01TL2ZpaXRuS2M1Ujc0ZExPVWNzR1l2YUVxa3M4aXk2RUFx?=
 =?utf-8?B?b0dmTERDTGg5VDdRSHJrSDhnMDIvWFVUMi9HemphejN3eUJFMXpxTUNWL01K?=
 =?utf-8?B?bHFvakNRSzZWcmNjcGpXZVVSWVNzblJaUFEvd1BJKzc5M2pYTE9QV1hGb2pM?=
 =?utf-8?B?QTlJMUUwaURQU0lIUk0wTUFONjdWQnpiK0h4VjRMcER4SENsaU51dmdnYXFF?=
 =?utf-8?B?bGdwRnJRY0tzTW9OVDBUNkYvWnVSa3hZMEgxNUZDZ1dIZnFxdVg1ZUxjWWxX?=
 =?utf-8?B?djRaK0tDaHpGbHM5ZTdTV0NicWZRZFd5QjVLTzhvK2VlbXpjcVhXY1BlSnZQ?=
 =?utf-8?B?T0ZISFNBVFZ0NGtNS3pxdUhleFZicHJkQ2RUSUwwRkZqdDlvMFE5a01JWGZ3?=
 =?utf-8?B?YWkrNU9WTTZ6S202V1U3SU04SzJvS2JIWWtSZVdOVmpyMnpaeXhFa1VuSHVL?=
 =?utf-8?B?R0ZZeVRCSUh5Z21jRVFJNFB1dEI4eDlpY3kyeGFDUm4yYjlqM1I2QmVKRnhG?=
 =?utf-8?B?K2wxdG0rNEt6NEQxeDRhMTJBeGxXbW9aTmhjc2I0RFJEQ3BQUjBreTNCdGVS?=
 =?utf-8?B?dTR1VHVnYXJxeHlDTFJlNyt3VjFYVGNOVUUwVkl1ZC9hajNISW4vT0k3aitn?=
 =?utf-8?B?WlBDTytGaCtGOHprbllKeXBlOXBjKzdEbXY0ZkRtclRFYktLb0M2cE5nTkNV?=
 =?utf-8?B?OXRZL3AzRU00cEhodWphNUh0emR3NUd2RUJaOFpDNjRveEZuSTgycU14S3pr?=
 =?utf-8?B?Zk9UQ09QaXJ0UTErMnNPKzZpN3Rvb3lJWVdWaEIwOWZwdk92Q0tWV3c5U0tQ?=
 =?utf-8?B?aXBscHpFTk9nRVZYTFF1Rk5vRUQ0YWsvRC8xVWVSbm9jbUorcGh0Mnc3cG5O?=
 =?utf-8?B?dzJKbVdOc1JmSm9mSFJEMWhMZDRhb3pZenhaTkZaWWFHRkwvS2JrV3RyajY1?=
 =?utf-8?B?dHRnOVp2b0pPNGowMG5DbTIyN2tZZ3A5QjRRTVBUbElsbDdxZUxIR3l1K0FD?=
 =?utf-8?B?R2R0M2lTSHRwc1U0eFUwSEQ3eGhBSFhVa1o1eVVicFJveFNJZENZTGlkS2R2?=
 =?utf-8?B?ak80MkkybmVBWVpmR25uTFhuelNzQUxRa1FxT3o5L0YzTFVUNVA0UEpjYkZi?=
 =?utf-8?B?YkF0TmtCT2F2cHMxRElwWFBNZXUxNHkxT3ZSOXdOVlNTRGJ3QmQzcTN1Z0Nm?=
 =?utf-8?Q?crIx48OgG/81OEK?=
X-Microsoft-Antispam-Message-Info: KWX8BtpZK65IrsVViKq9gehC2VkEJsdWM4jA2dS0gewQZuwno0gavUgS9vFOfsh3Gu1weTDmMSXoUh0JXaNNG3k+nI/QpTsYvG1RcaP2wwg5QvkPD46zFFcBIgmLFLnUP3gbo4wBEHZ8XO4CniVeJEjbKezOuuOBvokm2xNg81gL0bEzxotHR73ZG0RP8ksP
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:vzoyFwlmGIzlCU6DU1jJX+3g+vxnoQHz/Ev+9YPKJfUiG3v9RXtgw7+pAoQ4xuPIE9ZCirHV2WsuHRSZbGCUvPAqbhy1ghGfW44ovnUo6OB4iFLuFdUhhm0QJ5GsCeIBu8IyphCcRmT+7lZYHwrjDctl4M9J9tSzlQozT8z/1RBAOFjnRtTjiR4Nc7i80spNkD2ZfJLIu9namUC4pJ3ppu8WW8FtdMp3Zfn/NsEp1FLlQWRzohslyjme28xI5ZVYYTyHMARqqIE771/+rSfQcsl+4nE1Bwuw18N/a5hDwCtrwsbeN6DLzP2vDJ+EtFwlpI2Qam8r3nEz3FFKO3BKwFLEKpjk2P+K15l7CoF5rdrcWUxXjfZUZL5ZlmY75Wi9vrvR/sz46rdkW8lAqNbY4iV3hHzvT37g/glBbeQHwF/3IRgjFYGe38eemaXec4aYr0JDo0CdJ+xA5ViFv30G1Q==;5:AWOZOo9XRmy/uFXG/NaaW1UsnEgUX7v71DHbKjFiULAJJpFgLfNyb+1utQ5o8pvPFiVX6FjTJ2C1OKvFnFpWBgqBakG79PmPWqZib/pAmfxQ2mlu1WooxlbB7raU0CjuKXDWiJO+1KjNZhnYzvleumY1jF67egI6I/HVb1Rvfxg=;24:IAXoSUOjV9vy4sqhN8CZLqYBKHzqR9Bro8cW/WzGbcbBvFXoxXoaT1Fk/JFcN7fF8VDzGTuxS1z5yi7vIphh0clwV6OmsYI0mbYhjh2JPLQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:IhFCW/kfJ5DW6EQIc3SLCAh3mfrvk/LaWkTe7PAkuXXuSwJtROn5oOsNrxFSgTqz2MFNwABO/xxjzqKIVYaU27tbRX3Cxi3VF63pkn8hWtbqU4LtcbweJTmVjZtO/LRnx3Dlg6vn8zObPs31b4090Ja/kOSrTseSSjMDVrWEVtB/psz3XEAbkOwuBMVOIbXAvqHYPuXGsE3XzdKIMYjNfD49ylBfVIcGdMTL3klM4CpgT3NHU5/RLaBK166O7cOe;20:i8r64vXjiB4KatBwh4qbZMSTeztQg4xQ89xSUutP5tsaiAELNG2kYMiWHWUcC09SNSK5uQDFJEoqDx0yWlUTRPf2AhmF3eTmwg4tpN0pL1YhqPQgbV3SRzCQo7Fqr2Sc7J5dU8cat4gSAfiEVlBWayT3RuxWmbRyUx9TmWgvV8c=
X-MS-Office365-Filtering-Correlation-Id: 7b78cb92-a465-40b6-f7c6-08d5bfcc3601
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:10:12.1874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b78cb92-a465-40b6-f7c6-08d5bfcc3601
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces a lockless mechanism to do that
without races without parallel list lru add. After
do_shrink_slab() returns SHRINK_EMPTY the first time,
we clear the bit and call it once again. Then we restore
the bit, if the new return value is different.

Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
covers two situations:

1)list_lru_add()     shrink_slab_memcg
    list_add_tail()    for_each_set_bit() <--- read bit
                         do_shrink_slab() <--- missed list update (no barrier)
    <MB>                 <MB>
    set_bit()            do_shrink_slab() <--- seen list update

This situation, when the first do_shrink_slab() sees set bit,
but it doesn't see list update (i.e., race with the first element
queueing), is rare. So we don't add <MB> before the first call
of do_shrink_slab() instead of this to do not slow down generic
case. Also, it's need the second call as seen in below in (2).

2)list_lru_add()      shrink_slab_memcg()
    list_add_tail()     ...
    set_bit()           ...
  ...                   for_each_set_bit()
  do_shrink_slab()        do_shrink_slab()
    clear_bit()           ...
  ...                     ...
  list_lru_add()          ...
    list_add_tail()       clear_bit()
    <MB>                  <MB>
    set_bit()             do_shrink_slab()

The barriers guarantees, the second do_shrink_slab()
in the right side task sees list update if really
cleared the bit. This case is drawn in the code comment.

[Results/performance of the patchset]

After the whole patchset applied the below test shows signify
increase of performance:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i;
			    echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
			    mkdir -p s/$i; mount -t tmpfs $i s/$i;
			    touch s/$i/file; done

Then, 5 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

2)After
0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b3ae1373c99a..c487e4300b48 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1293,6 +1293,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 
 		rcu_read_lock();
 		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1425907a32dd..dba5f72956c6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -597,8 +597,29 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * After the shrinker reported that it had no objects to free,
+			 * but before we cleared the corresponding bit in the memcg
+			 * shrinker map, a new object might have been added. To make
+			 * sure, we have the bit set in this case, we invoke the
+			 * shrinker one more time and re-set the bit if it reports that
+			 * it is not empty anymore. The memory barrier here pairs with
+			 * the barrier in memcg_set_shrinker_bit():
+			 *
+			 * list_lru_add()     shrink_slab_memcg()
+			 *   list_add_tail()    clear_bit()
+			 *   <MB>               <MB>
+			 *   set_bit()          do_shrink_slab()
+			 */
+			smp_mb__after_atomic();
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY)
+				ret = 0;
+			else
+				memcg_set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
