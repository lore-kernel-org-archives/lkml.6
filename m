Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtiRl4aqigdFugAtVBlJeITi/jZrIRWJCcJLZq0jupOe1L1Mvx0Hcp9tQAXgYzbGxvGUEwN
ARC-Seal: i=1; a=rsa-sha256; t=1519676176; cv=none;
        d=google.com; s=arc-20160816;
        b=Fj2hDeW+K+1LDuCLHKDAd7+i63pV45wGuuVqmvEaOEuZjdhYVwXEJyIp90kEobWeaF
         8nLtzerQplqow1qanRyh4KzM6zop/rDv8xO7+Yhl95ifqfQypQwwKPXJ2HCulV0uVMm0
         X9OVmFa2IuLDEIj1RBvMbHRaKQTABtNWWyJscENJcaLvm0ibOEG2NKs8YdoCbgRwdOJy
         bS2J6tLZzJ3hvL925KPeiMFyjebSQDXKYeQTGt1mnW3ve3iN5tQzENR7f+GwHYdJ4bgE
         d4Asu9XMyQYTdypgc5em1NOyIx+HqsLr+OBBEh9L5RgCfAxd5DeNqn7JV9mQgXc+WKp9
         YN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sj8QaG64QqBW83/0P8kE4FEZSz7G+Nj9YQ7ub1J4UyY=;
        b=z/Ll1BArw/W1AJjtvRjkeVoEFAzlwuvfbZTwXPnYlGuBFNr2V+5AXe3H0rR0XVE9hB
         e7+oDB+65mur9+FgqHTODvui6Ja2yzkkCpAkB3RXSf2cpHRFkHWknebDUFdEoxmJfIsK
         ue9DFKQmHhFEbsaT3vrboyea9J5z/s2QdZF1AZGRRCkgAGrZ3OhdFU/XNsC0cARNUMsW
         IfWP8+k9uNMLLvIUpVk2qlGPv5/TE2M0Zqse4V7Mz0wFHZ1P4+2piqcNkdUJhOLKDjFX
         OA7w2e8SJBibsCpsbgue4XQ/6LQjC6HdRDUqCRZf0fXRNrwWdyfMAZe3VEIzZN1N33ca
         31Yg==
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
Subject: [PATCH 3.18 04/13] scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
Date: Mon, 26 Feb 2018 21:15:32 +0100
Message-Id: <20180226201527.442649944@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495966223734995?=
X-GMAIL-MSGID: =?utf-8?q?1593495966223734995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -366,7 +366,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
 
 struct ibmvfc_fcp_rsp_info {
-	__be16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
