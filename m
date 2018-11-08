Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D3FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB5C20837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB5C20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeKHMjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:39:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeKHMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:39:19 -0500
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F12044A4;
        Thu,  8 Nov 2018 03:05:59 +0000 (UTC)
Date:   Wed, 7 Nov 2018 19:05:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <rong.a.chen@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>,
        Tejun Heo <tj@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [LKP] d50d82faa0 [ 33.671845] WARNING: possible circular
 locking dependency detected
Message-Id: <20181107190558.812375161de4b5df413ea31b@linux-foundation.org>
In-Reply-To: <20181107154336.21e1f815226facdffd4a6c54@linux-foundation.org>
References: <20181023003004.GH24195@shao2-debian>
        <20181107154336.21e1f815226facdffd4a6c54@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 15:43:36 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 23 Oct 2018 08:30:04 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
> 
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > commit d50d82faa0c964e31f7a946ba8aba7c715ca7ab0
> > Author:     Mikulas Patocka <mpatocka@redhat.com>
> > AuthorDate: Wed Jun 27 23:26:09 2018 -0700
> > Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> > CommitDate: Thu Jun 28 11:16:44 2018 -0700
> > 
> >     slub: fix failure when we delete and create a slab cache
> 
> This is ugly.  Is there an alternative way of fixing the race which
> Mikulas attempted to address?  Possibly cancel the work and reuse the
> existing sysfs file, or is that too stupid to live?
> 
> 3b7b314053d021 ("slub: make sysfs file removal asynchronous") was
> pretty lame, really.  As mentioned,
> 
> : It'd be the cleanest to deal with the issue by removing sysfs files
> : without holding slab_mutex before the rest of shutdown; however, given
> : the current code structure, it is pretty difficult to do so.
> 
> Would be a preferable approach.
> 
> >     
> >     This uncovered a bug in the slub subsystem - if we delete a cache and
> >     immediatelly create another cache with the same attributes, it fails
> >     because of duplicate filename in /sys/kernel/slab/.  The slub subsystem
> >     offloads freeing the cache to a workqueue - and if we create the new
> >     cache before the workqueue runs, it complains because of duplicate
> >     filename in sysfs.

Alternatively, could we flush the workqueue before attempting to
(re)create the sysfs file?  Extra points for only doing this if the
first (re)creation attempt returned -EEXIST?

