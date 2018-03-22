Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCVQNU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:13:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeCVQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:13:18 -0400
Date: Thu, 22 Mar 2018 09:13:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
Message-ID: <20180322161316.GD28468@bombadil.infradead.org>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321131449.GN23100@dhcp22.suse.cz>
 <8e0ded7b-4be4-fa25-f40c-d3116a6db4db@linux.alibaba.com>
 <cf87ade4-5a5c-3919-0fc6-acc40e12659b@linux.alibaba.com>
 <20180321212355.GR23100@dhcp22.suse.cz>
 <952dcae2-a73e-0726-3cc5-9b6a63b417b7@linux.alibaba.com>
 <20180322091008.GZ23100@dhcp22.suse.cz>
 <8b4407dd-78f6-2f6f-3f45-ddb8a2d805c8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4407dd-78f6-2f6f-3f45-ddb8a2d805c8@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 09:06:14AM -0700, Yang Shi wrote:
> On 3/22/18 2:10 AM, Michal Hocko wrote:
> > On Wed 21-03-18 15:36:12, Yang Shi wrote:
> > > On 3/21/18 2:23 PM, Michal Hocko wrote:
> > > > On Wed 21-03-18 10:16:41, Yang Shi wrote:
> > > > > proc_pid_cmdline_read(), it calls access_remote_vm() which need acquire
> > > > > mmap_sem too, so the mmap_sem scalability issue will be hit sooner or later.
> > > > Ohh, absolutely. mmap_sem is unfortunatelly abused and it would be great
> > > > to remove that. munmap should perform much better. How to do that safely
> > The full vma will have to be range locked. So there is nothing small or large.
> 
> It sounds not helpful to a single large vma case since just one range lock
> for the vma, it sounds equal to mmap_sem.

But splitting mmap_sem into pieces is beneficial for this case.  Imagine
we have a spinlock / rwlock to protect the rbtree / arg_start / arg_end
/ ...  and then each VMA has a rwsem (or equivalent).  access_remote_vm()
would walk the tree and grab the VMA's rwsem for read while reading
out the arguments.  The munmap code would have a completely different
VMA write-locked.
