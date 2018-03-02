Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMYsOIEbj/iqfC2RCgyqhvTsVYKeNbFntVnQaT+bbjiP9n0iNgivLLON4G0674XJwpHUh6
ARC-Seal: i=1; a=rsa-sha256; t=1519981493; cv=none;
        d=google.com; s=arc-20160816;
        b=0ZDVycofTKa4oSl52BqQjggVYGMXr1oaqFWb1DcswC+T2ZD1k7f8wQ/AllEM9q5Bf9
         pGHfKb8VezyKvYBkmm5AjcccSCSXU2xMNrMUwevSuaiDYWcEyEd1+N65UN/jguBx1A8x
         8vS+zpf1WBVS9BF2yfeSCNJoBb5dWWbJ3L5Shd4RqmRyUvqH6sJ+W3EzwtMf2ReIBo5h
         J4Ho7BLWIQCB4VYFZOrmYY4QR+yJ2k3iGndsevk6xc/X4iqzHJj5QaU996PEX2NFu6F0
         LW80Izm1JT3uGJnhayRIDlURkHn+HVoRQaMn9KJ8gNuF6hpzD8rkgLxGu1ywzJKQpEvv
         3MCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TdIXvucEns1GDawYVc/B3inwyavr5gVlOjwq7OUcLWQ=;
        b=oOO/E0ewuoaFopj7PUnNA2IVE4eeB8/Kvm7YJTT91f9FPRWD+w+SbElcPTqPa2mi9v
         TDkeMBb9Z4hwvauSqZ9hsqzmhRHQCqTg7F47g0gTFHmJgjfKIKaQ83CMFcvxH+407iQA
         bVQ6hRVeRjP6k2PoD+rKXrMEh6k7TaAerc+ltL6NBcNDBSkWTa6Zmd7HOPl7/XmaU/vd
         MJUwHb/ox/mLuLLMDtwgVHB/yJSxN5lpJX6hcLR6yyHGN/qcuQFd4z4VAqhWcCllYwud
         zRx+kUIVyefjzEnCK3RkMBummphrBbtxcQ4zvn0qbc0n0p4mNDzwEfO05u0RGi7i8ZiO
         dQ8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sam Bobroff <sam.bobroff@au1.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 109/115] powerpc/pseries: Enable RAS hotplug events later
Date: Fri,  2 Mar 2018 09:51:52 +0100
Message-Id: <20180302084508.249780395@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816114761371342?=
X-GMAIL-MSGID: =?utf-8?q?1593816114761371342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
