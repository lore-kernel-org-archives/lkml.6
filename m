Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2975C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CA12543E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CA12543E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeGBOi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:38:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751878AbeGBOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:38:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62Ecktu142341
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 10:38:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jykvgdt3d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:38:50 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 15:38:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62EchUO43516140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 14:38:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B44BE11C054;
        Mon,  2 Jul 2018 15:38:26 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5389B11C05E;
        Mon,  2 Jul 2018 15:38:25 +0100 (BST)
Received: from localhost.ibm.com (unknown [9.80.97.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 15:38:25 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 0/8] kexec/firmware: support system wide policy requiring signatures
Date:   Mon,  2 Jul 2018 10:37:55 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18070214-0020-0000-0000-000002A2393C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070214-0021-0000-0000-000020EE4B05
Message-Id: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA-appraisal is mostly being used in the embedded or single purpose
closed system environments.  In these environments, both the Kconfig
options and the userspace tools can be modified appropriately to limit
syscalls.  For stock kernels, userspace applications need to continue to
work with older kernels as well as with newer kernels.

In this environment, the customer needs the ability to define a system
wide IMA policy, such as requiring all kexec'ed images, firmware, kernel
modules to be signed, without being dependent on either the Kconfig
options or the userspace tools.[1]

This patch set allows the customer to define a policy which requires
the kexec'ed kernel images, firmware, and/or kernel modules to be
signed.

In addition, this patch set includes the ability to configure a build
time IMA policy, which is automatically loaded at run time without
needing to specify it on the boot command line and persists after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v5:
- Shared kernel_load_data_id and kernel_read_file_id enumerations.

The previous version of this patch set defined a new LSM hook named
security_kernel_load_data and an associated enumeration named
kernel_load_data_id, independent of kernel_read_file_id.  In this
version, the kernel_load_data_id and kernel_read_file_id values are
shared, simplifying Loadpin's and other LSMs calling one LSM hook from
the other.

- Warn about loading firmware from pre-shared memory.

Previous versions of this patch set prevented loading firmware, based on
policy, from pre-allocated (DMA) memory, introduced in commit
a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer").
Based on discussions, calling dma_alloc_coherent() is unnecessary and
confusing.  This version of the patch set allows loading the firmware,
but emits a warning.

Changelog v4:
- Define a new LSM hook named security_kernel_load_data().
- Define kernel_load_data_id enumeration.
- Replace the existing LSM hook in init_module syscall.

Changelog v3:
Based on James' feedback:
- Renamed security_kernel_read_file() to security_kernel_read_data().
- Defined new kernel_load_data_id enumeration.
- Cleaned up ima_read_data(), replacing if's with switch.

Changelog v2:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis

Mimi Zohar (8):
  security: define new LSM hook named security_kernel_load_data
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy warn about loading firmware (pre-allocated
    buffer)
  module: replace the existing LSM hook in init_module

 drivers/base/firmware_loader/fallback.c |  7 +++
 include/linux/ima.h                     |  7 +++
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/security.h                | 27 ++++++++++++
 kernel/kexec.c                          |  8 ++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 ++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 78 ++++++++++++++++++++++++---------
 security/integrity/ima/ima_policy.c     | 48 ++++++++++++++++++--
 security/loadpin/loadpin.c              |  6 +++
 security/security.c                     | 10 +++++
 security/selinux/hooks.c                | 15 +++++++
 13 files changed, 249 insertions(+), 24 deletions(-)

-- 
2.7.5

