Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo4PlxEPlPaOcC/fuBoDC0HA3iRbNiSWA+1E3Q2+vad40PA046Hv8Ehd7MheyVALBHzmW3d
ARC-Seal: i=1; a=rsa-sha256; t=1525116525; cv=none;
        d=google.com; s=arc-20160816;
        b=YUfeg7t1GGlmqS1ajayai1ixRJqIGTHA36wYM0nYh8hgcMat+N6cGaVsLMNkTjHdJt
         F/LB96pQigzfl4hsHUbYn8TwlmDJuBl6Gu1itg4f01GruGbagL+evC+EQz/N16UPiD+0
         y5jJzDc+pVZJWGzTnhJF/vbQtYofImnxLa90f6Jy1S3hUfNN5NsfANSGvLndeQiTou4d
         tCNRbaw9DiQs5BnLL8IUwFQtxe4q0BYqYeue6UCkDIVBpkjv8R5544z8HENyTR9xziTe
         zscOxC2qJXXgI6ryLfln85VgZI+x0HGRCj36B9G9M40inwVxhWoYkYNMVySwKoaH5sk8
         I0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zYK2ksb5VB/7PofrsmmHJW1h2BnwjDQrRdxQpqsIvMU=;
        b=MTSMxbeZcgbcFVnhZ+B4qJYXXMO34WlIB73j666xfjjak06BHZSgm6NHl/WPUwaqJw
         nJAg2FBQ4hYWTmmBni8dHLBdBKDZDfHTmp1F3SDtzbvam88h35pAf6cIq2Z7ZsljWkD5
         g55MQkbDXZ3UQqypwWkDu11AyMqPp0rSAWqN5Jjg76LAYEPWFK8WZuRSbuAUzcIwDhdO
         sx7tzLNTEAtm9tR8cZ3l6CjBPP8dxdi2oFF6wEA+hbObl68zxNdRurvuu91CyTsQGYOI
         D0GccRYMcj7b2gl9cc8oy5x2lQn/bjqSdgqUQ6d2NG/Tbjl+n9pyyhUn1ESvw57QpDl4
         OR3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4822DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>,
	Alan Tull <atull@kernel.org>,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4.16 093/113] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Mon, 30 Apr 2018 12:25:04 -0700
Message-Id: <20180430184019.138135380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200514004063912?=
X-GMAIL-MSGID: =?utf-8?q?1599200585561058881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anatolij Gustschin <agust@denx.de>

commit 881c93c0fb73328845898344208fa0bf0d62cac6 upstream.

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/fpga/altera-ps-spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -249,7 +249,7 @@ static int altera_ps_probe(struct spi_de
 
 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
