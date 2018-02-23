Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225anOnHyQdf30EPwLhOoHRS0SsO4dUOKTlELnZkO85xBYibLBgEMVvbsDe4wbu7v3V1z07a
ARC-Seal: i=1; a=rsa-sha256; t=1519410995; cv=none;
        d=google.com; s=arc-20160816;
        b=CjdX65xLii+3SmCmMIKnL8AXT++fdbTeEM5TxuyhlHEu0Ypm5vtE0Y1QCTqhJzHrlF
         Aa6V3vqWeJI6CHFil4iln5PReuACpXQFk3HsBrRy1RpMg4Gf1jyXPsbkk4xmGcwlp+88
         huySNrp7gVVM+biREPU/TmqfnkJCnY2K5oTcwjqybyz5opLkP0radsvURhavlXwH5sc2
         y9ol6lD7arsGJxTLyE+088IWJJKbQ2vRl590Jt3Wg6aBE3yg9+R4CSMJOLt+/J98mmxd
         LqTtwxFBAyrBY1a3eSq5kCdP6HVN8TshRKWFTxlFBn2/vRr9bjNsuh51c36+6l6csmO0
         1VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NOKj9mlpA8HiUx/HKOJKq9cESQ6TAUAoRFZXoLsD7qM=;
        b=AGHXsBeVa53E4AXwHLYo76pDejaRe7DU0lHFQlcIKluiDGsFEfPb+B2msDOAJYBIIm
         PawQYfDTWace7D3fMgDR3aZzX6K1HD5rLMtaNWrto8BZHLFaT/xtcM7CDCJnycP5kIKG
         4ZlC/EnzkNLvep6BhFDi/HjCbyEr7+w6uK9CoDLlCj4qo4uC0MXVj41eXwYHIEEohnFf
         uivMUQeQLw5l/S0qrWwoTEV0xKpPDpd1Dm9SYhafokhZoF9E+niLZvpxpkIAK0rhzIGm
         1DokL5X990bTo3zJHz0ZQJa5vehgCQX4l0qlEHd0Er3VRAmdqaO9GShhBWTNEL1U9BSf
         loIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabian Frederick <fabf@skynet.be>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 085/193] drivers/net: fix eisa_driver probe section mismatch
Date: Fri, 23 Feb 2018 19:25:18 +0100
Message-Id: <20180223170339.359985411@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217903866781097?=
X-GMAIL-MSGID: =?utf-8?q?1593217903866781097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabian Frederick <fabf@skynet.be>

commit cb4396edd84ed73081635fb933d19c1410fafaf4 upstream.

Some eisa_driver structures used __init probe functions which generates
a warning and could crash if function is called after being deleted.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/3com/3c509.c      |    2 +-
 drivers/net/ethernet/3com/3c59x.c      |    2 +-
 drivers/net/ethernet/dec/tulip/de4x5.c |    2 +-
 drivers/net/ethernet/hp/hp100.c        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/3com/3c509.c
+++ b/drivers/net/ethernet/3com/3c509.c
@@ -562,7 +562,7 @@ static void el3_common_remove (struct ne
 }
 
 #ifdef CONFIG_EISA
-static int __init el3_eisa_probe (struct device *device)
+static int el3_eisa_probe(struct device *device)
 {
 	short i;
 	int ioaddr, irq, if_port;
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -907,7 +907,7 @@ static struct eisa_device_id vortex_eisa
 };
 MODULE_DEVICE_TABLE(eisa, vortex_eisa_ids);
 
-static int __init vortex_eisa_probe(struct device *device)
+static int vortex_eisa_probe(struct device *device)
 {
 	void __iomem *ioaddr;
 	struct eisa_device *edev;
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -1990,7 +1990,7 @@ SetMulticastFilter(struct net_device *de
 
 static u_char de4x5_irq[] = EISA_ALLOWED_IRQ_LIST;
 
-static int __init de4x5_eisa_probe (struct device *gendev)
+static int de4x5_eisa_probe(struct device *gendev)
 {
 	struct eisa_device *edev;
 	u_long iobase;
--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -2843,7 +2843,7 @@ static void cleanup_dev(struct net_devic
 }
 
 #ifdef CONFIG_EISA
-static int __init hp100_eisa_probe (struct device *gendev)
+static int hp100_eisa_probe(struct device *gendev)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
 	struct eisa_device *edev = to_eisa_device(gendev);
