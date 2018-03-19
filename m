Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELswi8CEyQM1y3RfKc29jIbwlUrc08Yh3yCwxKvqFKUdkR4HRR/ScRSHZ97BZI69g0OctI3c
ARC-Seal: i=1; a=rsa-sha256; t=1521483042; cv=none;
        d=google.com; s=arc-20160816;
        b=bcSpyQfRVKfOnQAbL8iN/Q/gxvWo3UhxuUawdQvnh1N95JBC+I/6oy2X1N9P21kJ/d
         9Y4rcTB2oLEayecvyyLbVOxXHODhvl4zY8gwFzIXo/nkTQM3tEJHQUwGMEVV5BoUacoh
         dTjnJWGozhBYZfBMb3aPI4FuD9e8payel/odm/e9JU7DW1/k98alJhrHD0hcwWLf4GT1
         qZbIkUlzSQe6NNr51nwBcCDDa6Lfe4bGFFRwhyHtSa+AEp8hT4dLbPbh9ecfyGhEan0a
         69lVBUsZl4w8Rqlihd5s/P52UqEWJwebVToR0m2ksFbN/mMIXrZ5luMAN0w6n1alqlY+
         iguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1HsYO0/PpN47jXo/UbG1qMQ0BE5ikOcC9+i94JA2u6s=;
        b=gN2Jn7NVfCu6TI821GBZ/e56Hkq0O5OxWdfC18we/Dom/Zvkv5L/kNcWOZt1KsvAdO
         aYyFKcZjp21tpSqRZWwwFUZspUipGhiBSajXIL6/zx4+32Se47fZeszBekKuly/bP+FM
         /GjjxIsMhj8esEivgBifPNRYlpBptDfWkvZgpxa7f12hGmuNeZi0izeRlvIsJQp3wsk/
         u1aSYWsrPoZL2YVlfQGtukiEKFrBfYkwqCN5OR1Qh0AvLVFDAZb6+G9giraVDnkeIj3r
         ZhvPWswLDO4e510Fm7yhbI1eaFMX79FpFTJ/Ar7wWTzyNZR3O/p/lEfywEP3cveTRyzL
         22Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 47/68] mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()
Date: Mon, 19 Mar 2018 19:06:25 +0100
Message-Id: <20180319171834.510721801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390603013968403?=
X-GMAIL-MSGID: =?utf-8?q?1595390603013968403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>


[ Upstream commit df467899da0b71465760b4e35127bce837244eee ]

Some drivers (like nand_hynix.c) call ->cmdfunc() with NAND_CMD_NONE
and a column address and expect the controller to only send address
cycles. Right now, the default ->cmdfunc() implementations provided by
the core do not filter out the command cycle in this case and forwards
the request to the controller driver through the ->cmd_ctrl() method.
The thing is, NAND controller drivers can get this wrong and send a
command cycle with a NAND_CMD_NONE opcode and since NAND_CMD_NONE is
-1, and the command field is usually casted to an u8, we end up sending
the 0xFF command which is actually a RESET operation.

Add conditions in nand_command[_lp]() functions to sending the initial
command cycle when command == NAND_CMD_NONE.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/nand_base.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -600,7 +600,8 @@ static void nand_command(struct mtd_info
 		chip->cmd_ctrl(mtd, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
-	chip->cmd_ctrl(mtd, command, ctrl);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -629,6 +630,7 @@ static void nand_command(struct mtd_info
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -691,7 +693,9 @@ static void nand_command_lp(struct mtd_i
 	}
 
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -724,6 +728,7 @@ static void nand_command_lp(struct mtd_i
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
