Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeCIV7l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:59:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932206AbeCIV7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:59:38 -0500
Subject: Re: [PATCH v2] exec: Set file unwritable before LSM check
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 09 Mar 2018 16:54:27 -0500
In-Reply-To: <CAGXu5j++Ju0Jg0O3gXPGD7Nzy8uE3NZo_dCF-L0hontG_P+5yw@mail.gmail.com>
References: <20180309193020.GA5149@beast>
         <CA+55aFyp4Lvz8QVckBr+zp4OfB1VaFNb2J1s0-xEMA9h44c0UA@mail.gmail.com>
         <CAGXu5j++Ju0Jg0O3gXPGD7Nzy8uE3NZo_dCF-L0hontG_P+5yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030921-0012-0000-0000-000005BAFE07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030921-0013-0000-0000-00001937240B
Message-Id: <1520632467.3911.49.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090260
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 11:54 -0800, Kees Cook wrote:
> On Fri, Mar 9, 2018 at 11:47 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Mar 9, 2018 at 11:30 AM, Kees Cook <keescook@chromium.org> wrote:
> >> The LSM check should happen after the file has been confirmed to be
> >> unchanging. Without this, we could have a race between the Time of Check
> >> (the call to security_kernel_read_file() which could read the file and
> >> make access policy decisions) and the Time of Use (starting with
> >> kernel_read_file()'s reading of the file contents). In theory, file
> >> contents could change between the two.

For files opened by userspace, IMA refers to the problem as "Time of
Measure, Time of Use" (ToMToU) and emits an audit message.

security_kernel_read_file() is being called by the kernel to read the
kexec kernel image and initramfs, kernel modules (new syscall),
ima_policy, EVM x509 certificate, and firmware.

If these files are signed, like they should be, then IMA prevents them
from being opened for write.  Modifying the file via the filesystem
should not be possible.  Other sorts of attacks, would probably be
possible.

If these files aren't signed, then in terms of IMA-measurement the
file measured, might not be the file used.  The ToMToU audit message
is not being generated for these files.

> > I'm going to assume I get this for 4.17 from the security tree.
> >
> > Because I'm guessing there are actually no existing users that care?
> > selinux seems to just look at file state, not actually at contents or
> > anything that write access denial would care about.
> >
> > And the only other security module that even registers this is
> > loadpin, and again it just seems to check things like "on the right
> > filesystem" that aren't actually impacted by write access (in fact,
> > the documented reason is to check that it's a read-only filesystem so
> > that write access is simply _irrelevant_).
> >
> > So this issue seems to be mainly a cleanliness thing, not an actual bug.
> 
> That is my assumption too (I left off the Cc: stable as a result). I'm
> much less familiar with IMA, though, but it's a caller of
> kernel_read_file(), not hooking it, etc.

Please add my reviewed-by.

Mimi
