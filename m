Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224IWCDU2rKqS8NvbfMycz7jloBWFbxnjjGC2CbJ2FZJg6lEHUMj9pxLG7jjEOhBUV1VptF9
ARC-Seal: i=1; a=rsa-sha256; t=1519411060; cv=none;
        d=google.com; s=arc-20160816;
        b=dOG3O3OnQ0OTmJ8ZLd7XtMYr8oOz3KrAYoqPnYaUpZ/M8J1cejfVK1No4Szut5uLXK
         23K4ZB6tL51TismoKZav2iwnlbchZGv+YAmeviccBPD6SPWCFv/WTP4MUmQo2AY8QhEZ
         3jzyl+hrZLpRLZZEIF7x7kXX7COVyO/ky+1K9Ta2GzSCtLzQ/FCqmqhsfF7qegIyCune
         PX8LY3WsK8AG7CBYekqPiDSJu1JtBpLJb8LBB59nm29iR277nvjZZBk6htVWGF9kTZ0/
         cC7EufbcwcqqwmARkL9A+d4Eo/LqP8QmcfhEaQHBNHfzxpoGZkY8Gq8cPZ/ycbzUROSg
         y9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Svl4nIX365SZkIVEMS9wByfw1zYkebv5g17nAJj4KI8=;
        b=Wm4opCnFeGnPv9fSfbd1qO/S34Zvk8z9GiVJZ8W6TMIgQn2rXbv1WFi7DC9UUrkJRJ
         278nvRZvGwIe6TbyA8MdC8lwjtxh3YaijQFYwThsey6Ccef4G0cYjrBL9FbK91JlqrVm
         4ceC1UjY5yAI68mZp8U/2V62Tq8RMXkKlk6tgi/Qk7HK75a4e+MtDXh5VfRNTQVWzpH4
         y1aXjDvX1paeVCZepjjleqZ/Ubff8rT5R3UcZn+F2bCYqX0Iss0ASGa5Ic4RLv1NhcId
         du29hlU2F1AlogN6Jfaf0GyPjwqXT4TvuAHsnLavveICrzrtkwb1f46lmc5xPddEpzhs
         96Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4.4 106/193] mtd: sh_flctl: pass FIFO as physical address
Date: Fri, 23 Feb 2018 19:25:39 +0100
Message-Id: <20180223170342.521240156@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217971637695389?=
X-GMAIL-MSGID: =?utf-8?q?1593217971637695389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1873315fb156cbc8e46f28e8b128f17ff6c31728 upstream.

By convention, the FIFO address we pass using dmaengine_slave_config
is a physical address in the form that is understood by the DMA
engine, as a dma_addr_t, phys_addr_t or resource_size_t.

The sh_flctl driver however passes a virtual __iomem address that
gets cast to dma_addr_t in the slave driver. This happens to work
on shmobile because that platform sets up an identity mapping for
its MMIO regions, but such code is not portable to other platforms,
and prevents us from ever changing the platform mapping or reusing
the driver on other architectures like ARM64 that might not have the
mapping.

We also get a warning about a type mismatch for the case that
dma_addr_t is wider than a pointer, i.e. when CONFIG_LPAE is set:

drivers/mtd/nand/sh_flctl.c: In function 'flctl_setup_dma':
drivers/mtd/nand/sh_flctl.c:163:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);

This changes the driver to instead pass the physical address of
the FIFO that is extracted from the MMIO resource, making the
code more portable and avoiding the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/sh_flctl.c  |    5 +++--
 include/linux/mtd/sh_flctl.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -160,7 +160,7 @@ static void flctl_setup_dma(struct sh_fl
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.direction = DMA_MEM_TO_DEV;
-	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
+	cfg.dst_addr = flctl->fifo;
 	cfg.src_addr = 0;
 	ret = dmaengine_slave_config(flctl->chan_fifo0_tx, &cfg);
 	if (ret < 0)
@@ -176,7 +176,7 @@ static void flctl_setup_dma(struct sh_fl
 
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.dst_addr = 0;
-	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
+	cfg.src_addr = flctl->fifo;
 	ret = dmaengine_slave_config(flctl->chan_fifo0_rx, &cfg);
 	if (ret < 0)
 		goto err;
@@ -1096,6 +1096,7 @@ static int flctl_probe(struct platform_d
 	flctl->reg = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(flctl->reg))
 		return PTR_ERR(flctl->reg);
+	flctl->fifo = res->start + 0x24; /* FLDTFIFO */
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -148,6 +148,7 @@ struct sh_flctl {
 	struct platform_device	*pdev;
 	struct dev_pm_qos_request pm_qos;
 	void __iomem		*reg;
+	resource_size_t		fifo;
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
 	int	read_bytes;
