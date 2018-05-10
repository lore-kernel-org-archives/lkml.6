Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZo7TMnZSLvXpP/Q6IIMm0DOpjnouK/cg7+IwGOfE98O76MIF5Ccy1/TJxMCBDrwIwyBmgOp
ARC-Seal: i=1; a=rsa-sha256; t=1525945935; cv=none;
        d=google.com; s=arc-20160816;
        b=O8q3Yn96ezQvYg+xk809uebm3k8MVzYJa/p495xyWJlOMg/mY1ZeOSCIhmSnYBrVXE
         5bGBZEEDEsBwjjeIUXpoiEDs1/iTGbWoD6606KRALtjPn2V06gpt8DucJu+rYxUnbrq7
         bqJuPQVlNrz9VYQH6rizg04mWrkdrWPU7MQmDoOFD0otWg+U8gZ/JEQ04P75vzTkX9IG
         3GwHBLYn5TgUQ08OMFFkl00Hyt2Ay6Xv9inCy889i6YoiUy2hiLWTAqYMVA5nHa61CTD
         2c9C7K6h2bgNoRs8kGfBg2VTX/EclyAOiSJ5SWp1OOCz85E2RPRDma6j8jIJEUP018k5
         3Q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=WLUivg9hLlzR1/q9AKiIHmHt9pEA2tAxeJ7em/wLOy0=;
        b=z+LwnuuY5C6TlKRFUhBkeW5MlWTGgrOLOv03v2/t3pJnk+ggLznpx6iPSi2TyJzhXJ
         YtBSrs5uSGaIj0unb7HhxUK/30Jt61NoI6/VyKZHBFkX9KyGqNF2xhYbFcLLsphsb3Nm
         KCwYO/f00j1SmVx59UsqI+8JEAFVUYyz4NzF4+VoVxf6ljMB1bpvFdgv9kyOloeLBO3N
         xQCFzUrjww5lFk6lkyWNXVdgTyg89V9T9Sa1PAc3DIRLRKVy4DXD15zr+z7pfrCW3z99
         eM27pUAI1rNlq6YQYohwC7lx1DNLxHhqomth7EhtutT3emTQtPvJlA+X6FEgAo5Urhn1
         LbEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=bdcL3bXH;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=bdcL3bXH;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 00/13] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
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
Date: Thu, 10 May 2018 12:52:08 +0300
Message-ID: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:69::30) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:QzOOfn8Oe35UaQjIlyeX9dhUDzXgRpUTcwVcAADEW93rDjkmmdBX6d/PZbHYt8of02f1gI1A3qPnAQ6gdlRl4+V1rgsT1I9BcOhaHHWlf/Cyt/SWssbPSdKlj9Jy2Cm9mfCxYIFcrioLFbQtfhsvaPZcVWrCUqN6ZwNG8Ixjdx8SMIPtrDbMxpeu9bcN2xHEFYrVQ/ZvaIZdZhIMM+Py6FqCa6MRuPqGSlVRNnfe31h6xhJXUz+8cOJzdaGnD1JW;25:N+FAXGIemz33QvvHv691zXATLYE7P7XE4A82ZsRHvYZFkFmCVAa00G9AyWN1QIKcTi7BlqtBU4QNQxma1tyiMBGPQ2+a6Prwc73e57glDonRa8IDr2ZEbLKc2j690eMYVsYUHDETbsogW+oSJjcF+WNf2B6Ae2tq573QhBR7qrj5LuR2/f1AE0lmacS0+Nw9w3ChkPs2TiCMIZs2qU8ox4X7GaU5GwEdcYtq/lW4FK8S6KHiUpPDhP0JT0NWycGSrxkoLSkSjjpjTGtUnRs4khefZ+UHdmPQHFzyRvf6jX9es6rLqhBth5f/lGk5ZbqPGlk6iCu+0ux6A3YrPmRv0w==;31:rrPrzCZaHikis4t9jCnQH3UxFT49sEE8DXo4WG/IX4Ql1wa41bRqMfLU+G3S6hEk3W08mg5kEdkx6RLSo3Bg85yYrMSeo6zqXqNXy6C3yk3zjs5F8wKjBjbL9tjsqBAoGs3nOqv0tG5AEYQWxME9iA4+UgE/f3Vi2Gxo38HUmhmUghnYrOs3Q3Jwfg2VbbdrkHzIHw3Umv99WPu4UFqEL6ylqgIXY5V86kBMM9mKMNg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:r5Ore9ZCwlEW1yK4KmgDyDJ4njG5ESXF9Q/dOpAnXjrFxSc3oI78dGP3k8xPK4VqDzz3OCB8yfAum87a7srRC7h3i6EDarh0pS1TxFyagZFz9n5rCumvzZFuxlINWBPY4VYQYS/GdyE4Jc7zCgkdrXd8R6iSpBV/5deM/0942N+EntQa3atCrcPaS/lvLZ8+ei4CBMzyc6Wp1CWVnmEylmONFdkYj3Ohpgnq3czPKI38mN1zeG7dVPjcgO6GEaNTVUjWEhm3Ykp725mbMAl2pq9P28KlbQ2LH19r0UnJVwQNRPdstY/dCglLciYkUZ+dCDKRV/KzOgBk7xp2yCSKA0p16gaZL8JaM66AN2lhaJw430Ht0VGJQeF1r69niwt4Eys8LvTquJvpfpdqnbh9LNFhAz/kAOtO3YkuFbkgnsHK8TEmW8KFXw6/1fDMDzR3pxz7ejWrVCardM6ddIBU4UrNDViyFokvMHxW2lhNP4zlMDVWoA8UJoZgA+woSqdp;4:ShqLhp+RUFa2FVz1EKvrzpppKq8Y8BEvU9R8xDYz9NyuPg4K0IxDN74z3bXh5Iw5D7m3gUFFQxQ5qtMDtVlNucFTxUudUZ3BS21M19WyAB0L0DkQ/CdqMYYMt7dgcfy4u6D43AmfsfM2/vtXXBeRa1JFnQKt3qjXYJHZI4KAHkasgfiHKjadwWmFatJv8Sx459yHF/i/lZ+7TPkI/Y1sEwaHdUsZqJHt0VCbbIZTaPZAbT5gaHhc4C4mRriqHhWfMg3BzCjf+3VDF3ToouCYEtqKF0BVStJS/SFrXQrVpKO1AX3vwUmQSfsQ0ddltGHh
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13432287A78F56177A407C41CD980@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(376002)(396003)(39850400004)(39380400002)(189003)(199004)(25786009)(6506007)(5660300001)(103116003)(230700001)(39060400002)(97736004)(476003)(53936002)(486006)(81166006)(47776003)(81156014)(105586002)(106356001)(8936002)(66066001)(956004)(55016002)(9686003)(8676002)(68736007)(7696005)(23676004)(61506002)(2486003)(7736002)(52116002)(26005)(305945005)(55236004)(316002)(86362001)(6116002)(3846002)(186003)(16526019)(33896004)(386003)(59450400001)(58126008)(6636002)(7416002)(478600001)(50466002)(2906002)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6SStmb1g4bmd0VXNZRG12MGxJOHJGSDFk?=
 =?utf-8?B?MFh5QjEvczVzSUhnQ0M0dTBvNEg4NEVXTmgzcEtncGpVeGNOK3FSQXdzMnYx?=
 =?utf-8?B?d3RFTytEMzB0SW8vR0l1Tk5LUVI0TE81NWUzYVBIVXJVZnE0VkxpWjB4N2hZ?=
 =?utf-8?B?T0pRWDhPNU9pS1g4ZjJGZmtPNGpWMkdaK0x6NCtvYTNMUTlpRXA4aGxCcFRL?=
 =?utf-8?B?b0t5cm1IcHg2djhocStCMmtSdHZmaUI4Zkx0eG1MZGlBOENlY1JZWVd5aFhZ?=
 =?utf-8?B?RjRjd0tUVW8yKzhoSG02ZnYwZklhVDVXNkF5aWxuZElXWWtrZDBZN3ZOUHA2?=
 =?utf-8?B?ZzBPQWM2aVFMbjBHUEovbkdJWFhmUWppYkxpZ3FSc204WDVoTUZ1dDNPby9X?=
 =?utf-8?B?NmFaNG1NUlZ2S3JlSlpGT2Ftc1dPOW1xaVh1VUdLOU1OT2QxYVhhN0V1RWEx?=
 =?utf-8?B?Z0NxWVR6L1JBSC9GUUlYT2N2QmdPam1xQnNGNFJXc3lCMVB2R0FpMjlJVkFi?=
 =?utf-8?B?QVdHMFNqSzlqSWZVLzgvOHRJdlloUVdvWk4vNW5wSWxJVHZPTklWWGM2RmYw?=
 =?utf-8?B?d0pybm1MclhWRUVzbVN4RzcyMHNRUS94TDljYzNZUUhIbmhRbWdaenJUck8y?=
 =?utf-8?B?aVI4cHQ3Y2xXMTd3YkN2Nit1QnZVOHc2ZjkxWnpremhXWDBULy96cU9rVGF5?=
 =?utf-8?B?UFVaaFUyZStMbksxUGhONm84T0Z1NTBLNEtCVVhmZFRSRnVObWhGUHBkOGp4?=
 =?utf-8?B?RklwYWN5MjZvTHUzbW1wNnkxMU4waExXUjc2YkkvOWZTaHErdFVhZkhGVUds?=
 =?utf-8?B?UnFqNlREb0U4amxrdnpLQ0Z1WGtmS1ZQTldQaHpVU3NUQS9hYzZsRmxqWXpM?=
 =?utf-8?B?WkE5U2tFd2pCWU51K2ZJY2dMUHBvckxyZmxVUldhOFREWGN2cjQ4MkVOaUIr?=
 =?utf-8?B?TDlWM01hL0JwejRFZXdVSDA4emlRcHVJS2VrbzZxNlI1eEUyWGdFZVFzUzBk?=
 =?utf-8?B?cFo2Zmt3WGNxTlRXSjZBNVVHNTZuU1d2a25jby80WGxld1JIRFlpaVBxaU9u?=
 =?utf-8?B?dkZvMGR3ZEVXcXdvcTF5TVQ0WURocmkzS2kyTlI2OVNFMmFEeU93NVVYUWJK?=
 =?utf-8?B?ckkyKy9lVTNsWUFnVjJFZnc1S244eDdFME9uUGplb1cvbTZLQjk1dHFOK2Zz?=
 =?utf-8?B?TWoxN3FjM01GOUc4MXpWT05ZRmp4OFZKNEV5dVNxcWdPTlpBL0JwV0o3TFFL?=
 =?utf-8?B?N0lEa0Y5RDV2dG5MQnd4MGhMZ2NXUHpxSG4xSW5iRzlVdUY3ckpmNTZxL0Ru?=
 =?utf-8?B?dFIybFNmTUlKVXBubGNrdU52eE1tUk10MlZwVDNLUHhXS0x6VGt0Y3Awdmtv?=
 =?utf-8?B?cWFFekRZdjdub3RSUStYZjEyN1hwWExLMHZscVlxM3Z1MUQ2ckU0cGNrZEJS?=
 =?utf-8?B?TGRoZTZZcGNGOUxCV1F5R2JzS0RKSThvLzlhS1pQcGFuczg5Z1Y1TWZrS2p2?=
 =?utf-8?B?amI1cmhNSU8vN2FmbUE4MDk3NlVKMzZscEZiWngzMUJDSmVtMUZXd2o2TGNt?=
 =?utf-8?B?dWFiMm9pTXhUTXdIaTAvZ2pVTjRaYjNmY09JbE1mbmFpcDJ2NTRIa1Qxa0hJ?=
 =?utf-8?B?NlEyYTZ6bWdoSXc1MWNBeEI0WklBOXFNdzF3aHZqekI5c2h4ZlpaMnc3UTM3?=
 =?utf-8?B?UVlaUTR1aXNJNk9xMVBPTnRGMXBEZkE3TkVOVTFYNjAzZ3I0a2VmMVREdDFt?=
 =?utf-8?B?VGsrME1tYjRiTzRnTjYrS2JRPT0=?=
X-Microsoft-Antispam-Message-Info: NY4QZfodc4Ztkj3cLn9mTmRDF+roQZ8UGFkCN9S5yA1/mGpFFm3lj74ezaIKKn0ll/6X9keL0lgnF+D2OD+n1+NsaIxd/IndufJsL9E+gBDSuxNdWPkxkolw9Sgy8wFHnrdGNb0FH2gULfdI2QghJpOrboNjRB1/rmC2PQ1Ax6+R1INBP81nN4S8iMvAZerb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:NNTQV1JdSimheok4XiOeG2M4DJrETl6cbqqtHcooWDNPVFMWT6W34uXWl+R2m/1AAny8FCInvPF68JnY2EfiGLSGk1W4HPg7t3kFBPSfXULO+k6ELMvWm4B0mFDU1WiqPlXZN6VtFT1OJ/PrkxzrJIypjMZff7A8MEF1lkLFcyCJgHUWHqRa4g7Vt75ciyWszRrvv1CAYsDjxuZxAsb32SJ1IRNJ0bKUrs/ZzX83wgH4wprOL/OKFvW57WfKSq5Wg87nlGUuKEfLYfP5+Dsdy6y/I0ordYC3i4Fpyz78feT/cvDovdtlWskRnqaNAN2OFacstzXkyaAidVaA+UmlRsySjK3LYpyt6MyWpusV0i/2MIbp64EDgzO7Wcw/4YEDseo03UdrriQSltBI9FjHSTWNql4i78nmYquo1LaZy/cbaDib4P33vsnaYYTJLRlFeIgV6ho0EKC8jyoMetyKSw==;5:HwmTL1CmSYTtW2bMaIA2bLQpVOWO0MA/rnF+AumNFF6Tg8lqwgE+BEp0SkatXrZbBvedery9iUhkQiyY5xFendmZJqxckOgTVLcTRzJSgZwYkNOPvjk7Yz1iXlHi4yE9O+aWjqDBuvj/K0a5i36qrnGt777SgvTWgfBhJXo42NM=;24:+ku/FqXK3pmzCFK8+lHl8OqXLuHCA0/wLiQg91ZC4AEUL3esGOWst9ytAxCg5Dq0GzZBYdsaI1Zko/0PdvxqwaobU/Td5bcyTADf6ki41RE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:Zk65UaVFf0NZJ2h0k0AKiFcnFxTvfrtR8bJpCmtFDgICWsCRKatvccz4eQlhACCLzL5nlRKqSuJSzHaGFeLDDQdlTiC7OM6qzMmJ63X8zz5mCoNFbTkUAlq5a2xMse+/iX6oBMdwzf2j1jeac+vYJMifN7HplVsJ/2sRSEfQKl/K8jj5reAaBwIjFiM8gfsdXAOzRDVBT8YFASTBu9VGcde13jraZgK+a00f7S8vWrFNP8wyvk9hWYC4KsKuxJt1;20:P8GoRgEuw1yszXzfnwcULtFUpdznVfLU+byvSzY2Sw0UYjrbAPIsPUzsCyRcCBr4dMgZdmzRdCKKhXJ+rKmmEDmlFA2c49kY14s25C9DuDVayE2VYYkb5btkPWpfVdRaXz/Md882RUay3RJNhNAM4XNSSsc5d8bshyAQwJsekPM=
X-MS-Office365-Filtering-Correlation-Id: eb7ad171-1c21-4862-4262-08d5b65bb44d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:52:10.8065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7ad171-1c21-4862-4262-08d5b65bb44d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070285088533127?=
X-GMAIL-MSGID: =?utf-8?q?1600070285088533127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
	do mkdir /sys/fs/cgroup/memory/ct/$i;
	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (5 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU


Last four calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.48 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches

0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

This patchset is made against linux-next.git tree.

v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB

v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups

v3: Many changes requested in commentaries to v2:

1)rebase on prealloc_shrinker() code base
2)root_mem_cgroup is made out of memcg maps
3)rwsem replaced with shrinkers_nr_max_mutex
4)changes around assignment of shrinker id to list lru
5)everything renamed

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.

---

Kirill Tkhai (13):
      mm: Assign id to every memcg-aware shrinker
      memcg: Move up for_each_mem_cgroup{,_tree} defines
      mm: Assign memcg-aware shrinkers bitmap to memcg
      mm: Refactoring in workingset_init()
      fs: Refactoring in alloc_super()
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg


 fs/super.c                 |   18 ++++-
 include/linux/list_lru.h   |    5 +
 include/linux/memcontrol.h |   39 ++++++++++
 include/linux/shrinker.h   |   11 ++-
 init/Kconfig               |    5 +
 mm/list_lru.c              |   65 +++++++++++++----
 mm/memcontrol.c            |  148 ++++++++++++++++++++++++++++++++++----
 mm/vmscan.c                |  170 +++++++++++++++++++++++++++++++++++++++++---
 mm/workingset.c            |   13 +++
 9 files changed, 421 insertions(+), 53 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
