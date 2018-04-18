Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbeDRK7Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:59:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751940AbeDRK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:59:11 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
Subject: [PATCH v2 1/3] perf tools powerpc: Fix callchain ip filtering
Date: Wed, 18 Apr 2018 16:28:58 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
References: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041810-0040-0000-0000-0000044EDFD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041810-0041-0000-0000-000020F32DDD
Message-Id: <20180418105900.5899-2-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For powerpc64, if a probe is added for a function without specifying
a line number, the corresponding trap instruction is placed at offset
0 (for big endian) or 8 (for little endian) from the start address of
the function. This address is in the function prologue and the trap
instruction preceeds the instruction that writes the return address
to the caller's stack frame. So, the call frame information will say
that the return address is undefined here and there will be no DWARF
operations to describe this.

Alternatively, if we place a probe in the function prologue at some
address after the LR value has been copied to R0 but before R0 is
written to the caller's stack frame, the call frame information will
say that the return address is available in R0 and there will be a
corresponding DWARF operation to describe this.

For both these cases, the return address is not available on the
stack which implies that the LR value at index 2 of the callchain
ips provided by the kernel is still valid and must not be skipped.

This can be observed on a powerpc64le system running Fedora 27 as
shown below.

 # objdump -d /usr/lib64/libc-2.26.so | less
 ...
 000000000015af20 <inet_pton>:
   15af20:       0b 00 4c 3c     addis   r2,r12,11
   15af24:       e0 c1 42 38     addi    r2,r2,-15904
   15af28:       a6 02 08 7c     mflr    r0
   15af2c:       f0 ff c1 fb     std     r30,-16(r1)
   15af30:       f8 ff e1 fb     std     r31,-8(r1)
   15af34:       78 1b 7f 7c     mr      r31,r3
   15af38:       78 23 83 7c     mr      r3,r4
   15af3c:       78 2b be 7c     mr      r30,r5
   15af40:       10 00 01 f8     std     r0,16(r1)
   15af44:       c1 ff 21 f8     stdu    r1,-64(r1)
   15af48:       28 00 81 f8     std     r4,40(r1)
 ...

 # readelf --debug-dump=frames-interp /usr/lib64/libc-2.26.so | less
 ...
 00027024 0000000000000024 00027028 FDE cie=00000000 pc=000000000015af20..000000000015af88
    LOC           CFA      r30   r31   ra
 000000000015af20 r1+0     u     u     u
 000000000015af34 r1+0     c-16  c-8   r0
 000000000015af48 r1+64    c-16  c-8   c+16
 000000000015af5c r1+0     c-16  c-8   c+16
 000000000015af78 r1+0     u     u
 ...

Case 1 - Probe at 0x15af28, return address is undefined.
 # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton
 # perf record -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
 # perf script

Case 2 - Probe at 0x15af38, return address is in R0.
 # perf probe -x /usr/lib64/libc-2.26.so -a 0x15af38
 # perf record -e probe_libc:abs_15af38/max-stack=3/ ping -6 -c 1 ::1
 # perf script

Output before applying this patch:

 ping 27909 [007] 532219.943481: probe_libc:inet_pton: (7fff99b0af28)
                   15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
                   1105b4 getaddrinfo (/usr/lib64/libc-2.26.so)

Output after applying this patch:

 ping 27909 [007] 532219.943481: probe_libc:inet_pton: (7fff99b0af28)
                   15af28 __GI___inet_pton (/usr/lib64/libc-2.26.so)
                   10fa54 gaih_inet.constprop.7 (/usr/lib64/libc-2.26.so)
                   1105b4 getaddrinfo (/usr/lib64/libc-2.26.so)

Fixes: a60335ba3298 ("perf tools powerpc: Adjust callchain based on DWARF debug info")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v2:
 - Consider case when return address is in R0 as pointed out by Ravi.
 - Rather than declaring a separate get_return_addr() function that
   ultimately calls check_return_addr() and since check_return_addr()
   is called only from get_return_addr(), integrate additional tasks
   such as finding DSO information inside check_return_addr() itself
   instead of having another function.
 - Update commit message with description of both cases and how to
   reproduce them.
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 72 ++++++++++++++---------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 0c370f81e002..d3a13f79d3ee 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -61,7 +61,13 @@ static int check_return_reg(int ra_regno, Dwarf_Frame *frame)
 	 * Check if return address is on the stack.
 	 */
 	if (nops != 0 || ops != NULL)
-		return 0;
+		/*
+		 * Check if return address is not in R0. In that
+		 * case, it must be on the stack.
+		 */
+		if (nops != 1 || ops[0].atom != DW_OP_regx ||
+				ops[0].number != 0 || ops[0].number2 != 0)
+			return 0;
 
 	/*
 	 * Return address is in LR. Check if a frame was allocated
@@ -145,18 +151,32 @@ static Dwarf_Frame *get_dwarf_frame(Dwfl_Module *mod, Dwarf_Addr pc)
  *		yet used)
  *	-1 in case of errors
  */
-static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
+static int check_return_addr(struct thread *thread, Dwarf_Addr pc)
 {
-	int		rc = -1;
-	Dwfl		*dwfl;
-	Dwfl_Module	*mod;
-	Dwarf_Frame	*frame;
-	int		ra_regno;
-	Dwarf_Addr	start = pc;
-	Dwarf_Addr	end = pc;
-	bool		signalp;
-	const char	*exec_file = dso->long_name;
+	int			rc = -1;
+	Dwfl			*dwfl;
+	Dwfl_Module		*mod;
+	Dwarf_Frame		*frame;
+	int			ra_regno;
+	Dwarf_Addr		start = pc;
+	Dwarf_Addr		end = pc;
+	bool			signalp;
+	const char		*exec_file;
+	struct addr_location	al;
+	struct dso		*dso;
+	u64			map_start;
+
+	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
+			MAP__FUNCTION, pc, &al);
+
+	if (!al.map || !al.map->dso) {
+		pr_debug("%" PRIx64 " dso is NULL\n", pc);
+		return rc;
+	}
 
+	dso = al.map->dso;
+	map_start = al.map->start;
+	exec_file = dso->long_name;
 	dwfl = dso->dwfl;
 
 	if (!dwfl) {
@@ -209,6 +229,8 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
 	rc = check_return_reg(ra_regno, frame);
 
 out:
+	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
+				dso->long_name, al.sym->name, pc, rc);
 	return rc;
 }
 
@@ -237,32 +259,26 @@ static int check_return_addr(struct dso *dso, u64 map_start, Dwarf_Addr pc)
  */
 int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 {
-	struct addr_location al;
-	struct dso *dso = NULL;
 	int rc;
-	u64 ip;
 	u64 skip_slot = -1;
 
 	if (chain->nr < 3)
 		return skip_slot;
 
-	ip = chain->ips[2];
+	rc = check_return_addr(thread, chain->ips[1]);
 
-	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
-			MAP__FUNCTION, ip, &al);
-
-	if (al.map)
-		dso = al.map->dso;
-
-	if (!dso) {
-		pr_debug("%" PRIx64 " dso is NULL\n", ip);
+	if (rc == 1)
+		/* Return address is either in LR or R0 and is yet to be
+		 * written to the stack. This can be observed if the probe
+		 * is placed at an offset from the start of the function
+		 * that comes before the prologue code to write the return
+		 * address to the caller's stack frame.
+		 * So, an attempt to skip an entry based on chain->ips[2],
+		 * i.e. the LR value, must not be made.
+		 */
 		return skip_slot;
-	}
-
-	rc = check_return_addr(dso, al.map->start, ip);
 
-	pr_debug("[DSO %s, sym %s, ip 0x%" PRIx64 "] rc %d\n",
-				dso->long_name, al.sym->name, ip, rc);
+	rc = check_return_addr(thread, chain->ips[2]);
 
 	if (rc == 0) {
 		/*
-- 
2.14.3
