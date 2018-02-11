Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeBKOHg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 09:07:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753243AbeBKOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 09:07:34 -0500
Subject: Re: [GIT PULL] Integrity: IMA FUSE fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 09:07:26 -0500
In-Reply-To: <alpine.LRH.2.21.1802112339270.20189@namei.org>
References: <alpine.LRH.2.21.1802101718330.4382@namei.org>
         <CA+55aFzX+=WRaVi51gaqCdnrxwXC3kqxk8LZyXQY=yn5XigE4Q@mail.gmail.com>
         <1518324116.5491.132.camel@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1802112339270.20189@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18021114-0012-0000-0000-000005AD93F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021114-0013-0000-0000-0000192954FC
Message-Id: <1518358046.5491.187.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802110186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 00:19 +1100, James Morris wrote:
> On Sat, 10 Feb 2018, Mimi Zohar wrote:
> > Custom policy rules could be defined to disable measurement,
> > appraisal, and audit for files on fuse.  However, I don't think we
> > want to automatically disable measurement, even meaningless
> > measurements.  Some indication needs to be included for remote
> > attestation, security analytics, or forensics.  For systems with
> > policies that require file signatures even on fuse, the safest thing
> > would seem to be to fail the signature verification.
> 
> I don't understand this -- if a file passes signature verification, it 
> passes.  If it was modified and still passes, the problem is elsewhere.
> 
> I don't think the FUSE measurements are inherently useless, or more 
> useless than any others, at least.  You can misconfigure all kinds of 
> things on a system which would undermine IMA, and I would count allowing 
> unprivileged use of FUSE with critical files as such.

The problem is that fuse can provide whatever it wants, whenever it
wants.  It could provide different pages for the initial file hash
calculation and then for usage.

If the file is first read into a buffer, like for the kernel_read_file_xxx() hooks, then the file data would be the same for the file calculation and usage, but for most of the IMA hooks, the file isn't first read into a buffer.

> The point of the patches, IIUC, was that FUSE had no useful way to notify 
> IMA that a file had changed, so, always measure.  IMA assumes that changes 
> to a running system are made under the control of a correctly enforced 
> security policy.  If you're using FUSE and IMA, then you should understand 
> the security implications of that.  Or am I missing something?

That's all true, but I think the intent of these patches was to detect
malicious file change, where the fuse filesystem itself is malicious.

>From the patch description:    
    It is useful in FUSE because the userspace FUSE process can change the
    underlying files at any time without notifying the kernel. FUSE can be
    mounted by unprivileged users either today with fusermount installed
    with setuid, or soon with the upcoming patches to allow FUSE mounts in
    a non-init user namespace. That makes the issue more visible than for
    network filesystems where unprivileged users cannot mount.

For the example test provided, re-measuring the file works properly. I
had missed that if the fuse filesystem could provide different files,
at least in theory, it could also be able to provide different pages.

Mimi
