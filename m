Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8hRpZRyyeSKZBpoinDCp70mwkJmAnDeVklMqgpZQDWzsbehoq7L22LKX3QsKK5EIcRPHd
ARC-Seal: i=1; a=rsa-sha256; t=1521483336; cv=none;
        d=google.com; s=arc-20160816;
        b=bF8FgsmgRXatl16m7pi+FMl8WQsYopMh3lK3prYfdwHWsL6I/G8F9ozW/MmLOYcnyo
         z97QmUoSxsRFNTEmVWRU9NPklVd3ljlQi0eav9li9UQLOr2Km9sQbf/QpAlR7GGxRPJp
         dpqduBiWT8yEuatwUyZkzMTZc7qIroyLGbvFBw2mUZMhEExIKOgDxVdkbgNbVL2g438x
         LC8LxTPepRTHzRznMe7+WjL1EA/CCXU44ygcu6F/iFOtKTMZpFSbdw3j20Ns/jpTwbWA
         Po59WCNTjmjLX1YkDIvUGVoi3MO4GnLuXrjoPNfmJWRI/EeZBB2Vx82TCuSIf3n29Go1
         rNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gRWMszJOfj6s5QMGBMLzLYY1xzTObKCSFwvjJhroHyw=;
        b=i/rwJG/ZOh1HCvsHV/HtkadHfAMpxlAC/7JjRl8dRaxM6nDqtm14EfFQ4YIPqu6GpQ
         YU1uf+gGFQguV5BUdGMqkcHuHv8ub5VLepYRCe+FSTIGMU72YYa1Ie3Y1/O3CDkjkITV
         NX5/J+sCM4go2QBVP+gbjAdES/A8MOVLG7x6iOs7ITe4pE9G6a73qd4UWr16s6PVcp2e
         wQZi0sjEb0iTG0pA4EOjGlC3CFeaSLw3rsGwko6Q4s1Lc6bo9qwZdVIbVGs2qLFDqyOj
         +0JmWsgrFpyVf990ucKFpaQeFbjrdxYf3JvgO3Jf0xk509k7kIkg/51RgxlRHINrop3F
         NmZQ==
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
Subject: [PATCH 4.4 087/134] mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()
Date: Mon, 19 Mar 2018 19:06:10 +0100
Message-Id: <20180319171901.863994566@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390603013968403?=
X-GMAIL-MSGID: =?utf-8?q?1595390911056455957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -626,7 +626,8 @@ static void nand_command(struct mtd_info
 		chip->cmd_ctrl(mtd, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
-	chip->cmd_ctrl(mtd, command, ctrl);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -655,6 +656,7 @@ static void nand_command(struct mtd_info
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -717,7 +719,9 @@ static void nand_command_lp(struct mtd_i
 	}
 
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -750,6 +754,7 @@ static void nand_command_lp(struct mtd_i
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
