Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeESWI1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:08:27 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49446 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] x86/microcode/AMD: Check microcode file sanity before loading it
Date: Sun, 20 May 2018 00:07:14 +0200
Message-Id: <cover.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it is very easy to make the AMD microcode update driver crash
or spin on a malformed microcode container file since it does very little
consistency checking on data loaded from such file.

This series introduces various checks, mostly on length-type fields,
so all corrupted microcode container files are (hopefully) correctly
rejected instead.
This largely matches what the Intel microcode update driver already does.

It also tries to make the behavior consistent between the early and late
loaders.

Please note that this isn't about verifying the actual microcode update,
that is, the blob that gets sent to the CPU as the new microcode.
Such verification is (hopefully) done by the CPU itself.

It is about verifying a driver-specific container file that includes
many microcode updates for different CPUs of a particular CPU family,
along with metadata that helps the driver select the right microcode
update to actually send to the CPU.

There are purposely-corrupted test files available at
https://pastebin.com/XkKUSmMp
One has to enable KASAN in the kernel config and rename a particular
test file to name appropriate to the running CPU family to test its
loading.

Changes from v1:
* Capitalize a comment,

* Rename 'eqsize' and 'bufsize' to 'eq_size' and 'buf_size',
respectively,

* Attach a comment about checking the equivalence table header to its
first size check,

* Rename 'equiv{_cpu,}_table_size' to 'equiv{_cpu,}_table_entries'.

Changes from v2:
* Split the patch into separate commits,

* Remove explicit CPU equivalence table size limit,

* Make install_equiv_cpu_table() return a size_t instead of a (signed)
int so no overflow can occur there,

* Automatically compute the PATCH_MAX_SIZE macro and use it for checking
a patch size,

* Make the late loader behavior with respect to late parse failures
consistent with what the early loader does.

Changes from v3:
* Capitalize patch subject names,

* Add a comment describing why we subtract SECTION_HDR_SIZE from a file
leftover length before calling verify_patch_size(),

* Don't break a long line containing the above subtraction,

* Move a comment in parse_container() back to where it was in the original
patch version,

* Add special local vars for container header fields in parse_container(),

* Return the remaining blob size from parse_container() if the equivalence
table is truncated,

* Split the equivalence table size checks into two patches: one for the
early loader and one for the late loader,

* Rename an equivalence table length variable in install_equiv_cpu_table()
for consistency with a similar one in parse_container(),

* Rephrase the error messages in install_equiv_cpu_table() to be more
descriptive and merge two tests there so they print the same message,

* Change install_equiv_cpu_table() to return an unsigned int while moving
the job of adding the container header length to this value to its caller,

* Drop automatic computation of the PATCH_MAX_SIZE macro and add a comment
reminding to do it manually instead,

* Add a local variable patch_type for better code readability in
verify_and_add_patch() function.

Changes from v4:
* Update the first patch in series with Borislav's version,

* Use u32-type variables for microcode container header fields,

* Drop the check for zero-length CPU equivalence table,

* Leave size variables in verify_patch_size() as unsigned ints,

* Rewrite the series to use common microcode container data checking
functions in both the early and the late loader so their code won't get
interspersed with a lot of checks and so will be more readable.

Changes from v5:
* Remove "This commit" or "This patch" prefix from commit messages,

* Make sure that every checking function verifies presence of any data
it accesses so these functions don't have an implicit call order
requirement,

* Integrate verify_patch_size() into verify_patch() after the late loader
is converted to no longer call verify_patch_size() directly,

* Make a patch matching check in the early loader more readable,

* Skip just one byte in the early loader when a container cannot be parsed
successfully so the parser will correctly skip unknown data of any size,

* Move assignment of a pointer to CPU equivalence table header variable
past this table check in install_equiv_cpu_table(),

* Split returned status value from returned length of data to skip in
verify_and_add_patch() so we keep the common convention that a function
zero return value means success while a negative value means an error,

* Don't introduce a new global variable for holding the CPU equivalence
table size, add a terminating zero entry to this table explicitly instead
to prevent scanning past its valid data.


 arch/x86/include/asm/microcode_amd.h |   1 +
 arch/x86/kernel/cpu/microcode/amd.c  | 403 +++++++++++++++++++--------
 2 files changed, 285 insertions(+), 119 deletions(-)
