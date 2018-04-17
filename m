Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UAQgfSw9J8kw7wCI+q66TXLyvyuSnuAL8Zg+q341gpm+Kso0WP9rQevqj4sesqMVkKBQb
ARC-Seal: i=1; a=rsa-sha256; t=1523980970; cv=none;
        d=google.com; s=arc-20160816;
        b=EZEjcTuNy6qtnAfL0CiXLnJG8+agNfJWQSa5MbhkLGZpKn1iwE6tFhqfg9xakOKYEi
         9TowWYWGZch9uhQ6amlwK96rWo9CM0gL+GYF97jJAHgRWsjIOSe51SpV+miM3v1uMP0z
         KWoce9JYOIl2evyhFdlTtmubDJG6R4Hxc3Pk2jWMKAX9V7S7Rnzv128ga1nlMULvfA4H
         NIhkqdUVIKs8Chp47Sq9mjNTazJoLEOCkmpSZ2iyuFJePB4i3Hq4iTU402w6P13kJSH6
         FPPxo1LpjXERU+Ho8iTGS+87Ba/KsbmeoVZpEXKm2q6dCsIjmhfsfsjkE2ZJTDM5Tx4e
         jEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e8pb/yAqQrwOpgyetWKmAV2tIw4oPl1R5in9M64WW4A=;
        b=heY7zAF4ssedzFB4IXFn6Z0D/fdEyTf6LKayv8Ycp/EOQSQHSYbcEQeTVhCeyrMuFE
         uZK9kb/tXU1CCPK6zm/OvwOu6Qs/JGlROudnaX2fdOA5dsjxs7NdXcLC21yoZG8QgJ1w
         eBgdS12rw2ST/tWxENeQDVm1UYe+OMQ7zCIwfnV44X8IylDzi0MFgK9m76lGC+TR0G3Q
         ewzD+o3Up2d95WOdVww+lFkCe9LHIYn7DJyIbzdxdWS/JT3Pa156il3tyA4VdsXiMfT2
         HBpHyRQ8JdunzbAimG3zmTsaAMv2/kUDDASY7jlMTQ/auzgcNKKE0416YlbbN3C73wYa
         G8/Q==
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
Subject: [PATCH 4.16 33/68] x86/apic: Fix signedness bug in APIC ID validity checks
Date: Tue, 17 Apr 2018 17:57:46 +0200
Message-Id: <20180417155750.689248378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009870580406629?=
X-GMAIL-MSGID: =?utf-8?q?1598009870580406629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -557,7 +557,7 @@ static void uv_send_IPI_all(int vector)
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
