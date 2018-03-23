Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCWUGY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:06:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:06:22 -0400
Date: Fri, 23 Mar 2018 13:06:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-Id: <20180323130620.7d60fc442463ed5c21898387@linux-foundation.org>
In-Reply-To: <20180323031013.GB11150@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
        <20180322033722.9279-2-bhe@redhat.com>
        <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
        <20180323005845.GA25740@localhost.localdomain>
        <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
        <20180323031013.GB11150@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 11:10:13 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 03/22/18 at 07:06pm, Andrew Morton wrote:
> > On Fri, 23 Mar 2018 08:58:45 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > > erk, this is pretty nasty.  Isn't there a better way :(
> > > 
> > > Yes, this is not efficient.
> > > 
> > > In struct resource{}, ->sibling list is a singly linked list. I ever
> > > thought about changing it to doubly linked list, yet not very sure if
> > > it will have effect since struct resource is a core data structure.
> > 
> > Switching to a list_head sounds OK.  The only issue really is memory
> > consumption and surely we don't have tens of thousands of struct
> > resources floating about(?).  Or if we do have a lot, the machine is
> > presumably huge (hope?).
> 
> Yes. It doubles the memory consumption.
> 
> AFAIK, the biggest number of resrouces I heard of possibly is mentioned
> in this user space kexec_tools commit. In this commit, Xunlei told on
> SGI system with 64TB RAM, the array which we have been using to store
> "System RAM"|"Reserved"|"ACPI **" regions is not big enough. In that
> case, we need extra 8Byte*2048=16KB at most. With my understanding, this
> increase is system wide, since each resource instance only needs its own
> list_head member, right?

Yes.  That sounds perfectly acceptable.

It would be interesting to see what this approach looks like, if you
have time to toss something together?
