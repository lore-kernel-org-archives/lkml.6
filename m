Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6qdYhRjsE1/MoNQ5r+nOL+krNGl+4NX3OC0namt+vd6JZuk0u6tADMgiSpyph5vkQFeUR
ARC-Seal: i=1; a=rsa-sha256; t=1526937894; cv=none;
        d=google.com; s=arc-20160816;
        b=j6xQpYk+fl0oIsksvlJzn+nBJ8gEioXT9TMX+qY2+G2XPNdayEmQTXDjccZ2S4dJp1
         4YtaBq9kH1RON3LexpLz6oi+J8eQtXMXULzyQ2qT+k/sFy8D1eVHRmnVj/LoOTEcjq8x
         yzy4vLZ77M+P2FeQbjgwbqPtLM+q72/SzehdhiEoVBuCxUXy4ud8wKoU/PMXJPAz5j30
         dK/gnnTlucxC/QWNNJB5wy7bXN1yWe+aCoYIbF7MPRloulDSEM41koxpw1vdD3oXI4FF
         wKpljDXBAbNZ/cCjPKEXan/fmTEQfciM1U2uueBKdl47fnZwXyzhH9eVuBn6I8LthpSp
         VFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ho7WNhAttsyir9kyQSAPCrJ8tv39cc/QTuo/eu/qTKw=;
        b=CGjuv5i1fSfIeOy1KiZcsmYOf4p2p373G1JFEB6ypj21VFy6XIvmhYBlbX/xoxMzJJ
         u5chAYD3B7cUvUvGwz8tBU81wEXOHDvW7SFWWxIuUxH//OEOUFGgtI7+9Oxo/qCXOkWg
         Cwp//jdqZl4gOrXCCaQekzd3NKSipj6ZcagVFZ803+g3VoXkB7oDL8Bzl4Ibjt+bzHQ0
         MkXr6msjWRRsM+u858WoUic7wK9y4rU3CiWAE6cXII5XIl4ywArsQpZYOFyKAgqhCzK8
         Bmz4k3aMLHxqS8CUCteUy88F3lX0Sqw6CUUHQNjR+vkVRMdWu1V7VqfI1qHajVk3ojHR
         9K6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UxGdQhCA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UxGdQhCA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.16 032/110] mtd: rawnand: marvell: Fix read logic for layouts with ->nchunks > 2
Date: Mon, 21 May 2018 23:11:29 +0200
Message-Id: <20180521210506.599322824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110429508486183?=
X-GMAIL-MSGID: =?utf-8?q?1601110429508486183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 90d617633368ab97a2c7571c6e66dad54f39228d upstream.

The code is doing monolithic reads for all chunks except the last one
which is wrong since a monolithic read will issue the
READ0+ADDRS+READ_START sequence. It not only takes longer because it
forces the NAND chip to reload the page content into its internal
cache, but by doing that we also reset the column pointer to 0, which
means we'll always read the first chunk instead of moving to the next
one.

Rework the code to do a monolithic read only for the first chunk,
then switch to naked reads for all intermediate chunks and finally
issue a last naked read for the last chunk.

Fixes: 02f26ecf8c77 mtd: nand: add reworked Marvell NAND controller driver
Cc: stable@vger.kernel.org
Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/marvell_nand.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -1190,11 +1190,13 @@ static void marvell_nfc_hw_ecc_bch_read_
 				  NDCB0_CMD2(NAND_CMD_READSTART);
 
 	/*
-	 * Trigger the naked read operation only on the last chunk.
-	 * Otherwise, use monolithic read.
+	 * Trigger the monolithic read on the first chunk, then naked read on
+	 * intermediate chunks and finally a last naked read on the last chunk.
 	 */
-	if (lt->nchunks == 1 || (chunk < lt->nchunks - 1))
+	if (chunk == 0)
 		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_MONOLITHIC_RW);
+	else if (chunk < lt->nchunks - 1)
+		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_NAKED_RW);
 	else
 		nfc_op.ndcb[0] |= NDCB0_CMD_XTYPE(XTYPE_LAST_NAKED_RW);
 
