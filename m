Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262ZIg/QoTFC2RHm0Af1KEHDB5IicSl5LKaUZlusxM/hqAFZiatI3yY4+1o/0yh8MQP4Ec5
ARC-Seal: i=1; a=rsa-sha256; t=1518708834; cv=none;
        d=google.com; s=arc-20160816;
        b=Wzo8fzfEbHG4Iz5l3FfBVFOxt4yc/SCHR3pK8J/BOew56/BB48htTXQzS9e5Bgweun
         Tpra5/pEVQzyvcacmjEanGk/sxDmt0nxjQlPsVxJ0E7cxv2XUPXwaVM/SeSaTZwHQaQJ
         ugW7b2DWuL6SDJinDOYvTL5DBVQ+DMctbgGLeFgUwC7LgtwA3+QlR+lPV2M4sW87DWIZ
         2cr1fWDSQR+curTqGb9l+DdvjlOJ68GISu+8jSsGli5CI31VmjtQ+UOyd1m2+cZ6F5fP
         ICwb4YTYhzK4FQlZ+OwJynSxUcElV+EefIaP40qftfmNpgiOL1loLnvTOjG1Ccm0tD1C
         OnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pr6QFJ8Yu8mxlEnUPfnAvpfUx6kui/ozxUxw0fQwv3E=;
        b=IT0UdDGtUBu3Co1y7J49HAoKbRJN9RBw7d5Ac9h2A3SsB7xfNRpaJBzHYqbRUfYexw
         Fz7Or+XneMao00Z6/9AE1aGuVYMSwUZZNqAXYeuDaTubtA0Og97/CJQhzHdyPbARe6Ld
         +qHF5EGEWrzl1aob+tm8zEP4Xqr9Y9wewlRJighsrQd2hWF9IAeMjdPMPUyXKklfvSvL
         /SWDRKDR6xqAKQSibK5GtufWIE/jQbFTe660PWmnR8ZAFdrs5DpK9uoSSytY8/Q9wtnU
         2/XwUQccKUcmQPjcyipE5ye5uZu1V/tt//iCSilMYJlgoF6YkVAp6ZkSOZuWnxL5KGxF
         JFKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH 4.14 098/195] mtd: nand: sunxi: Fix ECC strength choice
Date: Thu, 15 Feb 2018 16:16:29 +0100
Message-Id: <20180215151710.599351295@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481054802877681?=
X-GMAIL-MSGID: =?utf-8?q?1592481634867364433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit f4c6cd1a7f2275d5bc0e494b21fff26f8dde80f0 upstream.

When the requested ECC strength does not exactly match the strengths
supported by the ECC engine, the driver is selecting the closest
strength meeting the 'selected_strength > requested_strength'
constraint. Fix the fact that, in this particular case, ecc->strength
value was not updated to match the 'selected_strength'.

For instance, one can encounter this issue when no ECC requirement is
filled in the device tree while the NAND chip minimum requirement is not
a strength/step_size combo natively supported by the ECC engine.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/sunxi_nand.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1853,8 +1853,14 @@ static int sunxi_nand_hw_common_ecc_ctrl
 
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
-		if (ecc->strength <= strengths[i])
+		if (ecc->strength <= strengths[i]) {
+			/*
+			 * Update ecc->strength value with the actual strength
+			 * that will be used by the ECC engine.
+			 */
+			ecc->strength = strengths[i];
 			break;
+		}
 	}
 
 	if (i >= ARRAY_SIZE(strengths)) {
