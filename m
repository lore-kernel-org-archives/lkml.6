Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDZJzD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:55:03 -0400
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:19747
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754081AbeDZJyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:54:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
Date: Thu, 26 Apr 2018 12:54:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425194915.GH4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:7VEHUCCFdrCFjFqG9p4zUMjvOEZVKlXowb6zDp19yLWab82Nt7iIBXVM18XWSdpsj6a8hs0G1KxAb0hHcm07wzk2XjCmEKMtbpudXkOnPdwGBt9ARtCtJF+21j8Bbw0R+uVImOpEYHPTlmoVAgATt/nWXmt6d6jIByriuqZ1SG1zmdeKxviM433kskZ8Zz4LtWkS5um42eNEmGYfdBMTgbznTzcX5U3nvieNEgvUPp9oA3PMx3TIPWueBGVHCQNH;25:5cTHz8YtSRLGiM7oisu11g9IXSq1aPWck9+wISe/QlAF+uzgR+1dfWQjNtBDWvxhSK+kfWSuzh8pay0XgoEG2P7uad6VYQk68WcykhzXdMyR5Dr0ImtnJHzL6prrvYczvqm/qzGjeiu9HR+LOeqSzyhbceLIlYe9q8kZEfffmi1AEd1jV9eKNHuTGyHUlyOf0uZ9nsK83YAIgNyWzosQ7W3oZrfR11V7w51Km8L3A9trK1SHkwo/i/tbKmU4aX+lNrgAukAlM94lrdqjebPd0inTwLynL+4L7lq/qTtWn9/M7XVlJIRYC1FB2XFpzEXNbNZh8uteggmTj/Mlpph0kg==;31:AkU2q9w9mn0rfo96W4f65ml1/j0DnrBvDeKjOx4PrjfFQ/ItPZrBajDSvySshZ0JrXzGR+YuVnTLEb5nk9sOptDTbKdXlp6Cagyma5149eu1n/2eX3IEtN+hFCISHVfGwNB1aOJ3Q8jowyPXEycCTjUMyOxJw0qK2sTwRFJA/OcRHnMJqIuc2GsGVFqXvSc6AHKNh2+GL+nsvUmMgAgx/mQPhytrabyD5RAp+V2FDmQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:Qj+vOXtFA5v18WJ7cRWTloo3z09ULmxsBByeh07ZnotPc+ynk9EvOUwtWC2A8hCbn+pYTSDnryUGRus4e6rrmH2Yh1arSRKAT4mvltUgXM6ac2o8xA4lTp4D+43JULfKoLd2yLhKBv89bZWuOxYTGUe8X25ThTWBdVkO7amd5XM0YuAvtdmCTBBuGi3ehzOATOG6ybWqccEWbvDywX+OvcjinACv8zgjOugjh340tlha6YrX0AnoRbcyKcFX2AGc3DCyw25YtSxu1toZOJBltiy+CcjBAYTxe7+rSYgwHV+iPTUl7CtTYvKoJKoQl3GILqxqDpeu4pdT+dHcL4D5qpdpDpgESJIlmAwX/D+xmjv51fI3VNKae9O+BPCaosRz0nfVCLt1L4v6BWlyDWB++DDqZkCDNZKVZDr19Clyt2mv4f8VgcHgOMb94SboCgRAcIOhSmUcqJu+ZmhvctKiv54axTMbWbjWwZoqUw9QmwZ7pHRHkILgmfwXV3ctoOGJ;4:eMCqgGrz50f7wIasMQCTWvwZNEadPFBI6cfAlIB+Oe53guSkSkylPfgADLqel1fZPB5iwz3Wgz1XC75RkpKOkDSK3Y29PLOEJCgMZgmjKkWFV4NtK1M1HwwCuoRvd6mTGbLloy1G6ohiL/qA5ORRziV2bvnfXw1asEGnLftdzDE8POcuJiZxOb2qW5eGRXClWiWVSuFcRzJebF7QeD3wXlkyRoN8xxCY7NBdWOFnJf16QXf9cQdg6lXhMl7Es4IU5pjUH4sfWMQ78wFi8Djolw==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343238C5C04BA7B3B9C4F6FCD8E0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(376002)(366004)(396003)(346002)(189003)(199004)(106356001)(7736002)(6486002)(16526019)(6116002)(77096007)(26005)(478600001)(105586002)(305945005)(386003)(55236004)(59450400001)(575784001)(86362001)(6916009)(956004)(39060400002)(8676002)(11346002)(230700001)(186003)(53936002)(64126003)(2616005)(36756003)(3846002)(6666003)(446003)(2906002)(31696002)(81166006)(81156014)(47776003)(52116002)(66066001)(50466002)(486006)(65956001)(65806001)(52146003)(23676004)(2486003)(76176011)(31686004)(25786009)(4326008)(68736007)(316002)(58126008)(16576012)(97736004)(93886005)(5660300001)(476003)(65826007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6VjhSWnBPTVFGazhWY05jKzRabnIvczJO?=
 =?utf-8?B?K3Y0bGZ0RkE3OHloeTBtU0grMk5sU0ttOStESUIrTTQ3Y1ZISXJxL1k3NXNI?=
 =?utf-8?B?ZGNnNjBINnZDZjNLN2srV0NXc3ljMW9aaGttZ3k5THpzQ1BHTlJqdUUrR2Ir?=
 =?utf-8?B?eGsxeUlmM0hmeVJ5R2oyRi9GZSt2SFpYL1czRXo0MzB4SXdNSDFaRzlMd0xV?=
 =?utf-8?B?ZXhZMzVhRG83YlBMc2Q2ZDB6ajhuaGNCSzRXUEg1Rm1xVlAxeUJCanhuT2ZV?=
 =?utf-8?B?M2dGdG5TNUZpa3AyOFNzWGE1Q0pNOFc0a09LSDJtNkxjeWpXV2ZYbnNxTFo2?=
 =?utf-8?B?UDdVQUt0VHg2ZEdYU1lhTlB5dWt4VGJQdWRRMFB2czk1SEpPdDZNcjNWT3Vn?=
 =?utf-8?B?ZmlPYU5jRDdhQ2VKcnFLMG5vQWhJZXZxZjN2anJFcXloQUxmcTlmOEhLRGJy?=
 =?utf-8?B?b0hHcldYWGFpQnhEUk81blovUU0raUxOditIajNlM0FDNjlndWlvcStTMlpK?=
 =?utf-8?B?bXFsUU9zM3ZpWUlkV1RZMVk5UmppeGg1S1RnVFVwcTRGVG0wbkpTOVlvOU5m?=
 =?utf-8?B?THVvVU1wZFVqZHZueXo0RnlTSVlPNXMyV2RveDk3V2pUeWFwTnZjeE5QVDQr?=
 =?utf-8?B?R295NnNXMG54cjBtYzBidUtkTEpXMzRVeUdyTG1ITS91djRad3J1eEoyblo2?=
 =?utf-8?B?N2xMbGJrQjBRQXIwejhiVzZZUnlDdVh1UVFPcWw2OHBFblN5ZjJ1S0FCRW5K?=
 =?utf-8?B?aGVZTG1JN1RIRE0wUmVlTnhnYm5wU0wyR1poMksvQTY5ODY0YWoxSGZMdWpz?=
 =?utf-8?B?bVpYQ0NQQkhKZURqUlAya1lmbmorandPOWZQdDVLSjFnTmVRYURzWmloMnkr?=
 =?utf-8?B?WlF1NHo0WWMybmFVQ2VrNDVzVXFFN2V4QVppL1hCWmE2eC83by81RmhBam9p?=
 =?utf-8?B?U3B4VWtNRmduVGZFMlhON0NNcS94MkNDcXd6Qkt4dmsxeUY2Q0NFNjRBZUhl?=
 =?utf-8?B?aWRNanpCR3Bsb253RHNQNmkyc3VFekYvTitUYWRjRjlaaSt2ZStYZWViNEJ1?=
 =?utf-8?B?dHdSRUZ6TjRSeUJnaENkSzE5K2xzNGxBbmdTaGtMdDRzK0JJMlYxUStuMjNB?=
 =?utf-8?B?SXhMcWZESVFkT1g4R1NsMFNpc01ZZ2YrWURMMU5YY0tWWlN3TjZyWjlEV2Nr?=
 =?utf-8?B?c3Mwcm5FSDZyalFOcGtQWmtUdWhldlNNSFdGbEJ1TzQ5c2FqS1dCS2NJTVlX?=
 =?utf-8?B?cEhwOEJKUjljcWt6WDRXQnJOM2YyMVlmVjRkMmRHbkNJSkVQd3IvcGlXSkg4?=
 =?utf-8?B?ci9vaTZnakVkZE82NE4rYi9jR2F3aVVGdUJUVktwaENUUmdQVHFGZG10RTM1?=
 =?utf-8?B?SnpSbXFLSXFLaU9oN0xoNFlIUWlxaitlUkx6UUh1U093QStiZlI3MFdBcGVp?=
 =?utf-8?B?REhObDB2Mm1rWnNXM3U4dndid2JjcG9RYWZrVkpjNUN1L3hsTWxZcHhLdGNY?=
 =?utf-8?B?c0M1aiswN29PSzhoSjhnUjhYazdsQk1LRmdXaHJONWZ3VmVkQzdGTEo4Wkcv?=
 =?utf-8?B?c0tzNE1ITU5HOEN5OUpETk42MnlETERUaVF1bkZFbVpnaGdYVk5QVU4wTGk0?=
 =?utf-8?B?ZWtmZ1VSbnI1dkU0cVFJSGRvanZoUGJOU1krQjgrRExSOFM0ajZaRDkyU1ZY?=
 =?utf-8?B?UkdBRGoyeTFNdi90ekU3YVlnMjRLdmlQK2NhbU1vYm1CaXV6YmJBUmFnRXVk?=
 =?utf-8?B?a0xTZXlFTWZwSjQzNEJ1UnJKZTNmbDFkM3I3UVFlZFdMTDFKbVcxbHExVTEw?=
 =?utf-8?B?cDBaNHE5NVg0ckdKMG1PMFQvZ1puTSthd1BZS1FDTE9USHZ4L09pMi9UR3N5?=
 =?utf-8?B?WDRSem5sU2l3aFFMbnRSNThVaGtRV1VJS1BkT29QYTF5TllUZEFPMk9WNVV0?=
 =?utf-8?B?REtNd3lsVWhiTzZUVTZTQlg3UytMNEI5RXpJVW1ma1NrQTQ4dmhGZW9BUmdS?=
 =?utf-8?Q?5S5xBuPp?=
X-Microsoft-Antispam-Message-Info: Hs324EHiJUH5BMn5zaKgjWspKLzekTAo9YAvMmQcfGapHpElRN3fwQvP6Gd7e5kJj4SjEfSmgFL8HeopZQmtquHjFRwU0239+oXu8o/46BRiVXEWhoF3UplK1VJA9aXXbagEjj54iUagq99oKgN5kDHW51XkjNOe3+byBD0Vp8lHyn4z/xLFhxVRhXOsmHAq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:Sx8UrZRj0XzVfF2+0wvKqFis8Y/PBjkJwHpTg2aooTjOa003uvf+ijikFD50+8dZ1rDs8Ly5mC1GnRKq/sQV8K9kbOdlhj4B5yGmR5++HfCokmBTDWTz14MfZZuWU6o9q7JZIglkvcx97dw0gFFGybTMukRcopgYeTYxZC2AFyDslWcHqiv3VbmSzCcDj/bsGcbsZDFHrDtkV2TNQ1N54PG1v42c02AuL09MMOrCRaSX0fk/8bNImq54UVyB86rdGNjbQmU9QizJc/hlaWGVQfeY4YP86FerMsE0TWKUvm8Nr4nRq/zG7UXnC2KMNzN3O1b9G03ME8yA8i4S3zT5tvO20npXoAJ21wihMvITSaEImCGgzy8eQ81vyCnBoMdDYkjX+wY/oNCwPYH2xDzKDeJ88Dkc4eu+HTN11zKxdfznIrMVE/ms3a4NjuxcHGEoI8rIz8MYHhxJ37YxYOFhNg==;5:yst+tGkEGlGR6Dz4zgHVRJsUrjHq+vLS4UKTKH9dUYQlkz2w5KDMOYml0LJSyYqNDvBV328L0+exF3Qqwob4+H8cVvsXWxsIeNLrqDeoh4XvVoeaiswaGn0WvFt1C6L/KuxE/gQ3O+xWdT9RyvDEiZgwXAzIRjzll79q6YdmBGM=;24:2hdLYgseV4xtWfFZuEwTOSlieGsMXPVlPzpf9cb73G4ZXokMQmK0xdhdbqkdtQn/xpCT3aGFFPV0ilAxzqbrOzbrcY9D/qOGTsq6jNroaJI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:Mu3lAJ7vXsb+IcDCjW2/4oYELqy9DM23pOHk7RA3m6oqhwjz7gz4b4J9GTGx7dKcU5FbqhXO2YFq+kos4eaG8ee5n5zRYyK+IjEIykeLoG4qa4AtuOUUNllIOFV0cSDdhVg4XYpfiw67AECEluE+VItGwYAro9XwlW0v1t5bO+Na/1f2esPeIMDhMYfDLuEFlx9oIjzy3Mm5UWHzd80QjAqQSSZaoJjMUBFhw5xLNUFjTTssad3B1VMBlFhCybDD;20:2kpHgSKNA84eIYWlKDqmUXMc4fmpz99Xah8fCB1QHXDMghJC+Kj4QFJ1PozcyOuQTV/Gwhx2F9lECk7ndbU44fCimH671tW5gkF/HHy7JOqvWZQ5Wuo48nrzsmgMXr2c0UGyVy+GqjpRVsPUCn1b6JFa/Ibq4Qcthp7LNcds0xE=
X-MS-Office365-Filtering-Correlation-Id: a37119f5-11da-4fa4-7f48-08d5ab5bbdb1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 09:54:45.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37119f5-11da-4fa4-7f48-08d5ab5bbdb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

tg_rt_schedulable() iterates over all child task groups,
while tg_has_rt_tasks() iterates over all linked tasks.
In case of systems with big number of tasks, this may
take a lot of time.

I observed hard LOCKUP on machine with 20000+ processes
after write to "cpu.rt_period_us" of cpu cgroup with
39 children. The problem occurred because of tasklist_lock
is held for a long time and other processes can't do fork().

PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
 #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
 #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
 #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
 #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
    [exception RIP: tg_rt_schedulable+463]
    RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
    RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
    RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
    RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
    R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
    R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
 #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
 #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
 #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
 #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
 #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
#10 [ffff886537ad7f08] sys_write at ffffffff8121faff
#11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d

The patch reworks tg_has_rt_tasks() and makes it to iterate over
task group process list instead of iteration over all tasks list.
This makes the function to scale well, and reduces its execution
time.

Note, that since tasklist_lock doesn't protect a task against
sched_class changing, we don't introduce new races in comparison
to that we had before.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/sched/rt.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7aef6b4e885a..a40535c604b8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2395,10 +2395,11 @@ const struct sched_class rt_sched_class = {
  */
 static DEFINE_MUTEX(rt_constraints_mutex);
 
-/* Must be called with tasklist_lock held */
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
-	struct task_struct *g, *p;
+	struct task_struct *task;
+	struct css_task_iter it;
+	int ret = 0;
 
 	/*
 	 * Autogroups do not have RT tasks; see autogroup_create().
@@ -2406,12 +2407,16 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
 	if (task_group_is_autogroup(tg))
 		return 0;
 
-	for_each_process_thread(g, p) {
-		if (rt_task(p) && task_group(p) == tg)
-			return 1;
+	css_task_iter_start(&tg->css, 0, &it);
+	while ((task = css_task_iter_next(&it))) {
+		if (rt_task(task)) {
+			ret = 1;
+			break;
+		}
 	}
+	css_task_iter_end(&it);
 
-	return 0;
+	return ret;
 }
 
 struct rt_schedulable_data {
@@ -2510,7 +2515,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
 		goto unlock;
@@ -2528,7 +2532,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return err;
@@ -2582,9 +2585,7 @@ static int sched_rt_global_constraints(void)
 	int ret = 0;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	ret = __rt_schedulable(NULL, 0, 0);
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return ret;
