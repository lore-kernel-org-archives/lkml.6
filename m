Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuBR6IaKdJ7grIrrLqvgKDK/qMskhGmTprijaYfsUZVuc1Q9s94rXYozPpjAEacIoVCkbpv
ARC-Seal: i=1; a=rsa-sha256; t=1519981523; cv=none;
        d=google.com; s=arc-20160816;
        b=Ab4Uz0sNWVBSSnXCPsknnuK9M3ulPgnP1E6v1t0t5lX4x1yfa0EY2IFaQ7Y02PnrpM
         KEj7UinIbrmUsRF0R2BsBlJQr9pnlkj5CuuK+U6eEPIATGV51IP/FhUezI46QBLwy7V7
         gN5ztsyIclxaVjJDXu94fzExJQ6G9U6iEQ0NafWKCBZulk1jQRdcp5uWiIPEW8+FG31+
         GuVMvJPCaJpys9reJ7YE3Sy4XRgDPobIu+VLL3RlvGYMASv0XfAl8Ato6nNQNjTL1CG+
         8ytTzW0mnM6HgFdZArq+oR/TreFNZ8WBsg4nFx4LnMgRxDz7BubWYiIUSklTVufQPEif
         e8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oahB04dxFZNcJriCra8a75qsPUQP2ou/ELcZaeECoRQ=;
        b=uyr+B3x9T7pOqfJpNt+VizJLB+ZrYv73jvRxs+usYxYo7FaNV/NNrsZFK3xQ9XEOeo
         KtgX+4pIwakaY7ytCKVkDdfC5QOB9XgIo3pp0N2hQMy15DOaXpkMk7wQuBxhRCFuckqC
         34SsVeiYWyY1Nrufszar9khmTxR1Xf6lwW1eZx1qnua/3Rv0OhM09Pl/RN1pFwQdHyTo
         +IhjLKRiemRZ+dXfqRvS+1crB/1V8E/C9ZneJWu9repN5ovV4DNkjzdeOyndNZAXYrP2
         olRRHAqLr06s4K6rsMCw2KmahpPyZ4Bpk+ePRK8YhdIZlibbN8Vo1c1s2L+kSyF98wIo
         Uzbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 101/115] xen/gntdev: Fix partial gntdev_mmap() cleanup
Date: Fri,  2 Mar 2018 09:51:44 +0100
Message-Id: <20180302084507.929171680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815402000490514?=
X-GMAIL-MSGID: =?utf-8?q?1593816146283149359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit cf2acf66ad43abb39735568f55e1f85f9844e990 ]

When cleaning up after a partially successful gntdev_mmap(), unmap the
successfully mapped grant pages otherwise Xen will kill the domain if
in debug mode (Attempt to implicitly unmap a granted PTE) or Linux will
kill the process and emit "BUG: Bad page map in process" if Xen is in
release mode.

This is only needed when use_ptemod is true because gntdev_put_map()
will unmap grant pages itself when use_ptemod is false.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1071,8 +1071,10 @@ unlock_out:
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (use_ptemod) {
 		map->vma = NULL;
+		unmap_grant_pages(map, 0, map->count);
+	}
 	gntdev_put_map(priv, map);
 	return err;
 }
