Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvA4r2rc5VNGEQoNDi9cuccejO2z9CDn9fsRyRk7Hxc8x7MDdqjUU3YhN/J3IFxDytnSzfq
ARC-Seal: i=1; a=rsa-sha256; t=1521638589; cv=none;
        d=google.com; s=arc-20160816;
        b=F+QTXLathXu1L8nmAUGNxf9nCQIYZff2B6D2ZQM+gyzZi3iIz2/EOdFyJdauicGfdX
         zExgTrALHe2063THUl/L1zIAwhvNP8D5UNlp/R4h1COTWTE81rasOUGocnO03AGpg0xM
         Y5LiA4KVtoC2oOfjslvv2n0bvMhLPdI3dqs1hmT+jsaEPDB3ZMMu7WXsSEZ3jPSdsEPV
         akL9cnq+GVdpOtcbQmleoiydsoat2eCy6zWT31RxQal0W0QgUpAOlIOHqJU4k9rfrZcA
         Sz8mcPDwT6MMrpE63kI4Y6rD1lLQwl63XC7uW5kcV7VHaoZ5wwwoQfagB1IAIbStUtmI
         h/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=pHnP6UyFAYuYY+17asrxmHlPbsqIn2EiLQOcHvvkucA=;
        b=F3sArqPdC/n/1hOidejf/ePJOXg0hAGO1AmPINlnX4GX2/dOqFS/JG0eL0odkIJuFc
         AC41DVkberdhgOc7wz1JNmVbGTz9B6NNbkmNc9TZ5wWOwg1+i/GJEDH0Cjqcu3CEPeZ+
         AeFOkXusZ+f9Lnn1whrUsxC+sljUp0oWd7c7DcvRhFNlsfFULF23P4ey/4y3lb3naA2o
         apBQzfccoXo1HUWSfl3N6sm5vIhHSjTWGOJDXMicu+bzt8ww72eU/2FO3+34q2yTaXN+
         FsUuGu79vhk8VO+RDUnLBwBFPSrGZ4L4Ps/Z6BUeWpx46nkR/xRoNRsmURt4xLWYk/a+
         zNfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=W6hX3zL2;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=W6hX3zL2;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 10/10] mm: Clear shrinker bit if there are no objects
 related to memcg
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
Date: Wed, 21 Mar 2018 16:23:01 +0300
Message-ID: <152163858159.21546.2876185232270486710.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::23) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92fae8fe-89a1-4317-0084-08d58f2ee188
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:zWjubKPYCx3pUWu5+yHPfSmz9qVsISPwtw/nDmAqlOWVcQXgFHfp35pLVOEIxM/cByIwXwsGOI4Zi3q9S2l4xF2Bkc7AwpUrzQ0DAgk6CAjD6PR/GqARi1SjREjxkQscsfeuRnXf/VjOnFITHNlS7Q02rbMY3y6zAUgC5lSbMWIOK1x2PybxVQEkiZ1CfYt/PNFWaHHHkquuBoT5TqVl7s2b2sH7emMHDwZeM7sERAkdo97eKrLyAswzQ9knulqt;25:mqoA7esL+I70SqonTEpW6xtkjNZ+gbPUyCOqJb96Kum0hxOwYG1AlXa9OuaKd4KOP6qUXsLgjCaF1gsOR5+nFjeE7jABIIQ+GKDzoGt3yLzicb3temewlV5xJTdzdo7UUFvHvkEcKDKjxw7pn/jLLo5lHAvtWjcw/76788yASF0pQDdUmdQo31UrcyFh3/r3EgKl7U40QVGHV2DbU6XraVOlKmqAcJunQ464dHkwnxkmFxMP+eY6Kl9XxVqQLb34dbQvz7L0873bkShzecjXaVcPN/T2Cft7HZwbvRuzmXOQGhbsTFjNWWkzSMIF4kUbXncf+L6ceMMk1BF4rFEj1A==;31:XhsqQC2kC6ILcsVH9+UA2QysDzk7tosk1mZeQt0p7kdpqLkEwNC/jBvzYi0jAvP2vqsDH4eZ9s3yIwqlu/khP6QOsKBBqR+eIk5Df4uherqHGued6uG3Ife6Ai/dzLuCnjm9Jx9D19pp29oW39IrPZYRdnZ7PbOwUxCAbfJi8ita93j2mxZMvGvICwm1KlnvU672HmevTTjV8YlLUIt3tHXv0fgJaiaw9RO6A7bMc5g=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:VuPzW7HNactqJc4kVyy27OG9EgK31CDr0oU7+GjgONsJ9ZwX3IKgmFoxNZwpPE3/Xbow9/iLXDORPg/bjG8GIKSXQpNx45FsKzw6f9j02P40mDpEX1I31O2mUJNraq1A25ImUQ46ssx2szulzcWbZCoOEfUsZugmuUHVONh99Q9ox+aoplySeMuRZTcsVlTqNuXmbkSBbNjCh7XlyjaX+6vdgGTyrMr4ZBag2dRDhDKCHimd26NB/hzoGHLFsDZfsQ6cUhynIMEHUzyRM9/Frh7Kk5UgLFK4qCJFbG8hWu2PU3pWJ2c2I4bNgj1ZLZqwtNFu/pycnHdL1IlNT5bEOQeUKbKwSs6fpJtBPjYpKssxbVqm97gDSFJN20tGcYKDyxZgBoMKrWRybNrQv7LxU8+HCNd2dAY+WOrqS6K0RR+vdz+95PNNamMgsI00wRLsk2/SdOdvmL10Lgr5lvEc1QkTiWu/wnB15QgHYnzeKQQFdENuIyxcGgxdkHRJHOOQ;4:ayQDRw7MwhnkPiJFrkL1HIUj/lXZ2oPf1jg5kBXh4MUIKLCMNT/rSlA+AiFxVYwKgVdpj4lxPlj3iHLOBWukeiddYOS8gnHkGXh5Ax0+rhzmj07uaW/k0rmZDja3jLQsSenfZF9ul38HO1ztYvhWchuxMjws4sAKZ0j1Ayioef78r9wW+pz8zeguyGcyuBkWN2ptTkEo1H7DrKTNJQ/IHCT1V1IK2Csw/pKc4TAu8KMGWkWIZ5J+HklsAuzk6xBrxKDF+hjs5fAqO1OlP2cPNg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133502F54756B773413384C8CDAA0@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501323)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(346002)(39850400004)(366004)(39380400002)(376002)(396003)(189003)(199004)(68736007)(23676004)(8676002)(58126008)(478600001)(2906002)(5660300001)(105586002)(81156014)(81166006)(386003)(6506007)(55236004)(47776003)(59450400001)(6116002)(66066001)(3846002)(8936002)(26005)(16526019)(186003)(97736004)(7416002)(76176011)(39060400002)(61506002)(2950100002)(230700001)(52116002)(53936002)(55016002)(575784001)(7696005)(2486003)(25786009)(9686003)(305945005)(33896004)(50466002)(316002)(103116003)(7736002)(106356001)(86362001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6a3pXbDVyejlUY0N1YzVseFZRbmdONmJY?=
 =?utf-8?B?M0h6M3JSMjNSdGd3Q1BSMTFNS2U5MlBBamFuRlBrbTN0U1VyNk1UT2ZWY3oy?=
 =?utf-8?B?ZDd0ZGN4eG1RYnM5QkNKNVVHSHNJdjZFYUE2UzhPeFFqZE56UzBXQmQrNmlV?=
 =?utf-8?B?QUYxU0JwWHJUTnlWakVoUDNhRnlVaUY2TW9TMkIzeGh4RGtvdklOakVyV0w3?=
 =?utf-8?B?d21VR2NHN2Z2RXhjNEdIVVhCYkpGamo5Mm5mNStxUDdONXFTcHZJYzVxa3Zo?=
 =?utf-8?B?RVY5cHBISHorWGtIZkdMWUl6V25Za0lSWmFZNFVjUGxMWjhNaHV1OVJVUW8x?=
 =?utf-8?B?aE5FMVJReGdvU2hCL1NTRnkwd0wxb0d6TUVkMk5oV2ZWNzV4ZTBkbEtCNFNr?=
 =?utf-8?B?UmdyL01FUjZaZ1NkWEpGOTk5WlU1QmZBZVFBczJsUmJqU1ljcnk5Q0ZJWkxw?=
 =?utf-8?B?OEhiTGpGN0p2M0VTU1oyM1cvYVQzNGF3NmFlVzA1MHgvU2JvWjl3QjQ3Snky?=
 =?utf-8?B?Q3RsQTNETks0YnViY1ErY0pIbXRuajZMencxcHlIbTFVL3FJNWxBRzRod2xm?=
 =?utf-8?B?dUI1ZFdKd2doUm50bEIvdFl2TUZCczhwYTVNTHpKYWswWjhqcExpOXczUVB4?=
 =?utf-8?B?d040ejhlZklMcUZaUldiUCsybHdBMFNqUFhLZGpHekVIcGFsbzBIWDFFVThT?=
 =?utf-8?B?WmRlUmttZkNuV2xOVlpUSHVFSVFtZEhxMFZERTNJWlZFcktnTWtVZEVOZS81?=
 =?utf-8?B?ZzcrTzBBVWptRldTMjkxY0ZUejMxVWtvN0dqV05ZR1FiUHZERGx5NS9EY2Yr?=
 =?utf-8?B?QUdRYzd5S0Q3WjhlamtkS1lQc08veElsdG1FZWV4K3cxODc4bnM0UTl3UlVW?=
 =?utf-8?B?WGZkWWN0WG5tWjVxNXQ0OWRoZkF1M3VXT3FvOVpPcEMxTjdxM096aVoyWnNZ?=
 =?utf-8?B?VTViT0NuSDNLclJENGZ4N2szN0lYUGtiUGlRM1YzcDNPVFlHQzJ4a3QyU29h?=
 =?utf-8?B?UWRsa0dGa0M0WWhNcDQzVS9qeC91MWNTQ1FJQVpmU0hvU1RpL1FpUkQ2dUxT?=
 =?utf-8?B?RFQ3ZWtwTXR1d1FabTd5eWp1RVdadkhsQXF0akVCNzVOTGlic0h0aFBORmx0?=
 =?utf-8?B?R1gySVdZRlZhUE95Q2VOSHFNZktvU2pPbXd2anFhSTdnUGF2QzBNRjZ1eE1X?=
 =?utf-8?B?bnlvaTdYV3gycnNoOG16TkNqSHNVNytKM3NqSUdwTy9teGh4RDJDSXBaUVls?=
 =?utf-8?B?Wk1OQkpEY1NxQ29MS3VhVE9XNnZtaFRxOWtaWWl0bXRUMjBoMTYxbVRCZFRn?=
 =?utf-8?B?b0lVTlhiRzJvdU5zZCtiRzZPNkhlcjF4UHd4N0ROU011ckVzL2dsUGN4Vmox?=
 =?utf-8?B?elEyOUttcmhhcGtlaWFLRE1Hb2hRN28zMDQ3VnJFK1BoSFEzYnVNQXJuRzdl?=
 =?utf-8?B?V2ttdnNzenk0ZTJkdHh0WjhSa1FZNk9WaHozbGJrMWVGaDhsQks4SE9kMU5y?=
 =?utf-8?B?SndiK2dvRGZCNVgzTGl3d3JPd3JwZTEyNXVERDZnellYZE9XN3VCamRlMDIz?=
 =?utf-8?B?SUROSHFtL0Q4TWRzQVc4K0JXTGs5TFhOczJMSng2OEJmeDZ3dlZGVzBJazBY?=
 =?utf-8?B?UkJtZnVHUHVtNU0vUW1QVmZEUmliUGVhWXFEMDRsVVpyYWQ5dnhXRnJsUzlD?=
 =?utf-8?B?dEZDMFdleFlrcUJqTkRZOHNUUDJYK2JoT1FKTmdDVFVtVlc1aW1xV1hpcjNz?=
 =?utf-8?B?UWp2alJGMXArQ0JvS3E0ZDNianlGbjVOTE9tZi9iZmp2RHJrbE5scVVvSUx4?=
 =?utf-8?B?L08zbzNSRjJ1YmRJRWsvMllhSE55RCs4UnNqT0tMdzhXRE91aC82MVVHZVlI?=
 =?utf-8?Q?eV30tFaiCAwms=3D?=
X-Microsoft-Antispam-Message-Info: c99N+kaK2IEuaEzmrIt52JPU0qFQrunYxQTRU9zua01a9xNA/01bOnV91H42LtTrnLQEAANMKTAiuawqdGBpkH3ZLwuJqA6OzCSxUWfwja01Wg4HgBsze2XwrH9WsZQF9oql4rHtOD/6RLUnC1gbnIgjf6wepL5+g3xxsifhXe6D31DXt06ATo2GLevvgiaz
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:xsGEsOwfWlHJ9+uP4l0BYJ6XlAYDSeXOAN9hLrhQ+U6UMJswJjLQcgwmo2JZcGf0rd91p76QAxLF3oNhrCCaN6I0s3Aan6rLh4MMtC6j5IozIS5IYmRM4WowXLpea8Q1BG4KrAt6olZNgY4tl4tpZz/nhBuoHyiUZHyGcsB9Ykv2gGGJ2ksik/Eda154q9MrAr3AXVf+xAOe8Ab6BI4DuuBKG9ya+iLvWpLg/73J3ejVLa1WZ2GM+/Xa0l/n5jBKtq267/zUCNw+AYQfpyI9tT32Elm910NEt7P05S/54w9CB5vD3cK9JbqvTwvrVXsGmKicLjMYc41Kkj8J4T4T682V1dZWN4mA3WGRnBY7uvk=;5:6dPJJUzEao1gp9NUbIcEuJobKTRwKnjb8XCkH3e0FEaI3C8ZItAu8xrk5Eh0xJwpcZPCaQfY/foCWD3fnu1leLEDdSDUXmynP/9sv6Vy0eCwJ8fuTs8p+HaWnOY50jsas8s6b8CNNsLe7bHFtlRGa9krFG3tBewYJGY21SLGuLc=;24:UL5+Gf2CIhEiL0cP/eWFkOSHjTENrufT7KXKYZ/0OniS2+7sonyxPIkTv7oySd1GWy77cpRh2YTZaBImNYdtIj9/Z2FTNUBeiC2ywvBgA98=;7:/7BhOk388eiKhk0bA7fy1NHNuS//dHg94I3se/B1LMGin5cV9b/WZ/K4nA5apQtXiwx59Q0bgvKkly5QLJOLuk4ByicnGKPAElXlOYnRZIrXbhgeYmvCZ6myQD95L82OmoTcvWhLEuXcEZK0V2gdxxvCrT1TSi6DqFS1Eauc+vGXqfa3jA6z0cuguyyhJ7kj/vU/fPYXdLglnuNORUmP6hz13XDIqiLLU0M/X7I4J3y78QFmXxa/UHPerMixvg7r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:gU2eovfvX7nFAlmkB066KwumUEsNH8E55gZ/Lfb7hoyqsKOCgaCQOXDaa2nYV79fVHNqA7ys1z/otVfJ52v9rWEXxUclQY1amIBzC/LQPBWbVTgH4wXJ5W8T5/8yEs37W5lqgu6sOC/VqWhuFmofU7BuJEuQU7tgh8B0oKhuVUk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:23:03.9877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fae8fe-89a1-4317-0084-08d58f2ee188
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553705818183633?=
X-GMAIL-MSGID: =?utf-8?q?1595553705818183633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces new return value SHRINK_EMPTY,
which will be used in case of there is no charged
objects in shrinker. We can't use 0 instead of that,
as a shrinker may return 0, when it has very small
amount of objects.

To prevent race with parallel list lru add, we call
do_shrink_slab() once again, after the bit is cleared.
So, if there is a new object, we never miss it, and
the bit will be restored again.

The below test shows significant performance growths
after using the patchset:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done

Then 4 drop_caches:
$time echo 3 > /proc/sys/vm/drop_caches

Times of drop_caches:

*Before (4 iterations)*
0.00user 6.80system 0:06.82elapsed 99%CPU
0.00user 4.61system 0:04.62elapsed 99%CPU
0.00user 4.61system 0:04.61elapsed 99%CPU
0.00user 4.61system 0:04.61elapsed 99%CPU

*After (4 iterations)*
0.00user 0.93system 0:00.94elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 80%CPU
0.00user 0.00system 0:00.01elapsed 80%CPU
0.00user 0.00system 0:00.01elapsed 81%CPU

4.61s/0.01s = 461 times faster.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    1 +
 mm/vmscan.c              |   21 ++++++++++++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1f3dc4eab409..788ea4e6a40b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -133,6 +133,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 24aeed1bc332..b23180deb928 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,6 +34,7 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e1fd16bc7a9b..1fc05e8bde04 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -387,6 +387,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
 {
 	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
 
+	smp_mb__before_atomic(); /* Pairs with mb in shrink_slab() */
 	set_bit(nr, map->map[nid]);
 }
 #else /* CONFIG_MEMCG && !CONFIG_SLOB */
@@ -568,8 +569,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -708,6 +709,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	if (!memcg_kmem_enabled() || memcg) {
 		struct shrinkers_map *map;
+		unsigned long ret;
 		int i;
 
 		map = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
@@ -724,7 +726,20 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 					clear_bit(i, map->map[nid]);
 					continue;
 				}
-				freed += do_shrink_slab(&sc, shrinker, priority);
+				if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+					sc.nid = 0;
+				ret = do_shrink_slab(&sc, shrinker, priority);
+				if (ret == SHRINK_EMPTY) {
+					clear_bit(i, map->map[nid]);
+					/* pairs with mb in set_shrinker_bit() */
+					smp_mb__after_atomic();
+					ret = do_shrink_slab(&sc, shrinker, priority);
+					if (ret == SHRINK_EMPTY)
+						ret = 0;
+					else
+						set_bit(i, map->map[nid]);
+				}
+				freed += ret;
 
 				if (rwsem_is_contended(&shrinker_rwsem)) {
 					freed = freed ? : 1;
diff --git a/mm/workingset.c b/mm/workingset.c
index 62c9eb000c4f..dc05574f0a07 100644
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
