Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsi8lX+KP/6y0KJTGzt4JXnkz/OGcgGkkU5PQt2Sc+Oe/Qh194dq+RCDjySrUgdkHhtZEFq
ARC-Seal: i=1; a=rsa-sha256; t=1521214906; cv=none;
        d=google.com; s=arc-20160816;
        b=EULxNNPtiPqxNCBzFeMMVTfE9UkYzkGqj5/ptRGaneTgnX5XOJW+QlxIWNfm8bYd35
         9IDz15JWoAtlUPIgkRagfUy3x6qOcCEzq1GDk5VUmHry7HbkHSxPP8zcQhFmnUqza/q/
         ACAoGnw2HSIK3gq4nju4dTQaWlJ/a4E6hpcZPYxqp0rjJ11bwORmHXVNEbJYNjpyCHg9
         1bIVdCPkrEkVSYk4vsvdCaIpbq/2t9XN1UPl17ku07L4ZxPlwGr94dnEV65dtjUyFwv7
         VRgxMLem5Y3ECXib52hmufNZaSqFqm5nf9TWn48f2EF5WOBWZG8OOCcRcxx37by2eKWk
         eeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c0IIbZW9TNHYUZRwAlZH1JiUtpqWvWyYiq2zIEpeIyI=;
        b=naYKm98oeBasBJ3/pnuf+sXy5yNfKEg+u7Sv6zUPfljjfeaqkd//leOMU9di1lNYZa
         qNxqMoxKhyKVjJ1DK12s9fHoi5O/1Z0y6MjD9YNViiW7Fqn+85TkCnxe9Nd1WZbnHGiv
         KU9kopnTOLLPVwcb2Cjk1GNoEPcAJ5+v1ruPKzWtcmyn8/yptrnPCWUfzvJktW77QU7z
         lh0ahmy+wDIhw5CFVMYhhPCFsAVQLmfOR7aWlq/2SfN6GMcSMN7q0K8qaeTJ67ChOkBk
         G//t6Fg17dg6Cs4poMdFmc/mpa278veUBVUD+qEgXbLM9+5nJG+ngjzKJQnVt0BKoheN
         ToAQ==
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
Subject: [PATCH 4.15 059/128] mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()
Date: Fri, 16 Mar 2018 16:23:20 +0100
Message-Id: <20180316152339.757796180@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109075093130036?=
X-GMAIL-MSGID: =?utf-8?q?1595109441748709993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -738,6 +739,7 @@ static void nand_command(struct mtd_info
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -831,7 +833,9 @@ static void nand_command_lp(struct mtd_i
 	}
 
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -866,6 +870,7 @@ static void nand_command_lp(struct mtd_i
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
