Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeEQGdf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:33:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751967AbeEQGdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:33:33 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 1/2] perf script: Show virtual addresses instead of offsets
Date: Thu, 17 May 2018 12:03:25 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18051706-0008-0000-0000-000004F75D80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051706-0009-0000-0000-00001E8BD034
Message-Id: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170059
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf data is recorded with the call-graph option enabled,
the callchain shown by perf script shows the binary offsets of
the symbols as the ip. This is incorrect for kernel symbols as
the ip values are always off by a fixed offset depending on the
architecture. If the offsets from the start of the symbols are
printed, they are also incorrect for both kernel and userspace
symbols.

Without the call-graph option, the callchain shows the virtual
addresses of the symbols rather than their binary offsets. The
offsets printed in this case are also correct.

This fixes the inconsistency in perf script's output.

This can be verified on a powerpc64le system running Fedora 27
as follows:

  # cat /proc/kallsyms | grep sys_write
  ...
  c0000000004025a0 T sys_write
  c0000000004025a0 T __se_sys_write
  ...

  # perf probe -a sys_write

Before applying this patch:

  # perf record -e probe:sys_write -g ~/test
  # perf script -F ip,sym,symoff

                    4125b0 sys_write+0x8000000000008010
                     1b9e0 system_call+0x8000000000008058
                    118234 __GI___libc_write+0xffff0000f52c0024
                     92c74 _IO_file_write@@GLIBC_2.17+0xffff0000f52c0044
                  5afbfd8a [unknown]
                     91a60 new_do_write+0xffff0000f52c0090
                     94638 _IO_do_write@@GLIBC_2.17+0xffff0000f52c0038
                     94bbc _IO_file_overflow@@GLIBC_2.17+0xffff0000f52c014c
                     95a24 __overflow+0xffff0000f52c0064
                     84548 _IO_puts+0xffff0000f52c0218
                       440 main+0xffffffffe0000020
                     236a0 generic_start_main.isra.0+0xffff0000f52c0140
                     23898 __libc_start_main+0xffff0000f52c00b8
                         0 [unknown]
  ...

  # perf record -e probe:sys_write ~/test
  # perf script -F ip,sym,symoff

  c0000000004025b0 sys_write+0x10
  ...

After applying this patch:

  # perf record -e probe:sys_write -g ~/test
  # perf script -F ip,sym,symoff

          c0000000004025b0 sys_write+0x10
          c00000000000b9e0 system_call+0x58
              7fffb70d8234 __GI___libc_write+0x24
              7fffb7052c74 _IO_file_write@@GLIBC_2.17+0x44
                  5afc1818 [unknown]
              7fffb7051a60 new_do_write+0x90
              7fffb7054638 _IO_do_write@@GLIBC_2.17+0x38
              7fffb7054bbc _IO_file_overflow@@GLIBC_2.17+0x14c
              7fffb7055a24 __overflow+0x64
              7fffb7044548 _IO_puts+0x218
                  10000440 main+0x20
              7fffb6fe36a0 generic_start_main.isra.0+0x140
              7fffb6fe3898 __libc_start_main+0xb8
                         0 [unknown]
  ...

  # perf record -e probe:sys_write ~/test
  # perf script -F ip,sym,symoff

  c0000000004025b0 sys_write+0x10
  ...

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 72a351613d85..7c777cb32806 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1764,7 +1764,7 @@ static int add_callchain_ip(struct thread *thread,
 	}
 
 	srcline = callchain_srcline(al.map, al.sym, al.addr);
-	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
+	return callchain_cursor_append(cursor, ip, al.map, al.sym,
 				       branch, flags, nr_loop_iter,
 				       iter_cycles, branch_from, srcline);
 }
-- 
2.14.3
