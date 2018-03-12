Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeCLVxb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:53:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932265AbeCLVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:53:29 -0400
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jiandi An <anjiandi@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Safford <david.safford@ge.com>
Date: Mon, 12 Mar 2018 17:53:18 -0400
In-Reply-To: <1520615461.12216.6.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
         <1520615461.12216.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031221-0020-0000-0000-000004028E7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031221-0021-0000-0000-00004296E08E
Message-Id: <1520891598.3547.190.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120237
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 09:11 -0800, James Bottomley wrote:
> On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:
> [...]
> > I'm no expert on IMA and its driver.  James, will you be kind enough
> > to look into overhauling the IMA driver to not measure until after 
> > initrd phase if that's the consensus on resolving this?
> 
> I'll add it to my todo list.
> 
> Since my TPM 2.0 test environment is a VM with a tpm that has a network
> connection to an emulator on my host, it's impossible to set it up so
> that it's built in (because you need the network config before you init
> the TPM) so I might accelerate if I suddenly need to debug IMA issues
> in this configuration.

There are a number of different issues being discussed.

- When IMA is enabled, unlike some other TPM device drivers, the TPM
2.0 is not forced to be builtin.

This is addressed by Jiandi's patch.

- Jason's comment questioning having Kconfig force the TPM to be
builtin.

Using Kconfig to force the TPM to be builtin is not required, but
helpful.  Users interested in IMA-measurement could configure the TPM
as builtin themselves.  Without the TPM builtin, IMA goes into TPM-
bypass mode.

Extending a TPM with IMA measurements, which was not builtin, but
loaded at some unspecified point in time, changes the existing meaning
of the IMA-measurement list.

- This use case, when the TPM is not builtin and unavailable before
IMA is initialized.

I would classify this use case as an IMA testing/debugging
environment, when it cannot, for whatever reason, be builtin the
kernel or initialized before IMA.

>From Dave Safford:
    For the TCG chain of trust to have any meaning, all files have to
    be measured and extended into the TPM before they are accessed. If
    the TPM driver is loaded after any unmeasured file, the chain is
    broken, and IMA is useless for any use case or any threat model.

    While the initramfs may be measured by the bootloader, there are
    two problems:
    1. IMA has no way of knowing if the kernel or initramfs has
    accessed any unmeasured files before TPM driver loading and IMA
    initialization.
    2. Even if we can somehow guarantee that nothing outside the
    initramfs has been accessed prior to IMA initialization, it is
    difficult if not impossible for the attestation server to know what
    a good initramfs measurement should be, as the initramfs is built
    on the suspect device in the first place.  We can sort of trust the
    initramfs measurement in the reference manifest, but after that,
    the attestation server has no way to trust a reported initramfs
    measurement.

Mimi
