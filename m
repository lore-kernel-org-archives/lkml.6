Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZriJY8zLrVdk5jey16wV4AydN5afgF8OleE7M6oJS8heP+JOGpttMlMu3oOvvaAeJss4yCh
ARC-Seal: i=1; a=rsa-sha256; t=1525867145; cv=none;
        d=google.com; s=arc-20160816;
        b=EOpIVqQ0CNiQwR9J4/BZDH7RxhuEj93EHdgCjCp1PfuMTamGCm/gB2119OELoq3OSf
         awVgAAAkUE6BaB13S7Fpk9Lk9MgFcVzZs+pkCbulOHNoIsau/PIPVDxfaRWd+zL3Lvao
         YGG0o9qtSnFz7d50RR3SnTwNgszAr/AeDO9gifAzPbLcSiJwL7iNLBUc5suaeCHch/QJ
         Fn/K4WYvYRsxGgJAIqL7y610gMc+qhljbde1OmmAA7D79/l3/eLgXuNOPZYD8QbNYVwN
         DcLHqTM24MrNwLElzdCIFVxhh2cnLxrQV85R3wXj9B5S6Rf3KVT1uip/KsfEQEPsVgnH
         QXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=i/a1HIgUYQdtVnmKvgsW8oV2n8FbgtIS4Ng05Lnt1zQ=;
        b=hN+icdBVQtd25Zch/hJKjYvB1HFEb44IiL+T24beqZCuSY2I0cS/1hLhp2MwpIvjI/
         cXt2f/8pdC/bHZw57auGEU21PumJ3hrouSlwCj3sckTHA913VJNorusAnT6+wlG5zJBt
         oxwpJbI2cJ+QyRfG59Z0xW6XXoS5gzcIAweQfKcevl611OR1rz5FLSU5SK4JriJ6qsQn
         44MJ5q+lBAzx4vMOhqMG6W0OGDvsLXSbt7zy8w5G4KBvfr7gOLHLWMSoSzwWsavnk1NZ
         NbsHj6xA8a5QfI+VD52/ASJFlBxRLFqZSdwp57JSL0HY2v1adza3nwgZYEhHupbYNc7A
         e17w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Qt9Dgf34;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Qt9Dgf34;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.137 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 13/13] mm: Clear shrinker bit if there are no objects
 related to memcg
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
Date: Wed, 09 May 2018 14:58:56 +0300
Message-ID: <152586713627.3048.6958181425724648686.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0022.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::32) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:xO004wiJGevn+WZLmNwmDdykUS2hlVrZNxzCPnqQ8ZzuAB4pIH9894/OzY/BVaDL4tabFv8lFZI+gQYAbqgp3SKks4VZTwo4xEQ1q/Lzv046H+kooJ79PWdDkLvW3KvxWehjrlp6Tn90xE6fsm9wcwGuKVnKvL+0JP85/Tk7lGJ8g0m3PajWRSljVAW/Jur8QXQQe8y8Fzzzm/VHCjgrSixTSbqXHaRq0n1VNpGzMhy+9KxSyo9C+aBhwZwxnpJe;25:0yuRzd0uKDxsicOGnadsJIJ04xg37WRsXwy6Qrg/hhS5OU7R7h2yRyfXIfBb3bxa6lX7XE9xG4PuVFJNV/8llaV1SZKpPmVQcu2zcHbRC9hUSADehCT617FUE013C0CwsnhUn8WeWHGezSPxvpfg2PoS1iebhAS3l1heSo0KKXL0G028hKWWAtKoI4PnmA5bQaGdGz3wvVQoinrnX6PkOshIWx33ueUks/D8NwdCbCkkU+cVXoOt/wBAq85hdphT3ZFlXU5pj+GcdMa6gm5kzLCCE737CKIpHwr0kGVM18pgq6pdVBiNPE2aRXMcrviomRvQLkkHunTo2NNuO9kWfQ==;31:R1l1Srmwt/L2V/GoEYuzxDAUq5NLsUbVsBlmei3VlmlC7wC3xYJmlErAwpa6kbfoBGkqNP9V7RMRBkzBHSRL9n19U1OxFFLqX/M2KoR7AI8m0Un7/k7jGjN89trrGgSgeUpCAUPDWASUura3xFPQ5d7dU8NCgsznIl0UX48kn2A9kcnnSAbIITXgwCOa/oTUlH2wlCo7PdqqL90ytc/7IpX4fFjPmDHQ6HDGUwSTNUE=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:YKwURi+abmRKG/75qj+yE+5YqUHR/AjVwSrRQ8qQEn+vFDdMPAc7f8biVx05lNKejTtIYQrjjvE71bKwfpjgPtL/1JwE/AIZeQQoTTXGu3yVSdqrmWGfYdcUnnMOqmmU3Qt86zpQbtK2BTh9hnPfcbD4mzOmN8DXXaU3nvbQ2io3S+/6PUwZyI2keDBh9uZGqTxdcriquG5ms05lnRtWf+sO3KqpHCAohMSSA+BDVqhcn661sRA/YcydVWS6ykYJDwIElgqjVoUowaJCVVpBfB1jnCzyUsL/+GAPbMwTF/e3KtikHIKG4b0zO+onMUq1ItVBwvJ+7Lwjg4RPPYbUBLJ4fF+1lFnQizbyQ/MDaNzuV0fprh5sTf3BlCUvxK4+oJDiwTxdc7T0SZzapq7zC7ODT5twRssbHWQtHwyrbpyvg2pjydS1RyAzscXiIY2VaBMJSFCoMShVBrEo4fu8+XrO8rvRjLONRPN8ndT05CfzDcfJ0fCA/vwZ/9YruYPD;4:JvhdcOzwz1chgHWn0q9IW0aBJfguhSWMXU+9OTZRFHCuGLQUOpUFejkbJ8h7aQv/T3WAN83QAvfrI8JSi0Nodf6wNIm+SNMhUc+sJNiPdupFNG2CMQwpbMvvRlWOhWoZM8r3AaVBr7OsoyvcPX7tzwRJuRUFE/45mTTn+sJS1vROzvHzLtq5Ra7rFA2KyzKopAtU5jtBUeIUpW8gF5fMcbfL8OLle/+MQnDGFV4UMqbPgAmRYbBxfMOvoHVj3z6+xu8X7/Ozo9zNrqRjtN64AA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343D9E38E68D25D2D7E8118CD990@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39380400002)(39850400004)(366004)(346002)(376002)(189003)(199004)(7416002)(6636002)(186003)(68736007)(26005)(3846002)(6116002)(55236004)(86362001)(316002)(2486003)(305945005)(23676004)(61506002)(52116002)(7696005)(7736002)(446003)(478600001)(76176011)(2906002)(50466002)(6666003)(16526019)(33896004)(58126008)(59450400001)(386003)(6506007)(97736004)(39060400002)(230700001)(5660300001)(53936002)(103116003)(25786009)(11346002)(956004)(9686003)(55016002)(486006)(476003)(105586002)(81156014)(47776003)(106356001)(8936002)(81166006)(66066001)(8676002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6NVlqNUFYNHRrUFl6RTdVTGUrMnoySzN0?=
 =?utf-8?B?MzhVR0dReVR3cUZjK2lnay84SCtlMCt4bWh5cnZMMzdCZ0dqNm5mTGI5RTNp?=
 =?utf-8?B?enFzL3l1VFB3K3VONTZrbzh0czBaN0ZYTlFycG1iRHRzODI2RkxBVmpUS3RJ?=
 =?utf-8?B?cTRraGdtbkFiZHJPMzY5MmpyVzJkRWdPYldGeFdhL1dJSVlRVjBOVm9OMTFz?=
 =?utf-8?B?N1hkOWMvbyt6aEhIRG1ZQmhvd2dCUTI4SmUvWE02a1pUYXBDNklGRTBXYmZm?=
 =?utf-8?B?ekkySlhlRVYzMDMxVmo1d3NDcEViSlE4eXlyczFUZzQ3V0FUUm83aXhheUk3?=
 =?utf-8?B?c1JiWnRhWXhXQXdkWEkzQzJteHdrV1hYbXVpaENKaUV1VUM1QTUzUkdDVUQy?=
 =?utf-8?B?LzNKODMwdXF1NXBUTWVoc080K0E1allGdmo0MVNxWWU1TkJYQTFyV2RPN2RZ?=
 =?utf-8?B?R0N2aDRySHlQRFdUbXJjMXd0NzNRd0JMUGxweTJKbzFTTDY4ZUhuR1UzbTJ1?=
 =?utf-8?B?VmloQXludmVuQlFvVGhDSjN0VFJycjcyOHYrY3ZMSFRNUzBUakl4QzA2UHd1?=
 =?utf-8?B?akFWUUdyc1htUm5TakdaR1RuaVRaVnBOR1ZrM3A0aldML1NHTERaTDNBTUcx?=
 =?utf-8?B?Q0lBYUoxRnJMbERzZzRId2dpSXB4RUdKVlg0Mlo5U2dGcS9aa1lkdVhleUFk?=
 =?utf-8?B?UU5uamZlSzFJL3B3MDU4eDUwZVo5T3VZa2hISHFxczNuM2VYSWY3U2dJT28y?=
 =?utf-8?B?QThPakFESDJpRDkxWVZxbTIzekdNRndBSXcwclcycUFkLzE2Y25qTXB1TzZR?=
 =?utf-8?B?ODhRSWxrZy8wdjV6Nmx5N3NZVnIyS0N1am9RL2t0UU1tN2RvRitWMW1Id0xy?=
 =?utf-8?B?ajdZeCsrRGZEckJFTkFmc1c1Y0g2c2N6eklBYVdhTi9Xc2ZNRlNwbWF4OUJ6?=
 =?utf-8?B?T2VrWmZGNWVpSVhmcnhQOW91VklIbzQ5d3RjdVJ1SjM1SGNaOVlhV2xNRnBD?=
 =?utf-8?B?ZEQyY2tPM1ZqL3VlaGNQdkJGdWozTTc2dmVuL3hVcE5HbUxSK2g5QlZieU5M?=
 =?utf-8?B?TUxHU0UrSDRRRmxmWEFLRmpQWDNEakNwTW5JeHRyV0Y5T0phMjV5OFk5N044?=
 =?utf-8?B?VkRPamFWS3l2R1RhOWF1dzUrOVJYMGVNQUxkYldKUXJiOFNSUGxQZDhxRGlZ?=
 =?utf-8?B?L3I2VW85RUxvY0xaaFI4L000WlJRN1R3akEyNHcwYUVkMDJrWmE2MUswLy9J?=
 =?utf-8?B?T3A4S0UwQ0M5Z1RRaDRhdkRhMDhHU3J4eGx6SitiazJmMjNQUWhUU20zVFB3?=
 =?utf-8?B?YzdzZGppUUNIWVZrYk84RjhMbUZSaEhKL0EyWmlNWTNjbFRyOWVFSjQ0S3Fv?=
 =?utf-8?B?eU9EbTA0b0RPQ1RQQmNZUGlnL0lmQXlHMWNNMy9sN2ZDc2RyWGIrTlZLb3Ns?=
 =?utf-8?B?MER2YjB1aGRlNDlhb0dNdnJsQk55ZUt1Z3YzRHJVemdXRW9QNGx3NEYzbjNC?=
 =?utf-8?B?RmRsbnJoZVlYdTZHVUdnVVgzRDdYTjQ0YTA2TTNxbDJwelM2WWhtWXp1cGtq?=
 =?utf-8?B?QXZSelRXeTFwaVpSLzhHM2pQZ0luRjJ0NXpIbnRHOVZMdTJ3NUFvTmdLdXZM?=
 =?utf-8?B?bmRMQjBRS3IydHJjNHFDdFNoMVhTQ1lrN09kM2E1TnBYU3pmT1JEY1ljNTE1?=
 =?utf-8?B?QUpBb1N5NWFsaE9neEFzNnpkTmVkOHFxZCtGY2U2ZDI5MDQrVzJ2cURZWGMy?=
 =?utf-8?B?bFQ4S2lTcEdFZ1cwT3ZzVVJoNVdYRko3ZGxQaXMyS096aS9TUHF3VldTaUUv?=
 =?utf-8?B?TFFFVDNPTlB3aW5jVWRCWjVRWjR4Q3gxcWtWNDM1Z1ZZK1lQdz09?=
X-Microsoft-Antispam-Message-Info: K/ZYutvmlSbgdyi1XDzhNoeL0AFLUB/xFdmiBchJtyfv/s8C7V9QWYsEYk66Cgt488g5937XwLnyux+iWFxL8tK75HMsGOPpyQ9WZi6qisISoeukimGv/OuXCMLOdZ0lt4Xq3JndASuHAPmJZjZCJSqyP7hFbI4YWMyBGZ/M5YtrMuttw+RSO8hTSfso7eXa
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:RiEMvEWvcBs/nqG7keYUN0dbO/TIdmK+RzrFnyNbcRVrIHKh8EDbjGZp6MnCoNInYFvMRrmUhgxV7cVRda6q/prkGRlkXO9K8iSk/Jnn1DP392RuM0pezsBOTfFQvxn5LaWV6Y7JxdBuT5r0K1Qxo0V3bk1KmHKBvLOk/eBS/RR+lui8IGLNj5h+DcUtWzVI+wJTWVYN41mPvnZ5RsNqjqGcrq6Su9fULumGt8rd6+DT4fzBifqFq+O4K848RhmgFmw/B5VJNWTILQRp3RvpUZk5UH5arTo7eV6TWkox9J00Xkr99uFjwo5Stlq7e0pvPRMS3/D8LNXeUi6r4JuO1NVGGekuqUA+SpPRg5kD0jumV7YCfdZyw1D4khZBdTNwyHYaxmOWi5luWt5Of9VZ/vLly3pGN3c8BvTGadIFAapAzN0jG+e67j13jKfAoHCKAbWYVdOsVm3/sqE9aN+3Kg==;5:Adqa65OjuWcEJS8b2mh4xhK/Sllyuzyq/wSq44TkEBKwg/U2Y1yCrpqajWenkbaa0RhhdCU+afDSyMCoQ/2vjtqpDoj5YhegrjWs2fs8HTmXSQ+5xEULyzlMO41SnamyqSEHum6dEHLd9M06pz11LLkePv23I/tdavHw9yjas4o=;24:IPrCBnKKev9zRKECdl7OvvST4EgS9mSFwRzs15+GYBxhAXqYGpCuGN+sXjxopZ5LfH4akPYRmBrY/ZqlcmQXRNr+XvzctxjGRfj0zVQyu2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:EpnejaIYqjzLV23XpmvFjXSk9m2oHOjxiPM8zTyhXlTQTa7vZC+05IoZkbyKf7D5RBaCulmYglb3oejulaUClV5wf0NbO1kYho9Zw57bxnLdsZTXQI9UP/S/tiDl1CstZ5hC58wzNZg66ykj75tQ3aXPAPBNIWQUUOei3rOXEv6Gxpirw5voubmnzM6DiMMYPu93fTQ9OVqQorMH5cPuHG32mBcVmnC+MBzAIhDD7VuTiZZYa2O1LsMjMCGzCfUQ;20:ZMa9LrWI3MpOaM1yzgowoAMQPMXtGlrrqqlJ122V3jTqBISBjNmFh9OvSyLaIicxoSmZthl5CYSYO5zIR833KMJfLJducAg11i1JbNUaWhkFSoH+NzF3ARBRRpSKN0hhc8Wxoh21Gv5Omv6Fm5v71UdW/Q8G1Hb0B4HKAf98WHA=
X-MS-Office365-Filtering-Correlation-Id: 5662fcfd-f634-46c5-f8d1-08d5b5a440dd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:59.1283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5662fcfd-f634-46c5-f8d1-08d5b5a440dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987667744457334?=
X-GMAIL-MSGID: =?utf-8?q?1599987667744457334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done

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
 mm/vmscan.c                |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4548b09e44a7..9f00554aa59c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1255,6 +1255,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int
 
 		rcu_read_lock();
 		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(nr, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 80743878576c..49cdf9a17d6f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -586,8 +586,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * Pairs with mb in memcg_set_shrinker_bit():
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
