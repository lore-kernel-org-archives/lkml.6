Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15E6C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A320869
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7A320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeKNHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:17:20 -0500
Received: from namei.org ([65.99.196.166]:53100 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNHRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:17:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wADLHJCR015343;
        Tue, 13 Nov 2018 21:17:20 GMT
Date:   Wed, 14 Nov 2018 08:17:19 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [GIT PULL] integrity: fixup for new struct public_key_signature
 encoding field
Message-ID: <alpine.LRH.2.21.1811140813530.15226@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for a bug introduced with '82f94f24475c ("KEYS: 
Provide software public key query function [ver #2]")'.


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v4.20-rc3

for you to fetch changes up to fd35f192e42cf7c0df1e2480bfd5965e35b2f4ca:

  integrity: support new struct public_key_signature encoding field (2018-11-13 13:09:56 -0800)

----------------------------------------------------------------
Mimi Zohar (1):
      integrity: support new struct public_key_signature encoding field

 security/integrity/digsig_asymmetric.c | 1 +
 1 file changed, 1 insertion(+)

---
commit fd35f192e42cf7c0df1e2480bfd5965e35b2f4ca
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Fri Nov 9 00:53:40 2018 -0500

    integrity: support new struct public_key_signature encoding field
    
    On systems with IMA-appraisal enabled with a policy requiring file
    signatures, the "good" signature values are stored on the filesystem as
    extended attributes (security.ima).  Signature verification failure
    would normally be limited to just a particular file (eg. executable),
    but during boot signature verification failure could result in a system
    hang.
    
    Defining and requiring a new public_key_signature field requires all
    callers of asymmetric signature verification to be updated to reflect
    the change.  This patch updates the integrity asymmetric_verify()
    caller.
    
    Fixes: 82f94f24475c ("KEYS: Provide software public key query function [ver #2]")
    Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
    Cc: David Howells <dhowells@redhat.com>
    Acked-by: Denis Kenzior <denkenz@gmail.com>
    Signed-off-by: James Morris <james.morris@microsoft.com>

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6dc075144508..d775e03fbbcc 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -106,6 +106,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 
 	pks.pkey_algo = "rsa";
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
+	pks.encoding = "pkcs1";
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
