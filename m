Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeEWAX5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:23:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44191 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeEWAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:23:55 -0400
X-Google-Smtp-Source: AB8JxZqbH51KRX3U5BvsS8jySSyHkdJwfUkACZf3K5nc6VGbp6CCKAGHecfjmqd0jYuZ5CK//f6OBQ==
From: Brian Norris <briannorris@chromium.org>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Cc: <linux-kernel@vger.kernel.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mfd: cros_ec: retry commands when EC is known to be busy
Date: Tue, 22 May 2018 17:23:10 -0700
Message-Id: <20180523002310.87011-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 001dde9400d5 ("mfd: cros ec: spi: Fix "in progress" error
signaling") pointed out some bad code, but its analysis and conclusion
was not 100% correct.

It *is* correct that we should not propagate result==EC_RES_IN_PROGRESS
for transport errors, because this has a special meaning -- that we
should follow up with EC_CMD_GET_COMMS_STATUS until the EC is no longer
busy. This is definitely the wrong thing for many commands, because
among other problems, EC_CMD_GET_COMMS_STATUS doesn't actually retrieve
any RX data from the EC, so commands that expected some data back will
instead start processing junk.

For such commands, the right answer is to either propagate the error
(and return that error to the caller) or resend the original command
(*not* EC_CMD_GET_COMMS_STATUS).

Unfortunately, commit 001dde9400d5 forgets a crucial point: that for
some long-running operations, the EC physically cannot respond to
commands any more. For example, with EC_CMD_FLASH_ERASE, the EC may be
re-flashing its own code regions, so it can't respond to SPI interrupts.
Instead, the EC prepares us ahead of time for being busy for a "long"
time, and fills its hardware buffer with EC_SPI_PAST_END. Thus, we
expect to see several "transport" errors (or, messages filled with
EC_SPI_PAST_END). So we should really translate that to a retryable
error (-EAGAIN) and continue sending EC_CMD_GET_COMMS_STATUS until we
get a ready status.

IOW, it is actually important to treat some of these "junk" values as
retryable errors.

Together with commit 001dde9400d5, this resolves bugs like the
following:

1. EC_CMD_FLASH_ERASE now works again (with commit 001dde9400d5, we
   would abort the first time we saw EC_SPI_PAST_END)
2. Before commit 001dde9400d5, transport errors (e.g.,
   EC_SPI_RX_BAD_DATA) seen in other commands (e.g.,
   EC_CMD_RTC_GET_VALUE) used to yield junk data in the RX buffer; they
   will now yield -EAGAIN return values, and tools like 'hwclock' will
   simply fail instead of retrieving and re-programming undefined time
   values

Fixes: 001dde9400d5 ("mfd: cros ec: spi: Fix "in progress" error signaling")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/mfd/cros_ec_spi.c               | 24 ++++++++++++++++++++----
 drivers/platform/chrome/cros_ec_proto.c |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 1b52b8557034..2060d1483043 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -419,10 +419,25 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 		/* Verify that EC can process command */
 		for (i = 0; i < len; i++) {
 			rx_byte = rx_buf[i];
+			/*
+			 * Seeing the PAST_END, RX_BAD_DATA, or NOT_READY
+			 * markers are all signs that the EC didn't fully
+			 * receive our command. e.g., if the EC is flashing
+			 * itself, it can't respond to any commands and instead
+			 * clocks out EC_SPI_PAST_END from its SPI hardware
+			 * buffer. Similar occurrences can happen if the AP is
+			 * too slow to clock out data after asserting CS -- the
+			 * EC will abort and fill its buffer with
+			 * EC_SPI_RX_BAD_DATA.
+			 *
+			 * In all cases, these errors should be safe to retry.
+			 * Report -EAGAIN and let the caller decide what to do
+			 * about that.
+			 */
 			if (rx_byte == EC_SPI_PAST_END  ||
 			    rx_byte == EC_SPI_RX_BAD_DATA ||
 			    rx_byte == EC_SPI_NOT_READY) {
-				ret = -EREMOTEIO;
+				ret = -EAGAIN;
 				break;
 			}
 		}
@@ -431,7 +446,7 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!ret)
 		ret = cros_ec_spi_receive_packet(ec_dev,
 				ec_msg->insize + sizeof(*response));
-	else
+	else if (ret != -EAGAIN)
 		dev_err(ec_dev->dev, "spi transfer failed: %d\n", ret);
 
 	final_ret = terminate_request(ec_dev);
@@ -537,10 +552,11 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 		/* Verify that EC can process command */
 		for (i = 0; i < len; i++) {
 			rx_byte = rx_buf[i];
+			/* See comments in cros_ec_pkt_xfer_spi() */
 			if (rx_byte == EC_SPI_PAST_END  ||
 			    rx_byte == EC_SPI_RX_BAD_DATA ||
 			    rx_byte == EC_SPI_NOT_READY) {
-				ret = -EREMOTEIO;
+				ret = -EAGAIN;
 				break;
 			}
 		}
@@ -549,7 +565,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	if (!ret)
 		ret = cros_ec_spi_receive_response(ec_dev,
 				ec_msg->insize + EC_MSG_TX_PROTO_BYTES);
-	else
+	else if (ret != -EAGAIN)
 		dev_err(ec_dev->dev, "spi transfer failed: %d\n", ret);
 
 	final_ret = terminate_request(ec_dev);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index e7bbdf947bbc..8350ca2311c7 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -91,6 +91,8 @@ static int send_command(struct cros_ec_device *ec_dev,
 			usleep_range(10000, 11000);
 
 			ret = (*xfer_fxn)(ec_dev, status_msg);
+			if (ret == -EAGAIN)
+				continue;
 			if (ret < 0)
 				break;
 
-- 
2.17.0.441.gb46fe60e1d-goog
