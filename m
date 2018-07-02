Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0167F246D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167F246D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934095AbeGBJfA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:35:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:50869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbeGBJey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:34:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 02:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="242289978"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2018 02:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1E62AF7; Mon,  2 Jul 2018 12:34:51 +0300 (EEST)
Date:   Mon, 2 Jul 2018 12:34:50 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Benjamin Gilbert <bgilbert@redhat.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180702093450.h5tfjeynpi3nwjbo@black.fi.intel.com>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180701213243.GA20180@trogon.sfo.coreos.systems>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 09:32:43PM +0000, Benjamin Gilbert wrote:
> On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig, 
> > up to and including 4.17.3, fail to boot on AMD64 running in (at least) 
> > QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.  
> > Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level 
> > paging boot if kernel is above 4G") fixes it.  I've attached our kernel 
> > config for reference, and am happy to test patches, provide sample QCOW 
> > images, etc.
> 
> Adding linux-x86_64, LKML.

Thank you for the report.

I'm not able to trigger it in my environment. Tried v4.17.3 and current
Linus' tree.

I had to change config slightly to get kernel build in my setup. Diff is
below.

I run KVM this way:

qemu-system-x86_64 -kernel ./arch/x86/boot/bzImage -nographic -append "console=ttyS0"

Could you check if you can trigger the issue with my changes to config and
the way I run KVM?

If not, what the key difference in our setups that make the issue visible?

How do you run KVM? Do you have EFI enable? Config difference?
Running kernel directly, without GRUB makes a difference?

--- config	2018-07-02 11:59:23.662685761 +0300
+++ .config	2018-07-02 12:09:51.822677398 +0300
@@ -1,6 +1,6 @@
 #
 # Automatically generated file; DO NOT EDIT.
-# Linux/x86 4.17.3-coreos Kernel Configuration
+# Linux/x86 4.17.3 Kernel Configuration
 #
 CONFIG_64BIT=y
 CONFIG_X86_64=y
@@ -187,16 +187,13 @@
 # CONFIG_SYSFS_DEPRECATED is not set
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="bootengine.cpio"
-CONFIG_INITRAMFS_ROOT_UID=0
-CONFIG_INITRAMFS_ROOT_GID=0
+CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_RD_XZ=y
 CONFIG_RD_LZO=y
 CONFIG_RD_LZ4=y
-CONFIG_INITRAMFS_COMPRESSION=".gz"
 CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -1564,8 +1561,7 @@
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
-CONFIG_EXTRA_FIRMWARE="intel-ucode/0f-04-04 intel-ucode/06-55-03 intel-ucode/06-1d-01 intel-ucode/06-9e-09 intel-ucode/06-05-03 intel-ucode/0f-02-09 intel-ucode/06-56-02 intel-ucode/0f-04-01 intel-ucode/06-03-02 intel-ucode/06-3e-06 intel-ucode/06-0e-0c intel-ucode/0f-04-0a intel-ucode/06-25-05 intel-ucode/06-56-03 intel-ucode/06-0f-0a intel-ucode/06-0f-0d intel-ucode/0f-03-04 intel-ucode/06-2d-07 intel-ucode/06-3d-04 intel-ucode/06-0f-02 intel-ucode/06-05-00 intel-ucode/0f-04-03 intel-ucode/06-47-01 intel-ucode/.keep_sys-firmware_intel-microcode-0 intel-ucode/06-07-02 intel-ucode/06-0a-00 intel-ucode/06-9e-0a intel-ucode/06-56-05 intel-ucode/06-1c-0a intel-ucode/06-05-02 intel-ucode/06-2d-06 intel-ucode/06-08-01 intel-ucode/06-06-0d intel-ucode/06-46-01 intel-ucode/06-0f-06 intel-ucode/06-0b-01 intel-ucode/06-45-01 intel-ucode/0f-04-09 intel-ucode/0f-06-02 intel-ucode/0f-04-07 intel-ucode/06-16-01 intel-ucode/06-5e-03 intel-ucode/06-06-05 intel-ucode/06-08-06 intel-ucode/0f-00-07 i
 ntel-ucode/06-07-01 intel-ucode/06-3e-07 intel-ucode/06-1c-02 intel-ucode/06-08-0a intel-ucode/0f-03-02 intel-ucode/06-07-03 intel-ucode/0f-02-07 intel-ucode/06-56-04 intel-ucode/06-2a-07 intel-ucode/06-17-06 intel-ucode/06-3e-04 intel-ucode/0f-02-05 intel-ucode/06-06-0a intel-ucode/06-3f-04 intel-ucode/06-25-02 intel-ucode/0f-01-02 intel-ucode/06-0b-04 intel-ucode/0f-04-08 intel-ucode/06-09-05 intel-ucode/06-2f-02 intel-ucode/06-4f-01 intel-ucode/06-3f-02 intel-ucode/06-3c-03 intel-ucode/06-7a-01 intel-ucode/0f-02-06 intel-ucode/06-1a-05 intel-ucode/06-26-01 intel-ucode/06-0f-07 intel-ucode/06-0d-06 intel-ucode/0f-03-03 intel-ucode/06-9e-0b intel-ucode/06-05-01 intel-ucode/06-0a-01 intel-ucode/06-4e-03 intel-ucode/06-8e-09 intel-ucode/06-1a-04 intel-ucode/06-5c-09 intel-ucode/0f-00-0a intel-ucode/0f-06-05 intel-ucode/0f-06-08 intel-ucode/06-08-03 intel-ucode/06-55-04 intel-ucode/06-0f-0b intel-ucode/06-1e-05 intel-ucode/06-0e-08 intel-ucode/06-3a-09 intel-ucode/06-17-07 intel-ucode
 /06-06-00 intel-ucode/06-8e-0a intel-ucode/0f-02-04 intel-ucode/06-17-0a intel-ucode/0f-06-04 amd-ucode/microcode_amd.bin amd-ucode/microcode_amd_fam17h.bin amd-ucode/microcode_amd_fam16h.bin amd-ucode/microcode_amd_fam15h.bin "
-CONFIG_EXTRA_FIRMWARE_DIR="/build/amd64-usr/lib/firmware"
+CONFIG_EXTRA_FIRMWARE=""
 CONFIG_FW_LOADER_USER_HELPER=y
 # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
 CONFIG_ALLOW_DEV_COREDUMP=y
@@ -4742,7 +4738,7 @@
 #
 # Certificates for signature checking
 #
-CONFIG_MODULE_SIG_KEY="certs/modules.pem"
+CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
 CONFIG_SYSTEM_TRUSTED_KEYRING=y
 CONFIG_SYSTEM_TRUSTED_KEYS=""
 # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
-- 
 Kirill A. Shutemov
