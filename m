Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeDAGjQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 02:39:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750934AbeDAGjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 02:39:11 -0400
Date: Sun, 1 Apr 2018 09:38:58 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180329154607.3d8bda75@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329154607.3d8bda75@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18040106-0040-0000-0000-0000042914C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040106-0041-0000-0000-0000262C3B5D
Message-Id: <20180401063857.GA3357@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804010070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added akpm)

On Thu, Mar 29, 2018 at 03:46:07PM -0600, Jonathan Corbet wrote:
> On Wed, 21 Mar 2018 21:22:16 +0200
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > These patches convert files in Documentation/vm to ReST format, add an
> > initial index and link it to the top level documentation.
> > 
> > There are no contents changes in the documentation, except few spelling
> > fixes. The relatively large diffstat stems from the indentation and
> > paragraph wrapping changes.
> > 
> > I've tried to keep the formatting as consistent as possible, but I could
> > miss some places that needed markup and add some markup where it was not
> > necessary.
> 
> So I've been pondering on these for a bit.  It looks like a reasonable and
> straightforward RST conversion, no real complaints there.  But I do have a
> couple of concerns...
> 
> One is that, as we move documentation into RST, I'm really trying to
> organize it a bit so that it is better tuned to the various audiences we
> have.  For example, ksm.txt is going to be of interest to sysadmin types,
> who might want to tune it.  mmu_notifier.txt is of interest to ...
> somebody, but probably nobody who is thinking in user space.  And so on.
> 
> So I would really like to see this material split up and put into the
> appropriate places in the RST hierarchy - admin-guide for administrative
> stuff, core-api for kernel development topics, etc.  That, of course,
> could be done separately from the RST conversion, but I suspect I know
> what will (or will not) happen if we agree to defer that for now :)

Well, I was actually planning on doing that ;-)

My thinking was to start with mechanical RST conversion and then to start
working on the contents and ordering of the documentation. Some of the
existing files, e.g. ksm.txt, can be moved as is into the appropriate
places, others, like transhuge.txt should be at least split into admin/user
and developer guides.

Another problem with many of the existing mm docs is that they are rather
developer notes and it wouldn't be really straight forward to assign them
to a particular topic.

I believe that keeping the mm docs together will give better visibility of
what (little) mm documentation we have and will make the updates easier.
The documents that fit well into a certain topic could be linked there. For
instance:

-------------------------
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5bb9161..8f6c6e6 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -63,6 +63,7 @@ configure specific aspects of kernel behavior to your liking.
    pm/index
    thunderbolt
    LSM/index
+   vm/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/vm/index.rst b/Documentation/admin-guide/vm/index.rst
new file mode 100644
index 0000000..d86f1c8
--- /dev/null
+++ b/Documentation/admin-guide/vm/index.rst
@@ -0,0 +1,5 @@
+==============================================
+Knobs and Buttons for Memory Management Tuning
+==============================================
+
+* :ref:`ksm <ksm>`
-------------------------

> The other is the inevitable merge conflicts that changing that many doc
> files will create.  Sending the patches through Andrew could minimize
> that, I guess, or at least make it his problem.  Alternatively, we could
> try to do it as an end-of-merge-window sort of thing.  I can try to manage
> that, but an ack or two from the mm crowd would be nice to have.

I can rebase on top of Andrew's tree if that would help to minimize the
merge conflicts.
 
> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.
