Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuz9I7LvX0cNkJacW2Bc8LWl3imDCXx1s+zhe309t9+ORfnDrPpKOUqykZrPLWH1Lbmz81I
ARC-Seal: i=1; a=rsa-sha256; t=1520451642; cv=none;
        d=google.com; s=arc-20160816;
        b=XL7wtcwRlMwyT0s81jA8xezPhXjq2WZYY5XoVbes+sU7e01FqqQnW8hOGv2sS59r8+
         La5oTt3YcZnQnvitg3b3Na9ghnVy869PNKB/Boo8+PTdxw7m90T+eOUcp0OLcOqYDiTH
         JtxY/oTQVsyG+rWQLpDapeiOjDs2AUbrj5lnFdGdNW4yEoSU2nX6iA9611R0egLSC9TV
         s2HG6lyOpOZhidaRTVSdwmhIvTYFt5zF8k2KRMRS9UXQ0ZEEb80ua9wyfJK/tJTUfNaK
         ZhlD17TnAL281yA9COFeUeHi327U+Bse80WyjWyEy/bvJEOU7WOHiSJqWLWXOUWhLOV9
         Umfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D25R6zUW/pfOiA+Udal7Bdu3c2L/mWg0NxuGglkN4bE=;
        b=HqlEsKJug92b9ICJX47E0Xykn4zDm2A6dOuuRRHsTh6zzsPzxEpzjpBET6obM2rH9+
         BsCOfCJRYZQ+GBL+QlmEoPGIU9uGXeeBiQYht3M2qGXcvitncGm43tbLQje9i+680k/Q
         CahOoulXbVOM7001i5PllEdzdKdNo1UW/Y2u2LXA6YpsISjchkpbWL2noLSfL1VKQN1M
         ZZ9+EQR7ZSv1BH0DsbkIq5d0ksgBKlemaHV+yiICD4CAheAYhh/qO8oW7RqFH1IZVx+t
         bOe+e5hMKYeVOIJBVNWD7C8fVPvomCfixn3I93jLqPZFJlK61KDOV3X8NcsHoarIv5Me
         yP7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 005/122] powerpc/pseries: Enable RAS hotplug events later
Date: Wed,  7 Mar 2018 11:36:57 -0800
Message-Id: <20180307191730.038226969@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309101612595577?=
X-GMAIL-MSGID: =?utf-8?q?1594309101612595577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

commit c9dccf1d074a67d36c510845f663980d69e3409b upstream.

Currently if the kernel receives a memory hot-unplug event early
enough, it may get stuck in an infinite loop in
dissolve_free_huge_pages(). This appears as a stall just after:

  pseries-hotplug-mem: Attempting to hot-remove XX LMB(s) at YYYYYYYY

It appears to be caused by "minimum_order" being uninitialized, due to
init_ras_IRQ() executing before hugetlb_init().

To correct this, extract the part of init_ras_IRQ() that enables
hotplug event processing and place it in the machine_late_initcall
phase, which is guaranteed to be after hugetlb_init() is called.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Reorder the functions to make the diff readable]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/ras.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -49,6 +49,28 @@ static irqreturn_t ras_error_interrupt(i
 
 
 /*
+ * Enable the hotplug interrupt late because processing them may touch other
+ * devices or systems (e.g. hugepages) that have not been initialized at the
+ * subsys stage.
+ */
+int __init init_ras_hotplug_IRQ(void)
+{
+	struct device_node *np;
+
+	/* Hotplug Events */
+	np = of_find_node_by_path("/event-sources/hot-plug-events");
+	if (np != NULL) {
+		if (dlpar_workqueue_init() == 0)
+			request_event_sources_irqs(np, ras_hotplug_interrupt,
+						   "RAS_HOTPLUG");
+		of_node_put(np);
+	}
+
+	return 0;
+}
+machine_late_initcall(pseries, init_ras_hotplug_IRQ);
+
+/*
  * Initialize handlers for the set of interrupts caused by hardware errors
  * and power system events.
  */
@@ -66,15 +88,6 @@ static int __init init_ras_IRQ(void)
 		of_node_put(np);
 	}
 
-	/* Hotplug Events */
-	np = of_find_node_by_path("/event-sources/hot-plug-events");
-	if (np != NULL) {
-		if (dlpar_workqueue_init() == 0)
-			request_event_sources_irqs(np, ras_hotplug_interrupt,
-					   "RAS_HOTPLUG");
-		of_node_put(np);
-	}
-
 	/* EPOW Events */
 	np = of_find_node_by_path("/event-sources/epow-events");
 	if (np != NULL) {
