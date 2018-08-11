Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C91C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4971F21A5E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4971F21A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeHKSMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKSMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:12:34 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B903921A5D;
        Sat, 11 Aug 2018 15:37:57 +0000 (UTC)
Date:   Sat, 11 Aug 2018 11:37:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180811113756.494a10f7@vmware.local.home>
In-Reply-To: <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
        <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 00:57:12 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> > +
> > +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> > +{
> > +       if (!du)
> > +               return;  
> Do we really need this check?

I'd suggest we keep it. It's not a fast path, and operations like this
should really check for NULL.


> 
> > +       list_del(&du->list);
> > +       kfree(du);
> > +}
> > +
> > +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
> > +{
> > +       struct list_head *pos, *q;
> > +       struct delayed_uprobe *du;
> > +
> > +       if (!uprobe && !mm)
> > +               return;  
> And do we really need this check?

Same here, as it's not a fast path, and it prevents kernel oops if a
NULL is passed in.

> 
> > +
> > +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
> > +               du = list_entry(pos, struct delayed_uprobe, list);
> > +
> > +               if (uprobe && mm && du->uprobe == uprobe && du->mm == mm)
> > +                       delayed_uprobe_delete(du);
> > +               else if (!uprobe && du->mm == mm)
> > +                       delayed_uprobe_delete(du);
> > +               else if (!mm && du->uprobe == uprobe)
> > +                       delayed_uprobe_delete(du);
> > +       }
> > +}
> > +
> > +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
> > +                             struct vm_area_struct *vma)
> > +{
> > +       unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
> > +
> > +       return uprobe->ref_ctr_offset &&
> > +               vma->vm_file &&
> > +               file_inode(vma->vm_file) == uprobe->inode &&
> > +               (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
> > +               vma->vm_start <= vaddr &&
> > +               vma->vm_end > vaddr;
> > +}
> > +
> > +static struct vm_area_struct *
> > +find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
> > +{
> > +       struct vm_area_struct *tmp;
> > +
> > +       for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
> > +               if (valid_ref_ctr_vma(uprobe, tmp))
> > +                       return tmp;
> > +
> > +       return NULL;
> > +}
> > +
> > +static int
> > +__update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
> > +{
> > +       void *kaddr;
> > +       struct page *page;
> > +       struct vm_area_struct *vma;
> > +       int ret = 0;  
> It is not necessary to initialize ret here.

Agreed.

> 
> > +       short *ptr;
> > +
> > +       if (vaddr == 0 || d == 0)
> > +               return -EINVAL;
> > +
> > +       ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> > +                       FOLL_WRITE, &page, &vma, NULL);
> > +       if (unlikely(ret <= 0)) {
> > +               /*
> > +                * We are asking for 1 page. If get_user_pages_remote() fails,
> > +                * it may return 0, in that case we have to return error.
> > +                */
> > +               ret = (ret == 0) ? -EBUSY : ret;
> > +               pr_warn("Failed to %s ref_ctr. (%d)\n",
> > +                       d > 0 ? "increment" : "decrement", ret);  
> This warning is not really useful. Seems this function has little information
> about which uprobe is failing here. Maybe we only need warning in the caller
> (or caller of caller).

I'm fine with or without this.

> 
> > +               return ret;
> > +       }
> > +
> > +       kaddr = kmap_atomic(page);
> > +       ptr = kaddr + (vaddr & ~PAGE_MASK);
> > +
> > +       if (unlikely(*ptr + d < 0)) {
> > +               pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
> > +                       "curr val: %d, delta: %d\n", vaddr, *ptr, d);
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       *ptr += d;
> > +       ret = 0;
> > +out:
> > +       kunmap_atomic(kaddr);
> > +       put_page(page);
> > +       return ret;
> > +}
> > +
> > +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> > +                         bool is_register)  
> What's the reason of bool is_register here vs. short d in __update_ref_ctr()?
> Can we use short for both?

bool has more control, but I agree that this function is a bit
confusing.

-- Steve

> 
> > +{
> > +       struct vm_area_struct *rc_vma;
> > +       unsigned long rc_vaddr;
> > +       int ret = 0;
> > +
> > +       rc_vma = find_ref_ctr_vma(uprobe, mm);
> > +
> > +       if (rc_vma) {
> > +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
> > +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
> > +
> > +               if (is_register)
> > +                       return ret;
> > +       }  
> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
> function is a little confusing (at least for me). How about we always use
> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
> 
> > +
> > +       mutex_lock(&delayed_uprobe_lock);
> > +       if (is_register)
> > +               ret = delayed_uprobe_add(uprobe, mm);
> > +       else
> > +               delayed_uprobe_remove(uprobe, mm);
> > +       mutex_unlock(&delayed_uprobe_lock);
> > +
> > +       return ret;
> > +}
> > +
> >  /*
> >   * NOTE:
> >   * Expect the breakpoint instruction to be the smallest size instruction for
> > @@ -302,9 +463,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >                         unsigned long vaddr, uprobe_opcode_t opcode)
> >  {
> > +       struct uprobe *uprobe;
> >         struct page *old_page, *new_page;
> >         struct vm_area_struct *vma;
> > -       int ret;
> > +       int ret, is_register, ref_ctr_updated = 0;
> > +
> > +       is_register = is_swbp_insn(&opcode);
> > +       uprobe = container_of(auprobe, struct uprobe, arch);
> >
> >  retry:
> >         /* Read the page with vaddr into memory */
> > @@ -317,6 +482,15 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         if (ret <= 0)
> >                 goto put_old;
> >
> > +       /* We are going to replace instruction, update ref_ctr. */
> > +       if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> > +               ret = update_ref_ctr(uprobe, mm, is_register);
> > +               if (ret)
> > +                       goto put_old;
> > +
> > +               ref_ctr_updated = 1;
> > +       }
> > +
> >         ret = anon_vma_prepare(vma);
> >         if (ret)
> >                 goto put_old;
> > @@ -337,6 +511,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >
> >         if (unlikely(ret == -EAGAIN))
> >                 goto retry;
> > +
> > +       /* Revert back reference counter if instruction update failed. */
> > +       if (ret && is_register && ref_ctr_updated)
> > +               update_ref_ctr(uprobe, mm, false);
> > +
> >         return ret;
> >  }
> >
> > @@ -378,8 +557,15 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
> >
> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -       if (atomic_dec_and_test(&uprobe->ref))
> > +       if (atomic_dec_and_test(&uprobe->ref)) {
> > +               /*
> > +                * If application munmap(exec_vma) before uprobe_unregister()
> > +                * gets called, we don't get a chance to remove uprobe from
> > +                * delayed_uprobe_list in remove_breakpoint(). Do it here.
> > +                */
> > +               delayed_uprobe_remove(uprobe, NULL);
> >                 kfree(uprobe);
> > +       }
> >  }
> >
> >  static int match_uprobe(struct uprobe *l, struct uprobe *r)
> > @@ -484,7 +670,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> >         return u;
> >  }
> >
> > -static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
> > +static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> > +                                  loff_t ref_ctr_offset)
> >  {
> >         struct uprobe *uprobe, *cur_uprobe;
> >
> > @@ -494,6 +681,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
> >
> >         uprobe->inode = inode;
> >         uprobe->offset = offset;
> > +       uprobe->ref_ctr_offset = ref_ctr_offset;
> >         init_rwsem(&uprobe->register_rwsem);
> >         init_rwsem(&uprobe->consumer_rwsem);
> >
> > @@ -895,7 +1083,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
> >   * else return 0 (success)
> >   */
> >  static int __uprobe_register(struct inode *inode, loff_t offset,
> > -                            struct uprobe_consumer *uc)
> > +                            loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> >  {
> >         struct uprobe *uprobe;
> >         int ret;
> > @@ -912,7 +1100,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
> >                 return -EINVAL;
> >
> >   retry:
> > -       uprobe = alloc_uprobe(inode, offset);
> > +       uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
> >         if (!uprobe)
> >                 return -ENOMEM;
> >         /*
> > @@ -938,10 +1126,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
> >  int uprobe_register(struct inode *inode, loff_t offset,
> >                     struct uprobe_consumer *uc)
> >  {
> > -       return __uprobe_register(inode, offset, uc);
> > +       return __uprobe_register(inode, offset, 0, uc);
> >  }
> >  EXPORT_SYMBOL_GPL(uprobe_register);
> >
> > +int uprobe_register_refctr(struct inode *inode, loff_t offset,
> > +                          loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> > +{
> > +       return __uprobe_register(inode, offset, ref_ctr_offset, uc);
> > +}
> > +EXPORT_SYMBOL_GPL(uprobe_register_refctr);
> > +
> >  /*
> >   * uprobe_apply - unregister a already registered probe.
> >   * @inode: the file in which the probe has to be removed.
> > @@ -1060,6 +1255,31 @@ static void build_probe_list(struct inode *inode,
> >         spin_unlock(&uprobes_treelock);
> >  }
> >
> > +static int delayed_uprobe_install(struct vm_area_struct *vma)  
> This function name is confusing. How about we call it delayed_ref_ctr_incr() or
> something similar? Also, we should add comments to highlight this is vma is not
> the vma containing the uprobe, but the vma containing the ref_ctr.
> 
> > +{
> > +       struct list_head *pos, *q;
> > +       struct delayed_uprobe *du;
> > +       unsigned long vaddr;
> > +       int ret = 0, err = 0;
> > +
> > +       mutex_lock(&delayed_uprobe_lock);
> > +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
> > +               du = list_entry(pos, struct delayed_uprobe, list);
> > +
> > +               if (!valid_ref_ctr_vma(du->uprobe, vma))
> > +                       continue;
> > +
> > +               vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
> > +               ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
> > +               /* Record an error and continue. */
> > +               if (ret && !err)
> > +                       err = ret;  
> I think this is a good place (when ret != 0) to call pr_warn(). I guess we can
> print which mm get error for which uprobe (inode+offset).
> 
> > +               delayed_uprobe_delete(du);
> > +       }
> > +       mutex_unlock(&delayed_uprobe_lock);
> > +       return err;
> > +}
> > +
> >  /*
> >   * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
> >   *
> > @@ -1072,7 +1292,15 @@ int uprobe_mmap(struct vm_area_struct *vma)
> >         struct uprobe *uprobe, *u;
> >         struct inode *inode;
> >
> > -       if (no_uprobe_events() || !valid_vma(vma, true))
> > +       if (no_uprobe_events())
> > +               return 0;
> > +
> > +       if (vma->vm_file &&
> > +           (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
> > +           test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> > +               delayed_uprobe_install(vma);
> > +
> > +       if (!valid_vma(vma, true))
> >                 return 0;
> >
> >         inode = file_inode(vma->vm_file);
> > @@ -1246,6 +1474,10 @@ void uprobe_clear_state(struct mm_struct *mm)
> >  {
> >         struct xol_area *area = mm->uprobes_state.xol_area;
> >
> > +       mutex_lock(&delayed_uprobe_lock);
> > +       delayed_uprobe_remove(NULL, mm);
> > +       mutex_unlock(&delayed_uprobe_lock);
> > +
> >         if (!area)
> >                 return;
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 823687997b01..616160b85860 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4620,7 +4620,7 @@ static const char readme_msg[] =
> >    "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
> >  #endif
> >  #ifdef CONFIG_UPROBE_EVENTS
> > -       "\t    place: <path>:<offset>\n"
> > +  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
> >  #endif
> >         "\t     args: <name>=fetcharg[:type]\n"
> >         "\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index bf89a51e740d..bf2be098eb08 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -59,6 +59,7 @@ struct trace_uprobe {
> >         struct inode                    *inode;
> >         char                            *filename;
> >         unsigned long                   offset;
> > +       unsigned long                   ref_ctr_offset;
> >         unsigned long                   nhit;
> >         struct trace_probe              tp;
> >  };
> > @@ -364,10 +365,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
> >  static int create_trace_uprobe(int argc, char **argv)
> >  {
> >         struct trace_uprobe *tu;
> > -       char *arg, *event, *group, *filename;
> > +       char *arg, *event, *group, *filename, *rctr, *rctr_end;
> >         char buf[MAX_EVENT_NAME_LEN];
> >         struct path path;
> > -       unsigned long offset;
> > +       unsigned long offset, ref_ctr_offset;
> >         bool is_delete, is_return;
> >         int i, ret;
> >
> > @@ -376,6 +377,7 @@ static int create_trace_uprobe(int argc, char **argv)
> >         is_return = false;
> >         event = NULL;
> >         group = NULL;
> > +       ref_ctr_offset = 0;
> >
> >         /* argc must be >= 1 */
> >         if (argv[0][0] == '-')
> > @@ -450,6 +452,26 @@ static int create_trace_uprobe(int argc, char **argv)
> >                 goto fail_address_parse;
> >         }
> >
> > +       /* Parse reference counter offset if specified. */
> > +       rctr = strchr(arg, '(');
> > +       if (rctr) {
> > +               rctr_end = strchr(rctr, ')');
> > +               if (rctr > rctr_end || *(rctr_end + 1) != 0) {
> > +                       ret = -EINVAL;
> > +                       pr_info("Invalid reference counter offset.\n");
> > +                       goto fail_address_parse;
> > +               }
> > +
> > +               *rctr++ = '\0';
> > +               *rctr_end = '\0';
> > +               ret = kstrtoul(rctr, 0, &ref_ctr_offset);
> > +               if (ret) {
> > +                       pr_info("Invalid reference counter offset.\n");
> > +                       goto fail_address_parse;
> > +               }
> > +       }
> > +
> > +       /* Parse uprobe offset. */
> >         ret = kstrtoul(arg, 0, &offset);
> >         if (ret)
> >                 goto fail_address_parse;
> > @@ -484,6 +506,7 @@ static int create_trace_uprobe(int argc, char **argv)
> >                 goto fail_address_parse;
> >         }
> >         tu->offset = offset;
> > +       tu->ref_ctr_offset = ref_ctr_offset;
> >         tu->path = path;
> >         tu->filename = kstrdup(filename, GFP_KERNEL);
> >
> > @@ -602,6 +625,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
> >                         trace_event_name(&tu->tp.call), tu->filename,
> >                         (int)(sizeof(void *) * 2), tu->offset);
> >
> > +       if (tu->ref_ctr_offset)
> > +               seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
> > +
> >         for (i = 0; i < tu->tp.nr_args; i++)
> >                 seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
> >
> > @@ -917,7 +943,13 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
> >
> >         tu->consumer.filter = filter;
> >         tu->inode = d_real_inode(tu->path.dentry);
> > -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> > +       if (tu->ref_ctr_offset) {
> > +               ret = uprobe_register_refctr(tu->inode, tu->offset,
> > +                               tu->ref_ctr_offset, &tu->consumer);
> > +       } else {
> > +               ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> > +       }
> > +
> >         if (ret)
> >                 goto err_buffer;
> >
> > --
> > 2.14.4
> >  

