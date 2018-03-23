Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJoAQ19CZ83WYwGOUDDwvasKOzeepnSuo24+0LPGFnlpdfaQ7JhaQYbM9423SrNRVX6g0t
ARC-Seal: i=1; a=rsa-sha256; t=1521800347; cv=none;
        d=google.com; s=arc-20160816;
        b=Dzgfq7caOnSUdmXjFIReiixPB2FtIWfLO147SCMR7R0u82cgxxIq+2KPES4zMiZNo7
         pFSM158Gz8NM9vZVFmMsXc1YocC4jaDxdvGv9+39pdVUIt8uITBsKiISetQ85I85cLZ4
         RYp5wIPrmhEBl93NAv+8oxdG2x2ruljJLI1C5kihquKcHZ2flB9Cf1WjiYuVW80wPxCw
         +0q0w4nsvB81rR3Fx0iI9IT/H0ZX09K7Epa7ASjBFTfn4h3Qr1rXkAhXHjBEV3gkwdLP
         Q9TuHkDZ4N7EODYGyhqbpPFAwD8rn7fr+jBugYYNiSfBicow/GmNx60bgrSmjun4e4sS
         knvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MOJnNMIkFd+xyyJ1UhlD6E8nNKi+9G7Alu1JXpVzE7A=;
        b=tpQfS8U9KQxDNo0sBk7q66pYSNj1jQ/VLlArCQ8BFEAPE/pQzyGZerXH2zkw0orISN
         YbXIojBC1NqQLPEiKrfr8gbPt319fG2/v1QPUVd4zCO7LWs/MtJnSlBUG5MF4IsQxBjd
         8zHLNb/KpPGptf8QFLsuw9szY8lOp3jGnjwmZKhehAPg0I/qD8g+51s/rWSSHrCTglJg
         89XDYLJOHHw/Leeq8HtzhK9UbxVBv9Z/CuUc66yVk0N6eEOswNnDm2x8GD8wXb/4r67f
         l9ANXiFx40e7Rn68xWzqcDAE301sM/nuQHJEXQWr1+dfJ9qcdPMd0v5q3pZp5Wd0N6F9
         5slw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 21/47] wan: pc300too: abort path on failure
Date: Fri, 23 Mar 2018 10:55:12 +0100
Message-Id: <20180323094249.034131117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722592396394976?=
X-GMAIL-MSGID: =?utf-8?q?1595723321599155715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 2a39e7aa8a98f777f0732ca7125b6c9668791760 ]

In function pc300_pci_init_one(), on the ioremap error path, function
pc300_pci_remove_one() is called to free the allocated memory. However,
the path is not terminated, and the freed memory will be used later,
resulting in use-after-free bugs. This path fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/pc300too.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wan/pc300too.c
+++ b/drivers/net/wan/pc300too.c
@@ -347,6 +347,7 @@ static int pc300_pci_init_one(struct pci
 	    card->rambase == NULL) {
 		pr_err("ioremap() failed\n");
 		pc300_pci_remove_one(pdev);
+		return -ENOMEM;
 	}
 
 	/* PLX PCI 9050 workaround for local configuration register read bug */
