Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDEL6Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:58:16 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:4480
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751470AbeDEL6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:58:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com, ktkhai@virtuozzo.com
Date: Thu, 05 Apr 2018 14:58:06 +0300
Message-ID: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9444f0c7-4457-4e44-fbde-08d59aec803a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:2xkAnKWrr5Y3zVoOUdRLnBoVYLGgiaSSVxhrxMdlvcNWuQElxVa9OnNkIwEcen2339t0sAvA4yRD9QYFr8ofOkUkdtXS69kV0Im4vPQD+umFgpfYA9W5nxzvtpksnMFPuUhnU+N/96edQZ0GGdYwlLqOM7v8BJwKZOSzbpWFoP8FBujAAEkOC0MOTcBL2ohOjqceFDoaENTYiL7P7wg8NctP/QTn33DFexr2mFh2u4/Ydm8uc8FL2KoDv5fwNpHo;25:udC1JX5CFHooPyLE4pqyjd5EUR5uQ+H0pd3eBBj+eCTf6+ZtaoA++pbTEyUUMU/mTgeSMV6JxbYv5K3QjnQ/Ciy2+Ts/go8FZrAxa9WoALMekrqtfApJQmFWpMHmCpxa35ggSPJF8QmlFaLT/BDwafxpzsZt22TJn6yVN/4ax44MiSzE7J7TEzNzeOCYlj+H75d6/rY24AnkNHCcY+/xKBLTWi76WoGfadZCTyt503D++/YpMlA4VG6HEa5s+KsP2SLhvqk/r7KV2p+3wZAlSxwfOUh+MntgfgPTHiN6RjXV1Nbukkq8zHjVNO8IBx4NH/EWXa05ooHgFBf6mNChHg==;31:th4gcroithzeaHb/gIx4DsrmTlvd3RaCpZKaoxZE6wDgLgW/ElXtiPPxLBG80vOH2xXW1bMO3Vb12U/zCeAyMFNhsxZZpzpFbcBERlAR89H9R18dROlStxs7zNveOIVcYnTFlFG4ZQXjTMhKNRRmVTq8ydEpUdMU4zRYmomDBG/n5gIHR7uq/BrOZSa3UuyQu+lSl4+mzwdnSJGoBmrCdpEyFOQdt12gZtJ80em28LI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:BNMFPC/4JvQ//n8WCxe1d7XUJnog55x0fX5B+LWinT82J8T5afY81S4JHT3C/y81RF5CSfmQCALdmnqK27dvGkRPg6v5t2iAhOPbrnltah69f8hfVdEnT2RI9GHCJ13CY8aUx5WKyEiaLORdPPSc8RcIMQHgzhamfQG3r1rI1ggkz2tv/D36lPP0c+ua1g+ylNUfe8GBl7jbJBdaR6XwJxxYr/pcn0w6FrOYmSipXwOwi4vAH56MPlaofATkoy77msv5042zWs5N+PQLf0LVo69FEZHcNVEo1p19F91G6HIMK4+7a4sny6P83JRSMWZT9qUykkZmeyUAyks399fS/cKqitYZ7Hdg4tr7x/EgGH/cCXZCvyNnTEu0zVSu8X1HRUB8n3CIF+l3jALplZZ5XB7sm6BySoezebdOnbvA5VfpwmrtBdpW6pnnJsJAmGWhFnTcAhepnZBKbEvliaUUhzZk/8BCziKbZletAuzuBo6OWqpeMl+zvPexRlhGfR/N;4:e6cxLjUM79ceBxsyCpf1YYcGlkVCJeoxydU/jM/BFvWuOd5zHMPo3UJm0T+X6ltJiCFg5Degvf1TJO2Oi0vIfSjUjyy5z1YD5kBJvnidEgu2Wgd40Z/xD8lcG/InsQ13g2aUK1CTWaVH+cV7BBz4xYGwlqSdCtDgmdb7tqL+g6TJEiYI+YiIwi5yXfGq9cspXO/CnGaoWfMUcq9a8w/H0BZsCeBmWJ9NPjoGUFSSOFrUsCdE0Wun8MZ9grqdrsX06HqqmHxJ9N47UHV2YvhCig==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338D7DD678DF48155A1E946CDBB0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(59450400001)(25786009)(5660300001)(476003)(81166006)(97736004)(6116002)(39060400002)(33896004)(8936002)(486006)(55236004)(956004)(3846002)(81156014)(6506007)(386003)(9686003)(53936002)(55016002)(8676002)(52116002)(7696005)(47776003)(316002)(58126008)(23676004)(1857600001)(66066001)(103116003)(2486003)(106356001)(105586002)(478600001)(230700001)(68736007)(6666003)(86362001)(305945005)(7736002)(2906002)(61506002)(50466002)(186003)(16526019)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6MTZGbkhwTjdDbGtYMXM4N3pEb0JCQWNn?=
 =?utf-8?B?Y1pvYWE2UFRheXNmQ0hGdEJ1L2JiUW4xWHEwT2dSY1BleklMZlY3bStoK0ZN?=
 =?utf-8?B?NVpTRmR6UTJXRzJBSytLMUc2UDRpdGtDZmZkL0Y1aTFWZ0J1QS9JNmMwZXhv?=
 =?utf-8?B?VWM1S1U4SzdsaTY0dXZ3UFZ1bjUzeWlPOFdiSFF6Q3pMMVJPMGRiMXkxZ2lk?=
 =?utf-8?B?MUlNVEdTbTRvcVJDOFl5TkZmKzdzK0RlTzRMOElsem5EUmxhdEEvcWhOeGwz?=
 =?utf-8?B?YTY2eEt2bjhiSFV3VGFTZ2hrY1pOMCtKY1ovYnF6dWduSWI1dzZnc21idlpU?=
 =?utf-8?B?aFJJM2dicit2dlpUWGM1YXU0YzkzNytBZGJNbElLY0pOWlE3M1NITzVaR1dL?=
 =?utf-8?B?R05YbmhiRFFEY3dMbE5GTk5tV0h4aEdLbllkNmxibTV3S0FRNWhTWFNIUUd4?=
 =?utf-8?B?NkFwNjZMSC8vSEI5YzZjZnZiYXIzVXdIMTNvbnZtVnlnVVJYTWNWSTRCaWo5?=
 =?utf-8?B?R3FqK0NXbGRIV0pNZXNtUDdvVDVaaFloYTRCWGxvN0J3YmVwVk5qa0N2WWVD?=
 =?utf-8?B?R2U0RU1PZnRCeCtuNFlHOXpRZ01ObHovb0tOMEVWenFDTjc4SHRWYk0zZmgr?=
 =?utf-8?B?aUtNT2RQcHJ6Q05HRmpZK25acXcydkVSbGlGN1g4L1ZTa1FkVjJsWVYxaUxj?=
 =?utf-8?B?Mit5dlN1MDg1QWQ5cUJUMWh0Sy9hVHlublVwdlRzWGpOUG5tUENNdFJMZFAy?=
 =?utf-8?B?bUxmcHpCWDUwSDFDMU1WeHR0THdPNkNiVUJvcVBodTJtYURCa3h4ZmE2c09E?=
 =?utf-8?B?NkdqQVpSZFIxY1lja1ZFM0tKUmRXYzNlcWxqM3JzbFBrbjQvWmRoN1Q1Qy82?=
 =?utf-8?B?UWovQ3lMMnJicGh5OGNDcCt0Z0I4ejhQOFkxais1bmFsVkdMZGhKQWRydkFt?=
 =?utf-8?B?d2lFN2E0Um8yRXZnekNDV0IrVmdKT3lVSFUyR01lZUNoRHB3LzFuSi9laGph?=
 =?utf-8?B?QzJBQTg1WGpLb25QOWVNSGF1RjRHZjUrMXB4VHJLNVQ0dUNmL09xSmtEVTkw?=
 =?utf-8?B?VmZMT3VuZDljV2RFeEhLUHNrUm4rSDRoTE9VT3l4cGxLblgvUmlhZkJ0TGpF?=
 =?utf-8?B?REwxMHhQWUZEVmhVM3pxdmcwbmF6NUtsQlJScGIxMWNlZVR2N0JxcVdVUDhr?=
 =?utf-8?B?SjF3UFlEUEhBWUNndHZzQnprSXRTcmltZmVkMVFMQnIyVXJwTlZZTmxoeFpG?=
 =?utf-8?B?ZThoQldDL1E5RTFoK2M4d0dQMy9jN29yNlV6TlFoNDdWVjE1cXdUSnlQSkV0?=
 =?utf-8?B?Z3l6eUdPT3d6T1Vhb3JmYTRHcnh0TEtlNWJ1bGlNWjJzZzNjcFdMMjlENVVT?=
 =?utf-8?B?L2tUMFhha0hmalJ6Q09SMmc0RWh3bDJ3NkQ0dEVuc2JGUUlZWjdrOVhSMGZK?=
 =?utf-8?B?NzM1KzhNYW9iV083OXFEejFTcEh4aVo3T3pVV2FPK3IrZ1pXQkVsczdFdHpE?=
 =?utf-8?B?b3FodE5TNmxRcTRGV0tYcEhDdm03OGVpY3YxS1c5SGF2S2ZVb1BpV3NoMVVz?=
 =?utf-8?B?UUhzT1Y1NGlBTHdtd3drd1FQUjZlVVlIbFlOOVM5dGpRRmk2YTdUS2pWVThp?=
 =?utf-8?B?c3EyYTRNbS9ScjZPdkRmWXhVRDYrMXJZRW85elQ1bVkrMXgxMlJFOTh4SUMz?=
 =?utf-8?B?YnJuSy8rSFhwekRKMmx2THdDY1N6TlpBWlVBNzBGRzBsa015YTRKRHFLRDRE?=
 =?utf-8?B?eFVLanpra3BFUzgvV2hWSkVBPT0=?=
X-Microsoft-Antispam-Message-Info: VQMhO+gwwGGAWLv4PEifQAPYXGUcHpns4PTii8larUipASetaTWRtSSa2WRyJbb8YPTbYFinlGM3HdIeOdtr6EMoaD4EWfXUK067HURAzk1o4nXVcnd1QK93dd9BUVLC5bVDIgMCLBuEhh/XeGmM3J2A1hrDaHEEf8uwav0zuTtaReinNd7IcEUVDMt+/DZU
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:kFHct4IQwSdGMzLEbcCbGI+pJ4Jy7gpgqkszMYgiDv8DA8cavYu7wJwQodRO7LQOXr6FdBGM+7FL+cjZJAFlYLWsdtmIn5385AdpZto8vb50ScVK+eezhjMUBEEY24jN7TSrZmadM7AdSzwf47C6pbTl0qB0PIGJrcsTM5XDAtPjgkjZCC4rQ1437EKoSQqprUdXARyQjb5qaifb/VmErL+t3uVFrajXkqcq/xqhnNAFt8NgXNmzdZsIMJmDnv+g9napPTOVZ7iNMHz3hawR1Sq6k1X+4a2M+MQT+iQ8KUcGNB5UmInU/NUv2FaQR18i9Xpuf7Ay+Ypz4PPwxczVC5IHubgHthuIwbAzMUCSHjbyY1DUdL4bBc2kmygTW4vYCcpcBor/gknmxQMomHDESPa40HHbx+iISNgSlgKkoqiqkaS1Ok7Cg8Q6f/ZZamacfvUo9/we1H9TwK1p7vM6bQ==;5:33VpjJM/hF779SLD4BhiMDOF2cAQnoCXiVgiJ/gX6qfsL+OeCy/NLsU3JrMzhMA7r9pyIgFbye+U6hKxuit0inr7YZQaYQNWZAp4qN2skcZofiuvXRVg1gBtww0DlasyeaDkO5zS0dQ9l7U7QlAuDzGyfrY1g/0kSkfZdjINxbU=;24:ZeV2yxWWD3DWgsDE/Z/9I4kRUg534qmDZLZmg+qt6yaINUkI1aHqTKu7aG7fT87ecgFWAqRkD9ivQIygdT/RuPQoHE77KyMtU/q3uYXgJxk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:jhFc6CZK+jQ/EDjEDDENoUcQaCHjFEtznywvMDBuQOxPDCRtm+dIJ89kJ+JY2NJJjJjDzOkDi7obf8doNK53hNUGzTvt1rUd7kU4YZYuA4DK8P3cgZb3AJ8TUVH/84bDxe/Zy1lYRQfz4LS058YAbREAssbL7j7qo1Lx0MLi5F3HcCRFCoU/ZcySq7YTKmo6sppiNMI+DYe8oI3j+WEG+FyTbQZ28bVHfvr0kUwigrSYmK8JykLBNuOKfnXomb6R;20:bXqG65DauVPknj/yGPtx5RLrV/mHYl7Be5BUT0Hw5ZlpVh4jvDfsh2nK+Qa4edad8dMVYtmG5MCQ1km8sfkhl+p1qIAGHBFpACfUkoCZFR2hhrMB1gjYrE5ySJ0DL7mOYOBVwcAysXAjaJzPfe1Xgse4KPljlGLEIJdwIMlE718=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 11:58:09.3663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9444f0c7-4457-4e44-fbde-08d59aec803a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I observed the following deadlock between them:

[task 1]                          [task 2]                         [task 3]
kill_fasync()                     mm_update_next_owner()           copy_process()
 spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
  send_sigio()                    <IRQ>                             ...
   read_lock(&fown->lock)         kill_fasync()                     ...
    read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...

Task 1 can't acquire read locked tasklist_lock, since there is
already task 3 expressed its wish to take the lock exclusive.
Task 2 holds the read locked lock, but it can't take the spin lock.

Also, there is possible another deadlock (which I haven't observed):

[task 1]                            [task 2]
f_getown()                          kill_fasync()
 read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
 <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
  kill_fasync()                       read_lock(&fown->lock)
   spin_lock_irqsave(&fa->fa_lock,)

Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
as it guarantees fa->fa_file->f_owner integrity only. It may seem,
that it used to give a task a small possibility to receive two sequential
signals, if there are two parallel kill_fasync() callers, and task
handles the first signal fastly, but the behaviour won't become
different, since there is exclusive sighand lock in do_send_sig_info().

The patch converts fa_lock into rwlock_t, and this fixes two above
deadlocks, as rwlock is allowed to be taken from interrupt handler
by qrwlock design.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

I used the following program for testing:

#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>

#ifndef F_SETSIG
#define F_SETSIG 10
#endif

void handler(int sig)
{
}

main()
{
	unsigned int flags;
	int fd;

	system("echo 8 > /proc/sys/kernel/random/read_wakeup_threshold");
	system("while :; do ls -R / > /dev/random 2>&1 ; echo 3 > /proc/sys/vm/drop_caches; done &");

	if (signal(SIGINT, handler) < 0) {
		perror("Signal");
		exit(1);
	}

	fd = open("/dev/random", O_RDWR);
	if (fd < 0) {
		perror("Can't open");
		exit(1);
	}

	flags = FASYNC | fcntl(fd, F_GETFL);
	if (fcntl(fd, F_SETFL, flags) < 0) {
		perror("Setfl");
		exit(1);
	}
	if (fcntl(fd, F_SETOWN, getpid())) {
		perror("Setown");
		exit(1);
	}
	if (fcntl(fd, F_SETSIG, SIGINT)) {
		perror("Setsig");
		exit(1);
	}

	while (1)
		sleep(100);
}
---
 fs/fcntl.c         |   15 +++++++--------
 include/linux/fs.h |    2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 1e97f1fda90c..780161a11f9d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -865,9 +865,9 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
 		if (fa->fa_file != filp)
 			continue;
 
-		spin_lock_irq(&fa->fa_lock);
+		write_lock_irq(&fa->fa_lock);
 		fa->fa_file = NULL;
-		spin_unlock_irq(&fa->fa_lock);
+		write_unlock_irq(&fa->fa_lock);
 
 		*fp = fa->fa_next;
 		call_rcu(&fa->fa_rcu, fasync_free_rcu);
@@ -912,13 +912,13 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
 		if (fa->fa_file != filp)
 			continue;
 
-		spin_lock_irq(&fa->fa_lock);
+		write_lock_irq(&fa->fa_lock);
 		fa->fa_fd = fd;
-		spin_unlock_irq(&fa->fa_lock);
+		write_unlock_irq(&fa->fa_lock);
 		goto out;
 	}
 
-	spin_lock_init(&new->fa_lock);
+	rwlock_init(&new->fa_lock);
 	new->magic = FASYNC_MAGIC;
 	new->fa_file = filp;
 	new->fa_fd = fd;
@@ -981,14 +981,13 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 {
 	while (fa) {
 		struct fown_struct *fown;
-		unsigned long flags;
 
 		if (fa->magic != FASYNC_MAGIC) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
 		}
-		spin_lock_irqsave(&fa->fa_lock, flags);
+		read_lock(&fa->fa_lock);
 		if (fa->fa_file) {
 			fown = &fa->fa_file->f_owner;
 			/* Don't send SIGURG to processes which have not set a
@@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
 			if (!(sig == SIGURG && fown->signum == 0))
 				send_sigio(fown, fa->fa_fd, band);
 		}
-		spin_unlock_irqrestore(&fa->fa_lock, flags);
+		read_unlock(&fa->fa_lock);
 		fa = rcu_dereference(fa->fa_next);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c6baf767619e..297e2dcd9dd2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 }
 
 struct fasync_struct {
-	spinlock_t		fa_lock;
+	rwlock_t		fa_lock;
 	int			magic;
 	int			fa_fd;
 	struct fasync_struct	*fa_next; /* singly linked list */
