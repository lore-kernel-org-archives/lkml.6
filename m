Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Aw/hUkwRM0XdpOC/vUxQT+fWfJrs/jQlgO/zepGX/mrUr/IJ5LLwdSfvEMWeuQnL2s+0V
ARC-Seal: i=1; a=rsa-sha256; t=1523473330; cv=none;
        d=google.com; s=arc-20160816;
        b=NohWZpyF2zUsmJd5FkmTBPb0RXyMQywkcY61aHWlGgPIk+AqEbBhbDvSbNU0SK14Kj
         tMXvWeSrCvO8sNqosMJm6wdlOqNZrA8qa4QrPXwALG5RvmMOBxFRjSthwAT4IWr3sFDY
         83EQomqx71Ai84D/JIjXXO/KZT2ZtKY+DV3fvdIbgl0mdsGdl8xMuOeOVygigw3QB/qB
         yywq5HoopaIqBTUB2fTKgLyoBeKcnTXDAZOuP6EQl0uxuhYjPTcL1fnVVirfiZafYlhL
         MbjP8lVvrao8gJi1VL95svCbKO0iCbISBctFbK1JZ/YijhQZ/v+WNTYauU81pYmHTRuI
         MQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Dgua/7V+TR/yiK+k8PuDEttPjPhI4jfJvlrMcLchBR4=;
        b=z64/zsDcCizTV67Cvgy/Gn7JA2D8v2Ymcx4A+93S9lKaSxSOoy9i/ESy3W9NfGoGRZ
         KE2JTdDri2pHSndQGErra9kldZPHeCyCpa5E0pu9TkQPMaXlG9D6kr5sHIWmQPWgoJps
         ZQWha3xiabhNrVhwyNwgu3gNze5cePoLHiqZhC6MEREZ/nsNNAun7ySkEpig5oQXBa0X
         /nBpjY/OkKQ4Sf9AxE5zhrR/cTLFi4WEcSerdQ9cNKU+umtHDuPEUGIl8AktibVVY6xZ
         F3z/kyHyBY1b4iMd5+1My6UHhz8fGZz2bp5NRcwrNJq30E5ODhWLLnwfpgTrdavl9lp6
         f1/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 207/310] cxl: Unlock on error in probe
Date: Wed, 11 Apr 2018 20:35:46 +0200
Message-Id: <20180411183631.474994847@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477570404033024?=
X-GMAIL-MSGID: =?utf-8?q?1597477570404033024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 58d876fa7181f2f393190c1d32c056b5a9d34aa2 ]

We should unlock if get_cxl_adapter() fails.

Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from a guest")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/cxl/flash.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -401,8 +401,10 @@ static int device_open(struct inode *ino
 	if (down_interruptible(&sem) != 0)
 		return -EPERM;
 
-	if (!(adapter = get_cxl_adapter(adapter_num)))
-		return -ENODEV;
+	if (!(adapter = get_cxl_adapter(adapter_num))) {
+		rc = -ENODEV;
+		goto err_unlock;
+	}
 
 	file->private_data = adapter;
 	continue_token = 0;
@@ -446,6 +448,8 @@ err1:
 		free_page((unsigned long) le);
 err:
 	put_device(&adapter->dev);
+err_unlock:
+	up(&sem);
 
 	return rc;
 }
