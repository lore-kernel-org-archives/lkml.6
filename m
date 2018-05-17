Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZo2t/aRczw05P3aiPkjGa3wGQcZ9tkRcbULl9Fo/6P7qqnvIfe1rUCWuiFrLy1wT0ZGu7+s
ARC-Seal: i=1; a=rsa-sha256; t=1526568574; cv=none;
        d=google.com; s=arc-20160816;
        b=rlrD+2/NunDx+QvZgORh/2rjtjEhjINnwpb++KZf/wfu+Groi7mY5qCrCPwxwq9cQB
         rMmiFlcfj7G2JUbIKNh6Ealp888G4tqkUyiyhC11ywYSenEtnuDr1s93CVV8KFGgF33p
         33O7FZhMOCleHGmsHh27e3W4hIAFOzMx9s2eMtu2Lz62EBx3GIJLMBoODBIB4R5u9Pw/
         9KBSLYD0c/tzMSo6TD5F+lIr9LNGS/af/0rLYki1ClHZTDy5kR3bbMuoCSMUsNFKBRWn
         E4gphkQ/x4CuOzcgaFcM7QBVquWL78BtftmMUnaudZmq/VG0ZRO58uSbtMPNjddM+EBa
         Ue2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=KpnNycjncj9Lb4iRUlPwW94OYbHEqlEdC5wTzp0JBkw=;
        b=xjiRyqBokHLif79DwA6VwLiyGrHdWf33Ak4g/986fW3rjEhnxUrPE7tdZ/QWjHlGrT
         ex7FTfn8brKH3BKWcaDf4Mx/zgb6D4+WUVu/XUTYPHeTFkAzPh6UZ+Nyte9zFyWo0pO1
         vBUJcBKK+6v7894GVYwG2qDobCwCintoxZKC0lINTp1DxSP8ah7rLsElXDjwtnluRMha
         49WqHFU3tvNFG4VERB17L+wsBzwwihJAQ2szEVDpfsqqqlKl1rurVy8z6rAkghvUDG/C
         Q5J22pNPZXy5a/vS2hVxUnrcAI90dgvBoZ4J8VkjxCUdaxtvr6DApt69OLl8GoC6+9wu
         R/YA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 0/9] kexec/firmware: support system wide policy requiring signatures
Date: Thu, 17 May 2018 10:48:41 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 18051714-0044-0000-0000-000005538AC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0045-0000-0000-000028950007
Message-Id: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723169485644246?=
X-GMAIL-MSGID: =?utf-8?q?1600723169485644246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

New to this patch set is the ability to configure a build time IMA policy,
which is automatically loaded at run time without needing to specify it
on the boot command line.  The build time policy rules persist after
loading a custom kernel policy.

[1] kexec-tools suupports the new syscall based on a flag (-s).

Changelog v3:
- combined "kexec: limit kexec_load syscall" and "firmware: kernel
signature verification" patch sets.
- add support for build time policy.
- defined generic security_kernel_read_blob() wrapper for
  security_kernel_read_file(). Suggested by Luis.
- removed the CONFIG_CFG80211_REQUIRE_SIGNED_REGDB ifdef.  If both REGDB
  and an IMA-appraisal policy require signed firmware, for now require
  both signatures.  Subsequent patches might change this.
- Still unclear if the pre-allocated firmware buffer can be accessed
  prior to the signature verification completes.

Mimi Zohar (9):
  ima: based on policy verify firmware signatures (pre-allocated buffer)
  ima: fix updating the ima_appraise flag
  security: define security_kernel_read_blob() wrapper
  kexec: add call to LSM hook in original kexec_load syscall
  ima: based on policy require signed kexec kernel images
  firmware: add call to LSM hook before firmware sysfs fallback
  ima: based on policy require signed firmware (sysfs fallback)
  ima: add build time policy
  ima: based on policy prevent loading firmware (pre-allocated buffer)

 drivers/base/firmware_loader/fallback.c |  7 +++
 include/linux/fs.h                      |  1 +
 include/linux/security.h                |  6 +++
 kernel/kexec.c                          | 11 +++++
 security/integrity/ima/Kconfig          | 58 +++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 29 +++++++++++++
 security/integrity/ima/ima_policy.c     | 76 +++++++++++++++++++++++++++------
 security/security.c                     |  6 +++
 9 files changed, 183 insertions(+), 12 deletions(-)

-- 
2.7.5
