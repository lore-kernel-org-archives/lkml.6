Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49lx5ZiPAe9T1VfKBG957N99poqjZQ5nxg7TNCeXUE+n7oMXiOYVF1RXtGeemddh5cCdva3
ARC-Seal: i=1; a=rsa-sha256; t=1523399159; cv=none;
        d=google.com; s=arc-20160816;
        b=nHs4MfO3enr3ihfAeWY5as5pT4aZ4VfxL+B+rHKoWQgJfLgJfplqm9K1nxhyWGPpQS
         34+QGt1bXAhqkf4ymdN/eyeXQ3uYQ6Da3Sw3UVJKN+8a72JCwnZuU0OLVKoluzO99tvY
         FCTD5I9/XX7seqcDbp5fspgEU3q1QkxrpSkt+Gbcf/OZLiuz5W1MkaQkeWd/LZc7IcVY
         HhkkGAcS7r9EeRKlw1D3lApJSuNqy4hlr0yiu9cNog0ZAVoYn2iKvpLvRnvSnHM2pfhg
         UQBPMGncwrcJL2GOhYB439MI3zLiM0xU769Tab5mgY5qGgQgGPgKXCgzmPh1jPj8un0Z
         JdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mTl8xZ6VohxFudOTgG52vsHCB1bJMtio9vp24FAen7g=;
        b=KBk+jI/lbtz1CPPINENVHeKjFdzw59KcHu5VLvejwc1V0P1ugQv+N1/MZ7oj0CaMki
         Od7wnDeUwRTrdLjolXe4iV/vhnhj/1F23q0WZAg7Y5iFtVpafXuUJoDpViYV8h/8/+fa
         Vsa1GtpojFu5+TuQ91UdZccEDFsuk2BoYvhPNyzPa11YTDFAGx59A1XlSUR8DgCCeRvU
         Jz0V67vzs7yVpVYAZoQIx8FnEV5DO63c18ixLSMx6VzC3Ab4ilvgL/eRECuLePJ0XHex
         kycurARM5XC/EICAC4cTIbj7ptytgBIFpHDX/N4A20wnMgu3mcXjHq/jecnynZnP46Y+
         wqPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 001/168] i40iw: Fix sequence number for the first partial FPDU
Date: Wed, 11 Apr 2018 00:22:23 +0200
Message-Id: <20180410212800.218934539@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399796931292081?=
X-GMAIL-MSGID: =?utf-8?q?1597399796931292081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit df8b13a1b23356d01dfc4647a5629cdb0f4ce566 ]

Partial FPDU processing is broken as the sequence number
for the first partial FPDU is wrong due to incorrect
Q2 buffer offset. The offset should be 64 rather than 16.

Fixes: 786c6adb3a94 ("i40iw: add puda code")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h    |    1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -97,6 +97,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
 
 #define I40IW_TERM_SENT 0x01
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1378,7 +1378,7 @@ static void i40iw_ieq_handle_exception(s
 	u32 *hw_host_ctx = (u32 *)qp->hw_host_ctx;
 	u32 rcv_wnd = hw_host_ctx[23];
 	/* first partial seq # in q2 */
-	u32 fps = qp->q2_buf[16];
+	u32 fps = *(u32 *)(qp->q2_buf + Q2_FPSN_OFFSET);
 	struct list_head *rxlist = &pfpdu->rxlist;
 	struct list_head *plist;
 
