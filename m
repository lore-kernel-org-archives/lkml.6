Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeEBPpU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:45:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751862AbeEBPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:45:15 -0400
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Wed, 02 May 2018 11:45:04 -0400
In-Reply-To: <87h8nqglpx.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
         <87h8nqglpx.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050215-0040-0000-0000-0000045431C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050215-0041-0000-0000-000020F8531F
Message-Id: <1525275904.5669.308.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > Allow LSMs and IMA to differentiate between the kexec_load and
> > kexec_file_load syscalls by adding an "unnecessary" call to
> > security_kernel_read_file() in kexec_load.  This would be similar to the
> > existing init_module syscall calling security_kernel_read_file().
> 
> Given the reasonable desire to load a policy that ensures everything
> has a signature I don't have fundamental objections.
> 
> security_kernel_read_file as a hook seems an odd choice.  At the very
> least it has a bad name because there is no file reading going on here.
> 
> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
> anywhere.  Which means I could have a kernel compiled without that and I
> would be allowed to use kexec_file_load without signature checking.
> While kexec_load would be denied.
> 
> Am I missing something here?

The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
calls security_kernel_read_file().  So kexec_file_load and kexec_load
syscall would be using the same method for enforcing signature
verification.

This is independent of the architecture specific method for verifying
signatures.  The coordination between these two methods was included
in the lockdown patch set, but is being removed, as well the gating of
kexec_load syscall.  Instead of being based on the lockdown flag, I
assume the coordination between the two methods will reappear based on
a secure boot flag of some sort.

Mimi

> 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  kernel/kexec.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index aed8fb2564b3..d1386cfc6796 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/capability.h>
> >  #include <linux/mm.h>
> >  #include <linux/file.h>
> > +#include <linux/security.h>
> >  #include <linux/kexec.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> > @@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> >  static inline int kexec_load_check(unsigned long nr_segments,
> >  				   unsigned long flags)
> >  {
> > +	int result;
> > +
> >  	/* We only trust the superuser with rebooting the system. */
> >  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >  		return -EPERM;
> >  
> >  	/*
> > +	 * Allow LSMs and IMA to differentiate between kexec_load and
> > +	 * kexec_file_load syscalls.
> > +	 */
> > +	result = security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
> > +	if (result < 0)
> > +		return result;
> > +
> > +	/*
> >  	 * Verify we have a legal set of flags
> >  	 * This leaves us room for future extensions.
> >  	 */
> 
