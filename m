Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELsVUNr0uZNtqyVWdtC2EkzmXIPBVoIJP5+JXijdIkBOSj45sHGQs0KrRTApL3iu46kOP3kp
ARC-Seal: i=1; a=rsa-sha256; t=1521638570; cv=none;
        d=google.com; s=arc-20160816;
        b=FOC86So0Z+etk2SHGATUpxkYuDDo8gmXGz6Fk7TkUwBNhzUXuqr1NyTR4qhvpULCDW
         Ln6MSmoMav/6OLnvzonsrfyid/mQh4codIx1A095xtRa1bzK330bi6VRPO2L2+Xxy+sD
         FjB5vNw4x5gMeot+a6gEhB+PMYbp004bZAyjXVWA8r9O+9xWt96XEv1INse2baQ1kEJm
         SPrb2GGmheKMvscfmfMX327hrndqIk4ECMHGS2bSwnEt8DV2BO10UVvwnS5O952zbdZC
         LHjxwqri4ut+H3SdDZ6dgtIZprJJ/MNV+BKqRCQihysPI3pBdJkCAHE6C6dBHLsJSusO
         M2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=8ooVY5fTFdVIIcPXufCvmQMVgbQ1nQ3F726GUyTKBr0=;
        b=TpJYIbjLRfn3t/IEuZdwabr5h74fKSh2TQSye1AkanZVabOZhRyyN6owa8D4F0zKlf
         VDycDDjcKie5v96h6Kjpv7fuYwyGvT6yB4ZNEtDBDBQ/HQbL510PqgnDisLVqaPytTyc
         2a0haR60HXaTl4spvuq0B8bI8wQEmt3AEaFO7WJFkiUAftf3BOsuQaBBk2KMGOhDNGET
         nP284twqnN6DQxNexNwPGrS2D1rBOh7Mzf67U4VKuMXCXYq2zhIQJF7ISLSpL1pB2Vxg
         dNatv7lI0dhjlQb+Q3WFzFQugqnhP+nayT28rOclHhF5drVYVT3J7zzxIiwZ4DDhU9o7
         Wvxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YZPB/dO6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YZPB/dO6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 08/10] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date: Wed, 21 Mar 2018 16:22:40 +0300
Message-ID: <152163856059.21546.11414341109878480074.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0050.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::39) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481612e6-9cf1-4c9b-4f98-08d58f2ed5d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:R5QuY4SyCFKdaHfAc59qckhIb1g97A2quYwa5XyKHzi9x7/clwavpjGpKMFM/ZgaHB+wrBps9N/eiZZIp99zmDhhDJMRLQxesfLQVbf1Fldi+bwyTTClKeCWKbTZmZ4ktt2UVwuFg0QIlgQYOgCiMmHWeQW90HtHYai+UaF8oyL+1W0yuIslLUCWC2f3KfGsfE6zeLxa86nTloawmuRBrcU3BYNc8mPrM0RGhycN1cQ7hHbOAMT1W1eOCdCB9+7v;25:z2pIO5obMWigAZ9h3dnLdjCYsZyfc+rp6An0cSDQH9PLMY9m2mPygdYtxsNEvAenyL533omqWsI8MWdY/7ntvGRR4Yx4OOix19iwMLPp1yelgaK8RQOv7KznW1HQQF/t5c83z+PU9s4foH0hmKEy1aiON5GNlHk+y2bWbtR9jFQy2OHBYMJSNhNGyJRYs87m88jSazjraheYofMJkOz1bD2x4cNfcgo4rIL54BLTnkL4UkQGgxri7kM3MtfYZyvBI0k079lU4kHKU5KAMZVBNW8GoMmMEna6F6yojsphEecVdDXsCb4q014BirGdYwZiWXMslOBITIyQ1YxDWSLGBg==;31:jD3sXnfBqHpl8tpM/5d+CX+HNIcoOgkdk9LcFlAOEc8SVtq53HCkAgRagn+KMNREprCNLe/9okcCLG6el4Xl0eMFXDm1wsy+uUQHM67kFZTUB2n77wzDJVhdAm2h6x85LD00hahoW8JK11e03252VzIOabofAektYU7eLi4Q6dLyjn4AJ9GSNVDG/SSBw/hEs01QRvbQjrmxI6O2tHpPpEbSL1KH9tPJHzV+GlzsvJk=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:dL5eRXlwMvVG4aSLY/ecrU+SuZjUQNwX1kxmaNYdYtx5zmqf7r8l+w1FOuXdk2fDuulgMVEeeb46GkXVvQXt8BDedEPOkZ2poWoewMqL3HGBbW0HB+GU5fbp/bh5X59YR1eNgk0bkw+/H9NaFDena88FtutTxf4cxMQuJBAxVppINwZKPKQsCeDXLFdOdLDc04rjcJ1CdjZHGzsQ7f9TRc76+ryV6Dqvq7oTAxFirIEWKdUlMfEui1eT+VuxXHjSeUyn7m8hRRNMfEWOk01AqOKhVGEKwgCEA74FRmuVf0A29qTd8SJ9qB62qK2I1iIIy8Ey2ie4zs5NSVzzsP9ORd5tzM3uVsP6erLAHWU8SsmZFTe8x+5dzQc4eKTcBXYOxqSXtUrlUAU43hP6pn9jiMb2Nbdl8Ifbbr32ai4DiKYjun8bJzHNwyVrNmEDW1Ou7GNvyr2JR6awBHVPiqxWz4v26HO1s9creDIC55OS9RRJgsF3khunhrgEPKzUyXlv;4:zjIY6kIAqQgsrK0OLP1f7wWF3dskWrqXQJA7VVWuhne2PTQ1n/mFu2PX9dl4gmNxaPTnH2M1hWM5gcdvXCNqOdjTq6rIXfjA4BpF6KoWmxIMIOIICJj1cKfMwpB5J8A+4Yh8q9ETq+Q828lAasJSOAAu+7J3JK47PvP2TENCnhD19O+uqHDEB2l261wKPm16g6kHF65EfVEKn4iRIhR9Ey0CAH+ogSXR51gTZA6bEi43NpcpAxRR+FpOTofB5sDVfnTkap5P8ApYlvFp3lXC3A==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13350293920B3BC4717A41DBCDAA0@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501323)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(366004)(39380400002)(376002)(396003)(189003)(199004)(68736007)(23676004)(8676002)(58126008)(478600001)(2906002)(5660300001)(105586002)(81156014)(81166006)(386003)(6506007)(55236004)(47776003)(59450400001)(6116002)(66066001)(3846002)(8936002)(26005)(16526019)(186003)(97736004)(7416002)(76176011)(39060400002)(61506002)(2950100002)(230700001)(52116002)(53936002)(55016002)(7696005)(2486003)(25786009)(9686003)(305945005)(33896004)(50466002)(316002)(103116003)(7736002)(106356001)(86362001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6NnFDazd2YUFGT2hSakZHeUVMd2p4QjNu?=
 =?utf-8?B?aGpWTlFMYTIxcEJvNEVJQ08rOXN0YnJWeGw1dHdOUlBydmpVSWszNHJpcmlV?=
 =?utf-8?B?V0s5Sk14b1Jva0JNOFJSbzBwRlF6eFhDWGF0TVRIMy9sUHQ1SlBYbjNWUzli?=
 =?utf-8?B?RWp4UWptSEhqdUswdEJ4ZjRqQnluM2hMYzA1dTdnS2FpbDhiTlQrWGdVOTJT?=
 =?utf-8?B?QXRHMGZqSDBnQjRlSXJzL0lmRVgyL0ZnU1pna0krRCt2QmNzc1d1ZFhKamNm?=
 =?utf-8?B?LzdEUHd5K0FuUEtiL2VJWGp6R0hJQkFyRUl1aStrd1BXSlN6Sk05d01uK1pC?=
 =?utf-8?B?TE5IcnBGZ25GTHBMY2tZckllUitQTkZ4NFRPdTUvUVJpWFo2cHVxYTByS1Fk?=
 =?utf-8?B?dnhIcjFaK00vb2pxaXhFc3JEaVN4Ym84RDIxUjNZcDltdlUyRHNHUmhlN2pw?=
 =?utf-8?B?ZDhMbjVka0t5NW5wSnlVYVNIWHJUYXhNaFl5TTBwc2JqcCs4S3JJWCt4TjBw?=
 =?utf-8?B?TWhxd3RsREliYkNUYS9JbXFFSXJtODhKYmZ4bFl6bStmRkFLa1owM3p2Zis5?=
 =?utf-8?B?ZFdQeHNodHZRTHB0VWg5aDMxY2ZleXBKU296RHdaU3o0dDNQeGhHWTZHU0hH?=
 =?utf-8?B?WnlERWM5Z1NWM0dqOHJQZzJWWlRXaGRZU3VHZm5zSlVsMGJMcWIzOVUrQWVl?=
 =?utf-8?B?elltUEd6SFlFeFBuczVnOVl1c1lyVm1tNS8xZURNdVRGSUVZeDJ6NU1aNmc4?=
 =?utf-8?B?ODVBTjR6S21MSm5EUFBHbW5EVXZqVzBuZVMyYXkxdG1tbjdqeEtHOUhLU0FD?=
 =?utf-8?B?RlduNURHZkcwdHVlV0hqcDF5a1BzTGdEVmFyOCtQOTNZemtkeWF2blQrL3dW?=
 =?utf-8?B?SUlDNWpMWmxhOUdUYXVGYWJmeWEyQXEzMTRSTG44WlExTDk2YWZ6aDhwUFRS?=
 =?utf-8?B?VjRkN21pRTBJNWhjQ2xnNzNvSkFSYmM0bnJWWmZxcTFIRVgwd29iOEw0d3pa?=
 =?utf-8?B?dEJXUDBkOVVYcHZEQlBWWDdLUW9kUmhscERscUdRTzVhNmE1aG5FU3dJYjFx?=
 =?utf-8?B?WW9GR2NWR0lweDNuTGJvdU41NWFUaWYwWlZabHdjRGU2OG9aTUV2cjFZV2Nl?=
 =?utf-8?B?VkdFWWk2cGhkTkNJOEZSK21zdzhyWE5zZElDOERHRHRmSExZbXhST3V6MTRH?=
 =?utf-8?B?RDk5MjZmL1ZBdVRLVUlGaW0rL2ZmdGM2ZzBXQit0MVYvUHRhWE5tSlRiMTcv?=
 =?utf-8?B?VCtqUkc1M2piNTFqejNGREdhTk43ZmZ2Y2pHbkd6SHM3cGpNR1Q2T3FIRGh1?=
 =?utf-8?B?VXNTcGgzWUtmUWV4QVZCalFWMm5OTU1FNC9XWnFubXNLUVUvSys3dDdYVTFp?=
 =?utf-8?B?Z3MrWFNnendLQy9vYVBORVkyV2tyeEx4NzVldE9sOFhRRUQ1VHVLcEIyb1VM?=
 =?utf-8?B?dGx1UUk5NUVOL1VLSmpFNUpqNlpjTzNyMktzeUZWenRKUU1nYldMZldIOTRT?=
 =?utf-8?B?MGQ4cHlKQ3dBV0doS2xBOU14V3pmeWNtUWZxTXZRc1NzUVRvUU5MeGR1RnFr?=
 =?utf-8?B?amtaMEFvdXRjcHVIQUJBaUlqZXdGenplckJvdXJ5UW5FcXVGT29RdTc3eHpu?=
 =?utf-8?B?WS9yNzRpdkRSRTZhRWJ2MDY2NWVNN3E1aG1kaFZPK00yelRQelB4VUNCai8r?=
 =?utf-8?Q?fMKJdc/1gi0xdXNV2DXs=3D?=
X-Microsoft-Antispam-Message-Info: IBO1xZFENVtP1COgV45vCkIZVqlb5UJlXoUVibU48fkavI1MlkRWdMlbWlA7A3sObp2Sbj+GDLLNfFA9UCjdHacSwDTZ8pnD8R+3+0HlvU1VxM/f3cmdL8UQWuzu3fSLKTTUs0/j/Afq+lt0qmkrQx49M39Q5gPzKC5monEADI4yOUyeDAWORUd1ZrNwV8YF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:qPcaKKSD/qnWZO6nJ8pbHsXxz8jxWOaZDAx/zYlBu42qHeL2MtIRWHSvLitf0b7u4f8onrJ8e5Ynh1TfQ2h9ZcnBVJYERg1jqyfzU4PnlUr9+quy7xbJ6+ceM13kK8kmag28/Wf4rzihe46D+oVlwYtTYmIn8dbCgoIMTgIwOSDqFEZ4mEkDtNIBSgPp0uYyQoew2fmmDKot+BZuYs/TodUt2bk7K6ACdOJg+jYsLIgbkywt4n3HJRvGqg3oHtC71Ir45L/lt3d3IuheJ8wpZ8bA9marIc/OZwJK5SVk4I4844xXjxWqfHcaQet8eItPdWrekXf7PPZs9KMqZ+YeTe362aTGR05hDJGUUp3Do9A=;5:hYr3HMavRhiXl59N2oTTOz9HAab4joVuMBysy/vXH6dcu6WIsxG82/UulE4TajKBpJAlEAMxvWwDoPD6K+woLmBvLdpYPqThgSK+lm/c52+X0+RMKT/XDsE2JxUefEHG9J2yDXSu30eEjqNRBXrR81Pejmx8Lpn8L4vtGkGWVV0=;24:CfWQqip73vO7YvjiQUE3vc89q7KOxsYbE1+nVsufFVhxS96swVycjUwBMqemDWUbOgJB9sB8mdsaxQX+ghUVTEFStDshQWNvImeAZXPt7sI=;7:6GDd2jHKj9hGmVhPq8ITpGO83aOhttsWskp2aywPsnGjkg+1GUeS05dFVT4iA7Bp8lUYYMBJ6E8zQjs9KCAjr21JIJDSPGsziSB8Y/l8svyuZvzDRXwZLt3tpOS+InnS+kvN6O0vKy5357NV52ePdRym3X0D8vcfJxFFhewPuS5PMnT75xl+glaopfy9XIrj9pGof07KhJWXoGBaDhZXq7hSlYO5M4u6eppf1vQR+6yKcArPHfNQHtiAyztBhn7p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:5YzhAIEG+wGaFX72AfQ2hDjjtIygq1456hJN3qphJX9AIj+5mGeKKoc/gIAA2OyNXX4HyNelhpK1RMa9sy7tTh4KtnC38rIhblTXDug6d6OoWPd5L5vOiAJiI4R7IwmUG3020vPCtKv8RIdSNmv5cwxE6AMt6aNYpYnGoIPn9Nc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:22:43.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481612e6-9cf1-4c9b-4f98-08d58f2ed5d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553686088522081?=
X-GMAIL-MSGID: =?utf-8?q?1595553686088522081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    7 +++++++
 mm/list_lru.c            |   22 ++++++++++++++++++++--
 mm/vmscan.c              |    7 +++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 738de8ef5246..24aeed1bc332 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -78,4 +78,11 @@ struct shrinker {
 
 extern __must_check int register_shrinker(struct shrinker *);
 extern void unregister_shrinker(struct shrinker *);
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+extern void set_shrinker_bit(struct mem_cgroup *, int, int);
+#else
+static inline void set_shrinker_bit(struct mem_cgroup *memcg, int node, int id)
+{
+}
+#endif
 #endif
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 85a0988154aa..9a331c790bfb 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,6 +30,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static int lru_shrk_id(struct list_lru *lru)
+{
+	return lru->shrk_id;
+}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -38,6 +43,11 @@ static void list_lru_register(struct list_lru *lru)
 static void list_lru_unregister(struct list_lru *lru)
 {
 }
+
+static int lru_shrk_id(struct list_lru *lru)
+{
+	return -1;
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
@@ -120,13 +130,15 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		if (!l->nr_items++ && lru_shrk_id(lru) >= 0)
+			set_shrinker_bit(memcg, nid, lru_shrk_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -521,6 +533,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -532,9 +545,14 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+
+	set = (src->nr_items && !dst->nr_items);
 	dst->nr_items += src->nr_items;
 	src->nr_items = 0;
 
+	if (set && lru->shrk_id >= 0)
+		set_shrinker_bit(dst_memcg, nid, lru->shrk_id);
+
 	spin_unlock_irq(&nlru->lock);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9d1df5d90eca..265cf069b470 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -378,6 +378,13 @@ static void del_shrinker(struct shrinker *shrinker)
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
 }
+
+void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
+{
+	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
+
+	set_bit(nr, map->map[nid]);
+}
 #else /* CONFIG_MEMCG && !CONFIG_SLOB */
 static int alloc_shrinker_id(struct shrinker *shrinker)
 {
