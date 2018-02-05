Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Kw47JGB3/RyRlgj7yPoHkQRTAihxdN1lRBtRi6H469dO1zY7ZXtZnFQ9rtffLXG3auQkD
ARC-Seal: i=1; a=rsa-sha256; t=1517855020; cv=none;
        d=google.com; s=arc-20160816;
        b=S+7HbdF9SYC01Dd3cfpDQ+6omBSLE7Fdoai/nMURnBTA7voFuM4i3BwHwiuEIuiGTV
         tZkTEks2W5q+M8ZoX1UelWZveg7f80912i6fe7dAVBep83PnLUAJr/uf0uGKXfZhothx
         iNFfVqe1nnHSfhJ6MRLM8CpntJA20lrn9B1xoLzqvGWbwi05yj94rjbUa4+z56op1TTH
         s1atn8BWnbi3P6gQjdYfGCwuRjBChWm/rwzavY07ByzyMD3CQ0+FaNGX9+wNzkDc4opA
         7BuCVxRiTFGoa+JUxFVsBAywLAbOBQxd/+/rE1IYTRYX3pRTc80wv0zbFTHL3ucO7lvs
         /SWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1Sc0lw0t+rh67154D/TBQd0+lE1/BBSwMqfoZIORYiw=;
        b=Y53HFmLocw7SSnWT6oVwWuPAH/5MxbgKHvzDhirPTgix/OjmZU4qlhPauho2gODpFn
         XNWFljtPv6LppW6HQfle+kQ3kS4pV6AllFkPcv8loS1210C59fTt1D6Rvc0l/TbbJK7b
         Vhz2xnkRAGvB7drN+dR1ZpC37B14z46ifqmZsRwCT4SC2dmhIas5a9IQMg6WD+gHJDeA
         DGZgbJw3hTmbriiJ1WAMwJicwqQ2Y0mhhNyBojmuBz1PgecXarJLFDq0/s3Y5Oh6iXag
         Yry6beAGrQnitwyXWGSuciVU5WPA5EfKFbsy1qHyHO1LGTBXCCxeBPh7dmT56vtahLDG
         Qa9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4.14 03/64] powerpc/64s: Allow control of RFI flush via debugfs
Date: Mon,  5 Feb 2018 10:22:22 -0800
Message-Id: <20180205182138.714615532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586346194152818?=
X-GMAIL-MSGID: =?utf-8?q?1591586346194152818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit 236003e6b5443c45c18e613d2b0d776a9f87540e upstream.

Expose the state of the RFI flush (enabled/disabled) via debugfs, and
allow it to be enabled/disabled at runtime.

eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
    1
    $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
    $ cat /sys/kernel/debug/powerpc/rfi_flush
    0

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup_64.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -38,6 +38,7 @@
 #include <linux/memory.h>
 #include <linux/nmi.h>
 
+#include <asm/debugfs.h>
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -885,6 +886,35 @@ void __init setup_rfi_flush(enum l1d_flu
 		rfi_flush_enable(enable);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int rfi_flush_set(void *data, u64 val)
+{
+	if (val == 1)
+		rfi_flush_enable(true);
+	else if (val == 0)
+		rfi_flush_enable(false);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rfi_flush_get(void *data, u64 *val)
+{
+	*val = rfi_flush ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+
+static __init int rfi_flush_debugfs_init(void)
+{
+	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
+	return 0;
+}
+device_initcall(rfi_flush_debugfs_init);
+#endif
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (rfi_flush)
