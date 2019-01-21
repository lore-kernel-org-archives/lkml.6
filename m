Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D92C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431420663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfAUKAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:00:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfAUKAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:00:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 444D9811DE;
        Mon, 21 Jan 2019 10:00:04 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 006D260123;
        Mon, 21 Jan 2019 09:59:55 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH v5 0/2] let kexec_file_load use platform keyring to verify the kernel image
Date:   Mon, 21 Jan 2019 17:59:27 +0800
Message-Id: <20190121095929.26915-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 21 Jan 2019 10:00:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a .platform_trusted_keys in system_keyring as the
reference to .platform keyring in integrity subsystem, when platform
keyring is being initialized it will be updated, so it will be
accessable for verifying PE signed kernel image.

This patch series let kexec_file_load use platform keyring as fall
back if it failed to verify the image against secondary keyring,
so the actually PE signature verify process will use keys provides
by firmware.

After this patch kexec_file_load will be able to verify a signed PE
bzImage using keys in platform keyring.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

To test this patch series on latest kernel, you need to ensure this commit
is applied as there is an regression bug in sanity_check_segment_list():

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b

Update from V4:
  - Drop ifdef in security/integrity/digsig.c to make code clearer
  - Fix a potential issue, set_platform_trusted_keys should not be
    called when keyring initialization failed

Update from V3:
  - Tweak and simplify commit message as suggested by Mimi Zohar

Update from V2:
  - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
    should be used for verifying image as suggested by Mimi Zohar

Update from V1:
  - Make platform_trusted_keys static, and update commit message as suggested
    by Mimi Zohar
  - Always check if platform keyring is initialized before use it

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 22 +++++++++++++++++++++-
 include/keys/system_keyring.h     |  9 +++++++++
 include/linux/verification.h      |  1 +
 security/integrity/digsig.c       |  3 +++
 5 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.20.1

