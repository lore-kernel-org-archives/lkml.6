Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932884AbeCOXHj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:07:39 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47112 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932526AbeCOXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:07:38 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 00/10] x86/microcode/AMD: Check microcode file sanity
 before loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
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

 arch/x86/include/asm/microcode_amd.h |   1 +
 arch/x86/kernel/cpu/microcode/amd.c  | 179 ++++++++++++++++++++++++-----------
 2 files changed, 127 insertions(+), 53 deletions(-)
