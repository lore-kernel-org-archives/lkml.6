Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F311421EA2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311421EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeGGKFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:05:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:2850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbeGGKFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:05:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 03:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,320,1526367600"; 
   d="scan'208";a="214114810"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2018 03:05:44 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fbk63-000S99-Jn; Sat, 07 Jul 2018 18:05:43 +0800
Date:   Sat, 7 Jul 2018 18:05:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: Re: [PATCH 5/7] proc/kcore: clean up ELF header generation
Message-ID: <201807071557.QxJwgEfj%fengguang.wu@intel.com>
References: <196479b479237502d4d8b0e5a562b52205e5c374.1530904769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196479b479237502d4d8b0e5a562b52205e5c374.1530904769.git.osandov@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Omar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc3 next-20180706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Omar-Sandoval/proc-kcore-improvements/20180707-052548
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/nodemask.h:265:16: sparse: expression using sizeof(void)
   include/linux/nodemask.h:271:16: sparse: expression using sizeof(void)
>> fs//proc/kcore.c:328:23: sparse: expression using sizeof(void)
>> fs//proc/kcore.c:328:23: sparse: expression using sizeof(void)
   fs//proc/kcore.c:368:23: sparse: expression using sizeof(void)
   fs//proc/kcore.c:368:23: sparse: expression using sizeof(void)
>> fs//proc/kcore.c:384:49: sparse: missing braces around initializer
   fs//proc/kcore.c:408:23: sparse: expression using sizeof(void)
   fs//proc/kcore.c:408:23: sparse: expression using sizeof(void)

vim +328 fs//proc/kcore.c

   285	
   286	static ssize_t
   287	read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
   288	{
   289		char *buf = file->private_data;
   290		size_t phdrs_offset, notes_offset, data_offset;
   291		size_t phdrs_len, notes_len;
   292		struct kcore_list *m;
   293		size_t tsz;
   294		int nphdr;
   295		unsigned long start;
   296		size_t orig_buflen = buflen;
   297		int ret = 0;
   298	
   299		down_read(&kclist_lock);
   300	
   301		get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
   302		phdrs_offset = sizeof(struct elfhdr);
   303		notes_offset = phdrs_offset + phdrs_len;
   304	
   305		/* ELF file header. */
   306		if (buflen && *fpos < sizeof(struct elfhdr)) {
   307			struct elfhdr ehdr = {
   308				.e_ident = {
   309					[EI_MAG0] = ELFMAG0,
   310					[EI_MAG1] = ELFMAG1,
   311					[EI_MAG2] = ELFMAG2,
   312					[EI_MAG3] = ELFMAG3,
   313					[EI_CLASS] = ELF_CLASS,
   314					[EI_DATA] = ELF_DATA,
   315					[EI_VERSION] = EV_CURRENT,
   316					[EI_OSABI] = ELF_OSABI,
   317				},
   318				.e_type = ET_CORE,
   319				.e_machine = ELF_ARCH,
   320				.e_version = EV_CURRENT,
   321				.e_phoff = sizeof(struct elfhdr),
   322				.e_flags = ELF_CORE_EFLAGS,
   323				.e_ehsize = sizeof(struct elfhdr),
   324				.e_phentsize = sizeof(struct elf_phdr),
   325				.e_phnum = nphdr,
   326			};
   327	
 > 328			tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
   329			if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
   330				ret = -EFAULT;
   331				goto out;
   332			}
   333	
   334			buffer += tsz;
   335			buflen -= tsz;
   336			*fpos += tsz;
   337		}
   338	
   339		/* ELF program headers. */
   340		if (buflen && *fpos < phdrs_offset + phdrs_len) {
   341			struct elf_phdr *phdrs, *phdr;
   342	
   343			phdrs = kzalloc(phdrs_len, GFP_KERNEL);
   344			if (!phdrs) {
   345				ret = -ENOMEM;
   346				goto out;
   347			}
   348	
   349			phdrs[0].p_type = PT_NOTE;
   350			phdrs[0].p_offset = notes_offset;
   351			phdrs[0].p_filesz = notes_len;
   352	
   353			phdr = &phdrs[1];
   354			list_for_each_entry(m, &kclist_head, list) {
   355				phdr->p_type = PT_LOAD;
   356				phdr->p_flags = PF_R | PF_W | PF_X;
   357				phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
   358				phdr->p_vaddr = (size_t)m->addr;
   359				if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
   360					phdr->p_paddr = __pa(m->addr);
   361				else
   362					phdr->p_paddr = (elf_addr_t)-1;
   363				phdr->p_filesz = phdr->p_memsz = m->size;
   364				phdr->p_align = PAGE_SIZE;
   365				phdr++;
   366			}
   367	
   368			tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
   369			if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
   370					 tsz)) {
   371				kfree(phdrs);
   372				ret = -EFAULT;
   373				goto out;
   374			}
   375			kfree(phdrs);
   376	
   377			buffer += tsz;
   378			buflen -= tsz;
   379			*fpos += tsz;
   380		}
   381	
   382		/* ELF note segment. */
   383		if (buflen && *fpos < notes_offset + notes_len) {
 > 384			struct elf_prstatus prstatus = {0};
   385			struct elf_prpsinfo prpsinfo = {
   386				.pr_sname = 'R',
   387				.pr_fname = "vmlinux",
   388			};
   389			char *notes;
   390			size_t i = 0;
   391	
   392			strlcpy(prpsinfo.pr_psargs, saved_command_line,
   393				sizeof(prpsinfo.pr_psargs));
   394	
   395			notes = kzalloc(notes_len, GFP_KERNEL);
   396			if (!notes) {
   397				ret = -ENOMEM;
   398				goto out;
   399			}
   400	
   401			append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
   402					  sizeof(prstatus));
   403			append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
   404					  sizeof(prpsinfo));
   405			append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
   406					  arch_task_struct_size);
   407	
   408			tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
   409			if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
   410				kfree(notes);
   411				ret = -EFAULT;
   412				goto out;
   413			}
   414			kfree(notes);
   415	
   416			buffer += tsz;
   417			buflen -= tsz;
   418			*fpos += tsz;
   419		}
   420	
   421		/*
   422		 * Check to see if our file offset matches with any of
   423		 * the addresses in the elf_phdr on our list.
   424		 */
   425		start = kc_offset_to_vaddr(*fpos - data_offset);
   426		if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
   427			tsz = buflen;
   428	
   429		while (buflen) {
   430			list_for_each_entry(m, &kclist_head, list) {
   431				if (start >= m->addr && start < (m->addr+m->size))
   432					break;
   433			}
   434	
   435			if (&m->list == &kclist_head) {
   436				if (clear_user(buffer, tsz)) {
   437					ret = -EFAULT;
   438					goto out;
   439				}
   440			} else if (m->type == KCORE_VMALLOC) {
   441				vread(buf, (char *)start, tsz);
   442				/* we have to zero-fill user buffer even if no read */
   443				if (copy_to_user(buffer, buf, tsz)) {
   444					ret = -EFAULT;
   445					goto out;
   446				}
   447			} else if (m->type == KCORE_USER) {
   448				/* User page is handled prior to normal kernel page: */
   449				if (copy_to_user(buffer, (char *)start, tsz)) {
   450					ret = -EFAULT;
   451					goto out;
   452				}
   453			} else {
   454				if (kern_addr_valid(start)) {
   455					/*
   456					 * Using bounce buffer to bypass the
   457					 * hardened user copy kernel text checks.
   458					 */
   459					if (probe_kernel_read(buf, (void *) start, tsz)) {
   460						if (clear_user(buffer, tsz)) {
   461							ret = -EFAULT;
   462							goto out;
   463						}
   464					} else {
   465						if (copy_to_user(buffer, buf, tsz)) {
   466							ret = -EFAULT;
   467							goto out;
   468						}
   469					}
   470				} else {
   471					if (clear_user(buffer, tsz)) {
   472						ret = -EFAULT;
   473						goto out;
   474					}
   475				}
   476			}
   477			buflen -= tsz;
   478			*fpos += tsz;
   479			buffer += tsz;
   480			start += tsz;
   481			tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
   482		}
   483	
   484	out:
   485		up_write(&kclist_lock);
   486		if (ret)
   487			return ret;
   488		return orig_buflen - buflen;
   489	}
   490	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
