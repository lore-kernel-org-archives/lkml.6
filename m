Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDJSD7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:03:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35774 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDJSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:03:58 -0400
X-Google-Smtp-Source: AIpwx49W8tB4OTsv+CYOmH9pW7uF/oviAJt6YHUdU+WhI+AoIgGeShuX1ufb2gdBXzTqwHanbQB7LA==
Date: Tue, 10 Apr 2018 21:03:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: fix spam with zero VMA process
Message-ID: <20180410180353.GA2515@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody ever tried to self destruct by unmapping whole address space at once:

	munmap((void *)0, (1ULL << 47) - 4096);

Doing this produces 2 warnings for zero-length vmalloc allocations:

a.out[1353]: segfault at 7f80bcc4b757 ip 00007f80bcc4b757 sp 00007fff683939b8 error 14
a.out: vmalloc: allocation failure: 0 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null)
	...
a.out: vmalloc: allocation failure: 0 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null)
	...

Fix is to switch to kvmalloc().

Steps to reproduce:

	// vsyscall=none
	#include <sys/mman.h>
	#include <sys/resource.h>
	int main(void)
	{
		setrlimit(RLIMIT_CORE, &(struct rlimit){RLIM_INFINITY, RLIM_INFINITY});
		munmap((void *)0, (1ULL << 47) - 4096);
		return 0;
	}

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1608,8 +1608,8 @@ static int fill_files_note(struct memelfnote *note)
 	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
 		return -EINVAL;
 	size = round_up(size, PAGE_SIZE);
-	data = vmalloc(size);
-	if (!data)
+	data = kvmalloc(size, GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(data))
 		return -ENOMEM;
 
 	start_end_ofs = data + 2;
@@ -1626,7 +1626,7 @@ static int fill_files_note(struct memelfnote *note)
 		filename = file_path(file, name_curpos, remaining);
 		if (IS_ERR(filename)) {
 			if (PTR_ERR(filename) == -ENAMETOOLONG) {
-				vfree(data);
+				kvfree(data);
 				size = size * 5 / 4;
 				goto alloc;
 			}
@@ -1919,7 +1919,7 @@ static void free_note_info(struct elf_note_info *info)
 		kfree(t);
 	}
 	kfree(info->psinfo.data);
-	vfree(info->files.data);
+	kvfree(info->files.data);
 }
 
 #else
@@ -2135,7 +2135,7 @@ static void free_note_info(struct elf_note_info *info)
 
 	/* Free data possibly allocated by fill_files_note(): */
 	if (info->notes_files)
-		vfree(info->notes_files->data);
+		kvfree(info->notes_files->data);
 
 	kfree(info->prstatus);
 	kfree(info->psinfo);
@@ -2281,8 +2281,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	if (segs - 1 > ULONG_MAX / sizeof(*vma_filesz))
 		goto end_coredump;
-	vma_filesz = vmalloc((segs - 1) * sizeof(*vma_filesz));
-	if (!vma_filesz)
+	vma_filesz = kvmalloc((segs - 1) * sizeof(*vma_filesz), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(vma_filesz))
 		goto end_coredump;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
@@ -2389,7 +2389,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 cleanup:
 	free_note_info(&info);
 	kfree(shdr4extnum);
-	vfree(vma_filesz);
+	kvfree(vma_filesz);
 	kfree(phdr4note);
 	kfree(elf);
 out:
