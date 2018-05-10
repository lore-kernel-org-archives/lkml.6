Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqDvmoNzzMpOLvBED3UD43sz9wjwK/4BXOL+fygNw8v3DeFXIkGWbTk06BmzC8PJalQ49Yo
ARC-Seal: i=1; a=rsa-sha256; t=1525946015; cv=none;
        d=google.com; s=arc-20160816;
        b=ArA0FZN33TTE1bO/+UmWaetiYp/tHCmN7AFvDT7sGKvvZ9F8iAplY3C8SLtO+evKlo
         5Eq5rMjD+MxsWPvSUXIOLtVEgPyLDEJkrBLYb5LU+qSqEzmSa5WDdB6MOayhNTKuTFfU
         Nd9vUWdFqrvTZEsf5tWk4HW/N2GoFiAkSSom+NlDeRdEDCFFgNeNNOZST1urOGB7aekE
         HLLt/SgZK8sNSgMPKN8NGZ/n8kOfJKIjetF1SoyiOt5zuvnit2rYq+Yc5y+px+oT9ICS
         OZhbu4t8h96R7K4FzTKxUlW5gUT+01+hRdu8swxurmcofhyBlwLlPAnbhj+fs5NeAbh4
         9f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=+hHnX3Y6CMsne/gWPRYTEBzO6gul6SYjBQeAjVJMMJo=;
        b=k/d/zN2plGMo70TBIEroR8o7anys204Ky1rCWWDBCSBsvWjTrsDRzQlhpd/kK7Z+hG
         4nLPmlduMsmmT8ncwVa1L4H0uantbYWGcSclD0w/mnJR79sZUMz80YNDIN3PQJKeYjdl
         jBg8riGqtOp3DdRaGidRTB6VIJDxN4kUdAlOkxMAQIWiQwKvqZ6mWL1vm2tIfCna+tLY
         wrXZAtJlr5orkxgokdzkf+ddsozrair10VXHnjXjZInPCJqNBEsZC4ka6YjU2Q1TJ9Mb
         JgG9Kn456UaYps/4cqld3T6aa0P5NVU02/riStASv2h8vp7wI/878k8B/HqphLSOUMev
         bFMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aGxL2cji;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=aGxL2cji;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.117 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 08/13] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date: Thu, 10 May 2018 12:53:25 +0300
Message-ID: <152594600514.22949.13772959733696297685.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:209::18) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:o67QlVsdZu+cpWiZSHx1xSQ94dCkvw6aLFXIh15Zt7KiiYQ+LzKB2w76opJ+akElrEZD+lujXUHwH9t92Q5oy4jA5eo6udO0IKRVbsj5dOWhszli8OrpAJBCF5UDH9x4B+2gastXTRgqWK0sRoOpl2Cy3DtdIXfbZyCjTMz685awj4RdhB6IgffRioUkGHut9zJa+e4n1xdwVgRZckbsu4cmeO9FOzsR5bUo55fyOpLY0NGqLdN845aL+wd8YkSF;25:ahghaAg+f/ncPYg/9ixuUs4M1jA+NfCMAJf1g2o9bmPjapIzgNkN22TX5Ik8ZfnmQWxhnBdFtG3M4z44XI9cUEzT7tQCfMwhmjSzZKgfi2rjwy2jNtA/ORH+vgzrbNxDgX6oQxUQTkhHZR+i36wLwLnWDESgiy3KSQaeXqf5A81JbRn8M3QA82lTHmfsHFXhLkXCN5onWehHJNSfasm5lKJIytSV703IMsvQn9NQxxYIH8HY32KmHVEAAgNxEVT3f5+6Qr2P8zNtFAf/YMGDIbbr6uJexsGQgUn2r4WByq1NfdN9ML6cMl+wiJECdcNpwZNJmoXDcpb4zy37BAQ8vA==;31:2SH2C3qhgHZIBkHtTal9TTyCUhSUrzFV2YE8dukFQsBX/4l0i4oK2VgjXvw/uIzKWlUDL6SPBHt0tHFuxZi+YorxGhQg322caN3LGCNUsAvqw2iQoVm74W5TabemzT77zhv5M+lImo0pKJP6c7J1b4HqpwooFCHkbvvK4rEzQxVnabY2MtzsYiYVjTkG2t2cmx7NwZbxI5Jvl7FSx1tpcNdeZDjVf7++A8rE7paBbkk=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:244aepF6nQ+OTpgu1HdBM5ItCeJ539oeyrWKXU3V1OHfGAnFlGZxr44URwplbesHZrfTHwp6n+XAIvnvXr2H8wvOa9WjqTXDAPVLqWkvRvTP/wbUwu97X4PZhLQNnGiIYH8/TFNCzuVnKfrUw4fuq8UwmD5U0dSNGRlv/+acCr5xnzjc/YypcD5Ay/p93hXOoZOeYaS73PohYW3qiomuyX8BoEeUdiMfdtjdC3ceEW0V7lMg+kA86Q4tRgeKF1mWyOvxgrZdCrgPTU/NtTbC17BPCwL1wdqTBPNaXqYaTZZRFCZkiOPUaEXbVgUpmGj6YDrgOE9bbMFqPT4G4+yoy55KhsqLwCln2dWk1D895BhQG+eT2YYcsZiIl+kZTv9lv/xtBoDOLpEc/4oEDU7vdwNXmVM0p6aVq12OA/4qmVGOXB7Pd2qzO7Kj68fylRh0++LRjnjgWhm+UCYp0yZORPkUwV3Umy+Z136uJxNCZgZ/JC5Ir9nB0F+7iQn8ta7k;4:WK+57gcPIQwZucnN9fB8IdP+HVh7cZJJNA9kbWVp2+1VATORwwSOHuHHcj86oCf+SXzZUnrut3pqLpVjhJoHHkDpWqGdTu/+ZryyDH3y++yDjd9/kcKQ3I8cyJ8jTuXlM1UvYtIlcRrlfkisQxhjG6KdEx79v29LVT2obcbGsHqV7CPu1nSykjnDxekLyBQXoHdq5ffWD063WJDQr4jo1syK2CndAywhk+PgTTYhkHSJe2USWDlJwe75gKdt7PfibzaJJqjAhUZtv2mfRbUO1A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338BB60904706A2CD6379DACD980@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(376002)(396003)(39850400004)(346002)(189003)(199004)(230700001)(6636002)(97736004)(55016002)(9686003)(8936002)(53936002)(956004)(11346002)(476003)(446003)(3846002)(7416002)(575784001)(486006)(6116002)(86362001)(5660300001)(2906002)(103116003)(106356001)(105586002)(68736007)(478600001)(26005)(316002)(58126008)(25786009)(2486003)(52116002)(7696005)(76176011)(66066001)(33896004)(61506002)(50466002)(23676004)(39060400002)(59450400001)(386003)(55236004)(6506007)(186003)(47776003)(81156014)(305945005)(7736002)(16526019)(81166006)(8676002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6V2xWTU4rVmRMWk1RenhSMld3VWVQb3dT?=
 =?utf-8?B?SVBScktlaTlQL05uK09KcmI3VUgrZU90UWNLTGl2TjR6eTBaVDVJUnhONDIy?=
 =?utf-8?B?MWZ6Y1hUN0tQTUpzTGsvakRydVBrMXl3d05BbFpIdkRvc3ZhMHRXVnpaWUNl?=
 =?utf-8?B?RXNXbXFlVTNUbjZyMnYvRU5kVEl3MUlmYzM2YTMwSDFSVmIxTXNsazRIOVha?=
 =?utf-8?B?Q1IyZ1VSK0YzZWx1ZU84MzIrK3NiMXdpazFzRENYZnlnVkhPNlJKdy9Vb21E?=
 =?utf-8?B?Y21UYkVJZkVaODc4dmdHa3BJSXlubVpUazE3ZnVqK2s4OEg3VXpZT2VVTVJC?=
 =?utf-8?B?NGtnS0VjSEZpY2YwR3Uwc2F1UitWNTVBckdwcjExZHpuK2pjUVp1amZIRnUv?=
 =?utf-8?B?VENTYld3UGQ5Z0FHdFAzRTNVYUFDR0l4VHhYdnFMUHBuQzJqdGpILzNUSkFa?=
 =?utf-8?B?SEFVcDAzcTR2ZTBGZ1JOZ3dTODRvVzJ2NEQzUjVYY1VwMjBpVk5tZTRLSU9H?=
 =?utf-8?B?cGlBR0ZiVldSOUhzR2plYUJCSHd0MzBaUmV5cUdhWGluV0xNRFdKYktGRDZG?=
 =?utf-8?B?ZjlrNEtUaHE1VXhrU0cwVVRFK1cxNFRkOGliaVl1M0RJTkliNTZHQUNicnRK?=
 =?utf-8?B?Z09lTlZVY01TUGxNdkU1UjNFU3FjeXhSaFZWVGJMUXZIMUtOR3U2ckp0TS9k?=
 =?utf-8?B?L0Y5bkppeG5jajJBYytTTHFNY1RURmJJOGd6UFR6QWViYW8zbjJDYW1PWHJW?=
 =?utf-8?B?UlFsb3paU0JqT0NDU2dQV29jdnhKMzgwcjkvc1VINlNNb3E1M3VHbG1ienVU?=
 =?utf-8?B?ZWRQRkRZc2hOVWVDWXZQd3VMOTI2YTUyd0VjK29RRUZxQXNodlBBV0twWkxF?=
 =?utf-8?B?QVl1bGN5dW9OQno2OWVnQTlnc2llcTBPTUFsczVKaVQ3Zk15T05jL2hpeHB0?=
 =?utf-8?B?SEM1djcwWHYzYUllaVdFVVNNWnk1UjJEZWYwMHBDQ2M0SnVaaTF0VThpZnhx?=
 =?utf-8?B?bGlwTmhqckxLVENibGVsTG80WXVPOGFoTGJMR0NzeHRTdS9McUZqamd0ZGtm?=
 =?utf-8?B?WFl5RU5SeVo4VTgxbjNweVpwcmxicmFWbXowMEZMT25vTWM0WCsxMzl2Qy9u?=
 =?utf-8?B?YU1TcEtKVXQxbEhKNmZsYVNXa3BFcjUvMmg3eGlhZy9KTzlvazdKZTlKSm4z?=
 =?utf-8?B?TGVDRStuRXJzaGRHZW5YNGZKUzk2TWtFZzFjM2pCQnpPazFNRGpxYjMybTd0?=
 =?utf-8?B?NmtDS2RLL1NERU44dHJ0Z1Q3Wi9NenFxYWZXdlQrcXJ3cGZ2YWd4WGlMTGRs?=
 =?utf-8?B?ekFyOEhoRkExeDRQM3JwTjE4SlprU1ZCekhqUndqRWdnRW5KWWpxUzZqaEx0?=
 =?utf-8?B?UUFLdUd0Z1Q5WHpnckljU012dllobU9MKzB3c2hzYUNBd25CK1N0eXcvVXNK?=
 =?utf-8?B?RzJMODNiSEk1aUhFbjhWMXlaOTRoQ0YzcncrdTE1RzFlUkVmWEJNQzhPQWRY?=
 =?utf-8?B?WWpDa0FVdFlvNVBJc2hPYmoyQkxzODZFY3JBd3RnS1NGYWkyN1h1NUdhLzdn?=
 =?utf-8?B?M05adThvR2JmbDJvTENQOHFaeU9zTXp1QW1KN1l5SUY2disxb1ZBWkZnSXh6?=
 =?utf-8?B?NlFPa0k4Z2p1L09hRUU3ZDZWNDJKNkd4RE94YjN4bTRCYng4QkxYQ3M5dnZq?=
 =?utf-8?B?N21PSzRFU1VxL3RVRncrQ21tajNLTWUwNlJVSlZvNTRNUWRkbHVicVk3K1Ra?=
 =?utf-8?B?UVVuL0ltbTl0U0RYNGU5bDlReWJSamcvcWJRZjgwYVlyeXlXSFdaejdxV0pV?=
 =?utf-8?B?NCtyaHpBd2tjRU45TDRWaHpTOE14bFh4Nkh5MVoyN01MeFZ5QT09?=
X-Microsoft-Antispam-Message-Info: B9juw7QoZLeq/UHR+8Uv2qRSYhMzPn+80ikYAsVGcs0975OTaddWAKNbmEpo/DbXLZQF5k0zzxvbCqnkdJ8ronc+sYDlUwQ7ircej18QgMfvkCgMaYnrmx+tJB03Rhmau8Fwrk/aP0IlJw2cuWG6OVSW9B1a1AdI95daKnK+GglOXYvkfGk+f9aJV0fCGhM8
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:V/QpjJRWUtcM0xoK/PZnaVyle3+I5EZvmmigkkIKzC0nH+bTIro0kB1Pc1BDcg1/aing7xtWXa+VcIam9yFS7FzheNL6YYR1UvCMqQyJNIYxDnGFVKIMcs2v6BfIcMdMm8qZE7wKekThL8bg/wAJuB4QmY8xvR2LaDiTs4vZ4RwhauHzF84OYvlxK+Tp1AvMT7t2i+W18z/I7J8acOhTeCqrfGk0Z34o+8c/nlQgWWKVAdmiFvmxTau4LSf5Ta4QHpYdZ5cmTYorL0jsmcA+YDEjgWFG3NtY1nhS412dD3h+MPR4/kVcSMThaPIsk/wMZDy3xyQAaBttj3Rhec4KdkM9CUjuLudKnkd2ibrRXn7KLqfFYtLoQM5qFQ4rA/E0C+LqTjddQMHQDamCmrwRol1kWh6zjIYg4z6PArtzOVinZ9KlFuODwFrvXxQtRNnmKY3LJJ2tErLT28YQFN3diQ==;5:8//i3KgPmBrd3c83Z39F+lvmCCQFQq3UmDvaIxOM2OmFgeW61ONJ0prIHc8DEHw3y/2q6c6PAOD4ICUDsOZmZn1gFdb98ioDZhrHizrSc5GA2JRSs9YCT7GCGubugDeVS6JXd7cvntg6gJ48Pmd4ibm65GVNiAlRMAsN/U8fo4M=;24:DFZu6RHVSZqyWIZYqCN+inSKExBprpLeiCHpCrKRGKb2agQcX0kUaWuXM+MgZLrFXoLJIIMXK8kMVqcgwTqv8GjKdxiIwoccBH+Z2VxxGiY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:MEUkWZ0NzzdH/NgEi53JOAyYBhI5CnceqLgjJ+SrY0l8liq/XAY600eOXV+jusFyPwYKGaiLEuW4ZDXoTv5C749eV1hPmpuANC6BqKbtOZL+fdCFGupFxEJstr3y8oy4hc3h7IhbTq8UhdouFWYFyztpv1G2uFYt6ldingNelwcdN4X5gAIbHvKNPc5tHGpLqxanJlJf5LGO7/55CXyjcqKWECSwNO1ziiDWvgHHN2a5FMZ5L845UD6rUl2J9Pl5;20:k0umGE7CtKpowjj2j9Fdb4UfZbUaiY7NZK8zyFd0UmnpvHYg+LCgu4/V+WJ8i87lZT2SBXWC4DvgyLThtSH18FPZz0kuAs+TzQVIk0VcYvXAu31gqCmws2JhNWfgZEOFxx74lSHSdRbAwiFVgYNvX+F7KSqx5oYoUq2WTwMx8hk=
X-MS-Office365-Filtering-Correlation-Id: abf3e03a-fa3c-4976-aa9c-08d5b65be1f3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:27.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf3e03a-fa3c-4976-aa9c-08d5b65be1f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070369004617567?=
X-GMAIL-MSGID: =?utf-8?q?1600070369004617567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index a63b7a4abc6b..a63bad2c981a 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -68,7 +68,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0721381b2e3d..46b805073ed0 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -517,8 +517,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -538,7 +539,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -546,16 +547,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
+		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx)
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_idx);
+		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18e0fdf302a9..df9e7f159369 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3173,7 +3173,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
