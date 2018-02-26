Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227irdwdJB9s+lpZc4hHDTD3LC2kmvFo+/9zhOKRT7OdI4lNtmX5x0wVGFyj5dctok2LcB4w
ARC-Seal: i=1; a=rsa-sha256; t=1519676852; cv=none;
        d=google.com; s=arc-20160816;
        b=iAozRVwN4aS4EPE4ptFfiFGr7YL97UhNY6x4yL9fZB8dPhyfhWUAGFAw0qYrvp0ANZ
         yyTpxrbWExozLjFuBz6S4TnZFB3C4VLhmSRjETOj/JTqphqsqAcmx0txNkMcRJ/2VOm5
         eb+1j0nbRaS/rpmbCFAIWREDN5JIGmMdEdfNa+wOaqsAhzq6pNC5sRgf3GH0lrsAk4Uz
         bI8II2g33wvZoegPPf8C6y8FB4uVv6N8FzEgM9bvFFg08N/aujQZCXg/2t4LkViurVeW
         2urLL79FyUr4D4PzEHNY5Cu0iQ0pouvHX4rl0f+wGunO8lDwWSwR0zt+LcxEazT9gTfp
         ihhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R2d7wkjCR2/gMp5Y46XXFSwRVMTO945ZnVqMRTBXymE=;
        b=RzMD1MSXyqpxs6xT9weaPpABAwNYUm5Xy/9NYMAPk2knju/4hFbhvWPS1eoAhmszf+
         DnLOltEa14hO0jgrhJiPiJlOtv36qfrY3acPTwiA4Icsxes0VCIf4tolI5EFcO6frBEE
         K/GXceLTWRyl0xdKP0CGzGdn4x2WNhOoiSQM/UJxI3qR0HYk7CQS3S+CNT2mmLoa63qU
         wHNE29c9BYr5bIGMyYYFjyPxCsXDq8FnQ4Mpg4XZ82k1HPa7LPTFYfklDvQ4NEJfCmGO
         FBfpCTc/RDkyFlb4kUJv2t1C+mIYRi0GpbP3JUxgSVIyynk7rZaOgOri2WUoAEB1hgZ3
         VZRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Gardner <gardner.ben@gmail.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.15 09/64] i2c: designware: must wait for enable
Date: Mon, 26 Feb 2018 21:21:46 +0100
Message-Id: <20180226202153.830139273@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496508464542854?=
X-GMAIL-MSGID: =?utf-8?q?1593496675103318799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Gardner <gardner.ben@gmail.com>

commit fba4adbbf670577e605f9ad306629db6031cd48b upstream.

One I2C bus on my Atom E3845 board has been broken since 4.9.
It has two devices, both declared by ACPI and with built-in drivers.

There are two back-to-back transactions originating from the kernel, one
targeting each device. The first transaction works, the second one locks
up the I2C controller. The controller never recovers.

These kernel logs show up whenever an I2C transaction is attempted after
this failure.
i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready

Waiting for the I2C controller status to indicate that it is enabled
before programming it fixes the issue.

I have tested this patch on 4.14 and 4.15.

Fixes: commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only if necessary")
Cc: linux-stable <stable@vger.kernel.org> #4.13+
Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-master.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -207,7 +207,7 @@ static void i2c_dw_xfer_init(struct dw_i
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable(dev, true);
+	__i2c_dw_enable_and_wait(dev, true);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
