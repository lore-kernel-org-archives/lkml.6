Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423813AbeE1LzY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423522AbeE1LId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:08:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Domen Puncer Kugler <domen.puncer@samsung.com>,
        Harry Morris <h.morris@cascoda.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 101/272] ieee802154: ca8210: fix uninitialised data read
Date: Mon, 28 May 2018 12:02:14 +0200
Message-Id: <20180528100249.628906640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Morris <h.morris@cascoda.com>

[ Upstream commit 86674a97f5055f4c7f406563408096e8cf9364ff ]

In ca8210_test_int_user_write() a user can request the transfer of a
frame with a length field (command.length) that is longer than the
actual buffer provided (len). In this scenario the driver will copy
the buffer contents into the uninitialised command[] buffer, then
transfer <data.length> bytes over the SPI even though only <len> bytes
had been populated, potentially leaking sensitive kernel memory.

Also the first 6 bytes of the command buffer must be initialised in case
a malformed, short packet is written and the uninitialised bytes are
read in ca8210_test_check_upstream.

Reported-by: Domen Puncer Kugler <domen.puncer@samsung.com>
Signed-off-by: Harry Morris <h.morris@cascoda.com>
Tested-by: Harry Morris <h.morris@cascoda.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/ca8210.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2493,13 +2493,14 @@ static ssize_t ca8210_test_int_user_writ
 	struct ca8210_priv *priv = filp->private_data;
 	u8 command[CA8210_SPI_BUF_SIZE];
 
-	if (len > CA8210_SPI_BUF_SIZE) {
+	memset(command, SPI_IDLE, 6);
+	if (len > CA8210_SPI_BUF_SIZE || len < 2) {
 		dev_warn(
 			&priv->spi->dev,
-			"userspace requested erroneously long write (%zu)\n",
+			"userspace requested erroneous write length (%zu)\n",
 			len
 		);
-		return -EMSGSIZE;
+		return -EBADE;
 	}
 
 	ret = copy_from_user(command, in_buf, len);
@@ -2511,6 +2512,13 @@ static ssize_t ca8210_test_int_user_writ
 		);
 		return -EIO;
 	}
+	if (len != command[1] + 2) {
+		dev_err(
+			&priv->spi->dev,
+			"write len does not match packet length field\n"
+		);
+		return -EBADE;
+	}
 
 	ret = ca8210_test_check_upstream(command, priv->spi);
 	if (ret == 0) {
