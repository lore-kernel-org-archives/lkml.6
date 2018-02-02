Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224tOpb9xH5MKDo1MsLC98UTmbisiu0cEthj7U9JxN2LV4KVkOoWZTG45P7VVTpRBGr3OSQS
ARC-Seal: i=1; a=rsa-sha256; t=1517591814; cv=none;
        d=google.com; s=arc-20160816;
        b=KIfabBFSbXnTRKodAdLQ0ajL2esnIQxfUTPEnd9tc0OvG7ZrjTvZiBWPRlQJqRd4G9
         gDUZ00omVyxBa2vd5zhkHe8xbwOV3FHtAmxzTmufMdKsbj9AKV3Nvd9tqfmc118/19ih
         T7jfYUy+x/Vx/YkRf7Lmb5Aa8kaxf1rAj1bS/MgTpPAot0QstCUXtdRRKGrveqI4dFEe
         ApOm/G6TIVd3Q/x/yI3GgU2jE1LlVful97NfyrvGTtIhnrvi5Lh5/MFtLdX4VVBwRZFO
         MdpN2xPs+AdXltszoao0abKsXRh3vSISZMIlEhPSDlIpFFIuBIBdummIXx8CEYdUauWL
         5HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WbiCjvlX015nc64MnQVHCHRCzGb/HlYn+bOEkqjAYrE=;
        b=Q3j/6wwJoqtbK+9LovhhnS0anABKFmiCmWoS+41YPUyUWVbqCuKBjCl38vrrR20w9c
         T5hxDeTvMTybDsjteN9bdeZOu0vQFAZ3npG1CILGYwVv0OeY6K2KkU9wEB4TK230/Tc+
         +SNq8bGfq/lLPWnwkEjAuSAsXJIFjGTCa/Ag48Z6oPXd5cN/Y/yyuQm+OUpsHJbYHRHW
         45LuVedVpZnikM4lFqiY6IZHwgcua0+SnnObajfjRh6pJZn+dTHVFUrHR8ZTd9GDN/+1
         NcwDDmQAc8ifNgPqVZ2H4vkCLKBf3x1l1+KI7cS/ookdqmlAUG2ECd1iThBFFT7WDcIP
         5XkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Douglas Miller <dougmill@linux.vnet.ibm.com>,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 25/55] scsi: aacraid: Fix hang in kdump
Date: Fri,  2 Feb 2018 17:58:43 +0100
Message-Id: <20180202140828.807489255@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309808970580972?=
X-GMAIL-MSGID: =?utf-8?q?1591310354541294014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit c5313ae8e4e037bfaf5e56cb8d6efdb8e92ce437 upstream.

Driver attempts to perform a device scan and device add after coming out
of reset. At times when the kdump kernel loads and it tries to perform
eh recovery, the device scan hangs since its commands are blocked because
of the eh recovery. This should have shown up in normal eh recovery path
(Should have been obvious)

Remove the code that performs scanning.I can live without the rescanning
support in the stable kernels but a hanging kdump/eh recovery needs to be
fixed.

Fixes: a2d0321dd532901e (scsi: aacraid: Reload offlined drives after controller reset)
Reported-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Fixes: a2d0321dd532901e (scsi: aacraid: Reload offlined drives after controller reset)
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/aachba.c  |    1 -
 drivers/scsi/aacraid/commsup.c |    9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -918,7 +918,6 @@ static void setinqstr(struct aac_dev *de
 		char *cname = kmemdup(sup_adap_info->adapter_type_text,
 				sizeof(sup_adap_info->adapter_type_text),
 								GFP_ATOMIC);
-
 		if (!cname)
 			return;
 
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1643,14 +1643,7 @@ static int _aac_reset_adapter(struct aac
 out:
 	aac->in_reset = 0;
 	scsi_unblock_requests(host);
-	/*
-	 * Issue bus rescan to catch any configuration that might have
-	 * occurred
-	 */
-	if (!retval) {
-		dev_info(&aac->pdev->dev, "Issuing bus rescan\n");
-		scsi_scan_host(host);
-	}
+
 	if (jafo) {
 		spin_lock_irq(host->host_lock);
 	}
