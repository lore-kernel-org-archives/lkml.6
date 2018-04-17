Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48P1LWAQDHH2/hmJtjNdTQEkgZScaxSXfFm0od6M8yn7SSqyryJW+sj9RiVW0e/wLODYA+7
ARC-Seal: i=1; a=rsa-sha256; t=1523981038; cv=none;
        d=google.com; s=arc-20160816;
        b=keWajSFvJ8q5m2kwpxNGQkdqhuN37Stsw3T4QghiH0DpDDXz7kTGORpKLcAfxRrNGM
         sm5BadEWsAsIWAXKOlDyomEi+qgM4gSSFTp6i5s2gHex/BaLkb/sVX7Tm9oA+wF9t4x6
         xkLLr9Ix+t7PcgOraCLK9VKHUjCk37+CNJshznraqgCSL9U1cZeVbn0Gcn3sHmlA0bug
         IrTmOapnqu+CsGaBjQ2MmgnzAqz70Gwlp1IbuaF0vcpiuIGo/QKALiJPTp5u2jZs8NLu
         hYhigzPsDcHjVhX+w0HVFfQ+n/P+V5WP+3un9+g801l7uA9oJiYElby+2mACeSu6dgcY
         GX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/W+aeeh8SHJU51cjh2XoHU8FLgpaCvnsRP1dq9RLPZQ=;
        b=cSp0+sgUDUvUE0KgDK5Q/ml11p3LHaA3XQZUq2Ve3D+jYjUrNMecoIJR+Zc7B1+K99
         1H4j6+MjCOR/gFlCeIG3Elbu0hbwKjqi2xXSGaoJ8OlMotuYMauYbK2ZBdtfXbedSQZE
         zgZwqJlgPW2frYAEaddg1Q9hb61hYyIVwzi8tM2oj66J8yZoBhAUR6pXdBtaXLtyIpoP
         kwdDLRAQIq4pTS+7Vum7QZ9LPh6aK0BMWV7uekyZxALQWRri9TfvK9NAzU2TXwLrGBPt
         YGG2MHV0QWqTww1x9LqhMiJuAU7sCikDxNwweJ0vsbmICuvec0kLWZofq8W1nNAxPtOI
         QSZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	jgross@suse.com,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	hpa@zytor.com
Subject: [PATCH 4.15 25/53] x86/apic: Fix signedness bug in APIC ID validity checks
Date: Tue, 17 Apr 2018 17:58:50 +0200
Message-Id: <20180417155724.340156421@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009870580406629?=
X-GMAIL-MSGID: =?utf-8?q?1598009941575843067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

commit a774635db5c430cbf21fa5d2f2df3d23aaa8e782 upstream.

The APIC ID as parsed from ACPI MADT is validity checked with the
apic->apic_id_valid() callback, which depends on the selected APIC type.

For non X2APIC types APIC IDs >= 0xFF are invalid, but values > 0x7FFFFFFF
are detected as valid. This happens because the 'apicid' argument of the
apic_id_valid() callback is type 'int'. So the resulting comparison

   apicid < 0xFF

evaluates to true for all unsigned int values > 0x7FFFFFFF which are handed
to default_apic_id_valid(). As a consequence, invalid APIC IDs in !X2APIC
mode are considered valid and accounted as possible CPUs.

Change the apicid argument type of the apic_id_valid() callback to u32 so
the evaluation is unsigned and returns the correct result.

[ tglx: Massaged changelog ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: jgross@suse.com
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1523322966-10296-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/apic.h          |    4 ++--
 arch/x86/kernel/acpi/boot.c          |   13 ++++++++-----
 arch/x86/kernel/apic/apic_common.c   |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    2 +-
 arch/x86/kernel/apic/x2apic.h        |    2 +-
 arch/x86/kernel/apic/x2apic_phys.c   |    2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
 arch/x86/xen/apic.c                  |    2 +-
 8 files changed, 16 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -319,7 +319,7 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int	(*apic_id_valid)(int apicid);
+	int	(*apic_id_valid)(u32 apicid);
 	int	(*apic_id_registered)(void);
 
 	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
@@ -492,7 +492,7 @@ static inline unsigned int read_apic_id(
 	return apic->get_apic_id(reg);
 }
 
-extern int default_apic_id_valid(int apicid);
+extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
 
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -200,7 +200,7 @@ acpi_parse_x2apic(struct acpi_subtable_h
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
 #ifdef CONFIG_X86_X2APIC
-	int apic_id;
+	u32 apic_id;
 	u8 enabled;
 #endif
 
@@ -222,10 +222,13 @@ acpi_parse_x2apic(struct acpi_subtable_h
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id) && enabled)
-		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-	else
-		acpi_register_lapic(apic_id, processor->uid, enabled);
+	if (!apic->apic_id_valid(apic_id)) {
+		if (enabled)
+			pr_warn(PREFIX "x2apic entry ignored\n");
+		return 0;
+	}
+
+	acpi_register_lapic(apic_id, processor->uid, enabled);
 #else
 	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -40,7 +40,7 @@ int default_check_phys_apicid_present(in
 	return physid_isset(phys_apicid, phys_cpu_present_map);
 }
 
-int default_apic_id_valid(int apicid)
+int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,7 +56,7 @@ static u32 numachip2_set_apic_id(unsigne
 	return id << 24;
 }
 
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
 	/* Trust what bootloader passes in MADT */
 	return 1;
--- a/arch/x86/kernel/apic/x2apic.h
+++ b/arch/x86/kernel/apic/x2apic.h
@@ -1,6 +1,6 @@
 /* Common bits for X2APIC cluster/physical modes. */
 
-int x2apic_apic_id_valid(int apicid);
+int x2apic_apic_id_valid(u32 apicid);
 int x2apic_apic_id_registered(void);
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 unsigned int x2apic_get_apic_id(unsigned long id);
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -101,7 +101,7 @@ static int x2apic_phys_probe(void)
 }
 
 /* Common x2apic functions, also used by x2apic_cluster */
-int x2apic_apic_id_valid(int apicid)
+int x2apic_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -554,7 +554,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -112,7 +112,7 @@ static int xen_madt_oem_check(char *oem_
 	return xen_pv_domain();
 }
 
-static int xen_id_always_valid(int apicid)
+static int xen_id_always_valid(u32 apicid)
 {
 	return 1;
 }
