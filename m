Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeECVHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:07:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750911AbeECVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:07:09 -0400
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:59 -0400
In-Reply-To: <87y3h0pu72.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
         <87h8nqglpx.fsf@xmission.com>
                <1525275904.5669.308.camel@linux.vnet.ibm.com>
         <87h8nospo5.fsf@xmission.com>
         <6203b1e4-70c3-6d0e-60e0-56c6e8f72ec9@schaufler-ca.com>
         <87y3h0pu72.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050321-0008-0000-0000-000004F2B661
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050321-0009-0000-0000-00001E86DF87
Message-Id: <1525381619.3539.45.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 11:42 -0500, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > On 5/3/2018 8:51 AM, Eric W. Biederman wrote:
> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> >>
> >>> On Wed, 2018-05-02 at 09:45 -0500, Eric W. Biederman wrote:
> >>>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> >>>>
> >>>>> Allow LSMs and IMA to differentiate between the kexec_load and
> >>>>> kexec_file_load syscalls by adding an "unnecessary" call to
> >>>>> security_kernel_read_file() in kexec_load.  This would be similar to the
> >>>>> existing init_module syscall calling security_kernel_read_file().
> >>>> Given the reasonable desire to load a policy that ensures everything
> >>>> has a signature I don't have fundamental objections.
> >>>>
> >>>> security_kernel_read_file as a hook seems an odd choice.  At the very
> >>>> least it has a bad name because there is no file reading going on here.
> >>>>
> >>>> I am concerned that I don't see CONFIG_KEXEC_VERIFY_SIG being tested
> >>>> anywhere.  Which means I could have a kernel compiled without that and I
> >>>> would be allowed to use kexec_file_load without signature checking.
> >>>> While kexec_load would be denied.
> >>>>
> >>>> Am I missing something here?
> >>> The kexec_file_load() calls kernel_read_file_from_fd(), which in turn
> >>> calls security_kernel_read_file().  So kexec_file_load and kexec_load
> >>> syscall would be using the same method for enforcing signature
> >>> verification.
> >> Having looked at your patches and the kernel a little more I think
> >> this should be a separate security hook that does not take a file
> >> parameter.
> >>
> >> Right now every other security module assumes !file is init_module.
> >> So I think this change has the potential to confuse other security
> >> modules, with the result of unintended policy being applied.
> >>
> >> So just for good security module hygeine I think this needs a dedicated
> >> kexec_load security hook.
> >
> > I would rather see the existing modules updated than a new
> > hook added. Too many hooks spoil the broth. Two hooks with
> > trivial differences just add to the clutter and make it harder
> > for non-lsm developers to figure out what to use in their
> > code.
> 
> These are not non-trivial differences.  There is absolutely nothing
> file related about kexec_load.  Nor for init_module for that matter.
> 
> If something is called security_kernel_read_file I think it is wholly
> appropriate for code that processes such a hook to assume file is
> non-NULL.
> 
> When you have to dance a jig (which is what I see the security modules
> doing) to figure out who is calling a lsm hook for what purpose I think
> it is a maintenance problem waiting to happen and that the hook is badly
> designed.
> 
> At this point I don't care what the lsm's do with the hooks but the
> hooks need to make sense for people outside of the lsm's and something
> about reading a file in a syscall that doesn't read files is complete
> and utter nonsense.

Sure, we can define a wrapper around the security_kernel_read_file()
hook, calling it security_non-fd_syscall() or even
security_old_syscall().

Mimi
