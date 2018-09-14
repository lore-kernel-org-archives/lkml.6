Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB93C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF2320861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF2320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeINNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbeINNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:16:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E82goK033639
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:02:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mg94gg0eg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:02:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 09:02:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 09:02:53 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8E82qqk62849188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 08:02:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B312542049;
        Fri, 14 Sep 2018 11:02:42 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50F0D42042;
        Fri, 14 Sep 2018 11:02:41 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.31.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Sep 2018 11:02:41 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 0/6] Add support for architecture specific IMA policies 
Date:   Fri, 14 Sep 2018 13:29:59 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18091408-0016-0000-0000-00000205456F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091408-0017-0000-0000-0000325C19D7
Message-Id: <20180914080005.6138-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=713 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific policy, introduced in this patch set, permits
different architectures to define IMA policy rules based on kernel
configuration and system runtime information.

For example, on x86, there are two methods of verifying the kexec'ed kernel
image signature - CONFIG_KEXEC_VERIFY_SIG and IMA appraisal policy
KEXEC_KERNEL_CHECK. CONFIG_KEXEC_VERIFY_SIG enforces the kexec_file_load
syscall to verify file signatures, but does not prevent the kexec_load
syscall. The IMA KEXEC_KERNEL_CHECK policy rule verifies the kexec'ed
kernel image, loaded via the kexec_file_load syscall, is validly signed and
prevents loading a kernel image via the kexec_load syscall. When secure
boot is enabled, the kexec'ed kernel image needs to be signed and the
signature verified. In this environment, either method of verifying the
kexec'ed kernel image is acceptable, as long as the kexec_load syscall is
disabled.

The previous version of this patchset introduced a new IMA policy rule to
disable the kexec_load syscall, when CONFIG_KEXEC_VERIFY_SIG was enabled,
however that is removed from this version by introducing a different
mechanism.

The patchset defines an arch_ima_get_secureboot() function to retrieve the
secureboot state of the system. If secureboot is enabled and
CONFIG_KEXEC_VERIFY_SIG is configured, it denies permission to kexec_load
syscall.

To support architecture specific policies, a new function
arch_get_ima_policy() is defined. This patch set defines IMA
KERNEL_KEXEC_POLICY rules for x86 only if CONFIG_KEXEC_VERIFY_SIG is
disabled and secure boot is enabled.

This patch set includes a patch, which refactors ima_init_policy() to
remove code duplication.

Changelog:

v2:
* ima: define arch_ima_get_secureboot
	- New Patch - to retrieve secureboot state of the system
* ima: prevent kexec_load syscall based on runtime secureboot flag
	- New Patch - disables kexec_load if KEXEC_VERIFY_SIG is
	  configured and secureboot is enabled
* ima: refactor ima_init_policy()
	- New Patch - cleans up the code duplication in
	  ima_init_policy(), adds new function add_rules()
* ima: add support for arch specific policies
	- modified ima_init_arch_policy() and ima_init_policy() to
	  use add_rules() from previous patch.
* ima: add support for external setting of ima_appraise
	- sets ima_appraise flag explicitly for arch_specific setting
* ima: add support for KEXEC_ORIG_KERNEL_CHECK
	- deleted the patch based on Seth's feedback
* x86/ima: define arch_get_ima_policy() for x86
	- removes the policy KEXEC_ORIG_KERNEL_CHECK based on
	  Seth's feedback.

Eric Richter (1):
  x86/ima: define arch_get_ima_policy() for x86

Nayna Jain (5):
  ima: define arch_ima_get_secureboot
  ima: prevent kexec_load syscall based on runtime secureboot flag
  ima: refactor ima_init_policy()
  ima: add support for arch specific policies
  ima: add support for external setting of ima_appraise

 arch/x86/kernel/Makefile              |   2 +
 arch/x86/kernel/ima_arch.c            |  33 +++++++
 include/linux/ima.h                   |  18 ++++
 security/integrity/ima/Kconfig        |   8 ++
 security/integrity/ima/ima.h          |   5 +
 security/integrity/ima/ima_appraise.c |  11 ++-
 security/integrity/ima/ima_main.c     |  17 ++--
 security/integrity/ima/ima_policy.c   | 167 +++++++++++++++++++++++++---------
 8 files changed, 212 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/kernel/ima_arch.c

-- 
2.13.6

