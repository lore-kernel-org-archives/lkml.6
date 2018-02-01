Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeBAUHq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:07:46 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:50517 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754663AbeBAUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:07:38 -0500
X-Google-Smtp-Source: AH8x224hnFUExYE7ZXQNertkAKUXAuUWbzR/NXYa9b4tGa/lLfZrg5vKx9bia08MOWTe2IYDh41Ccg==
Date: Thu, 1 Feb 2018 12:07:34 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] KVM/x86: remove WARN_ON() for when vm_munmap() fails
Message-ID: <20180201200734.hst7s56y6e5lztpi@gmail.com>
References: <001a1141c71c13f559055d1b28eb@google.com>
 <20180201013021.151884-1-ebiggers3@gmail.com>
 <20180201153310.GD31080@flask>
 <584ef475-21cc-9ef5-8ac9-d6b00e93134e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <584ef475-21cc-9ef5-8ac9-d6b00e93134e@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 12:12:00PM -0500, Paolo Bonzini wrote:
> On 01/02/2018 10:33, Radim Krčmář wrote:
> > 2018-01-31 17:30-0800, Eric Biggers:
> >> From: Eric Biggers <ebiggers@google.com>
> >>
> >> On x86, special KVM memslots such as the TSS region have anonymous
> >> memory mappings created on behalf of userspace, and these mappings are
> >> removed when the VM is destroyed.
> >>
> >> It is however possible for removing these mappings via vm_munmap() to
> >> fail.  This can most easily happen if the thread receives SIGKILL while
> >> it's waiting to acquire ->mmap_sem.   This triggers the 'WARN_ON(r < 0)'
> >> in __x86_set_memory_region().  syzkaller was able to hit this, using
> >> 'exit()' to send the SIGKILL.  Note that while the vm_munmap() failure
> >> results in the mapping not being removed immediately, it is not leaked
> >> forever but rather will be freed when the process exits.
> >>
> >> It's not really possible to handle this failure properly, so almost
> > 
> > We could check "r < 0 && r != -EINTR" to get rid of the easily
> > triggerable warning.
> 
> Considering that vm_munmap uses down_write_killable, that would be
> preferrable I think.
> 

Don't be so sure that vm_munmap() can't fail for other reasons as well :-)
Remember, userspace can mess around with its address space.

And indeed, looking closer, I see there was a previous report of this same WARN
on an older kernel which in vm_munmap() still had down_write() instead of
down_write_killable().  The reproducer in that case concurrently called
personality(ADDR_LIMIT_3GB) to reduce its address limit after the mapping was
already created above 3 GiB.  Then the vm_munmap() returned EINVAL since
'start > TASK_SIZE'.

So I don't think we should check for specific error codes.  We could make it a
pr_warn_ratelimited() though, if we still want some notification that there was
a problem without implying it is a kernel bug as WARN_ON() does.

- Eric
