Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZolr4dKhkcETV7ynzD6Ukav9+14CIS0NmIijb2hyPOUk5EchGjHt5BBVQxtEMTyPKmPEMpi
ARC-Seal: i=1; a=rsa-sha256; t=1525116359; cv=none;
        d=google.com; s=arc-20160816;
        b=aOZzR3SbPlNqQ31xPgMtwytPPBfMvyHS/QAs6TH8vKDFOFrtFGe0xce42ktUg29CmM
         b3XMRhP21VhcJNR7kIZDCPw90GzSfmsYVs9E4lpYDkEse/8vd4/Jns7IajwaviwTOyVl
         EKZgWZwTFWR/IoZKQSG1PX8rMkTOJ03v66G+TVbEx5YeV3srPBO6MHU/lyNvJPmHAvjJ
         ZzBD1aIjLGxJRnpNf49xNzstWtO7Wv7nJ5SAHYySaF/IwBFLnvr9d1h4AzbYVWZmwior
         x0bbp6aa6jBjtnw75dB/yS3lBbKVRsGSnu9iitAvf1Xc1P1qsFsu1DhgukmNVbKgBTCT
         MIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=mCTxIxcdPDpuUA8nso5b0plFd7rQq89H2BdwGXy5AU8=;
        b=hCqaL0ekXxOz04T49SwSixA2pqZJlj6zNfxU2mMVR11qYbhNwddo+jbo4th/aQtq/z
         KWYaVhe6NoSLnANV/P7QS8sM8EHkapuC9bktzMID4BN9t34iNjqBqZ/9uCtYlbHGaUhA
         fRXoKxjgo5mKEqSloP+f4vEse+AAWQ55lTEh10Vbu474UIJIsmbt/2zQN0iTUjUuPxNo
         xJbvWtInMILfEQaxZ4HF3ihnpET2g4IAtAglTjPKydG/9vWaufoMMijQk5m9JwaW1uI4
         5QMsPKSjLRfpFP0nTAg773bIF5oqS4bRGTSjgc33VUPaZXkBuO2dP2yy69PNVlGUPSCo
         1eKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFC122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.4 32/44] mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.
Date: Mon, 30 Apr 2018 12:24:43 -0700
Message-Id: <20180430190947.617318706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285170089780?=
X-GMAIL-MSGID: =?utf-8?q?1599200412491871670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit 7b70eb14392a7cf505f9b358d06c33b5af73d1e7 upstream.

Currently it is possible to read and/or write to suspend EB's.
Writing /dev/mtdX or /dev/mtdblockX from several processes may
break the flash state machine.

Taken from cfi_cmdset_0001 driver.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -814,9 +814,10 @@ static int get_chip(struct map_info *map
 		    (mode == FL_WRITING && (cfip->EraseSuspend & 0x2))))
 			goto sleep;
 
-		/* We could check to see if we're trying to access the sector
-		 * that is currently being erased. However, no user will try
-		 * anything like that so we just wait for the timeout. */
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) ==
+		    chip->in_progress_block_addr)
+			goto sleep;
 
 		/* Erase suspend */
 		/* It's harmless to issue the Erase-Suspend and Erase-Resume
@@ -2265,6 +2266,7 @@ static int __xipram do_erase_chip(struct
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(map->size - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, map->size,
@@ -2354,6 +2356,7 @@ static int __xipram do_erase_oneblock(st
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
 	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, len,
