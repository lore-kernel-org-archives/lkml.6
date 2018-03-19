Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbeCSOMR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:12:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755299AbeCSOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:12:13 -0400
Subject: Re: [PATCH 0/9] KEYS: Blacklisting & UEFI database load
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: joeyli <jlee@suse.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jiri Slaby <jslaby@suse.cz>, David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, matthew.garrett@nebula.com,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 19 Mar 2018 10:12:03 -0400
In-Reply-To: <20180311032022.GA31059@linux-l9pv.suse>
References: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
         <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
         <1520428682.10396.445.camel@linux.vnet.ibm.com>
         <1520436517.5558.2.camel@HansenPartnership.com>
         <20180311032022.GA31059@linux-l9pv.suse>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031914-0040-0000-0000-00000422DB0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031914-0041-0000-0000-00002625F0A7
Message-Id: <1521468723.3503.171.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803190164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-11 at 11:20 +0800, joeyli wrote:
> On Wed, Mar 07, 2018 at 07:28:37AM -0800, James Bottomley wrote:
> > On Wed, 2018-03-07 at 08:18 -0500, Mimi Zohar wrote:
> > > On Tue, 2018-03-06 at 15:05 +0100, Jiri Slaby wrote:
> > > > what's the status of this please? Distributors (I checked SUSE,
> > > > RedHat and Ubuntu) have to carry these patches and every of them
> > > > have to forward-port the patches to new kernels. So are you going
> > > > to resend the PR to have this merged?
> > [...]
> > > Just because I trust the platform keys prior to booting the kernel,
> > > doesn't mean that I *want* to trust those keys once booted.  There
> > > are, however, places where we need access to those keys to verify a
> > > signature (eg. kexec kernel image).
> > 
> > Which is essentially the reason I always give when these patches come
> > back
> >
> 
> Josh Boyer's "MODSIGN: Allow the "db" UEFI variable to be suppressed"
> patch checks MokIgnoreDB variable to ignore db:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-uefi&id=7c395b30a33a617c5cc2cdd419300af71277b79a
> 
> I think that we can consider to use MokAllowDB. Which means that kernel
> ignores DB by default.

Not all systems have a shim layer.  This design is really x86
specific.  Allowing shim keys, but ignoring DB, does not address those
systems.

> > > Nayna Jain's "certs: define a trusted platform keyring" patch set
> > > introduces a new, separate keyring for these platform keys.
> > 
> > Perhaps, to break the deadlock, we should ask Jiří what the reason is
> > the distros want these keys to be trusted.  Apart from the Microsoft
> > key, it will also give you an OEM key in your trusted keyring.  Is it
> > something to do with OEM supplied modules?
> >
> 
> As I remember that some manufacturers uses certificate in db to
> sign their kernel module. We need to discuss with them for switching
> to mok. Currently I do not know all use cases for using db.
> 
> There have some benefits for using db:
> 
>  - User does not need to deal with shim-mokmanager to enroll mok.
>    Target machine doesn't need to reboot and user doesn't need to
>    face to mokmanager UI.  

The reason for trusting enrolled shim keys is because it requires
physical presence.  (I kind of remember hearing that this changed.
 There is some method of accepting enrolled keys that does not require
physical presence.)

>  - The db is a authenticated variable, it's still secure when secure
>    boot is disabled.
>    The db is a authenticated variable that it can only be modified
>    by manufacturer's key. Kernel can trust it when secure boot
>    is disabled. It's useful for we do not need to taint kernel
>    for loading a manufacturer's kernel module even secure boot is
>    disabled.
> 
>  - Do not need to worry about the space of NVRAM and the EFI firmware
>    implementation for writing a boot time variable.
>   
> But I also agree that we should not trust all keys (like Microsoft key)
> in db by default.

Between requiring a shim layer and relying on physical presence, I'm
not convinced this is the best solution.  Do we really want to support
different methods for different architectures?

Mimi
