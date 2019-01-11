Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F7220874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CfmANB18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfAKNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:41:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44129 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbfAKNlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:41:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so13106753edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lgx8qN5/ClfwRURmnecKs3R0HNWtmSbJ2awJbDvzByM=;
        b=CfmANB18ib7O1BP5W4WI+0NQaOuT0b+3kfvhmkcivkgO26Hu9Ce9PKE+f+CRxvuSti
         nTRBnrFTLblfXLZ/yxT9CYrMRz9GElmNwKFJyrXvkd5EEY0in24O0I5NS85SheIryGcK
         e+jqmvEJtuccRphZO9PQweRc+y3YaBb47IEIqVSpJ3tqeY7azLUxqIR3mWldwwHelRDH
         StbOebz68PVc5/2uGaMbZqLmsfSXlVYoa9cXZitya5BsFHls6u5b/vsp2SldQei9xwa1
         WMoijG966+FhRcdhXbjE7wFVlxUfQJzgKK0ikj9D66bM6b4aq2pdqJKJnUkDi3TGYUvZ
         ud9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lgx8qN5/ClfwRURmnecKs3R0HNWtmSbJ2awJbDvzByM=;
        b=FRJ5dxrS5iQA6IlLVYcpb6cccT3sEEmNUGdWqkbd9LM0RspKMJLMvDO2Uuobi8lnKt
         SODF/2UTpbPs+QgeIOjYR0QlLA3oC7sTDWR5aP4545jGk9Az9hGjzfPGTlgzLqVjpbVl
         38ZCgxmD270f8HMuX1BIoT6OztGBL8kQnPRa10aV6RTh+BJX3He5KI0C7/Pi/IhfQazL
         RYaSVPxKyStSXam0nRYsJs/s6bguH+4XvilnNW4nst2FhdlnHm4BSG9FF7yiVJsZ3DUp
         VUr37cSW7lUxTH52JoRWGxhq3Zy2VQTFmoF7C1POGMRyAu9pPycKrcf/87N2B9joaoaj
         XhXA==
X-Gm-Message-State: AJcUukfaUak0AGoTWP5KWKsl/zvFc9SsWCn1LXQnr9LAcTlpayZ0hO/v
        28qpLBnLYfK889aQHElABOm1DySZkeKp7Q==
X-Google-Smtp-Source: ALg8bN5QbksTRLB7THrRv5GUUekOSWOGsSehtyhFdJCi2I/v8oYTbtYDafV9It1YKGdl1x9l3A3FRA==
X-Received: by 2002:a50:aa68:: with SMTP id p37mr12994063edc.168.1547214065195;
        Fri, 11 Jan 2019 05:41:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:2520:8b:922b:4c43])
        by smtp.gmail.com with ESMTPSA id a38sm2312070edd.44.2019.01.11.05.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 05:41:04 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Date:   Fri, 11 Jan 2019 14:40:59 +0100
Message-Id: <20190111134100.24095-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the Android binderfs filesystem used to dynamically add and
remove binder devices that are private to each instance.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* Changelog */
v1:
- switch from *.txt to *.rst format
---
 Documentation/filesystems/binderfs.rst | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/filesystems/binderfs.rst

diff --git a/Documentation/filesystems/binderfs.rst b/Documentation/filesystems/binderfs.rst
new file mode 100644
index 000000000000..74a744b42db7
--- /dev/null
+++ b/Documentation/filesystems/binderfs.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+The Android binderfs Filesystem
+===============================
+
+Android binderfs is a filesystem for the Android binder IPC mechanism.  It
+allows to dynamically add and remove binder devices at runtime.  Binder devices
+located in a new binderfs instance are independent of binder devices located in
+other binderfs instances.  Mounting a new binderfs instance makes it possible
+to get a set of private binder devices.
+
+Mounting binderfs
+-----------------
+
+Android binderfs can be mounted with:
+
+::
+
+  mkdir /dev/binderfs
+  mount -t binder binder /dev/binderfs
+
+at which point a new instance of binderfs will show up at ``/dev/binderfs``.
+In a fresh instance of binderfs no binder devices will be present.  There will
+only be a ``binder-control`` device which serves as the request handler for
+binderfs. Mounting another binderfs instance at a different location will
+create a new and separate instance from all other binderfs mounts.  This is
+identical to the behavior of e.g. ``devpts`` and ``tmpfs``. The Android
+binderfs filesystem can be mounted in user namespaces.
+
+Options
+-------
+max
+  binderfs instances can be mounted with a limit on the number of binder
+  devices that can be allocated. The ``max=<count>`` mount option serves as
+  a per-instance limit. If ``max=<count>`` is set then only ``<count>`` number
+  of binder devices can be allocated in this binderfs instance.
+
+Allocating binder Devices
+-------------------------
+
+.. _ioctl: http://man7.org/linux/man-pages/man2/ioctl.2.html
+
+To allocate a new binder device in a binderfs instance a request needs to be
+sent through the ``binder-control`` device node.  A request is sent in the form
+of an `ioctl() <ioctl_>`_.
+
+What a program needs to do is to open the ``binder-control`` device node and
+send a ``BINDER_CTL_ADD`` request to the kernel.  Users of binderfs need to
+tell the kernel which name the new binder device should get.  By default a name
+can only contain up to ``BINDERFS_MAX_NAME`` chars including the terminating
+zero byte.
+
+Once the request is made via an `ioctl() <ioctl_>`_ passing a ``struct
+binder_device`` with the name to the kernel it will allocate a new binder
+device and return the major and minor number of the new device in the struct
+(This is necessary because binderfs allocates a major device number
+dynamically.).  After the `ioctl() <ioctl_>`_ returns there will be a new
+binder device located under /dev/binderfs with the chosen name.
+
+Deleting binder Devices
+-----------------------
+
+.. _unlink: http://man7.org/linux/man-pages/man2/unlink.2.html
+.. _rm: http://man7.org/linux/man-pages/man1/rm.1.html
+
+Binderfs binder devices can be deleted via `unlink() <unlink_>`_.  This means
+that the `rm() <rm_>`_ tool can be used to delete them. Note that the
+``binder-control`` device cannot be deleted since this would make the binderfs
+instance unuseable.  The ``binder-control`` device will be deleted when the
+binderfs instance is unmounted and all references to it have been dropped.
-- 
2.19.1

