Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964972AbeEIS5g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:57:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46330 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935523AbeEIS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:57:35 -0400
X-Google-Smtp-Source: AB8JxZpOXJ4KUDSSBQYsFGXmzAd7whlGizKJvn1u4z6CuIGipjNUpO7buloWjxMekjKTlYd8Z5ztuQ==
From: Mathieu Malaterre <malat@debian.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmem: properly handle returned value nvmem_reg_read
Date: Wed,  9 May 2018 20:57:24 +0200
Message-Id: <20180509185724.24079-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180505202450.26630-1-malat@debian.org>
References: <20180505202450.26630-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function nvmem_reg_read can return a non zero value indicating an error.
This returned value must be read and error propagated to
nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):

  drivers/nvmem/core.c:1093:9: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: prefer ERR_PTR(-EINVAL) over a simple return NULL

 drivers/nvmem/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b05aa8e81303..f7b6c85cf393 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1107,6 +1107,8 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 
 		/* setup the first byte with lsb bits from nvmem */
 		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
+		if (rc)
+			goto err;
 		*b++ |= GENMASK(bit_offset - 1, 0) & v;
 
 		/* setup rest of the byte if any */
@@ -1125,11 +1127,16 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 		/* setup the last byte with msb bits from nvmem */
 		rc = nvmem_reg_read(nvmem,
 				    cell->offset + cell->bytes - 1, &v, 1);
+		if (rc)
+			goto err;
 		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
 
 	}
 
 	return buf;
+err:
+	kfree(buf);
+	return ERR_PTR(-EINVAL);
 }
 
 /**
-- 
2.11.0
