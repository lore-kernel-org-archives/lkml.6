Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZohRH0EYLQD9YyhOwyy0wYIuQQpNuiJ4KxJzDvQPXLWm5wMGfBxcnfBlNtL7POQ75zW+rvu
ARC-Seal: i=1; a=rsa-sha256; t=1526937853; cv=none;
        d=google.com; s=arc-20160816;
        b=u5Isk/6p14MARdeguskv0twVSUyNWO138jG+R8UAK6h3jZXDVr+WJoQwa8A9YH1rDF
         NxgtJ7ztv2ZOxeQgd15tY51W+qsnb7xZ6FEUku/G+055nBXX4qXPhYlm3F3x3Y6yl61T
         Vs6oaRsmBG64kyZPTkaAfwu+J8LPVGq9D6vJLJ84KiWcBidJSEpmP6zIxuUttdK7phmU
         vBzohDHCqJFDdVFYarxDf1EMKgV2UO3WtPfLF0Selo7h//VtMlPfWCSniGbIRn89TOpb
         Jhk4ryL2JcJUbRAZeePVK7XZgvMCZ/Suuf/tzR2iF5PLErMVP4Rcjt8G9XiG+qzuXIZe
         J2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FDJXtTpBParWypUTTBavFRqJjM3TpsxlMoDnHT4iyBA=;
        b=QUufeCa7H+fXu98+dTVgDpgfAUCHsaogDSHnQ2/L/nBhFN3D1dqrEcZro+eDixURUV
         UIIWfPRpmxZMatzPD1uzg9qe9wuiVzBSe00fBYa7l2eJHhb+DV+EYRi4wsLFnZOdSKV1
         6Yd72eMcmbbaX3vXq7lv7Fqx4snSmdCdcoqVJM813Uq62zpf3pWY41WLXYx+H/9dXoR3
         nRdR8WEw3l8+B151qYyhiitZTzir2+U9bA+6yIsIhvvtbGs99r7wrGDIGI2Mq2V1lhcd
         zUHMTgX6z9R7eB86m//4zumbNDP2vyn7UQ6A5lYph584yTkQfPDCDPibZlFW8LB6P2uC
         CHdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ja+DpWCC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ja+DpWCC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rick Warner <rick@microway.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 049/110] x86/apic/x2apic: Initialize cluster ID properly
Date: Mon, 21 May 2018 23:11:46 +0200
Message-Id: <20180521210509.104011988@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110386546561123?=
X-GMAIL-MSGID: =?utf-8?q?1601110386546561123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit fed71f7d98795ed0fa1d431910787f0f4a68324f upstream.

Rick bisected a regression on large systems which use the x2apic cluster
mode for interrupt delivery to the commit wich reworked the cluster
management.

The problem is caused by a missing initialization of the clusterid field
in the shared cluster data structures. So all structures end up with
cluster ID 0 which only allows sharing between all CPUs which belong to
cluster 0. All other CPUs with a cluster ID > 0 cannot share the data
structure because they cannot find existing data with their cluster
ID. This causes malfunction with IPIs because IPIs are sent to the wrong
cluster and the caller waits for ever that the target CPU handles the IPI.

Add the missing initialization when a upcoming CPU is the first in a
cluster so that the later booting CPUs can find the data and share it for
proper operation.

Fixes: 023a611748fd ("x86/apic/x2apic: Simplify cluster management")
Reported-by: Rick Warner <rick@microway.com>
Bisected-by: Rick Warner <rick@microway.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Rick Warner <rick@microway.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -116,6 +116,7 @@ static void init_x2apic_ldr(void)
 			goto update;
 	}
 	cmsk = cluster_hotplug_mask;
+	cmsk->clusterid = cluster;
 	cluster_hotplug_mask = NULL;
 update:
 	this_cpu_write(cluster_masks, cmsk);
