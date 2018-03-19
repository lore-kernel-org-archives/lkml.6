Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvhmLYEeAdV9A0HmWwo8APpsMqbP51mAjkotNOJsUGvi81kohJntwTWcfvxggHQxNuhwrYR
ARC-Seal: i=1; a=rsa-sha256; t=1521483949; cv=none;
        d=google.com; s=arc-20160816;
        b=HM6wPsaTixHJaFsA99+0YlfYflZ2JNE65OiYzyzJk9H9rbGm61PPtWcMMaodBCbHPF
         peIs6bI2/3IdL5K4z0RVI9xYX6VGVvDl4iBICvART2WPGF4+5u1cSTy1HYBH6hVUBNNS
         KlyUtKIgJ/hVdKHAP14daBTUkafATpYtjHSIqyc5F3W6Ye8v/yG6Te8B5ZplicASSPlJ
         OXVmVCMuNxmWNXSISaakbIdY/8pzbiZz/f/VhQI6NI7uNu1kC+6jmo8cMEt8u/dNzF7H
         JnvDQlZD+d6ONg6jc2R7aSnol47D2W0hvM/vE0TNeb//xJ0YqM7EiO33LjoDr0iwL+9r
         KX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rIgv/vFLQZth8WYWgmcg3yZG1vfmJHv7zdzVy6XHXRE=;
        b=B/ZZswrvh0cfLfYwUKRkEI3uEFatnCDAUc508k4Jb2/KZeZBOogopRh18GjjK6PGNz
         E/V+UbjL9LQfGmC+VLM9W8VUat8DzBYOIZ69IeHFELke7PhyHN7PKuJ5HA5BkTc7fV3f
         qGLqfu+OthKnpY8W+l3nAVanscMdXX9QauZvuq3RM5IpapDl9c/XEhFhBxs1We6gr3RJ
         F6UMa7gXePSgeXZcrsZIaoBpcFh7KeqhNBtaxs7SPJzYEFYjS7MyhgrP/2PzCpWJMlq9
         Su8Yow+VeCiFdgcBX0HP3JIW7DXmrkUMwbicJXxR8+wwsFrRFMRgqG8TLPv6vNoPv98N
         E+ww==
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
Subject: [PATCH 4.9 175/241] mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()
Date: Mon, 19 Mar 2018 19:07:20 +0100
Message-Id: <20180319180758.397891892@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390603013968403?=
X-GMAIL-MSGID: =?utf-8?q?1595391554208902638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -715,7 +715,8 @@ static void nand_command(struct mtd_info
 		chip->cmd_ctrl(mtd, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
-	chip->cmd_ctrl(mtd, command, ctrl);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -744,6 +745,7 @@ static void nand_command(struct mtd_info
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -806,7 +808,9 @@ static void nand_command_lp(struct mtd_i
 	}
 
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command != NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -842,6 +846,7 @@ static void nand_command_lp(struct mtd_i
 	 */
 	switch (command) {
 
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
