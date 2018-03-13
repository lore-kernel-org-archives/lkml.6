Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvH1dp0muLblTT5OPy7OLXyiZQZg45kP18bnyKD1iJR2G66m1L5LrlCkCGc8aOYOvARunz0
ARC-Seal: i=1; a=rsa-sha256; t=1520955071; cv=none;
        d=google.com; s=arc-20160816;
        b=azvLAJVv7O9Ps86wx/31RB1LUax+7NXLlwgL8YpsY3xhSLFUbm53nExHYNkzTKaVsE
         +Q4JuKLgIDdMGOTE5z3exzeVvRt8bq0pGyLhvsiLelosP68fnvMyd/Nte/7pI5KG0rs5
         uiF6I2z4ME12MN+i7nzoEnGwmyLia/ClajSDnERriYSd0/3cBbxl0hz8E4Zw27JqH4xX
         VCaLaMT5cxO+UuiWYAJcqiLpg/auRXpWZV10ui5HIO9M6a7jhqWSY7nKoZD1UEaTE2Qy
         VfTBw3NM8H15p6NCLvkdQ38pseAQWoUvq2zA4BiYbreIO0LhDPL8Y0JEXXXwF/aIAVGT
         IGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MeGrr8xl8Qa6IshfPweKohsWxy9mwxVK2IpEKuF05Mo=;
        b=Lbr6TjFgXKauNoPEwelcqEQNADfanyCPKRyMT22gfKcc9trEILX6NKdQP1gfkEawEK
         MsbipMhrde4pJ5Z6m9RnOpJyfvML5SQv+TNYzA7qnTJvSuk86s10lwf9e9OfRmxDU8uq
         JgTGSkIzrCnEvvAvIJmHDgs9GrVmt3ECIFtmFJLHzx699Y54HkWGHxVl0o1x8LHcXSPn
         r6fF9sRtldUso1IEuUErs1oZ1sSwULXZ6cxLGlhaC8CIwWxsmnpch8Cxuv3ISB4B6p4u
         pZjQLV+WIp440jhnWKnP51Co6I3HVTd0dUokWc4csmEta9sLtVajim7DXqFwdIMjkwv4
         NHdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>,
	Miodrag Dinic <miodrag.dinic@mips.com>,
	Aleksandar Markovic <aleksandar.markovic@mips.com>,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 079/146] MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
Date: Tue, 13 Mar 2018 16:24:06 +0100
Message-Id: <20180313152326.901035436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836985101401365?=
X-GMAIL-MSGID: =?utf-8?q?1594836985101401365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 791412dafbbfd860e78983d45cf71db603a82f67 upstream.

Reading mips_cpc_base value from the DT allows each platform to
define it according to its needs. This is especially convenient
for MIPS_GENERIC kernel where this kind of information should be
determined in runtime.

Use mti,mips-cpc compatible string with just a reg property to
specify the register location for your platform.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/18513/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-cpc.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -10,6 +10,8 @@
 
 #include <linux/errno.h>
 #include <linux/percpu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/spinlock.h>
 
 #include <asm/mips-cps.h>
@@ -22,6 +24,17 @@ static DEFINE_PER_CPU_ALIGNED(unsigned l
 
 phys_addr_t __weak mips_cpc_default_phys_base(void)
 {
+	struct device_node *cpc_node;
+	struct resource res;
+	int err;
+
+	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
+	if (cpc_node) {
+		err = of_address_to_resource(cpc_node, 0, &res);
+		if (!err)
+			return res.start;
+	}
+
 	return 0;
 }
 
