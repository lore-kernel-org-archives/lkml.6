Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvfUvPC6hnZx1cNXXTSTslMWokYoiaH/ZQpu9LxjV4DbTTwKlirZu1e0HsJ2ZAk2L7brTcJ
ARC-Seal: i=1; a=rsa-sha256; t=1521800121; cv=none;
        d=google.com; s=arc-20160816;
        b=A6P61eMA1gI+jwFZhRFr8PtdHj8g15Cm6LOlckb4tOhlP1bUZAs1WLDFI7lHKISRpU
         vyKhRLerZ0uCRkYM5EF6Cahja8c/IMWLQDniyKfCpqYA/6Ol5HHmzovjpL7kpB0yRbSM
         2m8QW8iTG427EZqZaUMv1++k9LFlE2v3z38eRXHJlN+MGtR0MwRHg7Lx9Y6QHjI3oUWk
         I8wvJHoegozguL0h1bU1ep6HLr5uFPg0NkuoTghLOsga2d1O0gt1vuyMZpExdn5Ljjb3
         pOCw4ejOdaixlS5V8A6A+JBKgmrqtpM/v9D73WqFbKUSfkiELobjFZD9XL7j/XXV5YbT
         4XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zTtO3UzXprME3bW535wUbHyEq3yPhww9IlbmwvkFx80=;
        b=hW9NPCAfAx3+VzPe6h/k5so+ocLGbLygVXjoq+l6UuxrWdB903G4GxWmIj3bqoMiAO
         L8PSXATevFqQfxVfK2lIWaV/KG+ekrd5beS0yp1OJ4IBYYjbk4gzXBfwnBjLQaFxlamx
         FMS0whYMg/P3/LJFBGoWbqtW73NUVYzZD0rR0SkBEH4p+lfVXXXnCtLl5v59USeRLBXz
         kS/aMHTlrsIDALadvPa+yz2OXuhjrpUIWcrmbAIgoKw1RcvNgOHWLbaI1b+SNer+8ORl
         yRbAFTEXu/n8Vxxkj49FVVLhOwyGnTdZW1EU8Uk+1JmFaPnYArzTrq7T9HNN/TWxGRVB
         A+Og==
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
Subject: [PATCH 4.4 41/97] wan: pc300too: abort path on failure
Date: Fri, 23 Mar 2018 10:54:28 +0100
Message-Id: <20180323094159.954567569@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722592396394976?=
X-GMAIL-MSGID: =?utf-8?q?1595723083755484431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
