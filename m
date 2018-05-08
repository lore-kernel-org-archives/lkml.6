Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZrKaeTYtF5hqRxM/c6c4AXYiah1l/GjUyju0ZVK5OpElBZuYMggr46q2mGQU/oHB31eniJq
ARC-Seal: i=1; a=rsa-sha256; t=1525806405; cv=none;
        d=google.com; s=arc-20160816;
        b=oYTGEBDE/RPofMZ9G9fKY/2j1f/I/a0MUe2WzMQhkbRgIVgCi9dcm4fgC1V/w8HYGz
         3yg4ygjERX7nCY4vCjFEbmY+LaYLxxybBH4fUGG0B6XgDu+uyvDL51me7jPm9KL7KEWl
         GPusOoL2MDj4/a73n8O5YVmrO8+Fi5qagDnWsV1liBYHwoeJ/+pPOI5J1LRbDaaIpWCd
         V0mgX5iE/0b460nWix/3OYRvc91NRzer8KFK9OrtOaVo62gJAfiC7wrW347KC2vbnT1D
         neWpIYgZ2OQPmIBPmyZnP1A3yvazQTi1n44BcSiVMDhy//gWynsALfFaXygE9MSeYFqM
         aQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=zYEdgJlJagG0MbsymGVt0rFJsq9R5U2b1QcIS7+iUtg=;
        b=XhSHewzNXZWVPQt+fYdWrdKwQ4d56Uv498WIDKmKm54o/ddr6Cb9o9nprJ+A2U1bTE
         dSAGhmXD21Va0mgKAlcTkfZRCrjpoFOBviG34sLDwzMTPAgvkyxbSxwHXQdAqeeBlamH
         OFMqQsbp/UUqe7FzBm3EA1PuKUA14VaZS3d7YzQ8exKCIZgUjYDGfk5bBigjh/xHeoKl
         mJXvddyt8M4aEnmYBileR2BeVbP10pUaqE5w+iv7ye9+Fz49TGQLoIRAJLN0te0AdBMx
         Z8d9TTAqYVB+r04c4scQbd+vejJVtPqhecUTwFKuPY+5GnCUOR8gDuW7jS9ZQ+baZIY0
         R6iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Tue, 8 May 2018 14:06:40 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Kim
 Phillips <kim.phillips@arm.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Mike
 Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
 Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Robin
 Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
Message-Id: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1599923977519130436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is in the context of allowing the Coresight h/w
trace driver suite to be loaded as modules.  Coresight uses
find_task_by_vpid when running in direct capture mode (via sysfs)
when getting/setting the context ID comparator to trigger on
(/sys/bus/coresight/devices/<x>.etm/ctxid_pid).

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Gargi Sharma <gs051095@gmail.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
Current CoreSight callsite:

https://lxr.missinglinkelectronics.com/linux/include/linux/coresight.h#L285

A quick look didn't find anything, but if Coresight needs to do
something differently, please comment.

 kernel/pid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b19971..92b1b623f3e0 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -342,6 +342,7 @@ struct task_struct *find_task_by_vpid(pid_t vnr)
 {
 	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
 }
+EXPORT_SYMBOL_GPL(find_task_by_vpid);
 
 struct task_struct *find_get_task_by_vpid(pid_t nr)
 {
-- 
2.17.0
