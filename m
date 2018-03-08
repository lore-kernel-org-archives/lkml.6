Return-Path: <kernel-hardening-return-12264-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvjh67vqJeijuBed56kfz9l71S11GlfCxCK3XDBcj29Yg+KBYohR8xNQtM9+rbdlFuwc52B
ARC-Seal: i=1; a=rsa-sha256; t=1520545143; cv=none;
        d=google.com; s=arc-20160816;
        b=qvMysCLTn7MaN8lptC7ml5CCzHnDC+m/+jIMtDh6UP0+GkBEob+k3L9F8Um5DgwVtr
         6JWgMx70k6yNHUxOgPvPBv0J+duVqM/iLEhCMlR0kFA/sUrGFbnM97DpF76wmMV3Tv8z
         h4zZEvSyHjI50Qkel3nexNUnKNC8hpNaMl9o3vBbj1qp1B6QtuhEAh4NIRjGGjwQlz+K
         /FoItxZwbzWKe6MdaLxaeC4czu42mbA7lLjWXl8haaG3Lv5I9u8SNXcrKC5hWNmTGPrr
         fK8pFh9CJmW/eBh8Zw3sKms/fECbgyzJtPukbbER/dnEXPxMb4Ngy+3cGYusbt0Jnmcc
         fszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=vH0aSa/HU5qPk+FC+9WacFTVfALMadgR2Bifb0Z+M3c=;
        b=ye0ESBmhRk530gNPcsDi5iQZ8N/DgGCw4uJWd9mtgU3nb5kn7+cZOwup87CGX31z/2
         aQJuYsu6MaxnHoWPl4op6YRDkeLOzZ86XRDiAckj0060Etx/TPiCE5DAIILM4Gh69q3n
         6vqVRiEMXcau0cIufmPp6wBS6ET+da98+6FBT9jAdu0pe2E9LUXygsSYaLEjgGTmM5qM
         cDojH0CDjdQoFgJxWBBMt2wb3N4cOtwZQLhe0jII78MWT12Nb6/5llKELz+Fcg9EPUQh
         vg/I9sNp4aXvNSuTG9le6whzyxsL7Mqe67W0nGEu/34Vdbqs1IUTgKzxcmotm5+dAttk
         HLHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12264-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12264-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12264-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12264-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Stephen Kitt <steve@sk2.org>
To: hare@suse.com
Cc: linux-scsi@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	Stephen Kitt <steve@sk2.org>
Subject: [PATCH] bfa: remove VLA
Date: Thu,  8 Mar 2018 22:38:41 +0100
Message-Id: <20180308213841.13807-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407144538028292?=
X-GMAIL-MSGID: =?utf-8?q?1594407144538028292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them with
fixed-length arrays instead.

bfad_bsg.c uses a variable-length array declaration to measure the
size of a putative array; this can be replaced by the product of the
size of an element and the number of elements, avoiding the VLA
altogether.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/scsi/bfa/bfad_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
index 3976e787ba64..7c884f881180 100644
--- a/drivers/scsi/bfa/bfad_bsg.c
+++ b/drivers/scsi/bfa/bfad_bsg.c
@@ -891,7 +891,7 @@ bfad_iocmd_fabric_get_lports(struct bfad_s *bfad, void *cmd,
 
 	if (bfad_chk_iocmd_sz(payload_len,
 		sizeof(struct bfa_bsg_fabric_get_lports_s),
-		sizeof(wwn_t[iocmd->nports])) != BFA_STATUS_OK) {
+		sizeof(wwn_t) * iocmd->nports) != BFA_STATUS_OK) {
 		iocmd->status = BFA_STATUS_VERSION_FAIL;
 		goto out;
 	}
-- 
2.11.0
