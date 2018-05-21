Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqww9axd56ir4hEqcGydqY5F5gmHa25NNQhZnp+zuhcKIbsRlupQ9Rpw9fHpNwQOobfEuBv
ARC-Seal: i=1; a=rsa-sha256; t=1526937747; cv=none;
        d=google.com; s=arc-20160816;
        b=KJ4A1s+QiYfDLuNOlgGZfmr9S+xe6Na8oyQFQuPBk0Da89kAWxhRfxv3KNpzzl3nwt
         67CAP/FEE5h8B4pYJ6E0AQLFVLOeyoUTG3Sf/FqPjKPwJo2j9Rj8eGgP4pZAR0P3a3Wm
         3I6thrZB6J+lYae+b+5k0KOGLLdmo1Sba+i8NT8rgAtsiBlgQjuLO5EIUdoTpXbMm+vJ
         05PNi9oAp0k6RVmsEYzDSWUqA2WliBxFBKyko15xF8rt1+VC5es15eAFUPPErmwR6hHj
         0wuAz8U4juw6ljMrE/VGJGX1yYVkytoMp7YAYrnvJtVRYHAhvO7OBY66pZHON5GyK0GS
         V5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7kicGUe8a8IZBzxh50FmleRzIFCJkbAOYWB8KSd4hE4=;
        b=PCwh1hv6WGsJqZ2Ujys68/jYG1jpm457REs7a5s++ThxiE29TkUZDYCYxYWVGNw70A
         JFPb3QaqqwYzFJyuqUpjHennT+MZ4sIcLN0f6XzwNlp3B7ybQoLklp6Ud9/nDMHPpxUz
         RFcpWzLNg0rHxPWTcL4HTA4f3WTzQS45Btlvyt8GZpw0g73OPfTC1S1KHT2IOUpmlao7
         YMzkNq5T/qCFPVULXvrImPF8IE6sKsRR/Ze5UBDPqBOlsWwI74OeIJP/KHU8SWKPinCr
         zKLQ5ZKh1CpKDnyVSIKBCl1t8FZImL7ERrYHiOCTOmVVuA7NjK/r4KsWEphjGw6V9LDR
         ZEBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=s/0ydgIq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=s/0ydgIq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 011/110] spi: pxa2xx: Allow 64-bit DMA
Date: Mon, 21 May 2018 23:11:08 +0200
Message-Id: <20180521210504.944381892@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109777677915566?=
X-GMAIL-MSGID: =?utf-8?q?1601110275437827724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit efc4a13724b852ddaa3358402a8dec024ffbcb17 upstream.

Currently the 32-bit device address only is supported for DMA. However,
starting from Intel Sunrisepoint PCH the DMA address of the device FIFO
can be 64-bit.

Change the respective variable to be compatible with DMA engine
expectations, i.e. to phys_addr_t.

Fixes: 34cadd9c1bcb ("spi: pxa2xx: Add support for Intel Sunrisepoint")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-pxa2xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -38,7 +38,7 @@ struct driver_data {
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
-	u32 ssdr_physical;
+	phys_addr_t ssdr_physical;
 
 	/* SSP masks*/
 	u32 dma_cr1;
