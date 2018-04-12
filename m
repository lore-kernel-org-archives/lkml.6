Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDLUoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:44:15 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33263 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeDLUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:44:14 -0400
X-Google-Smtp-Source: AIpwx4+EIIRoRIFWH5ErayLhHgadtC2yFXJAUKyuI9CrcpUuyDcCUNJSEnhvrJtIV34CtsRPvE0MZA==
Date: Thu, 12 Apr 2018 16:44:10 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/process: updates to the PGP guide
Message-ID: <20180412204410.GA6909@work>
Mail-Followup-To: corbet@lwn.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small tweaks to the Maintainer PGP guide:

 - Use --quick-addkey command that is compatible between GnuPG-2.2 and
   GnuPG-2.1 (which many people still have)
 - Add a note about the Nitrokey program
 - Warn that some devices can't change the passphrase before there are
   keys on the card (specifically, Nitrokeys)
 - Link to the GnuPG wiki page about gpg-agent forwarding over ssh
 - Tell git to use gpgv2 instead of legacy gpgv when verifying signed
   tags or commits

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 39 ++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index b453561a7148..aff9b1a4d77b 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -219,7 +219,7 @@ Our goal is to protect your master key by moving it to offline media, so
 if you only have a combined **[SC]** key, then you should create a separate
 signing subkey::
 
-    $ gpg --quick-add-key [fpr] ed25519 sign
+    $ gpg --quick-addkey [fpr] ed25519 sign
 
 Remember to tell the keyservers about this change, so others can pull down
 your new subkey::
@@ -450,11 +450,18 @@ functionality.  There are several options available:
 others. If you want to use ECC keys, your best bet among commercially
 available devices is the Nitrokey Start.
 
+.. note::
+
+    If you are listed in MAINTAINERS or have an account at kernel.org,
+    you `qualify for a free Nitrokey Start`_ courtesy of The Linux
+    Foundation.
+
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
 .. _`Nitrokey Pro`: https://shop.nitrokey.com/shop/product/nitrokey-pro-3
 .. _`Yubikey 4`: https://www.yubico.com/product/yubikey-4-series/
 .. _Gnuk: http://www.fsij.org/doc-gnuk/
 .. _`LWN has a good review`: https://lwn.net/Articles/736231/
+.. _`qualify for a free Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
 
 Configure your smartcard device
 -------------------------------
@@ -482,7 +489,7 @@ there are no convenient command-line switches::
 You should set the user PIN (1), Admin PIN (3), and the Reset Code (4).
 Please make sure to record and store these in a safe place -- especially
 the Admin PIN and the Reset Code (which allows you to completely wipe
-the smartcard).  You so rarely need to use the Admin PIN, that you will
+the smartcard). You so rarely need to use the Admin PIN, that you will
 inevitably forget what it is if you do not record it.
 
 Getting back to the main card menu, you can also set other values (such
@@ -494,6 +501,12 @@ additionally leak information about your smartcard should you lose it.
     Despite having the name "PIN", neither the user PIN nor the admin
     PIN on the card need to be numbers.
 
+.. warning::
+
+    Some devices may require that you move the subkeys onto the device
+    before you can change the passphrase. Please check the documentation
+    provided by the device manufacturer.
+
 Move the subkeys to your smartcard
 ----------------------------------
 
@@ -655,6 +668,20 @@ want to import these changes back into your regular working directory::
     $ gpg --export | gpg --homedir ~/.gnupg --import
     $ unset GNUPGHOME
 
+Using gpg-agent over ssh
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can forward your gpg-agent over ssh if you need to sign tags or
+commits on a remote system. Please refer to the instructions provided
+on the GnuPG wiki:
+
+- `Agent Forwarding over SSH`_
+
+It works more smoothly if you can modify the sshd server settings on the
+remote end.
+
+.. _`Agent Forwarding over SSH`: https://wiki.gnupg.org/AgentForwarding
+
 
 Using PGP with Git
 ==================
@@ -692,6 +719,7 @@ should be used (``[fpr]`` is the fingerprint of your key)::
 tell git to always use it instead of the legacy ``gpg`` from version 1::
 
     $ git config --global gpg.program gpg2
+    $ git config --global gpgv.program gpgv2
 
 How to work with signed tags
 ----------------------------
@@ -731,6 +759,13 @@ If you are verifying someone else's git tag, then you will need to
 import their PGP key. Please refer to the
 ":ref:`verify_identities`" section below.
 
+.. note::
+
+    If you get "``gpg: Can't check signature: unknown pubkey
+    algorithm``" error, you need to tell git to use gpgv2 for
+    verification, so it properly processes signatures made by ECC keys.
+    See instructions at the start of this section.
+
 Configure git to always sign annotated tags
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.13.6
