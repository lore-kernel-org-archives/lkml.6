Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx493Qfbb8ZSZSCIbTmZIkVJa5ndNXcSrGwmMTeWLVJ0Mux1sa/O5/3xPeSfd62jPQWG6Irg4
ARC-Seal: i=1; a=rsa-sha256; t=1524571919; cv=none;
        d=google.com; s=arc-20160816;
        b=gmr5L5+9YU/oaFpEjRdEL4f+QRCxoFI9/M3VrxrZ9rHwYdLKHOlVdrbimJzxDO6JXL
         lYzfbxb8/5sjBOy+l79d1GPlV1scmpy43nf70k1P7CbGuizDfA82REUZwnweO51kjaSg
         fZwneZkM6MzbMrIIYpEwHxRd7WT0Hn8P7xnNmxCslXTgktRzuyWzAL22XesAgPP5Z6VM
         sFopL7Dxk/Wbmpcjmz/jzR9TK6kKQC/k8+7v+dJBhJmNAXrxYGeZPP30rprF2xNASHQm
         dJ4Dlt7xL4OV4/4rdVDX4uUOU1KTX/8LdI8qn/6zx4qZ8XYMGjxdCnXTS1BpkrdOJXgy
         l2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=300hUMG8Lc0Ge+cNtGnHzieCNF9ixETksgIsbzRu3e8=;
        b=kLowpfkZxm2T2z13EAeYmZp5blwQBvhfhwh86cIIX/7YSD0j0tiFlwlykg9Iqsy00m
         vHsWx+t4VMtVMJ5ZNgWLJIFFiRgMMdMMP/QMk5jjKzLgeF37m/XKNQa/vdxV0cFPXCBJ
         0wd4l7K1Dgm2fphTUPipxKeqVzcgoyCDKw7vveSxcbxwMdrqkrvy5aYrr/S8tw0IKvxx
         qOZsxUkneQb3WF+m8/hY/yi6s4MGJk91bnJTj0RuZAq7KrCk4emdSltyShtNgNIHCjvG
         n07BO76w6dcwsZjzuakgPvexJIukwtz7SzTn2ITl8uxWIEiyncQ+d4PeNuJRo0Tu3bRY
         W+Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hXB5Hg6O;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hXB5Hg6O;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.106 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 00/14] Improve shrink_slab() scalability (old complexity
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
Date: Tue, 24 Apr 2018 15:11:52 +0300
Message-ID: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::30)
 To HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:lml7jy4MWSmggRRBuF8ExmbE4+Cs+zoVWUelMFKGptGH/jPEX4T2kwC14i1zOzdEkajfVdwplFgBl5kMro+VzWCfn0A0MxJ2g2yxTK6hXVUqKtV/wQRZYN8hh+369wAeEq+2dRg8/TYZSbjqxYVYLDA7Wkr/o3bRh6F5o6DvG3ib3dfxkF3DsIGM++2SF9C0TwXJ2pF2Dl8yw9x5wAKApKjko6v5hPahxotGsjyYJhW2onlHaESvkzcLt/nT1Ix7;25:zMmjnmyB+7qvair3pNV2NfqsYwF1DYGzHr0L7CzkT43fTScZ+DL86Zdiq9ziryqLdvsM9PuSi9xUICNUnyn6iqvI9zhqoUSYULieflpqVSV9S7820s48NHN+iUbqN+AHMTUE3f+KjE49yO/1wc+fs9kvBmktn9F4maleIaJfyCBvsVL9L7Z9nPLBYapBKivtN3RTZ5xVdSGpS4jZvwTcdowP2vIg1z6j4DIWR23oi5gbTVPB/hGq+DC84/uVdMxLLQWIvmh8qAx1Es6F4wITWZzB/iaUnIruhMCbyMXuOi5+sA1EXA9ReIM2LMiowPDOPisYqw5wU/6TUkHu4M3bOQ==;31:sbA1FKxYNBxPqO0QSpC+Q0x76Oy6BVQJzojnUcZRaJSawOolV4Mo8nJsDanSuuXdrLlsuk91o8YH2j4y4GAU/LWVKkqyJtjXFxS6u7lp8sbohJkpeq+ozlhq2i8QlViF9+F/cCtG8+/8NkpfztJ+nKbIbCUR78mSUhruERq54N7p2HAowSyglgrrSFD5VO+OT+YcNUO7CtTdk+DEeEzML9lNFivjtKB5quMw45QusDQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:f2V5AzTUTjr39p+1i4qtVRDG+foIiUrp2IkPlW283Chkhk91KuQydSqXrlHFhBtlaiZozcXNGBbKquAX4+OMhykSKD8rKs9yJOUhqvMe1i5AURNoub2Nt2j+paTTdvbh8WyXhgE+qeB+nmUeUNSIcYAcgunVFJKm92tBaSl148AQig6nRruKGwRhCAuLHNgBHxvahLdr7rjF0wZl3kp8qpZS1I6NLiY0XTCRhN/yAY9W0A5UwBTb+BmWo7+hw+PEyc8EVPrr9eXwYybFUg4nRuSkOGjd82vEKczCXAPZtaVt7EmOUSPW7SgA93OFdXROQNYbgbnSGyq8MwcFZLYGLg5LTo/16vforFCsaBjia29kDxfcp9auZs9Fq1Zz2HdLjEaaZYiFljLTAFBbQcQPj4ZtAiL2rO7ntW+n7hBZZfZaouO+f8VqTepL3IUTzphRa9SrI9BJKSGjCr5g9M0R3TeXRYCsOvBFzlpDJOuYRhOlmEN2jjEUCupQ6iAAwVCt;4:B0j+SvtaGgpyDMq4i+9Tki9XlcbR5JUJ864Orl7WaI0VJfd/G7g7/iRdQKyWZILB1zJuJNcc6odslexZ0MLIUwnmSRm+XCRj46Z1uOfbmBo3wBPxw25UJ2Py3LLpAwalU+jvplq0fjlNyKd/U7xp6Oagfghpsv+hNwn5a5uv/5W8Sv0vR+LlWOeONdu8NjU1/0pgk1hQCUdLNowseVS04LRezwrQY6C95Hr3+w6yyzqy+Voni8xPM4b2rYgFbkCMNh41A3o6iRlWHk3FYjODLBOkDHPl01LWJOPvn1dlFp/MJgLyTaF1m36aX/MRd8z7
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13373B4470261EA96C2482E1CD880@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39850400004)(376002)(39380400002)(346002)(199004)(189003)(105586002)(6506007)(386003)(59450400001)(9686003)(55016002)(33896004)(55236004)(86362001)(5660300001)(6636002)(2486003)(8676002)(956004)(52116002)(7696005)(8936002)(81166006)(486006)(106356001)(7416002)(81156014)(23676004)(103116003)(478600001)(476003)(3846002)(39060400002)(25786009)(66066001)(186003)(61506002)(16526019)(6116002)(305945005)(53936002)(68736007)(47776003)(50466002)(58126008)(97736004)(230700001)(2906002)(316002)(7736002)(26005)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6eURkSDdCUUE2SEhvWXNKUFpOMDdaSmp0?=
 =?utf-8?B?NUpXaEpKSDVrWTNHdUVTWWdCVEh1Ujd3aXlTYWRLRUN2dGw2WEM3aGpNREJ3?=
 =?utf-8?B?aXgxVmRWaGZKZzdlTVoyMG5KSHRMMHE5SW5lTXdXMUh2VDJKNk1zU1p2N2pi?=
 =?utf-8?B?US9ZTW5aa1psajVIbUVMRmtmc3NFdW4yNzF1THE3WUZBVm5UcWN3NDNUdktE?=
 =?utf-8?B?a0xtOXJSWFhkYUk5VTJJbCt4YzZIeld1M1g2ZFRZN2prcm5ybWR6eFRSOXQx?=
 =?utf-8?B?OFB6UmNubE5aTTVJM1lJbzhPV1BXN3IyaFZOUlo3MWhUSi9XOVBGKzZlNUhC?=
 =?utf-8?B?eENZN3NrOHZWQk92emFibHBrdmVMR1R2anFkMC9XdUp0a1JDOGNUNzRDbFJa?=
 =?utf-8?B?REJiRXB3VkZSOEdjMWZtR3ZhYmZpdDF5bmJpdmI4QUhQdmduTHN6RXRIaWJW?=
 =?utf-8?B?bVJRcWpRWjdRRkJmVmgyUVpEbXBSOGdzb1ZlS0E2V2Jpam5KWnpQejJRbXZ0?=
 =?utf-8?B?b2NqRzkwYlpoa2U4RzJrOGl5MHBuc2tnSHhZTkNTU2pUV3VLT3FyWDd4czZv?=
 =?utf-8?B?VzVNTkZ6ZmF5cTg1Ny9WZ20zcHg1bE5XS25KeVJWUEYyTXlCNUp3bEd4OHdY?=
 =?utf-8?B?QVZoVk1JaXFRZ05FRCtvVWhkQmNnTk45UTUzRkRHRUo4N1JLd1dmK1dEQkgr?=
 =?utf-8?B?SGlWUTd5a2lTclFiRVEzS09tOFhnaTJ6aXd3aTN1bVA3c3FXcVJ4Q1BYdjh0?=
 =?utf-8?B?WEdhZ0k1dlZOcDV4WGZtOVpzTUZMbENsTFNHbVBSM1d2MnlkeFo4R0hqejI5?=
 =?utf-8?B?djlYTEJwMEY5ZVl5WGxNdVltelNWMUtDV0NyenFXZUk0cFFwUCtqcitnL1JP?=
 =?utf-8?B?M2YwMG11YWNjOUppVWVaUEo2Qko2ZTA5b1RzbzBFNUtUYlN6anFPWDF4bWhT?=
 =?utf-8?B?WTBWRWo2a1MwY1FBNm1FY3JPZW9JOUoybC9DekdEaWYxUUtFSW9GdGZoLzhp?=
 =?utf-8?B?cFYyWEQ1RjNDZVEvMHBEUG9FQm5uamo0ZTg5ZGE5Mm0wRHQzQ2REcWhqUGh5?=
 =?utf-8?B?aHRFSUtEb3ZuYWRPNFJGdUNQd0FZQnRSSUV3OGxxbTRIaEdKQTVWVkM5akk1?=
 =?utf-8?B?ZDdVckUxUjdmSTU2VFk0d0ZlV3FYWXdKOGsxbU9vRXhVdGZ4bXhSdzlSNU9n?=
 =?utf-8?B?QjZMZ2hKeVEyMmtWSG95cXp3bjJ5QUR0N0t6ZDlWeEdYT09sTEU5a1VjUG1k?=
 =?utf-8?B?U1lRMVdsRmxiVjdFSmZUWlVYOGJMU2RvcExvVmpQZUlrNXE5NEVhQ3o3SGFK?=
 =?utf-8?B?VC9IT3FWR0lWYnRCd3pxWGk5YjZMMkVwaVFRK1Q3cURsZXRUU2djUHQwdS85?=
 =?utf-8?B?bFZtS1hMUlFIQndMaUVpK2JoakluOUJ1aytKVDFJbDU4U2hyNC8zNkt5MEQv?=
 =?utf-8?B?Vnk2V1IzdjJxSDBabGkxbVJlbVZBUUJGUko3eEFmT21Hd0tSQkhEVk1QQkw4?=
 =?utf-8?B?SVlJR250RWVkSXE2YjZybC9XM0FRbDd5eHJrdnlwY01uSFUxamd2VGdBejdD?=
 =?utf-8?B?OC92V0QrYktnSDZ6eFAyMnJxSFN6ZXpITGp1NE9TQU9uMVYveEMyNjV4bTdY?=
 =?utf-8?B?K0RFVVFZYnBDT1hVZ2ZseFd4SmpRb2k1dlNUZElXWkZvZ1FiU1JxOTg0RWJi?=
 =?utf-8?B?b09nT3VXMXB6a200cDhOQkpjNjdPdlVTWklaUWVqbHA2M0VLdnF4bm9Pd0ZV?=
 =?utf-8?B?bVZjVlQ0enpzUnpRMVVlQTFBPT0=?=
X-Microsoft-Antispam-Message-Info: YERdFehP7qZOIASwJgA4vDBhinDSFy/jIK4HmMIrlwRg+5s9JyjFwvAdxlMWdBHyZsb0Awt9hmRc3D5Xf9Er2bLyh3NVseqp0qzwP7YRQBXLX6ZdNDkS1sbQBMisnkMYny480ACpY3BMOe7OOWAxaScg+mWozdA6neM7T6MHggbVf7Qgtnw4jxvFDWGhRtGx
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:QrgQSTN7AnNjMBuRaMPkdumoFl3BpgIR/g9AoHYBcuHmVb2ykg7EpJ570GL6jvotGd3wWWL49vtT13yDjoPoKjmvz7LBIItJRhcp9aDhK/SFb2ZLGHqlFEq3vOy/R5l7pwBS3hg8ynpLJe5JaIhb2MmBDx0RzNsFC70RpxqGEkrOMs5KMljB1t/ll7xLXXhfR5y+PuuqvjCUk+dbGkAxkSAzf9ONYsjuoDmYat2fvjOnetLrOwDS6J3vAD+ZuL9iVF3sBw5hLMGIOlWlJcleI/bu7wHtzGUcbY/JiYsby5KZNYSdlWF2qruu3snqqswQQaWXfWw8iSKW6AnDuPHMkg7hr7rvVRhX/gQ8mEXEDetxf4r9BSpZhjAiazprhcf0qbbSyAn9hwk7AYNFnK+SIrqF+x7UGBsr/puf2Zt13PEOazmFOXpdRi65VVY9LKpDX+43p5Os/slCKSXy+iMiVg==;5:E/ula8K+EwJ4KHzjrw3ih8glGrYcpMKL59z1NNZVQUapu9LM6ZugniBRlpGt69O3C+Wp0OxQ6Ox/BBtm2vbGRDHFZrthMiSRgCgsPih5bOG+lwW4mdYyXpi/J6tyh2MFRP7OjAs+RrxD3HhrEDz1ugx3aWY8NY4o6lnDB9OMZa0=;24:y4aNqq6cxVFeq2kzSj3EqXqTPSwQHJxTbwgaF3PhQHMSmvNFci0uWbrmhRDrW4Gusl++1CUEcB+mGdqORoYMuR9G0cWf2eM7h2EOGBFI604=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:kzkpnjCre+kE63CRzH9zE3wGtVdCRjjNKPumwlg9JYM0ZWdvt9Wuihp2sDqM172qxC3wWGcFGbiMXQ5dMZSSIN1D2M3ef7cP/Q3l6FIikDAesZNzXJaF7jPyQjL4ZqsuB6Pas0mwWu2NmAQ7yX9cuVLkCrkYyMSOHMABm78irsb85KoewZGbqlxQPhXi9WlvQ7a5kLHoCLh4bJUAQYPwYvh9CL/jHEtiB9EDmsDBfNz/yQsb0WLprBQ0GePQcx2V;20:4ZfbaWmNAvtZTj8JN+wlgutyk5OUJPbqckqdSdRreXR6NAkHkLydP+GryuwvNBysKpWJbU1f6kEkoPg6bpMyYdahFGHtDUXvGc0fh8aU0gKpEQtatTbT4WMsWuFcfnIqHBOwjvlfpM3yUUnRBon8UcTH96g5erZ5pEnMSsIPyRY=
X-MS-Office365-Filtering-Correlation-Id: a6c33835-1431-4595-ae67-08d5a9dc925a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:11:54.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c33835-1431-4595-ae67-08d5a9dc925a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629524421123569?=
X-GMAIL-MSGID: =?utf-8?q?1598629524421123569?=
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

Kirill Tkhai (14):
      mm: Assign id to every memcg-aware shrinker
      memcg: Refactoring in mem_cgroup_alloc()
      memcg: Refactoring in alloc_mem_cgroup_per_node_info()
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
 include/linux/list_lru.h   |    3 +
 include/linux/memcontrol.h |   32 ++++++++
 include/linux/shrinker.h   |   11 ++-
 mm/list_lru.c              |   65 +++++++++++++----
 mm/memcontrol.c            |  153 +++++++++++++++++++++++++++++++++++-----
 mm/vmscan.c                |  170 +++++++++++++++++++++++++++++++++++++++++---
 mm/workingset.c            |   13 +++
 8 files changed, 410 insertions(+), 55 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
