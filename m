Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQs5sNKUKIYF4mKSxxeSPJ/b1W912cxiCo1fBGzwTcQ6lX3Nb9GY2HtxwlOxzaQreu+hAn
ARC-Seal: i=1; a=rsa-sha256; t=1519981445; cv=none;
        d=google.com; s=arc-20160816;
        b=bsXIbs/8ygn+zNeNmhOCgnErQsIIFpKv0JhN7Q13K6YFlYTKl/wmhyG1Wfr+dJkj92
         fy6p+0S6nK+2m4o9G6kYVXKjtQZwoS83c9dwOQm6nCxEdQyqBjOWAjezgg+Y+nF8zBxJ
         j/YmAOhW+ZLumU8HWD7ELrHJChQeq1O9+/5fnbdNKlLHW9cZjyJYZh1MQEVghYg4FoHi
         jnU4BGnfGoWZlLYlelBKLxACmg5gLsrKJdy5TvPCIWaGq4yCjb3FB2iH6ZK+yFPepzbg
         vrxdiZkfaekRSn4YEImUR/+WCVs/nk2lIHWR8yF9AawfaTcAY2gSiWorMq27OSgjkM3e
         h4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BA92QFEUHs9EBA6tSlcH2gIgAJduhG6cCAyiUwfv2+0=;
        b=goh7sitBuT0fQsl4ejvnC3znFljDo4FVzh4/wH0Dt0Yx9pV6TaXaUHRnt328HbMDaw
         3OK4DGnXkC2K4AM65e/NaTp5VsMaX9heyl6SCkvuCmgnI5Un7ict9EW1QNq82IwRvYMj
         eAq8I/xW7diNhnjZmoTY2mZxej4+pSCuZgW480yB1rzIZTUSJbtD7Lk4XYJh1OfX1kAV
         A2nm7jxEpl8lYtfSZOMw1RhW79uj+aUC6EzproiXGBLmoghkrj1Fs2dybxKrzfiD2Mg8
         8+evfjUC33v+YN6f0krOMTDBuRu+ORjE/GHs21tOR0cwfdLhgxy/buVOjhvvkosD/dAy
         Y26g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Min Deng <mdeng@redhat.com>,
	Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
	Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	David Gibson <david@gibson.dropbear.id.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 092/115] powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ
Date: Fri,  2 Mar 2018 09:51:35 +0100
Message-Id: <20180302084507.575230806@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816064137372436?=
X-GMAIL-MSGID: =?utf-8?q?1593816064137372436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit e2d5915293ffdff977ddcfc12b817b08c53ffa7a ]

The hotplug code uses its own workqueue to handle IRQ requests
(pseries_hp_wq), however that workqueue is initialized after
init_ras_IRQ(). That can lead to a kernel panic if any hotplug
interrupts fire after init_ras_IRQ() but before pseries_hp_wq is
initialised. eg:

  UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
  NET: Registered protocol family 1
  Unpacking initramfs...
  (qemu) object_add memory-backend-ram,id=mem1,size=10G
  (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
  Unable to handle kernel paging request for data at address 0xf94d03007c421378
  Faulting instruction address: 0xc00000000012d744
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-ziviani+ #26
  task:         (ptrval) task.stack:         (ptrval)
  NIP:  c00000000012d744 LR: c00000000012d744 CTR: 0000000000000000
  REGS:         (ptrval) TRAP: 0380   Not tainted  (4.15.0-rc2-ziviani+)
  MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088042  XER: 20040000
  CFAR: c00000000012d3c4 SOFTE: 0
  ...
  NIP [c00000000012d744] __queue_work+0xd4/0x5c0
  LR [c00000000012d744] __queue_work+0xd4/0x5c0
  Call Trace:
  [c0000000fffefb90] [c00000000012d744] __queue_work+0xd4/0x5c0 (unreliable)
  [c0000000fffefc70] [c00000000012dce4] queue_work_on+0xb4/0xf0

This commit makes the RAS IRQ registration explicitly dependent on the
creation of the pseries_hp_wq.

Reported-by: Min Deng <mdeng@redhat.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/dlpar.c   |   21 ++++++++++++++++++---
 arch/powerpc/platforms/pseries/pseries.h |    2 ++
 arch/powerpc/platforms/pseries/ras.c     |    3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -586,11 +586,26 @@ static ssize_t dlpar_show(struct class *
 
 static CLASS_ATTR_RW(dlpar);
 
-static int __init pseries_dlpar_init(void)
+int __init dlpar_workqueue_init(void)
 {
+	if (pseries_hp_wq)
+		return 0;
+
 	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
-					WQ_UNBOUND, 1);
+			WQ_UNBOUND, 1);
+
+	return pseries_hp_wq ? 0 : -ENOMEM;
+}
+
+static int __init dlpar_sysfs_init(void)
+{
+	int rc;
+
+	rc = dlpar_workqueue_init();
+	if (rc)
+		return rc;
+
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
-machine_device_initcall(pseries, pseries_dlpar_init);
+machine_device_initcall(pseries, dlpar_sysfs_init);
 
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -98,4 +98,6 @@ static inline unsigned long cmo_get_page
 	return CMO_PageSize;
 }
 
+int dlpar_workqueue_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -69,7 +69,8 @@ static int __init init_ras_IRQ(void)
 	/* Hotplug Events */
 	np = of_find_node_by_path("/event-sources/hot-plug-events");
 	if (np != NULL) {
-		request_event_sources_irqs(np, ras_hotplug_interrupt,
+		if (dlpar_workqueue_init() == 0)
+			request_event_sources_irqs(np, ras_hotplug_interrupt,
 					   "RAS_HOTPLUG");
 		of_node_put(np);
 	}
