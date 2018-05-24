Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrx39bdBNVkjGLMdh/etTjeKXZCOCJyU13716sdLmEsVYCoE7pJn9w5cujCi77ecsqG+ObX
ARC-Seal: i=1; a=rsa-sha256; t=1527156316; cv=none;
        d=google.com; s=arc-20160816;
        b=vjzPFnHPoLXCT34bweMg63oKGqPpFFsDp2QRq0fJUvb5VnLP8Zyg13sdgEnUa4+BwQ
         LOiQr7bjTjFuvSh1JzdfaH4IvWNQuo5Mge9sSSRYzhDakwfTQi4bd6c220QBTX+cGS6j
         YpbbB5j8gf39fH2WQH0JryEFhzFuGMgJQx7AbcaoxrPrTibHRpDHIzDU0Gq+bafCKiXJ
         fU6R0B3NxZCkJGHW9RjoDS83yY+kS+ElvBItFmjFzK8Fj7epsodWMKsYsmlfEgV713Te
         Ic8V2jIrvDdp8QFB9b56Tk1MiEivMjuFI+p22peBFvKbkV4Ki5rjZ4964CYZ9Dliwb1v
         yzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2jMMzX80crl4ZHP+kSxthlVW34gMU/M0l1qiuJoHYbM=;
        b=Q3S3EOM22np2eYoB9mKKybcqoj0e2BRTiVK+RKyNbbiVC1jLmxVHlCzJ9WlaMU/6Hv
         KLMr1aZRMwQjCY0H/F1MVF7xPHIv7KVQQ93uwPIW9uvsG0FOlgRLlJHUPoIxenzkrJ2s
         CSWGwJA2YX7TE3et399i89Yx/ItIdDTPUFfiwWXDeE3JEWRE3wMHd376+MuDzGv8pYyF
         qDzGsIjECYlICPiw25baM9u8pl64C+rxfqRga2wDvmu+A9MHVaJK8/+Wrcjny64uget0
         DflPvHf98XLYsy0EkrDI4j59dSpw97uMpo2RTh8iPQNdtuaxoZFdNJzqWRcO7yxfXQ4Q
         zFmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xDE+2h3E;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xDE+2h3E;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Brad Love <brad@nextdimension.cc>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 135/161] media: cx23885: Override 888 ImpactVCBe crystal frequency
Date: Thu, 24 May 2018 11:39:20 +0200
Message-Id: <20180524093034.551885957@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338532239038455?=
X-GMAIL-MSGID: =?utf-8?q?1601339461507547033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 779c79d4b833ec646b0aed878da38edb45bbe156 ]

Hauppauge produced a revision of ImpactVCBe using an 888,
with a 25MHz crystal, instead of using the default third
overtone 50Mhz crystal. This overrides that frequency so
that the cx25840 is properly configured. Without the proper
crystal setup the cx25840 cannot load the firmware or
decode video.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/cx23885-core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -873,6 +873,16 @@ static int cx23885_dev_setup(struct cx23
 	if (cx23885_boards[dev->board].clk_freq > 0)
 		dev->clk_freq = cx23885_boards[dev->board].clk_freq;
 
+	if (dev->board == CX23885_BOARD_HAUPPAUGE_IMPACTVCBE &&
+		dev->pci->subsystem_device == 0x7137) {
+		/* Hauppauge ImpactVCBe device ID 0x7137 is populated
+		 * with an 888, and a 25Mhz crystal, instead of the
+		 * usual third overtone 50Mhz. The default clock rate must
+		 * be overridden so the cx25840 is properly configured
+		 */
+		dev->clk_freq = 25000000;
+	}
+
 	dev->pci_bus  = dev->pci->bus->number;
 	dev->pci_slot = PCI_SLOT(dev->pci->devfn);
 	cx23885_irq_add(dev, 0x001f00);
