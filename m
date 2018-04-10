Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YvrOYKMsNfAUxDYrO4xEM/G3V2sxz1ph5R+tKnx6e0jaCHt4dPE0smyAB0y/9ofZBGEh1
ARC-Seal: i=1; a=rsa-sha256; t=1523399855; cv=none;
        d=google.com; s=arc-20160816;
        b=BxSGwl24M9n6T5BzuibfVIPcs3xUaop3iYMzEscXLl+4kpEgrKrDfsEriDSu+n/Ol4
         5ntF39s7oonXbaepy5NGztW+KsVT/bOleILHX/V86S0qwfK+drol9Go0ydmr2eYXpdwW
         hHBdJ25P6m2GPlcqKIEjdgUPXNQ+GFGbf9blRwsFiPAbstdYggB9YT2ixnrbxqG6WPrg
         1lo9sbPsEnu610EurfIW2dyH7UPI9Z9IVP6AbWj9OA6gmYwdjWKnkG/4boCPI1Rsd51k
         O+KHh931kC7iEtkrdH9WOCWb7hHketzZmFr854Xk5/HiGIkLYqqhqnbZTtRkfEhhxe/A
         6NTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LOGYXuho7AQL2znerBoaleL618i6IT6qoge2DAKNopI=;
        b=bTBi+5iIean3/s5aQ2ZtIHDa7zjJeUvgKH4WkN6oYRkIXKtvHZ4j5VftsbPbzcDXS9
         ciQkp+FKosu5bicMk+TinLIr5FyPK/QfqgP2x/1JgODFx9jEIGmshrOnkLWvwRFxPxd2
         2dGZiPtpMVSQSR6wy6Wqud2poWDoTnxsApL23qtKbLCBwDhH+fyej+WhYDN256JvyXcy
         0mGWp3VWh1tXec3PXjAk6AcAZxN6PtkeudNdyQMXcwjkx0hVx98hxujUqOdufbyVzGJ7
         fODqxyTMEAKp3YRm5PUEhxeNqTxQfksxZHy9g2MNJmLIZLchqEwT99D0Pf627ysb27Wy
         vWAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/138] scsi: megaraid_sas: unload flag should be set after scsi_remove_host is called
Date: Wed, 11 Apr 2018 00:24:21 +0200
Message-Id: <20180410212910.373395262@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400105610831867?=
X-GMAIL-MSGID: =?utf-8?q?1597400527355455763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>


[ Upstream commit f3f7920b3910171b2999c7dc2335eb9f583e44f2 ]

Issue - Driver returns DID_NO_CONNECT when unload is in progress,
indicated using instance->unload flag. In case of dynamic unload of
driver, this flag is set before calling scsi_remove_host(). While doing
manual driver unload, user will see lots of prints for Sync Cache
command with DID_NO_CONNECT status.

Fix - Set the instance->unload flag after scsi_remove_host(). Allow
device removal process to be completed and do not block any command
before that.  SCSI commands (like SYNC_CACHE) are received (as part of
scsi_remove_host) by driver during unload will be submitted further down
to the drives.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6605,7 +6605,6 @@ static void megasas_detach_one(struct pc
 	u32 pd_seq_map_sz;
 
 	instance = pci_get_drvdata(pdev);
-	instance->unload = 1;
 	host = instance->host;
 	fusion = instance->ctrl_context;
 
@@ -6616,6 +6615,7 @@ static void megasas_detach_one(struct pc
 	if (instance->fw_crash_state != UNAVAILABLE)
 		megasas_free_host_crash_buffer(instance);
 	scsi_remove_host(instance->host);
+	instance->unload = 1;
 
 	if (megasas_wait_for_adapter_operational(instance))
 		goto skip_firing_dcmds;
