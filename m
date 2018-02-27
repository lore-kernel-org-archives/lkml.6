Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0WRY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:17:24 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36034 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeB0WRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:17:21 -0500
X-Google-Smtp-Source: AG47ELtlfcan+QvVSPko9EYEftpYa6zCXLHT0IwHZWBBO7MFRicdV7qmBBw6E1WTf6QTslYEpA1uyg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 1/2] security: evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c
Date: Tue, 27 Feb 2018 19:16:59 -0300
Message-Id: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested.
This variable was not used where it was defined, there was no point in
declaring it there as extern, thus it got moved and constified saving up 2
bytes.

Function                                     old     new   delta
init_desc                                    273     271      -2
Total: Before=2112094, After=2112092, chg -0.00%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 security/integrity/evm/evm.h        | 2 --
 security/integrity/evm/evm_crypto.c | 3 +++
 security/integrity/evm/evm_main.c   | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 0482539..45c4a89 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -31,8 +31,6 @@
 		       EVM_ALLOW_METADATA_WRITES)
 
 extern int evm_initialized;
-extern char *evm_hmac;
-extern char *evm_hash;
 
 #define EVM_ATTR_FSUUID		0x0001
 
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 691f3e0..fdde9cb 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -37,6 +37,9 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
+char * const evm_hmac = "hmac(sha1)";
+char * const evm_hash = "sha1";
+
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
  * @key: pointer to a buffer with the key data
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a8d5028..826926d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -33,8 +33,6 @@ int evm_initialized;
 static char *integrity_status_msg[] = {
 	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
-char *evm_hmac = "hmac(sha1)";
-char *evm_hash = "sha1";
 int evm_hmac_attrs;
 
 char *evm_config_xattrnames[] = {
-- 
2.7.4
