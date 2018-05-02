Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeEBO1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36455 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeEBO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:27:44 -0400
Date: Wed, 2 May 2018 16:27:41 +0200
From: Michal Hocko <mhocko@kernel.org>
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory_hotplug: use put_device() if device_register
 fail
Message-ID: <20180502142741.GI26305@dhcp22.suse.cz>
References: <2987b5bdb31e7c18cd837da0f1e32a98fecd3278.1524757165.git.arvind.yadav.cs@gmail.com>
 <20180427145623.GC5404@dhcp22.suse.cz>
 <5AE40830.2090007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AE40830.2090007@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 28-04-18 11:05:44, arvindY wrote:
> 
> 
> On Friday 27 April 2018 08:26 PM, Michal Hocko wrote:
> > On Thu 26-04-18 21:12:09, Arvind Yadav wrote:
> > > if device_register() returned an error. Always use put_device()
> > > to give up the initialized reference and release allocated memory.
> > Is this patch correct? The docummentation says
> >   * NOTE: _Never_ directly free @dev after calling this function, even
> >   * if it returned an error! Always use put_device() to give up your
> >   * reference instead.
> > 
> > but we do not have _our_ reference in this path AFAICS. Maybe this is
> > just a documentation issue? How have you tested this change btw.?
> The document is correct. Here device_register() will initialize object by
> making reference count as 1 and also increment reference count for device.
> 
> device_register() {
>    device_initialize()->kobject_init()->kref_init() - initialize object(
> reference count = 1).
>    device_add()->get_device() - increment reference count for device.
> }
> 
> If device_register() will fail then we have to release the object by making
> reference count 0.

I am confused. If device_register intializes the reference to 1 then why
it doesn't decrement it on a failure path and rather expects the caller
to do that? The doc as I read it means that we should only drop a
reference if we have our own one before calling device_register.

Or what do I miss here?
-- 
Michal Hocko
SUSE Labs
