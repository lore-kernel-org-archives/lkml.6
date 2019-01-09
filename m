Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D9C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2920859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfAIQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:49:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfAIQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:49:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC6AD99C18;
        Wed,  9 Jan 2019 16:49:00 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF58D57AB;
        Wed,  9 Jan 2019 16:48:55 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 0/2] let kexec_file_load use platform keyring to verify the kernel image
Date:   Thu, 10 Jan 2019 00:48:22 +0800
Message-Id: <20190109164824.19708-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Jan 2019 16:49:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a different approach for the previous patch:
[RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
make kexec_file_load be able to verify the kernel image against keys
provided by platform or firmware.

This patch adds a .platform_trusted_keys in system_keyring as the reference
to .platform keyring in integrity subsystem, when platform keyring is
being initialized it will be updated.

Another thing on my mind is that now kexec_file_load will still relay on
CONFIG_INTEGRITY_PLATFORM_KEYRING and all its dependencies to be enabled
to be able to verify the image against firmware keys. I'm thinking about
to have something like CONFIG_PLATFORM_KEYRING and make the .platform
keyring could be enabled for a more wider usage. Not sure if it's a good
idea though.

Tested in a VM with locally signed kernel with pesign and imported the
cert to EFI's MokList variable.

Kairui Song (2):
  integrity, KEYS: add a reference to platform keyring
  kexec, KEYS: Make use of platform keyring for signature verify

 arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
 certs/system_keyring.c            | 10 +++++++++-
 include/keys/system_keyring.h     |  5 +++++
 include/linux/verification.h      |  1 +
 security/integrity/digsig.c       |  4 ++++
 5 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.20.1

