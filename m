Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuPPkcH9uRrglpi7mb32DZZNI3Hp9T8T1hFxzgOPl1w8HoBYqIul1SISc3gzEmDtLGI0c3A
ARC-Seal: i=1; a=rsa-sha256; t=1521214556; cv=none;
        d=google.com; s=arc-20160816;
        b=Rpcje1k7souMbEs7EcO5Jyl+b5+omTITzRlGy2KtdYs1IWNMr22fJ6DaBK+ElROQ5p
         QZAYsA1hoxW/DrTX6RdwWq9Xcjse7HI1JQxC4BK2bcbpk/zNrSUGlz9YeOX8LI4dVmjs
         iT5OSedwaFsR+a7cXCspSaaS10veYS6cF+p/HgNNozGt2/Ybr5QSVBHuGN8QazwPFnur
         +7F2qBPHlfwtx5oP3bNIbzhIuUO65DUt8Le+mjJX/+ECWohBiV5qsoXWeX4kBZtE9Mup
         RMNv+0nyhJFWB9UZZQ+Z74aJLN5bvjuSdAe4IE7oh/O18SvRvMV4Rv96bRpwtBP4Q6zP
         rxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kq2VvXNeN2b9592u0uFZHMz+JA1D4aZUXn7joVvCW9U=;
        b=LLA+isDSj8xdjhX0XEZYs1HX5mSxEpK7NOhAQn+xnUd023p5g3KW1JIIhs+KGMUIL6
         nds2lsC/m1myhGB48/0gscFnrjzdI1vtfZF2MRft1stgCo0hRxOoIzjFWDXtR692snN4
         Kk0Us4zlifIW//UaytcGl+dRjiN24KHh6Lpcl57aX3iKCy/X/3+Lqvcp8vEx5Yz9iNtW
         WzyOfmw+2OgKzExqs5iypTqXaiPzc+WmdBJvJ7kOmQ3JA4naMao/2jqQ/sauxLySO42P
         sAedyCHn3u4sZZgP78FOv6WquIt0XP9VxPqYFifTn8coM3Jm4G75jluaeaFJRZs7JpOO
         I9zA==
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
Subject: [PATCH 4.14 048/109] mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()
Date: Fri, 16 Mar 2018 16:23:17 +0100
Message-Id: <20180316152332.577034686@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109075093130036?=
X-GMAIL-MSGID: =?utf-8?q?1595109075093130036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -710,7 +710,8 @@ static void nand_command(struct mtd_info
 		chip->cmd_ctrl(mtd, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
-	chip->cmd_ctrl(mtd, command, ctrl);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -739,6 +740,7 @@ static void nand_command(struct mtd_info
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -832,7 +834,9 @@ static void nand_command_lp(struct mtd_i
 	}
 
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -868,6 +872,7 @@ static void nand_command_lp(struct mtd_i
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
