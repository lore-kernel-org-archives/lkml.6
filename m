Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELu6YT+3mZ8kOotne7MvZ+6ryLhl+7lH/qZWslEDR02XM6B8M8XEZPoo/7Pmv8iNCOFvsZOK
ARC-Seal: i=1; a=rsa-sha256; t=1521638475; cv=none;
        d=google.com; s=arc-20160816;
        b=pEXnMNECehZh3XD6eQ0h4ikd9C74DfwqFTSwQZjl80NEP4h8kWcwvqGvu7krEdT4cB
         sjvqZ/IkuARk0TrdC6rQNcgp7mtlz9LpAO2bRY7KMPLH6cy0wXIDoW7O41TBWjBUzxQS
         QWVCHuv8M2Fy6V+8F2ouAnQjZFf0moZzJIyyP54B6ubBAwKHT+J+XL/acJaHSxHbA3hn
         bwwYj+VwS4Ves3Od3ta/lIf830R9BXqMxOsHeU6Ik19bxHz/HRc/1rhwioStFS9f/6VT
         DjE14zBi8wieXq33THL8iz9AKkTXouMQ455ufcppsSZeMEvV/GAMAtI2Mt2zsdVO8xTV
         4qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=0yJwstwoGirumHGUJxqTHtXjiCu0vATUGcOYHLpcZCM=;
        b=wvI9WF6cVCc7uojV9r/wbws6CVWbOHFK3APGXj7Kqp7dSYcfqm2COQktIobrBcZ+7V
         P05HhumYWEl0XwDyvamAbRvcwCDGvIhrc1dWcTuXzS28C2cR7DQ+IdXlow86DXrToh6u
         hJgMYm1rx3xnAe8FcRV8AU5H4f6xWCwYWjUwqn4GmSh4X86HBD2xM1kGucoeXXKOX9FK
         8cnjel0xcha3w7XfZB42uMMO4d98Y1Z00o7VGvfIVSQp/O8FG7YIPHBRLAgc5J8IandT
         9cW82cQjLlcEt67d69dV9AhPKAZQ1OJ9F4BePgFZ/Xt+UeMMp0+GDrHGwwhuCOu6Tyqy
         j2yA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PmC0U/Dv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=PmC0U/Dv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH 00/10] Improve shrink_slab() scalability (old complexity was
 O(n^2), new is O(n))
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Date: Wed, 21 Mar 2018 16:21:07 +0300
Message-ID: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: CWLP265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::27) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9f4c80-a52c-40e1-b9c0-08d58f2e9db6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:qausy3IfsJ94wKvzyAIEhio2LNT8xDrUGyreu4A/a7qVK4IZJ2f8z+YFKxIRuWWfYshNOGh+vc/JRY69iiGq+ayamQweG0AIk0JoIye7+1h0IwrX7Ckhw7yn7s9WWaODm6qtnWLmK6JoJIU5khUdpUUAMN+ZWlnWeofyklgjYElH1WL1iDjXfvyu9HCmyPW48Oa2qv729VFYl4MViePDRxOk1gQDpESyHsolFeT2cztZPFb7Uf/oGXuojjTRw2XO;25:YPno6/rbBsLele10a3x2aJRupyUcfmrgPI+JsGVSTV127pWwcv1AJAcCUgR3NDK2kP9xuupD17uNdogTXAE/52kvVvgaP9JEaURQEzIFtroSnnff5qdOhuhqlZ3d07yMdeKNGcaDUEhEWqq+t+ZJDtV/fEmRE/0oUqj/a6FE3UIltJm6gJzxteX93zSSpkADKTVh++bRIpo26fvQwYLxhlraNKr40kT83TLXGd0vVck3+42IAuqhkskEEsl9kFsFnFiXJ4ZXFQI2+sDQQ0BARvEHqIpDLao58UN0Sf7KjbOYArn4zXd77RytelHSVeMKoYpAzwDr6zssbuZHGxr6dA==;31:Mz0D0uhXJdbhhel0qmyMl3oiag11+1DOAhelyoHlIKLjoX5ukL9grOiryNrbs1eUoSJlEx1jqP99luvkdpiAJR8ITF7JKpuFwwrPCp6blhOrcZmWWg+bEBnSzhq/opSxx9JkqVDSOAL47+45eGP4dz9jq29h+F8Vgk10/brM6NnrXkG091ZwWlKGs3QhGvQ+IRbEzxTa/IGky3XCRH9yC4eQuRwNFIZFM4GUxr3cP0o=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:XSTfGX9NJSHErfQtp5Pm6Wu6Bho2OvTEejl4CH1kZ55ZalI5hiW/OOAc7yA2MlptuUjrHhfkvO0iBujebRDSPd2B3+gM6/s8HknSP2NEda97GC13KDvMCx+3oASM8mszytIzbPBuxjq/ZNtDzw42aSWVxujHtjWFjZL72hDGZNuowHPlubw4O2Gx33ZAxvoxIWZZtKDxSlTj8HJPChAqIQZKfsO4FBZZJUm4k6sp4FE5ngq6NwxwfviPz81cnlP1z1CyuBZ0C0dyOwdhmcF1ulfckRlCAWhy1t4JBUF74F8hSkjNXbGPRvq/lT3KqPdBtMiPkP+ucdbxFMUPpMCuvEuiD0538K252vC9hsgevc+rFo+r9LxaTqm3e+ZFDaENiLw17D+uC5zZwE9JHLeY4vMLddTd+gDpzrW5ilgtk8ybG3xckeaPQW5k+z+j9k0Ni+Sb9lr4DWex210VwygJCs6yOJcV2DFD+tuDNmIM6bCw8eAH+SAGvMzDydjcb8y2;4:LRCoF3okY+k9RIDW7XUJzsm4t0hDAVV07f69aAfyjYkXHXl3cqGAyMK6iNAUeIpFTmutCoLONM2u8HLndwGBtlGpE0lc+wh97C44yNTvA6IiN0hgtE0sPBFxiedwHE2Fmz3ibh1MD5wxyDvGQaFOyOjmQg/8MFbfSZcHHdOal2CUgq05z16ULydqKEBtZYYb5BFyCsXPrCRDcidl9ycG2rm6puxPp62SoG2gVW1WTxJRPueW966XEvhrfrG5q6sKoujVPWZFjtrHuWKK8qi5oJPGL++WkNRchcqmrvCZSPZMNjysMlZRkN+MN6z0rwQb
X-Microsoft-Antispam-PRVS: <HE1PR0801MB134042F2CD90B85EFA6E84E9CDAA0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501323)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(366004)(376002)(189003)(199004)(105586002)(39060400002)(8936002)(81166006)(316002)(86362001)(230700001)(103116003)(8676002)(2906002)(58126008)(106356001)(55236004)(50466002)(61506002)(386003)(25786009)(186003)(66066001)(6506007)(47776003)(52116002)(53936002)(33896004)(23676004)(55016002)(2486003)(7416002)(9686003)(5660300001)(16526019)(26005)(81156014)(7696005)(305945005)(59450400001)(6116002)(478600001)(68736007)(7736002)(3846002)(97736004)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6a1BDL09MN25NSm05eEtDc1h3VEdmdGQ2?=
 =?utf-8?B?U3FVY3ViWUlia3Z6bi8yYzdUT1VyeW8yTWJLVklEQ0JFeHAvbFpVcFROVm9a?=
 =?utf-8?B?OERnS3BWb3d3Wk5VSTdMYjZUdzhFUnZNVk9WVUhEVEZEbUhBR29rT3FqbVdv?=
 =?utf-8?B?Yjc3Uk1pSXh5SFNaeDFnNjRXM1BIYkhWalRtOGZhcTUvcUVrWUNzQ01kUzRT?=
 =?utf-8?B?UTIxQXJTTnZwWVhPSzJSZnBRNGF2MCsxK2hmSHJUMjRDdHUrTVNsejhhenNF?=
 =?utf-8?B?T2NYaStLSzJJL0FHMVQ5eVczMFcrb0RDSlVkd2N4dnBtQzVIdk5zUkFlYW56?=
 =?utf-8?B?OU9wOEZ2alNDUmdFYWsrUjhGY0JNR0h2cGd6STErUkdTQmRzdTB1Smp5VVN1?=
 =?utf-8?B?Z3Z3UHhhZFo4cjh0L2Z2VlRhTGVmdFZkZ0ZXVHJIQ0g3Ylc2eHY0ZFdCcS9p?=
 =?utf-8?B?WUtrSUhIaDN1RWZOMUhicGxTNlUxS2xNMlRQY0JDbC8ycHpYbUEvNmpMdDRY?=
 =?utf-8?B?UmhPVEVPWGZVcUdjVnRuRjl4TVJ4UUlKNHZlY0VDUXVEZTRQTDkwSVdqc3VP?=
 =?utf-8?B?eEpzQzlWa3IzSGZZd1ErMEVQRTZSb0Jmc21aM0c2RHYzbFl6MDh1bXB1NVBD?=
 =?utf-8?B?STR2L1dNVytvSzcrZWlES1hhZExWV2w3RmFZL0pPc2FTVnRORUpxVXpFM0Vh?=
 =?utf-8?B?T3A5Nm1GRW9Dejl6S2I5U2tsbGVvaEE5K2lCUEgwYzhPNHVOSXVCYlVlUUdt?=
 =?utf-8?B?R1N3Z3h1M2xQVjJEek1saEFPZVh1Vyt2d1hDOG9DZ1pSbDA0cmVzOUx6OHIv?=
 =?utf-8?B?ZEcydkJPUzdwUlJGc3d1MGhIMlc1VnJlWENGRmhza0k2NkNTMnlOVjlPMStu?=
 =?utf-8?B?U0tmRXFjODY2Vy9uWjc5a0xqQU9ZYnR6NWUwNGNwbVdIcVpJeUhHemRiQ3pu?=
 =?utf-8?B?aUhocVdibjAwcVg1T1hVRHBlYTV5M1lJMkJGTUdHNEx0ZktYak9NY1JZdGRO?=
 =?utf-8?B?UWU2UWhuTnh5SlgzWlFicEhIRkJiNldMSk1Fa1lLSFNVSjBVSjZRMkV0T1Zo?=
 =?utf-8?B?SlhnSW9vcys4b2ZYMlhLcUNacjRhZk1uQ2M2TlJ2OTJKZmZZczZod3hHd3FD?=
 =?utf-8?B?T1c5em42Q1ZvaG5xZmplazc0aFFVdHBxbDlaN1BuVEoyV0xjaE5zTm9mZzF6?=
 =?utf-8?B?WWlHdkxEbC85cy82Vk5ZZnVPa2ZTQ3ZabDlxRUNrWUtFZVkrSDBINURndXcr?=
 =?utf-8?B?c2ppZ3dXUURXWDU3akhwajRFT3ZIQmtFbVMwRmVqcm85UnJBbkx5SXBNbG9x?=
 =?utf-8?B?UHZJS3NCL0hxMkxQaU9SMFZkaFBKMmV4YXRvRGJUQk9NUnlnUGFHWmNiQUpK?=
 =?utf-8?B?dnovbUhkb0IvZHNFcllkTjdoT1ZHMFBSbmpoVVRjbEFFaFBtZVNMM25UanVM?=
 =?utf-8?B?ZE1kUWwvdml2TzcvMmlRSmU4eG1uVWowMUVjWnlQbHdBenBRK0FkZ2FyTk56?=
 =?utf-8?B?MUVSbS9hZ1VaRmtwbURRNGRjV3JLSDY3V2dNVzVwMkFpNkhoeWM4T2o2SEFU?=
 =?utf-8?B?WG1NWHFuZnRKM3VvRG5zWEt3bjA3NXlDODRjcGY1cDNxekdHKzB4VzFDRzY5?=
 =?utf-8?B?RzBTa3JWaVdYcFFXVVcwSU1FRUZLeWpwTUczN1VHS0JxVmpvU3BMYmhHTkE9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: /HtVgcPQoCN0Ji/xQTR7/ctp0NDYRy9i7lBFKStUMgQeGI+q9kImd1I0Aevcj1RXsL7JAeePQXlGK8+NsAGFKXKYa/0JOyg6rKgDHUhlZ8t3GVIdnOprQ2NGttFdCUfG7/uZWweM7yIy7T/pTftlGtsiNZF3XnP7QDT0kROFVPmlw745n8VmtzRI8VZuH/dG
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:Rg8noayDLKcFOJPUqiaCBZZ2Jm7I7xTN0IbumdrCrpSwb9gcPHba25Nbxgzl2bWnA/deXeFuUvfa/2Y282YvZXE7M4/Y2rnQC97duTDPhUzwCqfckWA4mP0ZJ0vJViEHmd9uOU+fsD1gEwZqlKNMKxXwSlbNzmUdOQhBVQHPvjmID/OTJDqbT6q2sdhfQUNWmShHih8RsICod75f6kFyzwS9Pun9bCVnyoSkIgtL1jziP02W6XRpBs37VTe32s8Po6Im336S+bqFwSavygmLBteiqsEZyyKIbmk3nt0U/drXsFtwtRfbBi2K++beju7J8sCML/pefoq29x4u92JfhbDxw+NgfGTCDRA3WTIxoaU=;5:vWX8ij+0B1Hn23dywr0bORVfIdtUCdl3V3TsjESnCp1ZZZoOeeSvedl2jQ/YK7ePjbYii79DQLD9VDFmelrilhSkDco9qTfkkLlExzRL8q9NV/Fp6BnO8gWSawySWg1o9bNqdc20kXkpooDuvAcoFDO+WdYgSPZKHLVibi0r7DY=;24:vGqM+LV33cohWlTkzDfWKPqj+LedWGvq6ROu1YGBYwIZfcYkmEM1cWchyqw8hs4VFTmW3oMrAFcnsujmNuBDaG3wTsuSuAmYQ92geMzHj6E=;7:eGdOviefbt4bka1blnzVhjDkzmOi5ijqBvluZAInVdauNlGsOY32G5CfO3QFBWNUQSH02U+0Rl6R9fnBxZ601Ms7l0mu+iX+RzNvSQ3TZ2zqyqdX0v2vY4te8qyoljcX6SKddIMUR2Vws3F9eKJaTZG8S3yhFOdrx09MwZpwGVxD/H+sKcGt9kCDP+2bkQUWVn8TcSDV7MamZtW5AOyPTAUwNZt0CHDjuY2ewlhfCiFQBxBXe4MPdZyAwUHEZgTr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:FUvt6LNJfnymbBBndXnQSh0B5qE2AFbR2sFNIekfns4TKzTyMDRREQPOruZmQNCVY+x8JmvmXIrzL24KraXwnzxUjTCkSegCZx+k0ot0DppNGV3mAYkfuAEjgID3DzOWFLrtRdbVHj6dRDEDqzm1X6rrexlD/9q5ZXoVakMGO9s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:21:09.4901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9f4c80-a52c-40e1-b9c0-08d58f2e9db6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553585316029185?=
X-GMAIL-MSGID: =?utf-8?q?1595553585316029185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks don't touch foreign containers
mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:
    $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
    $mkdir /sys/fs/cgroup/memory/ct
    $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done

Then, let's see drop caches time (4 sequential calls):
    $time echo 3 > /proc/sys/vm/drop_caches
    0.00user 6.80system 0:06.82elapsed 99%CPU 
    0.00user 4.61system 0:04.62elapsed 99%CPU
    0.00user 4.61system 0:04.61elapsed 99%CPU
    0.00user 4.61system 0:04.61elapsed 99%CPU

Last three calls don't actually shrink something. So, the iterations
over slab shrinkers take 4.61 seconds. Not so good for scalability.

The patchset solves the problem with following actions:
1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap
(Also, there is a functionality to clear the bit, after
 last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

    $time echo 3 > /proc/sys/vm/drop_caches
    0.00user 0.93system 0:00.94elapsed 99%CPU
    0.00user 0.00system 0:00.01elapsed 80%CPU
    0.00user 0.00system 0:00.01elapsed 80%CPU
    0.00user 0.00system 0:00.01elapsed 81%CPU
    (4.61s/0.01s = 461 times faster)

Currenly, all memcg-aware shrinkers are implemented via list_lru.
The only exception is XFS cached objects backlog (which is completelly
no memcg-aware, but pretends to be memcg-aware). See
xfs_fs_nr_cached_objects() and xfs_fs_free_cached_objects() for
the details. It seems, this can be reworked to fix this lack.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less do_shrink_slab()
calls.

This patchset is made against linux-next.git tree.

---

Kirill Tkhai (10):
      mm: Assign id to every memcg-aware shrinker
      mm: Maintain memcg-aware shrinkers in mcg_shrinkers array
      mm: Assign memcg-aware shrinkers bitmap to memcg
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Clear shrinker bit if there are no objects related to memcg


 fs/super.c                 |    8 +
 include/linux/list_lru.h   |    3 
 include/linux/memcontrol.h |   20 +++
 include/linux/shrinker.h   |    9 +
 mm/list_lru.c              |   65 ++++++--
 mm/memcontrol.c            |    7 +
 mm/vmscan.c                |  337 ++++++++++++++++++++++++++++++++++++++++++--
 mm/workingset.c            |    6 +
 8 files changed, 418 insertions(+), 37 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
