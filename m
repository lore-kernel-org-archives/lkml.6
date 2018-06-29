Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16262C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74BC27E40
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXxQeNJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74BC27E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937374AbeF2U1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937359AbeF2U1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:27:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DA127E3A;
        Fri, 29 Jun 2018 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530304061;
        bh=sT8u84XdRpSyvye6UeDijSE/ET8D/b4CRd0ABB2jKEE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cXxQeNJCZR+6v5WwZcbh8yvDKa0/Urr0ag8tvQ6SchcZV2Ream/0fXvaFrOHuWN53
         TL1CBpJ2JrorsrfSvKv/DvKlv57B0xKSo0Bog3BR8iEg0DxhGiOOKNbLsk8YUe6cjT
         sNgREtKwhCpGa1Bbb5xm3Hfe+IjuZeNv56CCcWds=
Subject: [PATCH v1 1/2] PCI: Document patch submission hints
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jun 2018 15:27:39 -0500
Message-ID: <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add hints about how to write PCI patches and changelogs.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/00-INDEX               |    2 
 Documentation/PCI/submitting-patches.txt |  153 ++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 Documentation/PCI/submitting-patches.txt

diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
index 00c9a90b6f38..0f1d1de087f1 100644
--- a/Documentation/PCI/00-INDEX
+++ b/Documentation/PCI/00-INDEX
@@ -12,6 +12,8 @@ pci.txt
 	- info on the PCI subsystem for device driver authors
 pcieaer-howto.txt
 	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
+submitting-patches.txt
+	- hints about how to submit PCI patches
 endpoint/pci-endpoint.txt
 	- guide to add endpoint controller driver and endpoint function driver.
 endpoint/pci-endpoint-cfs.txt
diff --git a/Documentation/PCI/submitting-patches.txt b/Documentation/PCI/submitting-patches.txt
new file mode 100644
index 000000000000..d6a694182446
--- /dev/null
+++ b/Documentation/PCI/submitting-patches.txt
@@ -0,0 +1,153 @@
+Start with Documentation/process/submitting-patches.rst for general
+guidance.
+
+These are things I look at when reviewing patches.  Most of the technical
+things are obvious or covered elsewhere.  Some things here are cosmetic
+personal preferences, but consistency makes maintenance easier.  I silently
+fix up most of the trivial things, so don't get too hung up on the details.
+
+Write the patch:
+
+  - Make each patch small but complete by itself.  Don't worry about making
+    patches *too* small; it's trivial for me to squash patches together if
+    necessary.
+
+  - Make sure the kernel builds after every patch.  You can't introduce a
+    problem in one patch and fix it in a subsequent patch.  If one of the
+    autobuilders finds a build issue, I'll revert the patch unless you send
+    a fix.
+
+  - Please do send whitespace and coding style fixes, but don't mix them
+    with other substantive changes.  It's easier for people to backport
+    fixes if whitespace changes are at the end of a series.
+
+  - Wrap code and comments to fit in 80 columns.  Exception: I prefer
+    printk strings to be in one piece for searchability, so don't split
+    quoted strings to make them fit in 80 columns.
+
+  - Follow the existing style for code, names, and indentation.  When
+    you're finished, the file should look like it was all written by one
+    person.
+
+Write the changelog title (first line of the changelog):
+
+  - Follow the existing convention  Run "git log --oneline <file>" and make
+    your subject line match previous changes in format, capitalization, and
+    sentence structure.  For example, native host bridge driver patch
+    titles look like this:
+
+      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
+      PCI: mediatek: Add MSI support for MT2712 and MT7622
+      PCI: rockchip: Remove IRQ domain if probe fails
+
+  - Write a complete sentence, starting with a capitalized verb.
+
+  - Include specific details, e.g., write "Add XYZ controller support"
+    instead of "add support for new generation controller".
+
+  - Do not include a trailing period in the title.
+
+Write the changelog:
+
+  - Make the changelog readable without the title.  The changelog is not a
+    continuation of the title, so it should make sense by itself.  Always
+    include a changelog, even if it is the same as the title.
+
+  - Explain the change (not just "Fix a problem"), but do it as concisely
+    as possible.  Include function names, references to sections of the
+    spec, URLs for bug reports, etc.  This makes reviewing and future
+    maintenance easier.
+
+  - Capitalize initialisms ("PCI", "IRQ", "ID", "MSI", etc) in all English
+    text, including title, changelog, and comments.  These are usually
+    written in lower-case in the C code, but please follow normal English
+    conventions in text.
+
+  - Include "()" after function names and "[]" after array names as a
+    visual clue that these refer to something in the code.
+
+  - Include dmesg output and stack trace when relevant.  Prune details that
+    aren't relevant, e.g., you can usually remove timestamps and function
+    addresses.  The objective is to concisely illustrate the issue and make
+    it discoverable by search engines.
+
+  - Use spaces (not tabs) in the changelog because "git log" indents the
+    changelog and things aligned with tabs won't stay aligned.
+
+  - Wrap changelogs to fit in 80 columns when shown by "git show", which
+    adds 4 spaces.  I use "textwidth=75" in vim.
+
+  - Order tags as suggested by Ingo [1] (extended):
+
+      Fixes:
+      Link:
+      Reported-by:
+      Tested-by:
+      Signed-off-by: (author)
+      Signed-off-by: (chain)
+      Reviewed-by:
+      Acked-by:
+      Cc: stable@vger.kernel.org	# 3.4+
+      Cc: (other)
+
+  - Include a "Fixes:" reference when you're fixing a previous commit and
+    copy the author of the previous commit.  This helps people figure out
+    where a change needs to be backported.
+
+  - Include specific commit references when possible, e.g., 'e77f847df54c
+    ("PCI: rockchip: Add Rockchip PCIe controller support")'.  I use this
+    alias to generate them:
+
+      alias gsr='git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
+
+  - Include bugzilla URLs if available (kernel.org bugzilla preferred),
+    e.g.,
+
+      Link: https://bugzilla.redhat.com/show_bug.cgi?id=1409201
+
+  - Include problem report URLs.  Use kernel.org URLs, e.g.,
+    http://lkml.kernel.org/r/<Message-ID>, because they don't depend on
+    other mirror sites:
+
+      Link: http://lkml.kernel.org/r/4bcbcbc1-7c79-09f0-5071-bc2f53bf6574@kernel.dk
+
+  - Include specific references to the spec when possible, e.g., "PCIe
+    r3.1, sec 7.8.2".  If you're talking about something mentioned in the
+    spec, use the same name and capitalization as the spec.
+
+  - Include a "Cc: stable@vger.kernel.org" tag if you want one, and
+    indicate which kernels need it.
+
+Post the patch:
+
+  - Use scripts/get_maintainer.pl to find the maintainers of files you're
+    changing, and copy the maintainers and authors of recent or related
+    changes.
+
+  - Always copy linux-pci@vger.kernel.org and linux-kernel@vger.kernel.org.
+    I don't apply patches that haven't appeared on the linux-pci mailing
+    list, even if you send them to me directly.  This is partly to make
+    sure everyone has a chance to review it and partly because I use the
+    Patchwork tracker [2], which only tracks things on the linux-pci list.
+
+  - If you send more than one patch and they're related, always include a
+    "[0/n]" cover letter.  This makes it easy for me to reply to the cover
+    letter saying "I applied this series."  I use "stg -e -v v1 --to=...
+    patch1..patchN".
+
+  - If you post a new version, please make sure it includes "[v2]" or
+    similar in the subject line.  If it's a series, I want a new version
+    of the entire series.  I don't want updates of individual patches
+    within the series -- that's too hard for me to keep track of.  It's
+    perfectly fine if some patches in a v2 series are the same as in the
+    initial posting.
+
+  - If you want the patch in the current release, include a cover letter
+    and tell me that.  Otherwise, I assume all patches are intended for the
+    next merge window.
+
+  - If you're really gung-ho, you can go to Patchwork [2] and mark your
+    superseded patches as "Superseded" so I don't have to do that myself.
+
+[1] http://lkml.kernel.org/r/20120711080446.GA17713@gmail.com
+[2] https://patchwork.ozlabs.org/project/linux-pci/list/

