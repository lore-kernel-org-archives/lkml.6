Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969165AbeE1PpI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968626AbeE1KRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:17:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 069/268] tools/libbpf: handle issues with bpf ELF objects containing .eh_frames
Date: Mon, 28 May 2018 12:00:43 +0200
Message-Id: <20180528100209.680966894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit e3d91b0ca523d53158f435a3e13df7f0cb360ea2 ]

V3: More generic skipping of relo-section (suggested by Daniel)

If clang >= 4.0.1 is missing the option '-target bpf', it will cause
llc/llvm to create two ELF sections for "Exception Frames", with
section names '.eh_frame' and '.rel.eh_frame'.

The BPF ELF loader library libbpf fails when loading files with these
sections.  The other in-kernel BPF ELF loader in samples/bpf/bpf_load.c,
handle this gracefully. And iproute2 loader also seems to work with these
"eh" sections.

The issue in libbpf is caused by bpf_object__elf_collect() skipping
some sections, and later when performing relocation it will be
pointing to a skipped section, as these sections cannot be found by
bpf_object__find_prog_by_idx() in bpf_object__collect_reloc().

This is a general issue that also occurs for other sections, like
debug sections which are also skipped and can have relo section.

As suggested by Daniel.  To avoid keeping state about all skipped
sections, instead perform a direct qlookup in the ELF object.  Lookup
the section that the relo-section points to and check if it contains
executable machine instructions (denoted by the sh_flags
SHF_EXECINSTR).  Use this check to also skip irrelevant relo-sections.

Note, for samples/bpf/ the '-target bpf' parameter to clang cannot be used
due to incompatibility with asm embedded headers, that some of the samples
include. This is explained in more details by Yonghong Song in bpf_devel_QA.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/libbpf.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -487,6 +487,24 @@ bpf_object__init_maps(struct bpf_object
 	return 0;
 }
 
+static bool section_have_execinstr(struct bpf_object *obj, int idx)
+{
+	Elf_Scn *scn;
+	GElf_Shdr sh;
+
+	scn = elf_getscn(obj->efile.elf, idx);
+	if (!scn)
+		return false;
+
+	if (gelf_getshdr(scn, &sh) != &sh)
+		return false;
+
+	if (sh.sh_flags & SHF_EXECINSTR)
+		return true;
+
+	return false;
+}
+
 static int bpf_object__elf_collect(struct bpf_object *obj)
 {
 	Elf *elf = obj->efile.elf;
@@ -567,6 +585,14 @@ static int bpf_object__elf_collect(struc
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
 			int nr_reloc = obj->efile.nr_reloc + 1;
+			int sec = sh.sh_info; /* points to other section */
+
+			/* Only do relo for section with exec instructions */
+			if (!section_have_execinstr(obj, sec)) {
+				pr_debug("skip relo %s(%d) for section(%d)\n",
+					 name, idx, sec);
+				continue;
+			}
 
 			reloc = realloc(reloc,
 					sizeof(*obj->efile.reloc) * nr_reloc);
