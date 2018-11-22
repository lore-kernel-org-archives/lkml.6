Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E7AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EA220684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h7c+1Xkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EA220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406497AbeKWEaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:30:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38386 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbeKWEaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Z0tlSzNy2ZBviAINPBcvERXngZmf2h/yqwhXqywYik=; b=h7c+1XknExmZRTUZXWTXRPy/f
        XMQ6lItxKonaD84brKX86XeYyXETAzdHYuL5rrVWlDfwmyMnX3+jMih4pQWBHkRjzmCpBQP7zX4o2
        39E2ixMI3CEchZsuB+Ze7Ynk5Jy1kq6eqDk6un8KMpJGr55ArcqQ7WR+X29j+RfBLyFxg=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:54136)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPt6V-0003Ic-MW; Thu, 22 Nov 2018 17:49:27 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPt6S-0004Av-Gs; Thu, 22 Nov 2018 17:49:24 +0000
Date:   Thu, 22 Nov 2018 17:49:23 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jessica Yu <jeyu@kernel.org>, vincent.whitchurch@axis.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] module: Overwrite st_size instead of st_info
Message-ID: <20181122174923.GK30658@n2100.armlinux.org.uk>
References: <20181119162513.16562-1-vincent.whitchurch@axis.com>
 <20181122120154.GH3505@e103592.cambridge.arm.com>
 <20181122122411.6ydftk7bjlrefwa5@axis.com>
 <20181122162849.GA8856@linux-8ccs>
 <CAKv+Gu_vAKhQ2oakTeJNwP_F6dhqKe2ZwjAR13wrVKfL5aS4Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_vAKhQ2oakTeJNwP_F6dhqKe2ZwjAR13wrVKfL5aS4Fw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:40:45PM +0100, Ard Biesheuvel wrote:
> On Thu, 22 Nov 2018 at 17:29, Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Vincent Whitchurch [22/11/18 13:24 +0100]:
> > >On Thu, Nov 22, 2018 at 12:01:54PM +0000, Dave Martin wrote:
> > >> On Mon, Nov 19, 2018 at 05:25:12PM +0100, Vincent Whitchurch wrote:
> > >> > st_info is currently overwritten after relocation and used to store the
> > >> > elf_type().  However, we're going to need it fix kallsyms on ARM's
> > >> > Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> > >> > instead.  st_size is neither used by the module core nor by any
> > >> > architecture.
> > >> >
> > >> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > >> > ---
> > >> > v4: Split out to separate patch.  Use st_size instead of st_other.
> > >> > v1-v3: See PATCH 2/2
> > >> >
> > >> >  kernel/module.c | 4 ++--
> > >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/kernel/module.c b/kernel/module.c
> > >> > index 49a405891587..3d86a38b580c 100644
> > >> > --- a/kernel/module.c
> > >> > +++ b/kernel/module.c
> > >> > @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> > >> >
> > >> >    /* Set types up while we still have access to sections. */
> > >> >    for (i = 0; i < mod->kallsyms->num_symtab; i++)
> > >> > -          mod->kallsyms->symtab[i].st_info
> > >> > +          mod->kallsyms->symtab[i].st_size
> > >> >                    = elf_type(&mod->kallsyms->symtab[i], info);
> > >> >
> > >> >    /* Now populate the cut down core kallsyms for after init. */
> > >> > @@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> > >> >            kallsyms = rcu_dereference_sched(mod->kallsyms);
> > >> >            if (symnum < kallsyms->num_symtab) {
> > >> >                    *value = kallsyms->symtab[symnum].st_value;
> > >> > -                  *type = kallsyms->symtab[symnum].st_info;
> > >> > +                  *type = kallsyms->symtab[symnum].st_size;
> > >> >                    strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
> > >> >                    strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> > >> >                    *exported = is_exported(name, *value, mod);
> > >>
> > >> This is fine if st_size is really unused, but how sure are you of that?
> > >>
> > >> grepping for st_size throws up some hits that appear ELF-related, but
> > >> I've not investigated them in detail.
> > >>
> > >> (The fact that struct stat has an identically named field throws up
> > >> a load of false positives too.)
> > >
> > >$ git describe --tags
> > >v4.20-rc3-93-g92b419289cee
> > >
> > >$ rg -m1 '[\.>]st_size'  --iglob '!**/tools/**' --iglob '!**/vdso*' --iglob '!**/scripts/**' --iglob '!**/usr/**' --iglob '!**/samples/**' | cat
> > >| kernel/kexec_file.c: if (sym->st_size != size) {
> > >
> > >Symbols in kexec kernel.
> > >
> > >| fs/stat.c:   tmp.st_size = stat->size;
> > >| Documentation/networking/tls.txt:  sendfile(sock, file, &offset, stat.st_size);
> > >| net/9p/client.c:             ret->st_rdev, ret->st_size, ret->st_blksize,
> > >| net/9p/protocol.c:                                   &stbuf->st_rdev, &stbuf->st_size,
> > >| fs/9p/vfs_inode_dotl.c:              i_size_write(inode, stat->st_size);
> > >| fs/hostfs/hostfs_user.c:     p->size = buf->st_size;
> > >| arch/powerpc/boot/mktree.c:  nblks = (st.st_size + IMGBLK) / IMGBLK;
> > >| arch/alpha/kernel/osf_sys.c: tmp.st_size     = lstat->size;
> > >| arch/x86/ia32/sys_ia32.c:        __put_user(stat->size, &ubuf->st_size) ||
> > >
> > >Not Elf_Sym.
> > >
> > >| arch/x86/kernel/machine_kexec_64.c:                   sym->st_size);
> > >
> > >Symbols in kexec kernel.
> > >
> > >| arch/sparc/boot/piggyback.c: st4(buffer + 12, s.st_size);
> > >| arch/sparc/kernel/sys_sparc32.c:     err |= put_user(stat->size, &statbuf->st_size);
> > >| arch/um/os-Linux/file.c:             .ust_size    = src->st_size,    /* total size, in bytes */
> > >| arch/um/os-Linux/start_up.c: size = (buf.st_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
> > >| arch/s390/kernel/compat_linux.c:     tmp.st_size = stat->size;
> > >| arch/arm/kernel/sys_oabi-compat.c:   tmp.st_size = stat->size;
> > >| arch/mips/boot/compressed/calc_vmlinuz_load_addr.c:  vmlinux_size = (uint64_t)sb.st_size;
> > >| drivers/net/ethernet/marvell/sky2.c:         hw->st_idx = RING_NEXT(hw->st_idx, hw->st_size);
> > >
> > >Not Elf_Sym.
> >
> > [ added Miroslav to CC, just in case he would like to check :) ]
> >
> > I have just double checked as well, and am fairly certain that the
> > Elf_Sym st_size field is not used to apply module relocations in any
> > arches, and it is not used in the core module loader nor in the module
> > kallsyms code. We'd like to avoid overwriting st_info in any case, to
> > fix kallsyms on Thumb-2 and also so that livepatch won't run into any
> > issues with delayed relocations, should livepatch support ever expand
> > to arches (e.g., arm) that rely on st_info for module relocations.
> >
> 
> Also note that st_size cannot be relied upon in general, since we
> overwrite the addresses of undefined symbols in a module's symbol
> table when resolve them against ksyms, while the st_size field is kept
> at 0. At relocation time, we don't really distinguish anymore between
> local and external module symbols, and so relying on st_size to be
> accurate would definitely break things.

Umm.

Undefined symbols of course have a zero size, because it's not known
how large the definition that the symbol refers to is.  However,
the non-undefined symbols should have a size with them - anything
emitted by the compiler should, but only if .size has been used in
the assembler will assembly have correct sizes.

Aren't SHN_UNDEF symbols ignored, except when applying the
relocations, where we rely on st_value to be set on SHN_UNDEF
symbols?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
