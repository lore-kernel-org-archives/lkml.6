Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeCMVGF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:06:05 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44892 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeCMVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:03 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 0/9] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <dcbfabaa-741f-5fc4-a6a4-6440f2786202@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:05:59 +0100
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

Changes from v1: Capitalize a comment, rename 'eqsize' and 'bufsize'
to 'eq_size' and 'buf_size', respectively, attach a comment about
checking the equivalence table header to its first size check, rename
'equiv{_cpu,}_table_size' to 'equiv{_cpu,}_table_entries'.

Changes from v2: Split the patch into separate commits, remove explicit
CPU equivalence table size limit, make install_equiv_cpu_table() return
a size_t instead of a (signed) int so no overflow can occur there,
automatically compute the PATCH_MAX_SIZE macro and use it for checking
a patch size, make the late loader behavior with respect to late parse
failures consistent with what the early loader does. 

 arch/x86/include/asm/microcode_amd.h |   2 -
 arch/x86/kernel/cpu/microcode/amd.c  | 164 ++++++++++++++++++++++++-----------
 2 files changed, 114 insertions(+), 52 deletions(-)
