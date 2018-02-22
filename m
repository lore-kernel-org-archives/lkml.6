Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932757AbeBVOV6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:21:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932564AbeBVOVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:21:54 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8846.1519309243@warthog.procyon.org.uk>
References: <8846.1519309243@warthog.procyon.org.uk> <151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk> <151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, gnomes@lxorguk.ukuu.org.uk,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com
Subject: Re: [PATCH 08/30] kexec_file: Restrict at runtime if the kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8886.1519309313.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 22 Feb 2018 14:21:53 +0000
Message-ID: <8887.1519309313@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I'm intending on inserting the attached patch before this one.

And replacing this patch with the attached.

David
---
commit ed0424c531d7dd25adebdec0ee6a78a5784f207a
Author: David Howells <dhowells@redhat.com>
Date:   Thu Feb 22 14:01:49 2018 +0000

    kexec_file: Restrict at runtime if the kernel is locked down
    
    When KEXEC_VERIFY_SIG is not enabled, kernel should not load images through
    kexec_file systemcall if the kernel is locked down unless IMA can be used
    to validate the image.
    
    [Modified by David Howells to fit with modifications to the previous patch
     and to return -EPERM if the kernel is locked down for consistency with
     other lockdowns]
    
    Signed-off-by: Jiri Bohac <jbohac@suse.cz>
    Signed-off-by: David Howells <dhowells@redhat.com>
    Cc: Matthew Garrett <mjg59@srcf.ucam.org>
    cc: Chun-Yi Lee <jlee@suse.com>
    cc: kexec@lists.infradead.org

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d5931e392050..c47c4de604cd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -167,6 +167,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+		if (is_ima_appraise_enabled())
+			break;
+
+		if (kernel_is_locked_down(reason)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
