Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48y6nNcwC9o23sP5X0Y7/owZ8WUVAo+9yVIHmurgI+Glg8DX+9U87teCcMPSKmcxjK+ss64
ARC-Seal: i=1; a=rsa-sha256; t=1522168374; cv=none;
        d=google.com; s=arc-20160816;
        b=NRORExvbuIKzwJb2tVIXkWklvB/yV7rdnt/gu2dNAg28CPZe6f4VwXrEDSDlQEtddJ
         MjHWmE/l1l2rzZXCPhxfDK1Bdj9NX5TrWzwkU/RPVHcMVXi1sQG9LuHPuyNzsz7sWxnu
         w42LeSNvUVgeTBwv0iU93W++lm+wetShtIVK9KPe5HNDZgolk0dbyR1Ds9JrebqsiC2d
         gcltk4622t278JEqCWI3I6tCyEcWbZl5V/uL4moMBSBOOAiJFLlx4DqiSLJk2I0hZ462
         75mu/f4I6wjDMoxLS3PkmMtpIThuHK/vl0bB0S+7DMVY/LgFGMSinpefsq8vhw+lCskY
         FM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KnXTzqOOoTaEnb97yVQ/g5bXKM/P5g6QnbnhHQiBU0c=;
        b=A4SU4QQS40l0FZosptiFXjVo0xxbsAyjHvXq+4nqhFLfgn89ezUjgFbveJjAUCkh2T
         uW+EX3Ckz9wNm4XnrEaPuXZNW+nQ9O4d9iRWeJ77P/gYEfidHTPDDWwOjo7tuTAezg04
         FNExjzIz/7vncDpcGeCp6q3ud9j6NUkdvtZrlECrHLy1Ii5UaK1y8Ng90u1AKV+QRmD/
         srVnv4CEpYzpw2JtU1wee/k8Yp5ug4tClpZf9Y6Z8V1y/1Xsgb07tI3EgqMpqz/VbB5p
         4+AyO7XmSE2E58LhtFIrph1P7ngd405f1emEZrtEYecZc/pQXYriGt0cVqysaQA+jpRR
         cAvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Kroening, Gary" <gary.kroening@hpe.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	abanman@hpe.com,
	dimitri.sivanich@hpe.com,
	hpa@zytor.com,
	mike.travis@hpe.com,
	russ.anderson@hpe.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 57/67] perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug on Skylake servers
Date: Tue, 27 Mar 2018 18:27:49 +0200
Message-Id: <20180327162730.737080200@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109225011553966?=
X-GMAIL-MSGID: =?utf-8?q?1596109225011553966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 320b0651f32b830add6497fcdcfdcb6ae8c7b8a0 upstream.

The number of CHAs is miscalculated on multi-domain PCI Skylake server systems,
resulting in an uncore driver initialization error.

Gary Kroening explains:

 "For systems with a single PCI segment, it is sufficient to look for the
  bus number to change in order to determine that all of the CHa's have
  been counted for a single socket.

  However, for multi PCI segment systems, each socket is given a new
  segment and the bus number does NOT change.  So looking only for the
  bus number to change ends up counting all of the CHa's on all sockets
  in the system.  This leads to writing CPU MSRs beyond a valid range and
  causes an error in ivbep_uncore_msr_init_box()."

To fix this bug, query the number of CHAs from the CAPID6 register:
it should read bits 27:0 in the CAPID6 register located at
Device 30, Function 3, Offset 0x9C. These 28 bits form a bit vector
of available LLC slices and the CHAs that manage those slices.

Reported-by: Kroening, Gary <gary.kroening@hpe.com>
Tested-by: Kroening, Gary <gary.kroening@hpe.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: abanman@hpe.com
Cc: dimitri.sivanich@hpe.com
Cc: hpa@zytor.com
Cc: mike.travis@hpe.com
Cc: russ.anderson@hpe.com
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1520967094-13219-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore_snbep.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3522,24 +3522,27 @@ static struct intel_uncore_type *skx_msr
 	NULL,
 };
 
+/*
+ * To determine the number of CHAs, it should read bits 27:0 in the CAPID6
+ * register which located at Device 30, Function 3, Offset 0x9C. PCI ID 0x2083.
+ */
+#define SKX_CAPID6		0x9c
+#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
+
 static int skx_count_chabox(void)
 {
-	struct pci_dev *chabox_dev = NULL;
-	int bus, count = 0;
+	struct pci_dev *dev = NULL;
+	u32 val = 0;
 
-	while (1) {
-		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
-		if (!chabox_dev)
-			break;
-		if (count == 0)
-			bus = chabox_dev->bus->number;
-		if (bus != chabox_dev->bus->number)
-			break;
-		count++;
-	}
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
+	if (!dev)
+		goto out;
 
-	pci_dev_put(chabox_dev);
-	return count;
+	pci_read_config_dword(dev, SKX_CAPID6, &val);
+	val &= SKX_CHA_BIT_MASK;
+out:
+	pci_dev_put(dev);
+	return hweight32(val);
 }
 
 void skx_uncore_cpu_init(void)
