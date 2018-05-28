Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939551AbeE1PE1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034003AbeE1KZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:25:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 220/268] hwmon: (pmbus/adm1275) Accept negative page register values
Date: Mon, 28 May 2018 12:03:14 +0200
Message-Id: <20180528100227.259726878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit ecb29abd4cb0670c616fb563a078f25d777ce530 ]

A negative page register value means that no page needs to be
selected. This is used by status register read operations and needs
to be accepted. The failure to do so so results in missed status
and limit registers.

Fixes: da8e48ab483e1 ("hwmon: (pmbus) Always call _pmbus_read_byte in core driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1275.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -141,7 +141,7 @@ static int adm1275_read_word_data(struct
 	const struct adm1275_data *data = to_adm1275_data(info);
 	int ret = 0;
 
-	if (page)
+	if (page > 0)
 		return -ENXIO;
 
 	switch (reg) {
@@ -218,7 +218,7 @@ static int adm1275_write_word_data(struc
 	const struct adm1275_data *data = to_adm1275_data(info);
 	int ret;
 
-	if (page)
+	if (page > 0)
 		return -ENXIO;
 
 	switch (reg) {
