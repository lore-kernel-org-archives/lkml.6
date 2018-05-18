Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpEeSlMs+LmFMSfTTlJGMWH/Q0iF3vMfa2dZugB8LMxn5rBXrlgtDqVjgCTJrh4i2pcGlkZ
ARC-Seal: i=1; a=rsa-sha256; t=1526633004; cv=none;
        d=google.com; s=arc-20160816;
        b=a55ON68QmPphLMk7AM+KS4E0FwyNU/56OnY9kjXu/YRRNZpInXPsTDC3wTMA27RLLP
         cnCnEs8j0Z1GnloRiSX0/xmXEFlOxoGkqsepb/6yYuPI5+4WKDI4IvFuZYyqWKdMCXnI
         OFeYC1mSZk21Na6Paw1dw+IYdDHbZphdZBCClHHJBjBgSl8M6oFvSpJeH+4ssA7AkH3a
         am9NNB0UmDTG9RSvAytL18BNQI003FKvNlvmFXFgRmJqYfnBbxdOvnfFiZuLIQyu+Zbv
         xp3RMBaw2Qjj7Lgm3XTL36khpXCzHlr/QXDMA83eyjYPo5VgzurhHYCPD2tXPqPiQn/7
         /xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=LFfDQx5J1CVLSSXFNH+S3h8jGjR6DUma2O/abeRlgEs=;
        b=RzMEGlXMO1GuhXXKBeJd8obCIOu3163q6J6MX0mYp4fwdR6pSwWpV1vkI2ZgCE0MMT
         Pq0VPAdyWKPL7OnkESivbegmQc8AT8TrPaiFZRWSsGtF4EFA0C8WJzdgBSTZK8YORFyd
         RD5qCKSWUiBVC7CC6oaXhB+IAKuoz/DAVjUggD2Y/KdUCKr2XwZbHVuGiN+DlFR3k6GD
         6jwARINRQdFr9mJZn7/pE0TE/Q1OrpQ9dDv7k11Do4bgTg1gjBghzB+HBcaxGDbsBfio
         6lecvDb6WJmuAs70PCnpas2NH6IYN0wmmimLPkXe/jgXTj/edLiaEo1SpmrM6bE3qx2T
         R7ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YX5bxNCx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.121 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YX5bxNCx;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.121 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 09/17] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
Date: Fri, 18 May 2018 11:43:15 +0300
Message-ID: <152663299522.5308.211266210014374179.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::34) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:ssEijJ7MxsEmHXm3bENCEPJYhP8SUzA+D8bBSS7QZARYFHEsm+m56T74fYFEIZ4feWYsOGktZW7qE7SzlGPzE64okizGKVrugE31wr7hxwMsRCD2Bh83JKy7KtyKWuYbXMI6VNT++PyGlmiZ9KyJgocWpsmPHWfc7/zFzI+gkPHgsS+/saOOzr2Ee1yEL3TXDu0k9EzF+effU1JvmP43aCxmiSXgssZtxjDpPWB4NXFoM103cQgKknUF+p1rNc3n;25:EzTsz7H5INnbqj17TTu16ljMHEvIsOUxrRQSMdGM28GAEkqQJnyur17AQLpZSfoTsK0n1NZhTu5Woq4c/wOzhe/gBbRGymZyFvV82PEWM/bgWYxmwl6rXoSIjp/lTZM+tQO7vZ4gRMYCHs3cxy4CnDPsZ1RzwEU2HptCDULt4kmxnSddzFnn9mEn6jlkmzVF+oRPb2hM73MEaXFdyxeWVD3ZWRjiMVcrfgMQWaT/Eq0Ubmi4LD8L9OCob56x2INKdn82r5t/RrMs5f3E+T2PGXHg56fMhM2TbHY0HADfWhgRSy0AqxJ6NFrjyZn8bcJj9qhXYOAKjAzMzdaqJF4aJg==;31:NG+jn+ClJLEs70OT++BmmElXY5lR8JFEDyIFS62OFV82EJbiIFlc+OkLyXwwVtEl6ipFaNejzcJhKW9MTNyTMHPCfV+FFwIytu0Ku/ldEvpV7cIqPA99aLuf1WebkG85eBE90UXbRw9sJHP2KQW4oQtheJIMNUEoGkepRdtINiTCLdpdqXrmiJPaJfuIAHTxRMVOGbyNgKJPF5jVakd3xhkxAqcfxW1q4IGhH+418fM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:edAKx5PPE5SBtBvg5INOVUeZkUq2RhUJh8cn8xtOABCa5uu4d6zcI4+P7FB1r2lZ9ugUfAS1O1lDJlCFieg9HGz9KDj4XRcJgKpKT/h5ZdoIZCXByxyCGyg8nTcouN7pLs0/9EtSGdDDrNozy4dUbPiGVgIa616nXJlHJDpPXV6wqHKdoV33hSdX/kBGeAXYbyF1AZ26HwY+XaX2qdyfy7U+Gfg3yTvQ7YezyfWXuJBl0R8og/Pb29gRzbhWrtQCM7ftXOOkpK+IyBC7TxWHEz9JV9JxeJOLR+yisaoFxvrEwAHqgHdS1oZB32LwMVTqQG2zZ6I0Oz3ze8+bHxfAxmVbmLx3JAB3ifyCQJuqgRhvtpaYhoCaoiV5XdbIkktXoiNmZddDV8BEdBI3jtCOs6BLNd6YgdR0qFZuhSTGhnEyDGbBY8UT1LtQ5TaG2yuYDaVjMv1OSuGz7QlnXlBVyOpWF9CzWMoPdGhNjKmXlouFEh9CXIT+kscBpYC0d9KS;4:db0UQ0IRyKIlYY8ifRZ2C4b2gO/kPHgW6UTTwng8tD9WT5+NKWYB0RnQzJ/1Al6l/9vK7K771aKtA1OtY5GU5cQIIVZXtD2B+Mni3U9TOPLd7otfzs2mauzr+g/P4YcPFgJsx+pvgLDB5HJlgTWzifV5L6hK1lYThA/bY2i6mehickH3fYJNPgDFhZ1bzGkZ3WSf7fESwy2Y+oHzSZ0S4qeTRC4F+5/hYCLnURF9FhpxWmswPtOulxyKfvYxs7J5eDrdNdY9mDVG9/S0bIsQYQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133893A5DDAF581137E06C88CD900@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(189003)(199004)(25786009)(956004)(68736007)(58126008)(50466002)(47776003)(66066001)(8936002)(8676002)(316002)(81156014)(81166006)(6636002)(478600001)(6666003)(486006)(3846002)(6116002)(446003)(230700001)(103116003)(476003)(2906002)(76176011)(7416002)(33896004)(11346002)(5660300001)(305945005)(7696005)(52116002)(39060400002)(2486003)(23676004)(186003)(16526019)(26005)(6506007)(59450400001)(61506002)(386003)(55236004)(86362001)(105586002)(106356001)(9686003)(97736004)(7736002)(55016002)(53936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6c25Tck0yYlRKN215bDRRYmhtZksvTlRD?=
 =?utf-8?B?bW9tQ3NlVWk5N1ZPWUgyNlBUdC9QYkZhbFBUR2Z4YXloL1o2d09ZQ0JlbTg0?=
 =?utf-8?B?OElONUZzQmdyYjdUbzE1UkJlTDI5aHhzWDFtWTBYQjRXQXZORWgxdUp4K3hF?=
 =?utf-8?B?MlFzSnlMdFNsanBuOVU4VnBvc3lKUUovY3JtdTlUck1WaEFBS0R5WW10blZF?=
 =?utf-8?B?azdOVFN2Q2NUOHVURzY0bW5RNnQrVG5DMCtHamVBUDJlZVdNWXk3L0l1dXV2?=
 =?utf-8?B?eTZpRzVadUNUYWRQdW5nVzE0YTArb0o1RHY2UzgxTFhnMnFZSEFjVHlZd0w4?=
 =?utf-8?B?SlRHbWwvR1pyQ3QvNnppek1odU8xOWRObXJBK3Z4Q2x1ejdQY2tOVzB1bEJm?=
 =?utf-8?B?aWlpMmt0Yng0QkxDYTlmaXBVanFYOEM0WFF1WGdKeWZSLzdlSkhmNEpmSzZw?=
 =?utf-8?B?azJWSXlzWmhlTy9adEF5cjVhdGxIREd1cERyZEJBdmNZNXZZY1Q5M3B1Q05o?=
 =?utf-8?B?Wmp4OXY0UEdPSXBFaE1PVlpJUzRpRnZjV05YajdWYzlGMFE2WVJ3a2lta21O?=
 =?utf-8?B?MGxDcEI4Wm1UTGhXaElOMjVBQTVXcnJiNDZ3NFB2THJYNlV2Q292eU9aYlRa?=
 =?utf-8?B?dk92d2h6anJka3R1SkFTaXpaN0RlTEtSRVRtVWR2UWFYMHBSZThod3dRbUdy?=
 =?utf-8?B?NWNFaGlOVlFUMVN6M0pOVE14L3N1T1ZkMllnSm1VOFZlVFJaelczQjBGclpM?=
 =?utf-8?B?QnF3dTJTRUV2MVZEWUxZWFZuajBQN05sUTY5Yi9GMEZ2WUlqdS9JQ01vOGRF?=
 =?utf-8?B?dXlwMDRUWlFpZWhzZXdTLzA5R1B3UjNlNUtwRUE1aW5UZTZOWC9SQjhJWGs3?=
 =?utf-8?B?T1hFaERDYURrYWRjVG4vUEhQSE5KM0haTUtTZEt2TkJmTWp3MGtyeld5NnZV?=
 =?utf-8?B?YTVTdXhxc0RmcEszVGE0eWFYVFFUR0Q1N3p5alJyNlREbTFDZkJzVHlSUFBF?=
 =?utf-8?B?aEQ4UXJUT3RsWkl0MGVLVHNqOTk2WkhzcmZGNXA5NFBhbGZpSUdtKzZXK3pS?=
 =?utf-8?B?WE5mMmNlVU9uVlNqTGp4U0VjcHlJQWJLRU1LOWdZbE5RMkN4MGhxdGFvWDU4?=
 =?utf-8?B?blF5R1YzNTB4cDIvS3l5V05MWUxNd3lpY04waGpoQVArZmFVcXFhaWR2c2VI?=
 =?utf-8?B?ZHZXTmVGRFBsWlJ6RmFweTJpS2thWXZzNlVSR1NKOHB2RzBESjlVU0g3Q0RE?=
 =?utf-8?B?aGp2R2oybm91M1djZ2tVR2t4RXdrdURxSDRveXZna3M5S29tcmRFekw3QzVu?=
 =?utf-8?B?WjVPTVd5SG5WMHdLUE9mbjBRdlNXQmJPaDR1bmkyZ0RvZHJ6WXBJZzB5dkRk?=
 =?utf-8?B?M1Vua0JoMEdHVFRuV2hqUlQyZWhtZzhLT3U1Qk52WU52dHdkTGwxSUYxSkp1?=
 =?utf-8?B?azZOMnJwaGRDRWNKcW8reERvRnFuNVNhVGNHNUJmQ3BndHFpR21YRkw5UDhj?=
 =?utf-8?B?NUVFZ1BrT1NQY08zbjUzSnROOFdHR2ppQjlpWlkwVmNPeXVIbU5LdzdQSEV1?=
 =?utf-8?B?UFVMZmhLRmpLakU5aThiRDVDTzFlTTVkdEhQWUFwVTdxNzZiWWg4NkV2QWNm?=
 =?utf-8?B?TU0wTlB5a3p3K05WNldwS0tRT01oWXpSbldxeWdyalAwNTQ1azFhNFJUL2pn?=
 =?utf-8?B?QXExZXpzQlF4RWpEWnRBbEpwZk43NzZsTlpzZnJsa0lPMFV3U3VGUUJUUzRU?=
 =?utf-8?B?NUhFamo4YWs0cHNLRkIrSGZ5aXY4UTZjUWE5M1V6UVFJQWFxWFdpUzFXNmF3?=
 =?utf-8?B?TXlaT05nWGtDWnFYMEpubWdWdmVyRWpwNDJzU09JdFBYcGNUZz09?=
X-Microsoft-Antispam-Message-Info: 6STRsfI6jQw3nUkHKNmaIl0KxZ8Bwz8zt439SxPURi0narVBSfjLkfPdRLTJ3ak4a0TcPgMOxhEQGo8ueXmETbRP4hxwUCB9f1Hm7c9HVQEAIyaIwvJM8jwDhj5LdIJqojrQ1nVPEB77+o/j9/gNsl7TFovZzQYY8ysVYmhTOwwZqrj+zzOh/v4jSeTiw3um
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:WGHM+I/WTmIMsfHquYZw7fKb/NzinqVU3TngaPpnB5aAgghUhIHzmIk8GS2TwjsocRImF4jQsxv27cJivALxjYyfxU31WazO36Qg3JlPbjfVFipye/W5mMbg0ilaJ4T8aYbUlVF8KWDv+tMtLwF/CsR2VFuVAskl1Py7jmrQmUgZmWnv9AK+GynCC+SiHCTyk1aCihYf3pkHju+4xq/iPh7JEDK8tuuISB5oxu9411jMXsiUG2EsENwNbSNxDtmytvt6kLHn0PFsGrk8SsfyBgx+ARNQQ7dzBTdgsUfYHiADBFkcZCI669BoC+qhotoJTTMt+90oKSZMAzzu2+B4VhyI5Xx2TvvTZHd1Lyq9kMx0Tbkep9Uji92J3Lu2tazlsifu8039oa4IyMXouekEQVUd9h3P9HIOczCDtk9gS4kxAK0YCHbTYr7bjm2kGTdwT+uhub+pKpCBXXS2vC9vRw==;5:77FPfLcFQavdyWjqe/vfDccJIuLv2q6h6nF8ww3FcPy5SXFwFFoeiTEAHCTAplu3Bop7NDljOqEYx7xj/6Ucw0vb4FV7UR5/PMhDw9V7jItZoPekwxJ+FHZfySPOBcX5PTV++YuM+QBnJScF0WH1dn05+HLfgizH6FbN7LWYwkU=;24:8wh8q6qqig7M7Wd+N5sK05ps5ITHKPua6byoXZTHgWipDuA9u81sCSlyj1bPqK0Y1TYmecy3x9VoHBfx9Nn7rv0T5A/6dyYINpQfCvwmc0o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:XRNshx1ibpWRf3tIYIe+F0CnrXQUSpMMbYaZHni4FRm0d+JReMLP2VFWR76ZxBA4Pxd96Uwg6i09Y+/4DhFIkGb27TII34XOQJlkZy00RatTqDM4ph3iNMFdzZaivrMlO1mZHtoTmpeAjeq7JwwYGr4TnHr+o7YcLXJjZrcQ6Wtpb4EBYf6RS6X/pikU+AG9fRb4EjKYkDdhpLphVx1DdILwufbLAug2Ec3615pnDp9L60i2ZXheZoYc+LYNk2zE;20:BC4/9z8ZC0rE0iZHhO4mkSlDccoTwDfAnIFGFUrwEo4PnTexe5GnLG5quGz2dMFcx9MPPq5CEbWVMY4MjkaPn5v1ni/gH61smZOyKH9HMIlm/++L9zT30rHBTDFPQPVqIU78645t3nTTb50mg/0ii006jd2pTjwXYS0rh/QuK2Q=
X-MS-Office365-Filtering-Correlation-Id: 3ba10584-306e-4a7a-bd3e-08d5bc9b67c3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:18.1345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba10584-306e-4a7a-bd3e-08d5bc9b67c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790728921962750?=
X-GMAIL-MSGID: =?utf-8?q?1600790728921962750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dde9ecae7cb5..151fa77eb7c9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -66,18 +66,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
-	struct mem_cgroup *memcg;
+	struct list_lru_one *l = &nlru->lru;
+	struct mem_cgroup *memcg = NULL;
 
 	if (!nlru->memcg_lrus)
-		return &nlru->lru;
+		goto out;
 
 	memcg = mem_cgroup_from_kmem(ptr);
 	if (!memcg)
-		return &nlru->lru;
+		goto out;
 
-	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+out:
+	if (memcg_ptr)
+		*memcg_ptr = memcg;
+	return l;
 }
 #else
 static void list_lru_register(struct list_lru *lru)
@@ -100,8 +106,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	if (memcg_ptr)
+		*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG_KMEM */
@@ -114,7 +123,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -140,7 +149,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
