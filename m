Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A552C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD86820665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfAHIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:12:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfAHIM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:12:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15F9BC0BEAB8;
        Tue,  8 Jan 2019 08:12:58 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4E9A226FE;
        Tue,  8 Jan 2019 08:12:49 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com,
        dyoung@redhat.com, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 0/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Date:   Tue,  8 Jan 2019 16:12:46 +0800
Message-Id: <20190108081247.2266-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 08 Jan 2019 08:12:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, as the subject, this is a patch that links the new introduced
.platform keyring into .secondary_trusted_keys keyring. This is
mainly for the kexec_file_load, make kexec_file_load be able to verify
the kernel image agains keys provided by platform or firmware.
kexec_file_load already could verify the image agains secondary_trusted_keys
if secondary_trusted_keys exits, so this will make kexec_file_load be ware
of platform keys as well.

This may also useful for things like module sign verify that are using
secondary_trusted_keys. I'm not sure if it will be better to move the
INTEGRITY_PLATFORM_KEYRING to certs/ and let integrity subsystem use
the keyring there, so just linked the .platform keyring into kernel's
.secondary_trusted_keys keyring.

It workd for my case, tested in a VM, I signed the kernel image locally
with pesign and imported the cert to EFI's MokList variable.

Kairui Song (1):
  KEYS, integrity: Link .platform keyring to .secondary_trusted_keys

 certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
 include/keys/platform_keyring.h | 12 ++++++++++++
 security/integrity/digsig.c     |  7 +++++++
 3 files changed, 49 insertions(+)
 create mode 100644 include/keys/platform_keyring.h

-- 
2.20.1

