Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELuqj3L5Lnh5+gAs5pZXdkb//ax27KDlVu3ATS9fSRPBqIbQnODgfNUpabyO4A6ruvUjMSDd
ARC-Seal: i=1; a=rsa-sha256; t=1521638497; cv=none;
        d=google.com; s=arc-20160816;
        b=SYc1T0NZvXZbBbGSfnw9BmqCsPr/gh9H3dhVecoaJHggV55Ml+TsA1kQmTFdvL5UWx
         DA8rsVv4FR3UNzAXng/3mkO6IeBsNR6oCCvmUzmHSyhESrMbmmrimxZsSw+dcNeDneTJ
         kVNVVc3Sy3f1ZzqgmsgSo5vJhcINlwjuMZmIyDcZB9Mm25myS0zz3bT2JhPvbcz6Sr++
         VlKmKWMMo+D7ndtemMyC+ZwanXdpZTTzreIAOLP8q/Kpp1sdneRUyCUMjrwZyZtRGLu9
         yTdAdZinX+mvrGVOp2EO2Ul6E+2uA0TULsXqfNeV6Ft7TyeoYj9untcUXyP7rcxIKgvE
         OZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=zHWqdZ9PfF1ZaHOpVt3dB0Vzy1DbtLmPhG3vM7s3x3E=;
        b=Irj/bAbG8UA+7p93eWU7m4Rrf0Dhbi8D+FP3M7q3zy6ZbEFTnUz4HtCahalg9rioyI
         DGFc2a7AYnrh/teeJud6O3mGik/aNYh3TYpcbkL+I9lvvD/F6bL+2gv5IqDbsVyNa1l0
         aZIZONeAS74FLcS4W+Qixr9OQoxg49KCkq5dTM3sFlu8CzDF6/DDQLsww2RNuoLtRCmo
         yAQ+BEmReInKSTA+fG3X13CokGyHDDvqH/Li12wJ6jp3b88WYzoWKceoXcLDhsV7BBEy
         /4rtMg/5Q/KovR96EDCqfM3/oG4Y3cpzuAjlfKGC02oJhWdcIKYKp1ypKQG5NPKUP7yO
         ZQcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=XGudwdmy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=XGudwdmy;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.126 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH 02/10] mm: Maintain memcg-aware shrinkers in mcg_shrinkers
 array
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
Date: Wed, 21 Mar 2018 16:21:29 +0300
Message-ID: <152163848990.21546.2153496613786165374.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::11) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd946c3-a8b2-4128-5f0f-08d58f2eabaa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:JLOm4Jg4u5p0pf30zHr2d250Lq6yDwFwTX7nGfkfjmaWPoQhbBs8GbLqoIhh7ojaX9t8L7XTDtFA2/S7izJt3oJaJ4l/DsSAbHnMZi/VD2yrgqcbN+u+w1BriKKQd2JBZSCo/hrePMtwyKWn3dB4Db3z2ApjvYfBdyUZTlJ/T9hYE1QIl61ZrwjkY7U1/m7yIb3S9m2/HJEY0jEgRhv+gCCPhsJSD13MwyvGp3wbxKzqfhySOjwFwMiRgobMFPOY;25:P9JhX5L31v9l8GHg4NA40y656dbAIxfQ22PgQN181AA4KMhV+Lz3fbwr6ItANT7XZJYZaMMFhdGqgUtGjbHxeL9PJOHtZRpEbf2bbkc7Srex8YSU0kATLVV2IKgRZ1d2eO+8XHPaOScP82fpjHD9hx+anbIK/VN3aDOAveMEYxI6nJVcf4bKkOjuQMdsflNN9v6RlutUEw5xcoznleeIBra3jdPKtEeN/hzjtS2P+BHi/EWZ8JbLXKDFuFqUMO2yLElSRBg0q8RZ60C/TRWb5kXzVLdGsIfufD72Wiovf/Xf6I7GQL4kjUvQxYZ6Rr7PwOL3VVK6E0O9DRD/uo3zpw==;31:rezd8zp21mfksm417epN/obF9lfPdAbniYWATCPYN7TO3jOYdrIbdAB6B3K/AHIUeAJGzP/Hl0QpvsJvDQAhC4Z92SpZk1XitT94Jo7lu2sD2AMB6Z9NvYf5ygyxktqKF4kvneXbpXPjMgwpTVWa3aMbDX0IfOBDnxYYjsRF5ntf05ye7+68EhrZBJrFZR0sUMJivp3uT5qp2Jky8i9WNlziHPwtTR+luD1sJB/glrM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:FA6VEs+n2d911a/UbJywqCCTthMeVP/yWK/sHId+8feex1wGaR7Ypz58wx7awgv8uyZuZeYgfqG2nULHrZRqio0WrcRxdFVNJTuZB32hKbISyetqllZCk8nrWhuagdzD33hEGEAKPsF5vwoTdfOLdIxPZw8Yd7EVrXq3Afdd2UIyP+hlk0wIHr7jQQC5fKrnQ9oR2GngmjNYIr/MPQt4mp01xS8AYvS9Q2Sr4wfhV2HuTEalYHWTU2o7CQieQS5ga2ZQlUz6QEb8ZjrnYawITPeSJfYCpkq14ZOVlVDxIfgPcGNRInAGifJUN38KBgoDiZq0sEALarwfkR6JkZX4wxp8Bdw7prbJap8PqCn5axSDBNnOZ5o+nvcq5HIe0QVKcjTbLGxHfeHNH5EkWpVNBmQ4rNOnLH5ixUOLHt1tliPZgiqy8ifUtEZ4DcX0ZtWdVe4B8tVSXlFM3F5hAhs2pIDWiOZSLRyHwlNZi5scmbIefHcRyglz2bnQPe6x287H;4:q1TqrtCKrMu+zcvGCmF7F1nthSJC8/1dcH+5lBxzsEaUFAFeCFd7ZMmAwlFtMWiGDedExpQ/I7JUnpoUVRRzux5UxaPAv1XV8lkDJ+CZTLWJgP+O9jqnj5e1/NDJEKaOqX9ZY+Dhb3XE0LMZBL/VIxdGNQR095xh28rZEs8KZO1k5fMnnU2YtrlpN/I2AVW7BUtNgVzt1CZdArCffst3Sq6J5xPyoLCUPQIsBq0fK9pF7LhLuqkjRf3QpRpWb+6WELUVtqlTmncN7ARJDRINEA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340486622B3BA2103193663CDAA0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501323)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(366004)(376002)(189003)(199004)(105586002)(39060400002)(8936002)(81166006)(316002)(86362001)(230700001)(103116003)(8676002)(2906002)(58126008)(106356001)(55236004)(50466002)(61506002)(386003)(25786009)(186003)(66066001)(6506007)(47776003)(52116002)(53936002)(33896004)(23676004)(55016002)(2486003)(7416002)(9686003)(5660300001)(16526019)(26005)(81156014)(2950100002)(7696005)(305945005)(59450400001)(6116002)(76176011)(478600001)(68736007)(7736002)(3846002)(97736004)(6666003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6TFZtUFZiZVZOSFBTWjJOMk9ORElKdUR0?=
 =?utf-8?B?ZzBLQUNWYXRZdTFtWm9wbTJINVBWZmk4Q1N1N2hHdFJIZ1QrTnlyZnkwNkY2?=
 =?utf-8?B?WmpwWFE5WjRGb3NzSU5YVG5va09MZkk3THJURjhKcXlhQUVMV2puRzVaTmc1?=
 =?utf-8?B?MTJHR1cvT3plV3RUaHg4dytjcjVtT1p1bmJobTlWMUk4NHFZZWYrQjEwTmQ1?=
 =?utf-8?B?UFVlNU9kZVdSaEgyUlhhZjNMeTBadE8vTE9LSHE5dWZ2cUNaSG5xZ1I5TFN4?=
 =?utf-8?B?Y2ZVbzhGREdmVFlXSVdpNEVsUi9WT1YvN3pZdmJvOThEUzQrbUliUzZManpO?=
 =?utf-8?B?aTNSQlpJelBRa2FNNnpGQUoyRjRaNGg3MTRoVHdHNEEwWEZDU0pLKzBkczN2?=
 =?utf-8?B?cXpYNWNXaTZHeDJ6V09FKzVqOGFOejVuenk4cmlWMjVtT2hiTXIwOG0rbmZl?=
 =?utf-8?B?SjQ5Z3FYY05ySm9WamcxcjE0Z3BEVHlhdlBNciszZ1lQeFdBaEw3UUpGU21U?=
 =?utf-8?B?TjhBMGdaY1NBd2czMjdrNjRxREVPK2tpUjM4dnlDcERqZHBqaU1CelNCL2Mx?=
 =?utf-8?B?MXhHMDFJalVMMnI3dFlDN3VpMm1Xb1NvVTRhVEJzN0Q2YjlIdENLemliSllJ?=
 =?utf-8?B?emQrTWp6OHdrMmNLbGxMYytGbTZ6ZUJ0NXp0Yks5K1djOVNUQTZSUkFFMjMy?=
 =?utf-8?B?VUFLcG5Ndy9RL3puNHQ0M3BJWWVuODJCTW5JQXZwWEZQZWxmWHJqbVp4TFJz?=
 =?utf-8?B?d21iQ2NqQ3M2a3pqNEV1a3VlWTdBdklrSWdrSmpMNFd5R0ZwdDlSUkFlQkc4?=
 =?utf-8?B?dHlSekNscUdMekJkWUhiajYwSEwwc0syMlloYUpFdVowQSt2Tmxnek5lV3pD?=
 =?utf-8?B?TE5ybkRsVEF3M1VlRWlCaTBydVhCOGZmS3FQNFJDdlRmYjVIb2ZxZjJFRm5X?=
 =?utf-8?B?eWd5cVFwZnQxWVgvNjlOcTIxbnFkVHdwWTA4ZE5tUy9GZmgwZDI1bG5UcVJn?=
 =?utf-8?B?ajZBcVRZV1k2RzJadWVDaGZkRHErVTlNMWkvOUZoOGphZThKSFFQd1cxUWh0?=
 =?utf-8?B?RktjQ2FEcTdndU01WExZYjk0aUVEamVYcDVWeHJSMXBURVFQUXFhSit0aGJK?=
 =?utf-8?B?RXpzUWxMenNlUklzN2prWmxOaW1kN3VEVFYrTXA2ZXozcHhtcHpnSjhKc2sz?=
 =?utf-8?B?SEVYWFgvb2lkZDVJc21GV0REcHR4WnR6aER3TEI0ZmJBRUdZakJYbjY2dUVE?=
 =?utf-8?B?ajdHV215ZStmL3d0ZDRScjhTY3RXaFY1LzQwVjQyNE5qQnI5ayt3akNFVy9a?=
 =?utf-8?B?WE90Qm9tMzdmMTM3VmpZRHFkRjVqSEhOa1J1NnFYUHhtbUU5SXdodU9QUlBT?=
 =?utf-8?B?RHlNdlQ3aHpvNGpCbStRMDdnRkpaZnpYYnhUODhodVZsOHdsbTB0YTEzaXFs?=
 =?utf-8?B?ZjJlZW5ESWRNL09weVN4KzVXSFl4R2xabDhJY01QbjBOenRWVlpTLzNZbnVG?=
 =?utf-8?B?cHAvdHY5SURpRkJrS2c1UlVvajA5QnVvc1hWcEUyTnlnd080L2VXVm91T0tE?=
 =?utf-8?B?eGRqWE1NTnFGaG9aZTYxQXVpUXVpeVd0RldrbnhJRTg4S0lYblVZRmEwampG?=
 =?utf-8?B?N2lvVGF6MWNyNE1QTDlEZzBxTU9SMERBV05qR253aGlHR1dMN1ptUmUxYmd2?=
 =?utf-8?Q?cb2oONsHc9xFM3Qk+Pyw27YBvuG222w9kLy1kKpWo?=
X-Microsoft-Antispam-Message-Info: OE5XtDLJtqu3MUDHbiBoXuW0PTFbEOo4J3Gwrf+/mMEj5W4Wyf79pYzOqOTqPu7RZzyMiQpzfmZ+EK/F01RI/zgR9f1NlRhs8LUcvuCA6lD3fd+c8QIFcO6BN8IW39vU/w/wh6Ow2Wbj0HEC47s0Jia6YFXrxGkWvwGrcYxnZzUvzu4XjI9YGkCTT5mpiXZz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:tLt+t66vVFv1PAktJnr6oBc/QNmU0HqDrHBNZOqKQi7gGpPrH8lTRhiTBd+nqW8m5jY0lvbz7YsY6w7t43Xw0V0Ttsa9JM5zBPwE9VMxelQx5ZEzBnzsdX6BOPRq7D6kV/Ccpf6+7SFEfW+tbotMc5bzSSVtEhK8qMhPqtbaZyPQnkiCk1aBD/dD9yv+eBjqdCaoR4mxJ7hjpWnPtPGk/X8r3xKJvg7ryjD/njZFau5hK0OZAOmDl30H9FkWp1OkNjFjjcT2nqowcSEJhXj4ImAGxUIZSYWg/sS9Qxj6dUmC9qsWUzzsCzpBmK5eyHhbQaYyWOmQSkEcdQmQSAeF2rzNRWXolTu7DCiq3JTNZbY=;5:cgeoUVJI3wJhDl6pGtXjaDDocGREsGyVuegxcoKnpjXJSEfwWW5r6Km4ZktOFYlns3/doV0NI7JL7xFi5hWfNav9GlszYXCCHK6nzjTsuPHyTfi2BphhECDIcxK5l4ODSFTtYeC7gT1MbN82kMWy6X67BPB0c7HXw2l1KDsQPCI=;24:HsulXamCOL1vGNyD1mE9yfIjj82wNLkdEjK8EQJiII+OpFrGDtcIN6hayf1odbAJ/93tofFTmXJ0Q+MSVoawg9R6pXKfNyRrP9hOLz+8moM=;7:O5j+R8YH1s0iqSnoJDI3sLYktrtiDZFHgShviUYvsznpgsTf2YKnYkuWVTDx8sIXrAQvNP0yAa0pdyHTMQlUlvdvEybuvR8voFHsgbbqWuwVgWENeITiEHvr0+dBcUXc65Of1ltBhRKSXMViIDl0CR4Rlr9+enyOZ7C2LczXPCPWMt1w7QgpNoGQ/1zFf7E9bdHk+AJ5CXfXgHSlLbcRGvaAIy1lEdh17erK+g2NoLgOkkgNHxsO6OYqAOynLfUU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:DvxNGZLXsGEHg0dWfvwikuEedbWsmo7M8xDfBMSgmfVW5y2ALwOg9nrfWsImQ6TXYTzQcr3jvCkVDUddwwztrhUfRtPOVpaQxKykQwk6i1BteEcK0fUDh8uL9tlqOm6j07c9BU0OZ75XLhrZz/A+X5OcpGjHsa2b7sSZMjywmSg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:21:32.7097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd946c3-a8b2-4128-5f0f-08d58f2eabaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553609558263575?=
X-GMAIL-MSGID: =?utf-8?q?1595553609558263575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces mcg_shrinkers array to keep memcg-aware
shrinkers in order of their shrinker::id.

This allows to access the shrinkers dirrectly by the id,
without iteration over shrinker_list list.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91b5120b924f..97ce4f342fab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -163,6 +163,46 @@ static DECLARE_RWSEM(shrinker_rwsem);
 static DEFINE_IDA(bitmap_id_ida);
 static DECLARE_RWSEM(bitmap_rwsem);
 static int bitmap_id_start;
+static int bitmap_nr_ids;
+static struct shrinker **mcg_shrinkers;
+
+static int expand_shrinkers_array(int old_nr, int nr)
+{
+	struct shrinker **new;
+	int old_size, size;
+
+	size = nr * sizeof(struct shrinker *);
+	new = kvmalloc(size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	old_size = old_nr * sizeof(struct shrinker *);
+	memset((void *)new + old_size, 0, size - old_size);
+
+	down_write(&shrinker_rwsem);
+	memcpy((void *)new, mcg_shrinkers, old_size);
+	swap(new, mcg_shrinkers);
+	up_write(&shrinker_rwsem);
+
+	kvfree(new);
+	return 0;
+}
+
+static int expand_shrinker_id(int id)
+{
+	if (likely(id < bitmap_nr_ids))
+		return 0;
+
+	id = bitmap_nr_ids * 2;
+	if (id == 0)
+		id = BITS_PER_BYTE;
+
+	if (expand_shrinkers_array(bitmap_nr_ids, id))
+		return -ENOMEM;
+
+	bitmap_nr_ids = id;
+	return 0;
+}
 
 static int alloc_shrinker_id(struct shrinker *shrinker)
 {
@@ -175,8 +215,13 @@ static int alloc_shrinker_id(struct shrinker *shrinker)
 	down_write(&bitmap_rwsem);
 	ret = ida_get_new_above(&bitmap_id_ida, bitmap_id_start, &id);
 	if (!ret) {
-		shrinker->id = id;
-		bitmap_id_start = shrinker->id + 1;
+		if (expand_shrinker_id(id)) {
+			ida_remove(&bitmap_id_ida, id);
+			ret = -ENOMEM;
+		} else {
+			shrinker->id = id;
+			bitmap_id_start = shrinker->id + 1;
+		}
 	}
 	up_write(&bitmap_rwsem);
 	if (ret == -EAGAIN)
@@ -198,6 +243,24 @@ static void free_shrinker_id(struct shrinker *shrinker)
 		bitmap_id_start = id;
 	up_write(&bitmap_rwsem);
 }
+
+static void add_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		mcg_shrinkers[shrinker->id] = shrinker;
+	list_add_tail(&shrinker->list, &shrinker_list);
+	up_write(&shrinker_rwsem);
+}
+
+static void del_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		mcg_shrinkers[shrinker->id] = NULL;
+	list_del(&shrinker->list);
+	up_write(&shrinker_rwsem);
+}
 #else /* CONFIG_MEMCG && !CONFIG_SLOB */
 static int alloc_shrinker_id(struct shrinker *shrinker)
 {
@@ -207,6 +270,20 @@ static int alloc_shrinker_id(struct shrinker *shrinker)
 static void free_shrinker_id(struct shrinker *shrinker)
 {
 }
+
+static void add_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	list_add_tail(&shrinker->list, &shrinker_list);
+	up_write(&shrinker_rwsem);
+}
+
+static void del_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	list_del(&shrinker->list);
+	up_write(&shrinker_rwsem);
+}
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
 #ifdef CONFIG_MEMCG
@@ -322,9 +399,7 @@ int register_shrinker(struct shrinker *shrinker)
 	if (alloc_shrinker_id(shrinker))
 		goto free_deferred;
 
-	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
-	up_write(&shrinker_rwsem);
+	add_shrinker(shrinker);
 	return 0;
 
 free_deferred:
@@ -341,9 +416,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
-	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
-	up_write(&shrinker_rwsem);
+	del_shrinker(shrinker);
 	free_shrinker_id(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
