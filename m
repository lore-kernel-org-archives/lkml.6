Return-Path: <kernel-hardening-return-12406-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELum8VyXzEmOjM/ybq8kzCurWvDiftdb7342quXaFvo8yd/cFFNBAz8XFbQw0gfrbgAu0n42
ARC-Seal: i=1; a=rsa-sha256; t=1520819062; cv=none;
        d=google.com; s=arc-20160816;
        b=AWmH3o7DkxGiVcbVR7c2UDq35C986rKUxUvqrF3KT/eOPoeObyLfQpYxOHAzaOtCrP
         HgtTVyiIJnXEXh7piVe3TB84MvgnPi/bSqkjsc2b6UyRWgWpwl0maPX7VW2g+5JGu0Gz
         pqgttYxwYcQ+CTx5yFwpgYjwtSOdEAzl3i2ZuCJDRGd4fGaavujRO6ORPB5s0aVwCJx5
         BG5LqOfwNoWmz5vpCHJvYn3J3iaot69AB2VQFB5QlGBPgtCTUaTUE4yQFTpFGrFjDnKi
         Be422r4zjJ39vYhXlE2ndGVWuhEH55dtA00JRbio/fWgeXm0FT7wbHjTAWbcacG0akjM
         U2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=f7Qje+aVozVqfO83c+/uI0iBNECdFYN0FYeFBHIzHSs=;
        b=P4rW8YHO04O4L7YI6mW39jG2AME8uRQl2goLqRtLVDyyrlUsSih56KBjvimPWRopp/
         OH7I8dRxXLbXXYdXSakXEYNAKN9PxtxrZ6BKKUldlBCaNR3mw1m9jFTvcShGrYFXMR5M
         0hJLu1Jn4Vb8rfl24/f9tDM3P7ckHFauS1hW1VbJQYKvKPtIJXGyumiNF1aBzAhqxWyO
         TLYiHRGVLI+1aNmpLEklZ5SYvZHsYkS8+Ravb2Cgct8PeDFVvAH0H3R7Mk84SR2YAhvi
         J3TZPMsaXpoUjk8oDnRUmmLTy9SOjDL7eQ98EJ6cIn/ABhTNxRUALu6bfFAVEXNERzZs
         iN1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=gyn/LL2J;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=TYoIALDA;
       spf=pass (google.com: domain of kernel-hardening-return-12406-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12406-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=gyn/LL2J;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=TYoIALDA;
       spf=pass (google.com: domain of kernel-hardening-return-12406-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12406-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:Y9ulWgzsHN9sal2d_SGaSAdNjKqRvhLSvF9xRJ8zA_tkowcmLiWztQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Subject: [RESEND PATCH] rsi: Remove stack VLA usage
Date: Mon, 12 Mar 2018 12:43:42 +1100
Message-Id: <1520819022-15238-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594694368799131704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  rsi uses
a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
is defined using a magic number.  We can use a pre-processor defined
constant and declare the array to maximum size.  We add a check before
accessing the array in case of programmer error.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

RESEND: add wireless mailing list to CC's (requested by Kalle)

 drivers/net/wireless/rsi/rsi_91x_hal.c  | 13 +++++++------
 drivers/net/wireless/rsi/rsi_91x_sdio.c |  9 +++++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 1176de646942..839ebdd602df 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -641,7 +641,7 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
 	u32 cmd_addr;
 	u16 cmd_resp, cmd_req;
 	u8 *str;
-	int status;
+	int status, ret;
 
 	if (cmd == PING_WRITE) {
 		cmd_addr = PING_BUFFER_ADDRESS;
@@ -655,12 +655,13 @@ static int ping_pong_write(struct rsi_hw *adapter, u8 cmd, u8 *addr, u32 size)
 		str = "PONG_VALID";
 	}
 
-	status = hif_ops->load_data_master_write(adapter, cmd_addr, size,
+	ret = hif_ops->load_data_master_write(adapter, cmd_addr, size,
 					    block_size, addr);
-	if (status) {
-		rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
-			__func__, *addr);
-		return status;
+	if (ret) {
+		if (ret != -EINVAL)
+			rsi_dbg(ERR_ZONE, "%s: Unable to write blk at addr %0x\n",
+				__func__, *addr);
+		return ret;
 	}
 
 	status = bl_cmd(adapter, cmd_req, cmd_resp, str);
diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index b0cf41195051..b766578b591a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -20,6 +20,8 @@
 #include "rsi_common.h"
 #include "rsi_hal.h"
 
+#define RSI_MAX_BLOCK_SIZE 256
+
 /**
  * rsi_sdio_set_cmd52_arg() - This function prepares cmd 52 read/write arg.
  * @rw: Read/write
@@ -362,7 +364,7 @@ static int rsi_setblocklength(struct rsi_hw *adapter, u32 length)
 	rsi_dbg(INIT_ZONE, "%s: Setting the block length\n", __func__);
 
 	status = sdio_set_block_size(dev->pfunction, length);
-	dev->pfunction->max_blksize = 256;
+	dev->pfunction->max_blksize = RSI_MAX_BLOCK_SIZE;
 	adapter->block_size = dev->pfunction->max_blksize;
 
 	rsi_dbg(INFO_ZONE,
@@ -567,9 +569,12 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 {
 	u32 num_blocks, offset, i;
 	u16 msb_address, lsb_address;
-	u8 temp_buf[block_size];
+	u8 temp_buf[RSI_MAX_BLOCK_SIZE];
 	int status;
 
+	if (block_size > RSI_MAX_BLOCK_SIZE)
+		return -EINVAL;
+
 	num_blocks = instructions_sz / block_size;
 	msb_address = base_address >> 16;
 
-- 
2.7.4
