Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B1EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FDA20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfAOJqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:46:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfAOJqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:46:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87582804EC;
        Tue, 15 Jan 2019 09:46:42 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B644D19940;
        Tue, 15 Jan 2019 09:46:35 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH v2 0/2] let kexec_file_load use platform keyring to verify the kernel image
Date:   Tue, 15 Jan 2019 17:45:40 +0800
Message-Id: <20190115094542.17129-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 09:46:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds a .platform_trusted_keys in system_keyring as the
reference to .platform keyring in integrity subsystem, when platform
keyring is being initialized it will be updated. So other component could
use this keyring as well.

This patch series also let kexec_file_load use platform keyring as fall
back if it failed to verify the image against secondary keyring, make it
possible to load kernel signed by third part key if third party key is
imported in the firmware.

After this patch kexec_file_load will be able to verify a signed PE
bzImage using keys in platform keyring.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

Update from V1:
  - Make platform_trusted_keys static, and update commit message as suggested
    by Mimi Zohar
  - Always check if platform keyring is initialized before use it

 arch/x86/kernel/kexec-bzimage64.c | 15 ++++++++++++---
 certs/system_keyring.c            | 20 +++++++++++++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  3 +++
 security/integrity/digsig.c       |  6 ++++++
 5 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.20.1

