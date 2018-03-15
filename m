Return-Path: <kernel-hardening-return-12619-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsm+4fWVCzSSH/1r5FhfjgSYpNIILYOp2kEf9H7xaMUjBD5bxZCSjPRAnkuRutZ1VzNg2oY
ARC-Seal: i=1; a=rsa-sha256; t=1521081125; cv=none;
        d=google.com; s=arc-20160816;
        b=tIsmKVPgCbabrhz5trJVf5hRedg3XFndHoD7X6H/kFt2vmxT+4fikoNizR/aAPYWim
         glBmcTuu/9iAsYuyNquYLY1978K+CbqtCRG6/9zkJkThn8iP6QcgOLwondNJVn7azirW
         kIOFl4l8xAUDbCfykxwNPatcBJ3rnRq0299vfv+PY/bc0g0AR/t/DIVrdsGC2OMpV4vn
         1XzOAOgb9veOy045XwxNdgzsGaMIqZk7QEBEfkwVc5Z8qW2WWynXV68RYFyZBjjCk8YW
         /O3JqOUfY/YcH6oUEcY6Z1AdFJa4BaKOC/o8PvIjsippbJYYZbmbuWuO0tK0dnwm+yLs
         o39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=DSgqCwRLQt+PDfEuSGauGX9xbD6DIcA8kGGyZgFiuiI=;
        b=hpQ49Y1gaWFs8naDF0mMGRBTKtVMCLRu3crrOX+TBO6NHlDwdYsybypnLlorh3QxQa
         TU7wfXmeR4dI0WtFTCYsIyA0FM5HsUumzUxasr5QHma9IHP0l1cwyECz08MqV6FJOJHz
         6KgzIrSOg0mLpEE0Rt/P7Ekw+i74RFmaFd4qeqhAw1Nt5z35uRQt/PSguzjKURLCTVo5
         6HWQgI59B6FWBRryvqiCxtyJJK3v8UU8sMsNKvzyc8mWDVLodGHipka9CBk6EXFkFs68
         3fpLfw/stLS30oJUw5FtZAxvvWRxIlsxPKp2ZITmnj3Wmr5WgQ5xIRZl3HJYMZ0s+T7k
         tdUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=t7179Oil;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BnM0LZWb;
       spf=pass (google.com: domain of kernel-hardening-return-12619-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12619-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=t7179Oil;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BnM0LZWb;
       spf=pass (google.com: domain of kernel-hardening-return-12619-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12619-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:ENupWkD-M8s88qXZnR3rx1cPClXE_gbVZo6lYae7GBU0PdUJ4bIo8Q>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2] rsi: Remove stack VLA usage
Date: Thu, 15 Mar 2018 13:31:25 +1100
Message-Id: <1521081085-16404-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594969162430778908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
(kernel Oops) or a security flaw (overwriting memory beyond the
stack). Also, in general, as code evolves it is easy to lose track of
how big a VLA can get. Thus, we can end up having runtime failures
that are hard to debug. As part of the directive[1] to remove all VLAs
from the kernel, and build with -Wvla.

Currently rsi code uses a VLA based on a function argument to
`rsi_sdio_load_data_master_write()`.  The function call chain is

Both these functions

	rsi_sdio_reinit_device()
	rsi_probe()

start the call chain:

	rsi_hal_device_init()
	rsi_load_fw()
	auto_fw_upgrade()
	ping_pong_write()
	rsi_sdio_load_data_master_write()

[Without familiarity with the code] it appears that none of the 4 locks

	mutex
	rx_mutex
	tx_mutex
	tx_bus_mutex

are held when `rsi_sdio_load_data_master_write()` is called.  It is therefore
safe to use kmalloc with GFP_KERNEL.

We can avoid using the VLA by using `kmalloc()` and free'ing the memory on all
exit paths.

Change buffer from 'u8 array' to 'u8 *'.  Call `kmalloc()` to allocate memory for
the buffer.  Using goto statement to call `kfree()` on all return paths.

It can be expected that this patch will result in a small increase in overhead
due to the use of `kmalloc()` however this code is only called on initialization
(and re-initialization) so this overhead should not degrade performance.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

This applies onto tip of wireless-drivers next, commit

	(28bf8312a983 mwifiex: get_channel from firmware 

v2:
 - Use kmalloc instead of #define (suggested by Larry)
 - (Apply on top of wireless-drivers-next tree)
 - (Fix up user name on patchwork.kernel.org)

 drivers/net/wireless/rsi/rsi_91x_sdio.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 98c7d1dae18e..13705fca59dd 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -576,7 +576,7 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 {
 	u32 num_blocks, offset, i;
 	u16 msb_address, lsb_address;
-	u8 temp_buf[block_size];
+	u8 *temp_buf;
 	int status;
 
 	num_blocks = instructions_sz / block_size;
@@ -585,11 +585,15 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 	rsi_dbg(INFO_ZONE, "ins_size: %d, num_blocks: %d\n",
 		instructions_sz, num_blocks);
 
+	temp_buf = kmalloc(block_size, GFP_KERNEL);
+	if (!temp_buf)
+		return -ENOMEM;
+
 	/* Loading DM ms word in the sdio slave */
 	status = rsi_sdio_master_access_msword(adapter, msb_address);
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE, "%s: Unable to set ms word reg\n", __func__);
-		return status;
+		goto out_free;
 	}
 
 	for (offset = 0, i = 0; i < num_blocks; i++, offset += block_size) {
@@ -601,7 +605,7 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 					 temp_buf, block_size);
 		if (status < 0) {
 			rsi_dbg(ERR_ZONE, "%s: failed to write\n", __func__);
-			return status;
+			goto out_free;
 		}
 		rsi_dbg(INFO_ZONE, "%s: loading block: %d\n", __func__, i);
 		base_address += block_size;
@@ -616,7 +620,7 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 				rsi_dbg(ERR_ZONE,
 					"%s: Unable to set ms word reg\n",
 					__func__);
-				return status;
+				goto out_free;
 			}
 		}
 	}
@@ -632,12 +636,16 @@ static int rsi_sdio_load_data_master_write(struct rsi_hw *adapter,
 					 temp_buf,
 					 instructions_sz % block_size);
 		if (status < 0)
-			return status;
+			goto out_free;
 		rsi_dbg(INFO_ZONE,
 			"Written Last Block in Address 0x%x Successfully\n",
 			offset | RSI_SD_REQUEST_MASTER);
 	}
-	return 0;
+
+	status = 0;
+out_free:
+	kfree(temp_buf);
+	return status;
 }
 
 #define FLASH_SIZE_ADDR                 0x04000016
-- 
2.7.4
