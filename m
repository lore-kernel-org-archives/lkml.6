Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeECV6H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:58:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751216AbeECV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:58:04 -0400
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date: Thu, 03 May 2018 17:57:55 -0400
In-Reply-To: <87d0yco1vy.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
         <87r2mso5up.fsf@xmission.com>  <1525383075.3539.67.camel@linux.vnet.ibm.com>
         <87d0yco1vy.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050321-0044-0000-0000-0000054EB88E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050321-0045-0000-0000-0000288FE16F
Message-Id: <1525384675.3539.89.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 16:38 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > [Cc'ing Kees and kernel-hardening]
> >
> > On Thu, 2018-05-03 at 15:13 -0500, Eric W. Biederman wrote:
> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> >> 
> >> > In environments that require the kexec kernel image to be signed, prevent
> >> > using the kexec_load syscall.  In order for LSMs and IMA to differentiate
> >> > between kexec_load and kexec_file_load syscalls, this patch set adds a
> >> > call to security_kernel_read_file() in kexec_load_check().
> >> 
> >> Having thought about it some more this justification for these changes
> >> does not work.  The functionality of kexec_load is already root-only.
> >> So in environments that require the kernel image to be signed just don't
> >> use kexec_load.  Possibly even compile kexec_load out to save space
> >> because you will never need it.  You don't need a new security hook to
> >> do any of that.  Userspace is a very fine mechanism for being the
> >> instrument of policy.
> >
> > True, for those building their own kernel, they can disable the old
> > syscalls.  The concern is not for those building their own kernels,
> > but for those using stock kernels.  
> >
> > By adding an LSM hook here in the kexec_load syscall, as opposed to an
> > IMA specific hook, other LSMs can piggy back on top of it.  Currently,
> > both load_pin and SELinux are gating the kernel module syscalls based
> > on security_kernel_read_file.
> >
> > If there was a similar option for the kernel image, I'm pretty sure
> > other LSMs would use it.
> >
> > From an IMA perspective, there needs to be some method for only
> > allowing signed code to be loaded, executed, etc. - kernel modules,
> > kernel image/initramfs, firmware, policies.
> 
> What is the IMA perspective.  Why can't IMA trust appropriately
> authorized userspace?

Suppose a system owner wants to define a system wide policy that
requires all code be signed - kernel modules, firmware, kexec image &
initramfs, executables, mmapped files, etc - without having to rebuild
the kernel.  Without a call in kexec_load that isn't possible.

> 
> >> If you don't trust userspace that needs to be spelled out very clearly.
> >> You need to talk about what your threat models are.
> >> 
> >> If the only justification is so that that we can't boot windows if
> >> someone hacks into userspace it has my nack because that is another kind
> >> of complete non-sense.
> >
> > The usecase is the ability to gate the kexec_load usage in stock
> > kernels.
> 
> But kexec_load is already gated.  It requires CAP_SYS_BOOT.

It isn't a matter of kexec_load already being gated, but of wanting a
single place for defining a system wide policy, as described above.

Mimi

> 
> >> Given that you are not trusting userspace this changeset also probably
> >> needs to have the kernel-hardening list cc'd.  Because the only possible
> >> justification I can imagine for something like this is kernel-hardening.
> >
> > Sure, Cc'ing linux-hardening and Kees.
> >
> > Mimi
> 
