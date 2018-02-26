Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbg00xLYHrpwXkphmCMQatwNFGXKRaMcMgcPGajqYfsOEWCgks94XaCndZoRiWGKmwRVXB
ARC-Seal: i=1; a=rsa-sha256; t=1519676538; cv=none;
        d=google.com; s=arc-20160816;
        b=ZVnwljBLA9Ycem8mTeoH6ulYv536shPu3EN6xrY6XarjAR086BVwLbQRu5WN8nI8ha
         pR86QTuzvlso1sMD1m+zensfv8BQ0ILdDPaHftAz6sd34T8eE+p/hWxFbLOSIP7mnPRC
         iZli9HO0aNQoA6Hm9qA2d2EjC50RxP+MMamICFWZr3jVvwbWRbJH2DL8TrE07MyDPbkf
         j2alFolTFw/S1JuEoyyWW07NjxMzI08IPSKUQ/dkzwfx2pFDwEbEPmW9ECVsBJeTldqN
         2PTiICSADcO6uVzAZQg0X8784b7a6gNt9ucnLt3q5m3qpMexmlyyuTQuf4I9wkwq/FAs
         GYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7w3GiR9bjBOOlwKouIn4mjdHC/ThtL1eVsMvlrfdGoc=;
        b=fH3gq75VcQ3mHW+I4RVZvyPCvMHkmvSMsvniJzNTL79eDXkgCD1Fh+risRF/7odjvF
         fpSRpXtewv9intk1fR4b28309RHZLX2rxRr+6dE+pX/rineN428l9VIAiymxsud9Uhug
         Zge0UCEUucqhhtWIH2WDTg+ZozWui3ZKL/T/bQV6SiJE/pCT9oZ36+MNYVDFKC1BmVyA
         f9vd4rmg4yxB/MZO63kfWdTwBF89WBVQtlphLCQD6Mn4xgvnyalc8C7bQvpn1iR3Kswr
         3WoNTP+isxvUbWfskyLqQvgbC9dNiMUI/wn6MI0EWluUYdL90gWk8vqWtHoy8mbbe5ud
         wKng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 03/39] scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
Date: Mon, 26 Feb 2018 21:20:24 +0100
Message-Id: <20180226201643.804600786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495966223734995?=
X-GMAIL-MSGID: =?utf-8?q?1593496345773536277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit c39813652700f3df552b6557530f1e5f782dbe2f upstream.

The fcp_rsp_info structure as defined in the FC spec has an initial 3
bytes reserved field. The ibmvfc driver mistakenly defined this field as
4 bytes resulting in the rsp_code field being defined in what should be
the start of the second reserved field and thus always being reported as
zero by the driver.

Ideally, we should wire ibmvfc up with libfc for the sake of code
deduplication, and ease of maintaining standardized structures in a
single place. However, for now simply fixup the definition in ibmvfc for
backporting to distros on older kernels. Wiring up with libfc will be
done in a followup patch.

Cc: <stable@vger.kernel.org>
Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ibmvscsi/ibmvfc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -367,7 +367,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
 
 struct ibmvfc_fcp_rsp_info {
-	__be16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
