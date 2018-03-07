Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754498AbeCGNSN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:18:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754480AbeCGNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:18:11 -0500
Subject: Re: [PATCH 0/9] KEYS: Blacklisting & UEFI database load
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jiri Slaby <jslaby@suse.cz>, David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org
Cc: matthew.garrett@nebula.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Mar 2018 08:18:02 -0500
In-Reply-To: <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
References: <147931984418.16460.6639993676886095760.stgit@warthog.procyon.org.uk>
         <6eabbb43-295e-9ba0-c0d9-120f48aa0e1d@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030713-0040-0000-0000-0000043BEC5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030713-0041-0000-0000-000020DF07A3
Message-Id: <1520428682.10396.445.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 15:05 +0100, Jiri Slaby wrote:
> On 11/16/2016, 07:10 PM, David Howells wrote:
> > Here are two sets of patches.  Firstly, the first three patches provide a
> > blacklist, making the following changes:
> ...
> > Secondly, the remaining patches allow the UEFI database to be used to load
> > the system keyrings:
> ...
> > Dave Howells (2):
> >       efi: Add EFI signature data types
> >       efi: Add an EFI signature blob parser
> > 
> > David Howells (5):
> >       KEYS: Add a system blacklist keyring
> >       X.509: Allow X.509 certs to be blacklisted
> >       PKCS#7: Handle blacklisted certificates
> >       KEYS: Allow unrestricted boot-time addition of keys to secondary keyring
> >       efi: Add SHIM and image security database GUID definitions
> > 
> > Josh Boyer (2):
> >       MODSIGN: Import certificates from UEFI Secure Boot
> >       MODSIGN: Allow the "db" UEFI variable to be suppressed
> 
> Hi,
> 
> what's the status of this please? Distributors (I checked SUSE, RedHat
> and Ubuntu) have to carry these patches and every of them have to
> forward-port the patches to new kernels. So are you going to resend the
> PR to have this merged?

With secure boot enabled, we establish a signature chain of trust,
rooted in HW, up to the kernel and then transition from those keys to
a new set of keys builtin the kernel and loaded onto the
builtin_trusted_keys (builtin).

Enabling the secondary_builtin_keys (secondary) allows keys signed by
a key on the builtin keyring to be added to the secondary keyring.
 Any key, signed by a key on either the builtin or secondary keyring,
can be added to the IMA trusted keyring.

The "KEYS: Allow unrestricted boot-time addition of keys to secondary
keyring" patch loads the platform keys directly onto the secondary
keyring, without requiring them to be signed by a key on the builtin
or secondary keyring.  With this change, any key signed by a platfrom
key on the secondary, can be loaded onto the .ima trusted keyring.

Just because I trust the platform keys prior to booting the kernel,
doesn't mean that I *want* to trust those keys once booted.  There
are, however, places where we need access to those keys to verify a
signature (eg. kexec kernel image).

Nayna Jain's "certs: define a trusted platform keyring" patch set
introduces a new, separate keyring for these platform keys.

Mimi
