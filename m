Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034449AbeEXTGw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:06:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030244AbeEXTGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:06:50 -0400
Date: Thu, 24 May 2018 22:06:40 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
 <20180524115613.GA16908@rapoport-lnx>
 <e42a383f-491a-b42a-347c-effe4b86b982@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42a383f-491a-b42a-347c-effe4b86b982@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18052419-0040-0000-0000-0000045D2705
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052419-0041-0000-0000-000021018598
Message-Id: <20180524190639.GD16908@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 07:40:07PM +0300, Pavel Emelyanov wrote:
> On 05/24/2018 02:56 PM, Mike Rapoport wrote:
> > On Thu, May 24, 2018 at 02:24:37PM +0300, Pavel Emelyanov wrote:
> >> On 05/23/2018 10:42 AM, Mike Rapoport wrote:
> >>> If a process monitored with userfaultfd changes it's memory mappings or
> >>> forks() at the same time as uffd monitor fills the process memory with
> >>> UFFDIO_COPY, the actual creation of page table entries and copying of the
> >>> data in mcopy_atomic may happen either before of after the memory mapping
> >>> modifications and there is no way for the uffd monitor to maintain
> >>> consistent view of the process memory layout.
> >>>
> >>> For instance, let's consider fork() running in parallel with
> >>> userfaultfd_copy():
> >>>
> >>> process        		         |	uffd monitor
> >>> ---------------------------------+------------------------------
> >>> fork()        		         | userfaultfd_copy()
> >>> ...        		         | ...
> >>>     dup_mmap()        	         |     down_read(mmap_sem)
> >>>     down_write(mmap_sem)         |     /* create PTEs, copy data */
> >>>         dup_uffd()               |     up_read(mmap_sem)
> >>>         copy_page_range()        |
> >>>         up_write(mmap_sem)       |
> >>>         dup_uffd_complete()      |
> >>>             /* notify monitor */ |
> >>>
> >>> If the userfaultfd_copy() takes the mmap_sem first, the new page(s) will be
> >>> present by the time copy_page_range() is called and they will appear in the
> >>> child's memory mappings. However, if the fork() is the first to take the
> >>> mmap_sem, the new pages won't be mapped in the child's address space.
> >>
> >> But in this case child should get an entry, that emits a message to uffd when step upon!
> >> And uffd will just userfaultfd_copy() it again. No?
> >  
> > There will be a message, indeed. But there is no way for monitor to tell
> > whether the pages it copied are present or not in the child.
> 
> If there's a message, then they are not present, that's for sure :)

If the pages are not present and child tries to access them, the monitor
will get page fault notification and everything is fine.
However, if the pages *are present*, the child can access them without uffd
noticing. And if we copy them into child it'll see the wrong data.
Since we are talking about background copy, we'd need to decide whether the
pages should be copied or not regardless #PF notifications.
 
> > Since the monitor cannot assume that the process will access all its memory
> > it has to copy some pages "in the background". A simple monitor may look
> > like:
> > 
> > 	for (;;) {
> > 		wait_for_uffd_events(timeout);
> > 		handle_uffd_events();
> > 		uffd_copy(some not faulted pages);
> > 	}
> > 
> > Then, if the "background" uffd_copy() races with fork, the pages we've
> > copied may be already present in parent's mappings before the call to
> > copy_page_range() and may be not.
> > 
> > If the pages were not present, uffd_copy'ing them again to the child's
> > memory would be ok.
> 
> Yes.
> 
> > But if uffd_copy() was first to catch mmap_sem, and we would uffd_copy them
> > again, child process will get memory corruption.
> 
> You mean the background uffd_copy()?

Yes.

> But doesn't it race even with regular PF handling, not only the fork? How
> do we handle this race?

With the regular #PF handing, the faulting thread patiently waits until
page fault is resolved. With fork(), mremap() etc the thread that caused
the event resumes once the uffd message is read by the monitor. That's
surely way before monitor had chance to somehow process that message.

> -- Pavel
> 

-- 
Sincerely yours,
Mike.
