Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755686AbeDZLCF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:02:05 -0400
Received: from mail-eopbgr50129.outbound.protection.outlook.com ([40.107.5.129]:36722
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755248AbeDZLAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:00:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 1/4] exit: Move read_unlock() up in mm_update_next_owner()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Thu, 26 Apr 2018 14:00:33 +0300
Message-ID: <152474043375.29458.13978538538182642678.stgit@localhost.localdomain>
In-Reply-To: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::29) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:uYnD29qdiiwcnHuJhU+LjquRoEw59CWSVCdWupEfVXtu5gWeHRaZExHFgwKYnisXYqK5TTBffIM1o+gyub85pLHZAGSBs2iHi0nj7JiXWsTUk5Jwo/iEYeY5c7OPR1sBPQOrfu4SoX+IkbZG+KmBqgmULYddVkavN//XKpgxgAzLX2eX8DD8wlDoCntSf8NWOaFOOGbSaugdrbRrK54W42us7ZXf2vfF2gcnNlPI5kGTpGnbVKBntZZK+/WASbn7;25:xiEeCu2v7AVwcZpcWQ1Y5rbj7b36gliBosIyTYDbwhttxmIlHxo6BEWxD9A7Y7E+LscY3XvGhK1sCtIYCwlX9121wrujhsttnO7B6flu1HxRzeGmcAZVGaqp9cY0N3iUkiA1CB3jgvn0jDASAixhptjue0kDLqqsBfK+tMrOj5lpqvzO9invZ+EpLRvUgUpgynDWsfk+R4e576aDXKQ+q0zRuhWBddAba0bluNG939MBdjzR8q/DfSHqQ5D3rj6qqqiKQdFGuegOVAV8SeuYAcPntVYnVDI0vlDpWhfeRNAnC0VUUwapGe8wzS3+sEbYxPfpfXLnmwsBuzlVgtBO/g==;31:APoFlyxfeBBXcxKBpWAY30MwVGHzRsoneRg3OrWETmkbie//MTTw/svSTwqyGnS+ri/A1ygfZbzJV4q87PUDrb8KGTcURnjuNSDf0xTSnEULyGaAZIQNYY0q0LRlV3P5pPZPWV0TMgRTKp9SLUtxvgWUDQ5iTKk7Y8I3BhN+7g0ZkFC5sFNxYVWgV7vG+49iTTYQiu5JPXZEh2mwJqDJxLrZFQVumnre3KfJYc6tW2M=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:7lxctH2tAOf+Wnaxsnaog2oYGKDE6fzdmgW5l5kabDtj11jAkMwHAZ0LMXxC8urPz4cGQGCV6AfZfZh9VvxuE3crjubLO7kM/eYpqM3d73wFl5wP4HrmlQu5feRVmab11jz0IPHC8YzDEE8YSVK5ItapjZDG3X1eBe0ZMjLzQCBaAQ9YhhvchE+u0+TmWtFsN0D/PuJPiW7sT/pmpfir78UMjlrgKnk0c/smnyYQeuDRxZPg8OngHmiuS93fj2OMvCuO6dDrVSfSKZMkkx9i9TVq64O/y2h56WGNzZvOR7UFBo5wEJMONg4n+nNTdncDQstZUGmLgM/l5INko6g1TxNEVFAAxGt0af3fAR0bFn2czDBVNHMOjdGI2J/IIX6Tvjpev4y4QiXXhWSrGVmQTlisOl5I/JFb3qJ1HIregWyw8uutpQFbz/qkFyauAo/u1y5xH+6Fc4Iyq1Jq2GZNWC4JI8Upz62F5Yq6IhxKDDQtQItVOlsXP2jXMKjNnQR6;4:/EKjxR2pTixEOTmKINfDS5GmQWtxpHlk1D+JpH4r4LAnajEYeDf0BW57Hq6htCfQfI+KrMvgfF99K1HrBZEqBbgQpUDX0kqU513525xMFobchpDld6U4OQmBs/c43+3UvByaA46YsekmXTg1PDWSbB+F7t8rfaax8YzfbYaj4IxVMAdxQh9xCTytUBO8j9MkUeM8S6ut+MGqJRnwz9kDfDjWlhJuy1BYozzBmz7Zk8NrH2wJl3DXC4IWqcYxlcqWfF8yGj+uZveCCKOOLErGmg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1335191086482662C6912AC6CD8E0@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(396003)(39380400002)(376002)(346002)(199004)(189003)(11346002)(58126008)(7736002)(81156014)(81166006)(6666003)(7416002)(16526019)(478600001)(53936002)(486006)(9686003)(55016002)(8936002)(305945005)(446003)(68736007)(5660300001)(86362001)(2906002)(956004)(8676002)(476003)(105586002)(230700001)(97736004)(25786009)(3846002)(6506007)(316002)(103116003)(33896004)(386003)(47776003)(59450400001)(39060400002)(52116002)(2486003)(50466002)(23676004)(7696005)(6116002)(186003)(26005)(106356001)(61506002)(66066001)(55236004)(76176011)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6eEtVMnE3VVphenQrUW1GcVlSSW9vTjND?=
 =?utf-8?B?MFFTWEJrMmVLZ2JBODBoeXdycmNaVjZKL2grTG5YcjI1d2F6TGNEOGgzNmVW?=
 =?utf-8?B?Nkd5clVBSUZVTkxaZFV1MkFiK1Z6bWE1NjFwOThjY2Jja0h6RGY4czY1Yldh?=
 =?utf-8?B?REdadllUZGE4Qnd0WTBuZ1JRL21zeVl3QVZJRUJQNVJkZVJGYktRWlcrZ3JF?=
 =?utf-8?B?b3dySWFhelNQdnByUmVldDZxWG9qdUs1U1F2MVZpbndHYUZhNTNFQVFRb2s4?=
 =?utf-8?B?SzVHcW5DVllQS1pKSFllaVNsamlwRzNFcHAwbytPQXlUWUVORlNEcHhmeXVt?=
 =?utf-8?B?ZXBMNmE3dXFaS0x2K0RycTlnZXNDRERkZkg1NFZjR1ZaTW1KbHBrUkUvTzlT?=
 =?utf-8?B?Q2RVVXR6NjZBaFFQRGo4bVZaNkV3MWRRR0xLYXZ6YnRCVEUxZVlwS1Z2V2dT?=
 =?utf-8?B?WlVRaWxON1ljSEJzT1Q2WEtpRE5yR29mK3NIUVoxY2FKV1lVZkFVMWw5NVE4?=
 =?utf-8?B?NU5IOHdQN1FqaTRVekYzS1A3WE5yekVnbzNxQnVQUlhKR2s0VGRTSVJxcllm?=
 =?utf-8?B?b24rcFhxa21NcXNLNGlMQS9zZHdsR1FWY2FWdytUb0x4ajhZZDMyWGQyaWhz?=
 =?utf-8?B?VWxvVHRPMXN3ZDlDNXo0U3ZBcDYwOW1IZjN2b3lOczV2UDM5dnVZbGFaWmN1?=
 =?utf-8?B?bnlCVEZodzFTMmRUd20vNDBnSmROeDNQVzRtSTZxWmVLeGFJUjlibWt1bDBM?=
 =?utf-8?B?MTloVmh6R0Q4Sm9qTVdiOUtTUVVnWXAydklMWHB3azVNcEQrd1J5VFc4L0VO?=
 =?utf-8?B?Vi9LdTFoZ0xUQWVaNXJ1bU51VHFWTzV4bml3dzRBOXZmejFwaVNjR0FYMXht?=
 =?utf-8?B?NExOc2F5dDVLN0FCTnNmczZtZnVEcHZLU25MTG1maExOR2tEUGxBZmhhQlhu?=
 =?utf-8?B?Nm4wS0VtdmFxcldrK052ZTE1bWdndlNEMWR4TElYR2FSLzI4ZlpTSDBUTHdL?=
 =?utf-8?B?UlEvMzUxS1pmWmxIVW9uRHg5MHhZV0hSRGRjcmpvUlpOZnkzVmxBQnNYWi9V?=
 =?utf-8?B?YXF1UmpBTS9wb2xjVFdPS2pRbXFGVFZna01JUEpPMWpDenVkN3JhbkZXU2tI?=
 =?utf-8?B?L1pEdkZtMUVXTVBwakFUN3VMZWhuOGUzUkFsemwyOHNKT2JQUy94L1VCa3RF?=
 =?utf-8?B?VE9YU091Q3Qva29hYmVuZmNzenROS0xKdFNYL0dBYnNTUFdMQXZ5Ni9kVU1k?=
 =?utf-8?B?T3Y5NVp2MzlEN0hCTWF1bU9WV24zZHJReXNPOXZYSDNRSWlHYTRiZStaRjR5?=
 =?utf-8?B?QnBvdFJQbjhyclBDdEVFejdVRm9WYWJkVXg1MGE1R2pTM1IzMUpUeEN1M0dH?=
 =?utf-8?B?a3VrNjl0T0pMZDhXMHdaS3NMeTdiNWdIZ084eER2MzFYSENnL1JTc0dRU2Fx?=
 =?utf-8?B?clA1VUtraE12ZXpQK1dmbnJCYzJGZ3I1OUo5RmEyNldQd05xNTR6M3lzdm8x?=
 =?utf-8?B?TE9LN1I2VVFpL0lSdEg3SnBFSlkwMzF3L2owdzJmUkxzQ3IvY2NTQXdjMjAw?=
 =?utf-8?B?dWlvMzlGWGhEWnJVVHFaYzBqTVpGTGtrbFNGSEk4U2xYYkJEU3RpbXB4SUE5?=
 =?utf-8?B?bHFEcXJWWUdMeXRXS3VUcHV1KzlwaU45cDBqVUprNkNpNHU3SzhZeWlCUkhp?=
 =?utf-8?B?T3Q0TmVpWGhIc2dQQzkrNFhwQlllUzByY0hTZ0UwZmF0Zm53L2VoQ0VFNXlp?=
 =?utf-8?B?UFdJZ3BKZUF5RTFQL0UxUGVWb3lRQzVFR2pRR2NYdUJWOTA4bkN1eTJRbmo0?=
 =?utf-8?Q?ziPdtFWdFI65UOd?=
X-Microsoft-Antispam-Message-Info: i6Ed9JIzDTw/SQZCCRBjnBJ8mvzuUX6neuE1MpqngWp4EsbpjxZvbQCZE0HCqrr2+fYfPP06ImqwDrD4Mr4Z33cUNQ7BM6KyduAmICBZ9fMIWQ/sAbFFh/5IRL4B+sPQXPS857HSGspjjfxfsGSeUj2hpneHyU96ZNcgHIk+150tBUeqwOEcJjwJPSwSrW7Z
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:DDZbNNfoxe8QZMDcgOyyjk0CioRjYnOXao50nUNPlg9g28RCm43ESFEa0nFOMMScd8zICJHe1Akf0RKWZP5OogXVcc0vGKgFmkZb7OhQ02iMVChAcixqC4UcL5N9z0uBA4b2mPiWXl5I5iXSJ3y2/TJ5MU/oY1zuKJBwYBzb2oFGYTdQ7io1iK35UVs7HtuhHjvqKZ0fhs7AuURi7FXyDPneEc4WYigqtQQBQqIW4aXCPniNsJ4GvNlfmP5Zsq2JRA0yWzoJ40+SFHRQm7Vg3Zw9RYvQUn/KQDLCi7qzx0ZhhfOys4mq48X3trRcEZAH7a747ND3UM21jzT6Q2/IUm8EyVy2wEptdxpgMEqrMiFx6ScIMJK5t0M9o3iemHvAyCIZ41VExqKO+S1glDFjJHUVVcWhRVcjHRqTZ13mzDn4MBaIaCozHTjJhGHC9U+BLatEORrefYhlbNUbYeAWYw==;5:KktSR7cglVfCajdMijtc/UEBcUYNod7JlAUUIvkzRQMa3Td5vWGWHwna6v3Ahe8KTo2UzjNsrsdVHK/+poiUm7aHwy6bbNUPz2FZOAi9jG/EN0nA68pbQQZhWGXY97pAKznonfOD7Ej5Xd4MK7Ncv17kgLnorduR44psODUa1Jc=;24:xYATyauGKCuos0N4dbOpOpmuxO5JJbE8VOKo7DLGwrr/uJsqR/c2jSA8gH9kdatRoKecQ2kkx45N91C6H7V/fkBgoUerv6VTYTlR8nOgmk4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:ogjBjOUBN5VJoKGeEVn2aj36s/EXS46gcOP4zgLlEwiAdax/SKQvQZDoTSAWgaVMe+JDiZpZrRGT80LCxZrAFDgTN23Hp1KHmt/F0k90lv0mc7ZmnlJCYhVu8MdF9pAUBekm3lPAIpKOC/ZA+sXJs+wIGi8wqVwhSHe9ut80hepwjGKhtoeAwNY+erkwCbrBA4bRmsvUNpNAcH8ulHsfsqe78f603YvCEiJ4e7zj9m8fqjexN3lct2F+vsT8Z1sJ;20:DCqHo6gySrNFCi1ShnVXylyxsUmWnRmMuWGE1Mo6wPLipsVy8tBCVH3rE/L6EBP+pdkkgNmbqJvrY6uQ5+lRjHETCTYpWTKhZlHuwm8pdorF7TwIlR71DoZrFLnZpac1grhk9Tn/moh2lPqcS0S/EtN2GvoUkoSre+mtvnXye8U=
X-MS-Office365-Filtering-Correlation-Id: 193ec601-299e-46b3-f331-08d5ab64f51e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:00:42.5005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193ec601-299e-46b3-f331-08d5ab64f51e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the places, we update task's mm, are made this
under task_lock(). These are exec_mmap(), exit_mm()
and kernel thread's use_mm() and unuse_mm().
The only exception is copy_mm(), which initializes
newborn task's mm, but we can't race with it, as
mm_update_next_owner() iterates tasks already linked
to task list.

get_task_struct() guarantees that task_struct can't free.
exec_mmap() and exit_mm() both call mm_update_next_owner():

	task_lock(current);
	current->mm = new_mm;
	task_unlock(current);
	mm_update_next_owner(mm);

and since mm_update_next_owner() checks and assigns mm under
task_lock() too, they can't miss they became a new mm owner.
So we can relax the lock and release tasklist_lock earlier.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/exit.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index c3c7ac560114..9fb7b699bdeb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -464,18 +464,15 @@ void mm_update_next_owner(struct mm_struct *mm)
 	return;
 
 assign_new_owner:
-	BUG_ON(c == p);
 	get_task_struct(c);
+	read_unlock(&tasklist_lock);
+	BUG_ON(c == p);
+
 	/*
 	 * The task_lock protects c->mm from changing.
 	 * We always want mm->owner->mm == mm
 	 */
 	task_lock(c);
-	/*
-	 * Delay read_unlock() till we have the task_lock()
-	 * to ensure that c does not slip away underneath us
-	 */
-	read_unlock(&tasklist_lock);
 	if (c->mm != mm) {
 		task_unlock(c);
 		put_task_struct(c);
