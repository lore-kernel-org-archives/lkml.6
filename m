Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494AOpRmNAi5ZbFgahfpdZMMH5z4eojfrh2GVJToL3uP16HqdgvkWpiqSMgYXjfPC7idZc+
ARC-Seal: i=1; a=rsa-sha256; t=1522346747; cv=none;
        d=google.com; s=arc-20160816;
        b=ei8joUDK104azdnNP1bklnb1QzMSQxqfn+sUDFfhWhMXcwyCF8+96q9ACKtRmc1MyZ
         tht+aNXMrtBmFrWshvKM4inOqjbX3EpyoxXvoH2HGzsvJFNZ6PFa5zvmSEZgqQMFLBRn
         tTk8t/RVzI5r/1pQVs0rGjq8yhCikJvQ0I9a+inD+mRGdfLNHNA9CBHyYGtdZLtLDseU
         27meA1RwpjtLffX9W2HKUEty0t7NDNapMtEZfDYW25d3owm9Aw89B8IycGe8g3tCbC4G
         UCuUxsryssJkw/alTLDn37Je93L+B0WMzXR84uhBQri2jhdEyliRvoyQNEGWQAcGEUfX
         I6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rSADHIzH1teFs/InldaZ7YjR+J7C1b3PWpiYX8H5hC8=;
        b=qV5/Mwb7rzWovkq+bgQxpLmPjO+/aC2rdGkHIEADFvr9SJdSDaZL6SMb6ThlR4yRma
         sEOq9YtjyxuM0tXCaMjGxw0ufMfrqkotnNQVnrj63Evstp+gGS6hIsEVlEfzhyTg4nIB
         xc9gD1Eh+Tp4OoQKmOzxCwhiYxuRwH592tGllReJvZKxAVPiyl/VkTvKEWREnS7WM1Q5
         DWUw1P1yrCznTN5mA5x54XItbEYG0DQahT2yLKEXjgYrLRnza+Oh/tG6BJXm97uw6KqB
         7ltqe558jNj9qhK0cJz8hHwzWl7Px3IXwAmMTexMZMJ/hNTF7XBmG5RPmtaBwuk9cTPf
         a1YA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 43/43] s390/qeth: on channel error, reject further cmd requests
Date: Thu, 29 Mar 2018 20:00:38 +0200
Message-Id: <20180329175734.945268884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296072058867998?=
X-GMAIL-MSGID: =?utf-8?q?1596296262837690460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit a6c3d93963e4b333c764fde69802c3ea9eaa9d5c ]

When the IRQ handler determines that one of the cmd IO channels has
failed and schedules recovery, block any further cmd requests from
being submitted. The request would inevitably stall, and prevent the
recovery from making progress until the request times out.

This sort of error was observed after Live Guest Relocation, where
the pending IO on the READ channel intentionally gets terminated to
kick-start recovery. Simultaneously the guest executed SIOCETHTOOL,
triggering qeth to issue a QUERY CARD INFO command. The command
then stalled in the inoperabel WRITE channel.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1175,6 +1175,7 @@ static void qeth_irq(struct ccw_device *
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
