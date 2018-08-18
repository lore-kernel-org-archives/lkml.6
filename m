Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91480C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2704A21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2704A21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeHROar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:30:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:30:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBNAf01283835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:23:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBNA3V1283831;
        Sat, 18 Aug 2018 04:23:10 -0700
Date:   Sat, 18 Aug 2018 04:23:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-2b1444f2e28be94b8f0b37376e1c619fd8cad63b@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, schwidefsky@de.ibm.com, tmricht@linux.ibm.com,
        mingo@kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.ibm.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, brueckner@linux.ibm.com,
          heiko.carstens@de.ibm.com, mpe@ellerman.id.au,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, schwidefsky@de.ibm.com, tmricht@linux.ibm.com
In-Reply-To: <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
References: <20180802074622.13641-3-tmricht@linux.ibm.com>
        <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Add raw report support for s390
 auxiliary trace
Git-Commit-ID: 2b1444f2e28be94b8f0b37376e1c619fd8cad63b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2b1444f2e28be94b8f0b37376e1c619fd8cad63b
Gitweb:     https://git.kernel.org/tip/2b1444f2e28be94b8f0b37376e1c619fd8cad63b
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 2 Aug 2018 09:46:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:26:48 -0300

perf report: Add raw report support for s390 auxiliary trace

Add support for s390 auxiliary trace support.

Use 'perf record -e rbd000' to create the perf.data file.  The event
also has the symbolic name SF_CYCLES_BASIC_DIAG, using 'perf record -e
SF_CYCLES_BASIC_DIAG' is equivalent.

Use 'perf report -D' to display the auxiliary trace data.

Output before:

 0 0 0x25a66 [0x30]: PERF_RECORD_AUXTRACE size: 0x40000
                 offset: 0  ref: 0  idx: 4  tid: -1  cpu: 4
     Nothing else

Output after:

 0 0 0x25a66 [0x30]: PERF_RECORD_AUXTRACE size: 0x40000
                  offset: 0  ref: 0  idx: 4  tid: -1  cpu: 4
 .
 . ... s390 AUX data: size 262144 bytes
    [00000000] Basic   Def:0001 Inst:0000 TW   AS:3 ASN:0xffff IA:0x0000000000c2f1bc
		CL:1 HPP:0x8000000000000000 GPP:000000000000000000
    [0x000020] Diag    Def:8005
    [0x0000bf] Basic   Def:0001 Inst:0000 TW   AS:3 ASN:0xffff IA:0x0000000000c2f1bc
		CL:1 HPP:0x8000000000000000 GPP:000000000000000000
    [0x0000df] Diag    Def:8005
    [0x00017e] Basic   Def:0001 Inst:0000 TW   AS:3 ASN:0xffff IA:0x0000000000c2f1bc
		CL:1 HPP:0x8000000000000000 GPP:000000000000000000
    ....
    [0x000fc0] Trailer F T bsdes:32 dsdes:159 Overflow:0 Time:0xd4ab59a8450fa108
		C:1 TOD:0xd4ab4ec98ceb3832 1:0x8000000000000000 2:0xd4ab4ec98ceb3832

This output is shown for every sampled data block. The
output contains the

 - basic-sampling data entry

 - diagnostic-sampling data entry

 - trailer entry

The basic sampling entry and diagnostic sampling entry sizes can be
extracted using the trailer entries in the SDB.  On older hardware these
values (bsdes and dsdes in the trailer entry) are reserved and zero.
Older hardware use hard coded values based on the s390 machine type.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: http://lkml.kernel.org/r/20180802074622.13641-3-tmricht@linux.ibm.com
Link: http://lkml.kernel.org/r/eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com
[ Merged a fix for a 'tipe puned' problem reported by Michael Ellerman see last Link tag. ]
[ Removed __packed from two structs, they're already naturally packed and having that. ]
[ attribute breaks the build in gcc 8.1.1 mips, 4.4.7 x86_64, 7.1.1 ARCompact ISA, etc) ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++++
 tools/perf/util/s390-cpumsf.c        | 247 ++++++++++++++++++++++++++++++++++-
 2 files changed, 317 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/s390-cpumsf-kernel.h b/tools/perf/util/s390-cpumsf-kernel.h
new file mode 100644
index 000000000000..de8c7ad0eca8
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf-kernel.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Auxtrace support for s390 CPU measurement sampling facility
+ *
+ *  Copyright IBM Corp. 2018
+ *  Author(s): Hendrik Brueckner <brueckner@linux.ibm.com>
+ *	       Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef S390_CPUMSF_KERNEL_H
+#define S390_CPUMSF_KERNEL_H
+
+#define	S390_CPUMSF_PAGESZ	4096	/* Size of sample block units */
+#define	S390_CPUMSF_DIAG_DEF_FIRST	0x8001	/* Diagnostic entry lowest id */
+
+struct hws_basic_entry {
+	unsigned int def:16;	    /* 0-15  Data Entry Format		 */
+	unsigned int R:4;	    /* 16-19 reserved			 */
+	unsigned int U:4;	    /* 20-23 Number of unique instruct.  */
+	unsigned int z:2;	    /* zeros				 */
+	unsigned int T:1;	    /* 26 PSW DAT mode			 */
+	unsigned int W:1;	    /* 27 PSW wait state		 */
+	unsigned int P:1;	    /* 28 PSW Problem state		 */
+	unsigned int AS:2;	    /* 29-30 PSW address-space control	 */
+	unsigned int I:1;	    /* 31 entry valid or invalid	 */
+	unsigned int CL:2;	    /* 32-33 Configuration Level	 */
+	unsigned int:14;
+	unsigned int prim_asn:16;   /* primary ASN			 */
+	unsigned long long ia;	    /* Instruction Address		 */
+	unsigned long long gpp;     /* Guest Program Parameter		 */
+	unsigned long long hpp;     /* Host Program Parameter		 */
+};
+
+struct hws_diag_entry {
+	unsigned int def:16;	    /* 0-15  Data Entry Format		 */
+	unsigned int R:15;	    /* 16-19 and 20-30 reserved		 */
+	unsigned int I:1;	    /* 31 entry valid or invalid	 */
+	u8	     data[];	    /* Machine-dependent sample data	 */
+};
+
+struct hws_combined_entry {
+	struct hws_basic_entry	basic;	/* Basic-sampling data entry */
+	struct hws_diag_entry	diag;	/* Diagnostic-sampling data entry */
+};
+
+struct hws_trailer_entry {
+	union {
+		struct {
+			unsigned int f:1;	/* 0 - Block Full Indicator   */
+			unsigned int a:1;	/* 1 - Alert request control  */
+			unsigned int t:1;	/* 2 - Timestamp format	      */
+			unsigned int:29;	/* 3 - 31: Reserved	      */
+			unsigned int bsdes:16;	/* 32-47: size of basic SDE   */
+			unsigned int dsdes:16;	/* 48-63: size of diagnostic SDE */
+		};
+		unsigned long long flags;	/* 0 - 64: All indicators     */
+	};
+	unsigned long long overflow;	 /* 64 - sample Overflow count	      */
+	unsigned char timestamp[16];	 /* 16 - 31 timestamp		      */
+	unsigned long long reserved1;	 /* 32 -Reserved		      */
+	unsigned long long reserved2;	 /*				      */
+	union {				 /* 48 - reserved for programming use */
+		struct {
+			unsigned long long clock_base:1; /* in progusage2 */
+			unsigned long long progusage1:63;
+			unsigned long long progusage2;
+		};
+		unsigned long long progusage[2];
+	};
+};
+
+#endif
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index e9a5ea21dbbf..14728b0834c6 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -26,6 +26,7 @@
 #include "debug.h"
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
+#include "s390-cpumsf-kernel.h"
 
 struct s390_cpumsf {
 	struct auxtrace		auxtrace;
@@ -35,8 +36,213 @@ struct s390_cpumsf {
 	struct machine		*machine;
 	u32			auxtrace_type;
 	u32			pmu_type;
+	u16			machine_type;
 };
 
+/* Display s390 CPU measurement facility basic-sampling data entry */
+static bool s390_cpumsf_basic_show(const char *color, size_t pos,
+				   struct hws_basic_entry *basic)
+{
+	if (basic->def != 1) {
+		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Basic   Def:%04x Inst:%#04x"
+		      " %c%c%c%c AS:%d ASN:%#04x IA:%#018llx\n"
+		      "\t\tCL:%d HPP:%#018llx GPP:%#018llx\n",
+		      pos, basic->def, basic->U,
+		      basic->T ? 'T' : ' ',
+		      basic->W ? 'W' : ' ',
+		      basic->P ? 'P' : ' ',
+		      basic->I ? 'I' : ' ',
+		      basic->AS, basic->prim_asn, basic->ia, basic->CL,
+		      basic->hpp, basic->gpp);
+	return true;
+}
+
+/* Display s390 CPU measurement facility diagnostic-sampling data entry */
+static bool s390_cpumsf_diag_show(const char *color, size_t pos,
+				  struct hws_diag_entry *diag)
+{
+	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
+		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Diag    Def:%04x %c\n",
+		      pos, diag->def, diag->I ? 'I' : ' ');
+	return true;
+}
+
+/* Return TOD timestamp contained in an trailer entry */
+static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
+{
+	/* te->t set: TOD in STCKE format, bytes 8-15
+	 * to->t not set: TOD in STCK format, bytes 0-7
+	 */
+	unsigned long long ts;
+
+	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
+	return ts;
+}
+
+/* Display s390 CPU measurement facility trailer entry */
+static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
+				     struct hws_trailer_entry *te)
+{
+	if (te->bsdes != sizeof(struct hws_basic_entry)) {
+		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
+		return false;
+	}
+	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
+		      " dsdes:%d Overflow:%lld Time:%#llx\n"
+		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
+		      pos,
+		      te->f ? 'F' : ' ',
+		      te->a ? 'A' : ' ',
+		      te->t ? 'T' : ' ',
+		      te->bsdes, te->dsdes, te->overflow,
+		      trailer_timestamp(te), te->clock_base, te->progusage2,
+		      te->progusage[0], te->progusage[1]);
+	return true;
+}
+
+/* Test a sample data block. It must be 4KB or a multiple thereof in size and
+ * 4KB page aligned. Each sample data page has a trailer entry at the
+ * end which contains the sample entry data sizes.
+ *
+ * Return true if the sample data block passes the checks and set the
+ * basic set entry size and diagnostic set entry size.
+ *
+ * Return false on failure.
+ *
+ * Note: Old hardware does not set the basic or diagnostic entry sizes
+ * in the trailer entry. Use the type number instead.
+ */
+static bool s390_cpumsf_validate(int machine_type,
+				 unsigned char *buf, size_t len,
+				 unsigned short *bsdes,
+				 unsigned short *dsdes)
+{
+	struct hws_basic_entry *basic = (struct hws_basic_entry *)buf;
+	struct hws_trailer_entry *te;
+
+	*dsdes = *bsdes = 0;
+	if (len & (S390_CPUMSF_PAGESZ - 1))	/* Illegal size */
+		return false;
+	if (basic->def != 1)		/* No basic set entry, must be first */
+		return false;
+	/* Check for trailer entry at end of SDB */
+	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
+					      - sizeof(*te));
+	*bsdes = te->bsdes;
+	*dsdes = te->dsdes;
+	if (!te->bsdes && !te->dsdes) {
+		/* Very old hardware, use CPUID */
+		switch (machine_type) {
+		case 2097:
+		case 2098:
+			*dsdes = 64;
+			*bsdes = 32;
+			break;
+		case 2817:
+		case 2818:
+			*dsdes = 74;
+			*bsdes = 32;
+			break;
+		case 2827:
+		case 2828:
+			*dsdes = 85;
+			*bsdes = 32;
+			break;
+		default:
+			/* Illegal trailer entry */
+			return false;
+		}
+	}
+	return true;
+}
+
+/* Return true if there is room for another entry */
+static bool s390_cpumsf_reached_trailer(size_t entry_sz, size_t pos)
+{
+	size_t payload = S390_CPUMSF_PAGESZ - sizeof(struct hws_trailer_entry);
+
+	if (payload - (pos & (S390_CPUMSF_PAGESZ - 1)) < entry_sz)
+		return false;
+	return true;
+}
+
+/* Dump an auxiliary buffer. These buffers are multiple of
+ * 4KB SDB pages.
+ */
+static void s390_cpumsf_dump(struct s390_cpumsf *sf,
+			     unsigned char *buf, size_t len)
+{
+	const char *color = PERF_COLOR_BLUE;
+	struct hws_basic_entry *basic;
+	struct hws_diag_entry *diag;
+	size_t pos = 0;
+	unsigned short bsdes, dsdes;
+
+	color_fprintf(stdout, color,
+		      ". ... s390 AUX data: size %zu bytes\n",
+		      len);
+
+	if (!s390_cpumsf_validate(sf->machine_type, buf, len, &bsdes,
+				  &dsdes)) {
+		pr_err("Invalid AUX trace data block size:%zu"
+		       " (type:%d bsdes:%hd dsdes:%hd)\n",
+		       len, sf->machine_type, bsdes, dsdes);
+		return;
+	}
+
+	/* s390 kernel always returns 4KB blocks fully occupied,
+	 * no partially filled SDBs.
+	 */
+	while (pos < len) {
+		/* Handle Basic entry */
+		basic = (struct hws_basic_entry *)(buf + pos);
+		if (s390_cpumsf_basic_show(color, pos, basic))
+			pos += bsdes;
+		else
+			return;
+
+		/* Handle Diagnostic entry */
+		diag = (struct hws_diag_entry *)(buf + pos);
+		if (s390_cpumsf_diag_show(color, pos, diag))
+			pos += dsdes;
+		else
+			return;
+
+		/* Check for trailer entry */
+		if (!s390_cpumsf_reached_trailer(bsdes + dsdes, pos)) {
+			/* Show trailer entry */
+			struct hws_trailer_entry te;
+
+			pos = (pos + S390_CPUMSF_PAGESZ)
+			       & ~(S390_CPUMSF_PAGESZ - 1);
+			pos -= sizeof(te);
+			memcpy(&te, buf + pos, sizeof(te));
+			/* Set descriptor sizes in case of old hardware
+			 * where these values are not set.
+			 */
+			te.bsdes = bsdes;
+			te.dsdes = dsdes;
+			if (s390_cpumsf_trailer_show(color, pos, &te))
+				pos += sizeof(te);
+			else
+				return;
+		}
+	}
+}
+
+static void s390_cpumsf_dump_event(struct s390_cpumsf *sf, unsigned char *buf,
+				   size_t len)
+{
+	printf(".\n");
+	s390_cpumsf_dump(sf, buf, len);
+}
+
 static int
 s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 			  union perf_event *event __maybe_unused,
@@ -47,10 +253,40 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 }
 
 static int
-s390_cpumsf_process_auxtrace_event(struct perf_session *session __maybe_unused,
+s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
 				   struct perf_tool *tool __maybe_unused)
 {
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+
+	int fd = perf_data__fd(session->data);
+	struct auxtrace_buffer *buffer;
+	off_t data_offset;
+	int err;
+
+	if (perf_data__is_pipe(session->data)) {
+		data_offset = 0;
+	} else {
+		data_offset = lseek(fd, 0, SEEK_CUR);
+		if (data_offset == -1)
+			return -errno;
+	}
+
+	err = auxtrace_queues__add_event(&sf->queues, session, event,
+					 data_offset, &buffer);
+	if (err)
+		return err;
+
+	/* Dump here after copying piped trace out of the pipe */
+	if (dump_trace) {
+		if (auxtrace_buffer__get_data(buffer, fd)) {
+			s390_cpumsf_dump_event(sf, buffer->data,
+					       buffer->size);
+			auxtrace_buffer__put_data(buffer);
+		}
+	}
 	return 0;
 }
 
@@ -85,6 +321,14 @@ static void s390_cpumsf_free(struct perf_session *session)
 	free(sf);
 }
 
+static int s390_cpumsf_get_type(const char *cpuid)
+{
+	int ret, family = 0;
+
+	ret = sscanf(cpuid, "%*[^,],%u", &family);
+	return (ret == 1) ? family : 0;
+}
+
 int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 				      struct perf_session *session)
 {
@@ -107,6 +351,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->machine = &session->machines.host; /* No kvm support */
 	sf->auxtrace_type = auxtrace_info->type;
 	sf->pmu_type = PERF_TYPE_RAW;
+	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
 
 	sf->auxtrace.process_event = s390_cpumsf_process_event;
 	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
