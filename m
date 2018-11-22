Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BEC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BEC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbeKVXDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:03:24 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:44152 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbeKVXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:03:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E7A3B1858F;
        Thu, 22 Nov 2018 13:24:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id x5ukQAmojBPZ; Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id B40C518558;
        Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1DCB1A070;
        Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 918531A05D;
        Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 89A5F1CFE;
        Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 8177C80C5B; Thu, 22 Nov 2018 13:24:11 +0100 (CET)
Date:   Thu, 22 Nov 2018 13:24:11 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux@armlinux.org.uk, jeyu@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Overwrite st_size instead of st_info
Message-ID: <20181122122411.6ydftk7bjlrefwa5@axis.com>
References: <20181119162513.16562-1-vincent.whitchurch@axis.com>
 <20181122120154.GH3505@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122120154.GH3505@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:01:54PM +0000, Dave Martin wrote:
> On Mon, Nov 19, 2018 at 05:25:12PM +0100, Vincent Whitchurch wrote:
> > st_info is currently overwritten after relocation and used to store the
> > elf_type().  However, we're going to need it fix kallsyms on ARM's
> > Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> > instead.  st_size is neither used by the module core nor by any
> > architecture.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> > v4: Split out to separate patch.  Use st_size instead of st_other.
> > v1-v3: See PATCH 2/2
> > 
> >  kernel/module.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 49a405891587..3d86a38b580c 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> >  
> >  	/* Set types up while we still have access to sections. */
> >  	for (i = 0; i < mod->kallsyms->num_symtab; i++)
> > -		mod->kallsyms->symtab[i].st_info
> > +		mod->kallsyms->symtab[i].st_size
> >  			= elf_type(&mod->kallsyms->symtab[i], info);
> >  
> >  	/* Now populate the cut down core kallsyms for after init. */
> > @@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >  		kallsyms = rcu_dereference_sched(mod->kallsyms);
> >  		if (symnum < kallsyms->num_symtab) {
> >  			*value = kallsyms->symtab[symnum].st_value;
> > -			*type = kallsyms->symtab[symnum].st_info;
> > +			*type = kallsyms->symtab[symnum].st_size;
> >  			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
> >  			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> >  			*exported = is_exported(name, *value, mod);
> 
> This is fine if st_size is really unused, but how sure are you of that?
> 
> grepping for st_size throws up some hits that appear ELF-related, but
> I've not investigated them in detail.
> 
> (The fact that struct stat has an identically named field throws up
> a load of false positives too.)

$ git describe --tags
v4.20-rc3-93-g92b419289cee
 
$ rg -m1 '[\.>]st_size'  --iglob '!**/tools/**' --iglob '!**/vdso*' --iglob '!**/scripts/**' --iglob '!**/usr/**' --iglob '!**/samples/**' | cat
| kernel/kexec_file.c:	if (sym->st_size != size) {

Symbols in kexec kernel.

| fs/stat.c:	tmp.st_size = stat->size;
| Documentation/networking/tls.txt:  sendfile(sock, file, &offset, stat.st_size);
| net/9p/client.c:		ret->st_rdev, ret->st_size, ret->st_blksize,
| net/9p/protocol.c:					&stbuf->st_rdev, &stbuf->st_size,
| fs/9p/vfs_inode_dotl.c:		i_size_write(inode, stat->st_size);
| fs/hostfs/hostfs_user.c:	p->size = buf->st_size;
| arch/powerpc/boot/mktree.c:	nblks = (st.st_size + IMGBLK) / IMGBLK;
| arch/alpha/kernel/osf_sys.c:	tmp.st_size	= lstat->size;
| arch/x86/ia32/sys_ia32.c:	    __put_user(stat->size, &ubuf->st_size) ||

Not Elf_Sym.

| arch/x86/kernel/machine_kexec_64.c:			 sym->st_size);

Symbols in kexec kernel.

| arch/sparc/boot/piggyback.c:	st4(buffer + 12, s.st_size);
| arch/sparc/kernel/sys_sparc32.c:	err |= put_user(stat->size, &statbuf->st_size);
| arch/um/os-Linux/file.c:		.ust_size    = src->st_size,    /* total size, in bytes */
| arch/um/os-Linux/start_up.c:	size = (buf.st_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
| arch/s390/kernel/compat_linux.c:	tmp.st_size = stat->size;
| arch/arm/kernel/sys_oabi-compat.c:	tmp.st_size = stat->size;
| arch/mips/boot/compressed/calc_vmlinuz_load_addr.c:	vmlinux_size = (uint64_t)sb.st_size;
| drivers/net/ethernet/marvell/sky2.c:		hw->st_idx = RING_NEXT(hw->st_idx, hw->st_size);

Not Elf_Sym.
